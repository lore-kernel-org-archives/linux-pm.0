From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 0/9] Support PPTT for ARM64
Date: Thu,  9 Nov 2017 15:03:02 -0600
Message-ID: <20171109210311.25655-1-jeremy.linton@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, devel@acpica.org, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-pm@vger.kernel.org

ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
used to describe the processor and cache topology. Ideally it is
used to extend/override information provided by the hardware, but
right now ARM64 is entirely dependent on firmware provided tables.

This patch parses the table for the cache topology and CPU topology.
New in the v4 we rename the topology cluster_id to physical_id
to match the kernel macro using it, and as its unlikley to actually
map to a cluster on an ACPI system. When we enable ACPI/PPTT for
arm64 we map the physical_id to the PPTT node flagged as the
physical package by the firmware. This results in topologies that
match what the remainder of the system expects.

For example on juno:
[root@mammon-juno-rh topology]# lstopo-no-graphics
  Package L#0
    L2 L#0 (1024KB)
      L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
      L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
      L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
      L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
    L2 L#1 (2048KB)
      L1d L#4 (32KB) + L1i L#4 (48KB) + Core L#4 + PU L#4 (P#4)
      L1d L#5 (32KB) + L1i L#5 (48KB) + Core L#5 + PU L#5 (P#5)
  HostBridge L#0
    PCIBridge
      PCIBridge
        PCIBridge
          PCI 1095:3132
            Block(Disk) L#0 "sda"
        PCIBridge
          PCI 1002:68f9
            GPU L#1 "renderD128"
            GPU L#2 "card0"
            GPU L#3 "controlD64"
        PCIBridge
          PCI 11ab:4380
            Net L#4 "enp8s0"


Git tree at:
http://linux-arm.org/git?p=linux-jlinton.git
branch: pptt_v4

v3->v4:
Suppress the "Found duplicate cache level/type..." message if the
  duplicate cache entry is actually a duplicate node. This allows cases
  like L1I and L1D nodes that point at the same L2 node to be accepted
  without the warning.
  
Remove cluster/physical split code. Add a patch to rename cluster_id
  so that its clear the topology may not be referring to a cluster.
  
Add additional ACPICA patch for the PPTT cache properties. This matches
  an outstanding ACPICA pull that should be merged in the near future.
  
Replace a number of (struct*)((u8*)ptr+offset) constructs with ACPI_ADD_PTR

Split out the topology parsing into an additional patch.

Tweak the cpu topology code to terminate on either a level, or a flag.
  Add an additional function which retrives the physical package id
  for a given cpu.

Various other comments/tweaks.

v2->v3:

Remove valid bit check on leaf nodes. Now simply being a leaf node
  is sufficient to verify the processor id against the ACPI
  processor ids (gotten from MADT). 

Use the acpi processor for the "level 0" Id. This makes the /sys
  visible core/thread ids more human readable if the firmware uses
  small consecutive values for processor ids.

Added PPTT to the list of injectable ACPI tables.

Fix bug which kept the code from using the processor node as intended
  in v2, caused by misuse of git rebase/fixup.

v1->v2:

The parser keys off the acpi_pptt_processor node to determine
  unique cache's rather than the acpi_pptt_cache referenced by the
  processor node. This allows PPTT tables which "share" cache nodes
  across cpu nodes despite not being a shared cache.

Normalize the socket, cluster and thread mapping so that they match
  linux's traditional mapping for the physical id, and thread id.
  Adding explicit scheduler knowledge of clusters (rather than just
  their cache sharing attributes) is a subject for a future patch.

Jeremy Linton (9):
  ACPICA: Add additional PPTT flags for cache properties
  ACPI/PPTT: Add Processor Properties Topology Table parsing
  arm64/acpi: Create arch specific cpu to acpi id helper
  ACPI: Enable PPTT support on ARM64
  drivers: base: cacheinfo: arm64: Add support for ACPI based firmware
    tables
  ACPI/PPTT: Add topology parsing code
  arm64: Topology, rename cluster_id
  arm64: topology: Enable ACPI/PPTT based CPU topology.
  ACPI: Add PPTT to injectable table list

 arch/arm64/Kconfig                |   1 +
 arch/arm64/include/asm/acpi.h     |   4 +
 arch/arm64/include/asm/topology.h |   4 +-
 arch/arm64/kernel/cacheinfo.c     |  23 +-
 arch/arm64/kernel/topology.c      |  74 ++++-
 drivers/acpi/Kconfig              |   3 +
 drivers/acpi/Makefile             |   1 +
 drivers/acpi/pptt.c               | 570 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c             |   3 +-
 drivers/base/cacheinfo.c          |  17 +-
 include/acpi/actbl1.h             |  14 +
 include/linux/cacheinfo.h         |  11 +-
 include/linux/topology.h          |   2 +
 13 files changed, 697 insertions(+), 30 deletions(-)
 create mode 100644 drivers/acpi/pptt.c

-- 
2.13.5

