def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines
dns_raw = File.readlines("zone")

# A Function to recursively detect any cycles present in Zone File.

# Eg :
# CNAME, facebook.com, react.fb.com
# CNAME, react.fb.com, graphql.com
# CNAME, graphql.com, facebook.com

# This method uses Depth First Search Algorithm to detect cycle.

def dfs(key, visited, records)
  if (records[key] != nil)
    if (visited[key] == false)
      visited[key] = true
      if (records[key][:type] == "A")
        return false
      end
      return dfs(records[key][:val], visited, records)
    else
      return true
    end
  end
  return false
end

# Utility Function to detect cycles starting from any node.
def is_valid?(records)
  visited = {}
  records.each do |key, value|
    visited["#{key}"] = false
  end
  valid = false
  records.each do |k, val|
    records.each do |key, value|
      visited["#{key}"] = false
    end
    valid |= dfs(k, visited, records)
  end
  return !valid
end

# Parse Raw string and transform it to appropriate Data Structure
# Also Performs Validation.
def parse_dns(raw)
  records = {}
  raw.each do |row|
    data = row.strip.split(", ")
    if data.size == 0
      next
    end
    records["#{data[1]}"] = { :type => data[0], :val => data[2] }
  end
  if is_valid?(records) == true
    return records
  else
    puts "Zone Data contains cycles!"
    exit
  end
end

# A utility function to resolve domain name to IP Address.
def resolve(records, chain, domain)
  if records[domain] != nil
    if records[domain][:type] == "A"
      chain << records[domain][:val]
      return chain
    end
    return resolve(records, chain, records[domain][:val])
  else
    chain << "Domain Not Found"
    return chain
  end
end

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
