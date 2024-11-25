#include <string>

#include "cppdash/cppdash.hpp"

auto main() -> int
{
  auto const exported = exported_class {};

  return std::string("cppdash") == exported.name() ? 0 : 1;
}
