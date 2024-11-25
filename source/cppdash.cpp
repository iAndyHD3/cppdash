#include <string>

#include "cppdash/cppdash.hpp"

exported_class::exported_class()
    : m_name {"cppdash"}
{
}

auto exported_class::name() const -> char const*
{
  return m_name.c_str();
}
