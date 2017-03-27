From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 0/9] Fix issues and factorize arm/arm64 capacity information code
Date: Mon, 27 Mar 2017 14:18:16 +0100
Message-ID: <20170327131825.32134-1-juri.lelli@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, juri.lelli-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

arm and arm64 topology.c share a lot of code related to parsing of capacity
information. This is v3 of a solution [1] (based on Will's, Catalin's and
Mark's off-line suggestions) to move such common code in a single place:
drivers/base/arch_topology.c (by creating such file and conditionally compiling
it for arm and arm64 only).

First 4 patches are actually fixes for the current code.

Patch 5 is the actual refactoring.

Patch 6 is a minor change suggested by Greg and can be squashed as needed.

Patch 7 removes one of the extern symbols by changing a bit the now common
code.

Patch 8 removes the remaining externs (as required by Russell during v1 review)
by creating a new header file include/linux/arch_topology.h and including that
from arm, arm64 and drivers.

Last patch addresses Dietmar's comments to v1 and adds a 'atd_' prefix to
interfaces exported by drivers code and used by arch (and potentially others in
the future).

Changes from v2:

 - rebase on top of 4.11-rc4
 - fix various problems pointed out by Greg, thanks for the review!
   (see patch 5 for details)

The set is based on top of linux/master (4.11-rc4 c02ed2e75ef4) and it is also
available from:

 git://linux-arm.org/linux-jl.git upstream/default_caps_factorize-v3

Best,

- Juri

[1] v1 - https://marc.info/?l=linux-kernel&m=148483680119355&w=2
    v2 - https://marc.info/?l=linux-kernel&m=148663344018205&w=2

Juri Lelli (9):
  Documentation: arm: fix wrong reference number in DT definition
  Documentation/ABI: add information about cpu_capacity
  arm: fix return value of parse_cpu_capacity
  arm: remove wrong CONFIG_PROC_SYSCTL ifdef
  arm, arm64: factorize common cpu capacity default code
  drivers: remove useless comment from base/arch_topology.c
  arm,arm64,drivers: reduce scope of cap_parsing_failed
  arm,arm64,drivers: move externs in a new header file
  arm,arm64,drivers: add a prefix to drivers arch_topology interfaces

 Documentation/ABI/testing/sysfs-devices-system-cpu |   7 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   4 +-
 arch/arm/Kconfig                                   |   1 +
 arch/arm/kernel/topology.c                         | 221 +------------------
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/kernel/topology.c                       | 226 +------------------
 drivers/base/Kconfig                               |   8 +
 drivers/base/Makefile                              |   1 +
 drivers/base/arch_topology.c                       | 241 +++++++++++++++++++++
 include/linux/arch_topology.h                      |  17 ++
 10 files changed, 288 insertions(+), 439 deletions(-)
 create mode 100644 drivers/base/arch_topology.c
 create mode 100644 include/linux/arch_topology.h

-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
