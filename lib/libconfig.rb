# Copyright (c) 2012, Christopher Mark Gore,
# All rights reserved.
#
# 8729 Lower Marine Road, Saint Jacob, Illinois 62281 USA.
# Web: http://www.cgore.com
# Email: cgore@cgore.com
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#
#     * Neither the name of Christopher Mark Gore nor the names of other
#       contributors may be used to endorse or promote products derived from
#       this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

class Object
  def to_libconfig_boolean
    if self
      "true"
    else
      "false"
    end
  end

  def to_libconfig
    to_libconfig_boolean
  end
end

class NilClass
  def to_libconfig_boolean
    "false"
  end

  def to_libconfig_string
    ""
  end

  def to_libconfig
    to_libconfig_boolean
  end
end

class Integer
  def to_libconfig_integer
    to_s
  end

  def to_libconfig_string
    to_s.to_libconfig
  end

  def to_libconfig
    to_libconfig_integer
  end
end


class Float
  def to_libconfig
    to_s
  end
end


class String
  def to_libconfig
    '"' + self + '"'
  end
end


class Symbol
  def to_libconfig
    to_s.to_libconfig
  end
end


class Array
  def to_libconfig_list
    "( " + self.join(", ") + " )"
  end

  def to_libconfig_array
    "[ " + self.join(", ") + " ]"
  end

  def to_libconfig
    to_libconfig_list
  end
end


class Hash
  def to_libconfig_group
    result = "{\n"
    self.each do |key, value|
      if not [String, Symbol].include? key.class
        raise RuntimeError, "Invalid key type #{key.class} for libconfig group."
      end
      result += key.to_s + " = " + value.to_libconfig + ";\n"
    end
    return result + "}\n"
  end

  def to_libconfig
    to_libconfig_group
  end
end


module Libconfig
end
