From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH v2 0/6] Support PPTT for ARM64
Date: Wed, 20 Sep 2017 14:56:52 +0800
Message-ID: <f0194dff-6fb4-b2ba-93a8-2dd3a5dd9186@huawei.com>
References: <20170919184751.25110-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170919184751.25110-1-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@codeaurora.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, Jonathan.Zhang@cavium.com, ahs3@redhat.com
List-Id: linux-pm@vger.kernel.org

Hi Jeremy,

I have tested it on D05 board, the sysfs can display right information about
cpu topo and cache topo, except that the core_id and physical_package_id are
not continuous and counting from zero. But this doesn't influence the system.

Thanks,
Xiongfeng Wang

On 2017/9/20 2:47, Jeremy Linton wrote:
> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
> used to describe the processor and cache topology. Ideally it is
> used to extend/override information provided by the hardware, but
> right now ARM64 is entirely dependent on firmware provided tables.
> 
> This patch parses the table for the cache topology and CPU topology.
> For the latter we also add an additional topology_cod_id() macro,
> and a package_id for arm64. Initially the physical id will match
> the cluster id, but we update users of the cluster to utilize
> the new macro. When we enable ACPI/PPTT for arm64 we map the socket
> to the physical id as the remainder of the kernel expects.
> 
> For example on juno:
> [root@mammon-juno-rh topology]# lstopo-no-graphics
>   Package L#0
>     L2 L#0 (1024KB)
>       L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
>       L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
>       L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
>       L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
>     L2 L#1 (2048KB)
>       L1d L#4 (32KB) + L1i L#4 (48KB) + Core L#4 + PU L#4 (P#4)
>       L1d L#5 (32KB) + L1i L#5 (48KB) + Core L#5 + PU L#5 (P#5)
>   HostBridge L#0
>     PCIBridge
>       PCIBridge
>         PCIBridge
>           PCI 1095:3132
>             Block(Disk) L#0 "sda"
>         PCIBridge
>           PCI 1002:68f9
>             GPU L#1 "renderD128"
>             GPU L#2 "card0"
>             GPU L#3 "controlD64"
>         PCIBridge
>           PCI 11ab:4380
>             Net L#4 "enp8s0"
> 
> v1->v2:
> 
> The parser keys off the acpi_pptt_processor node to determine
>   unique cache's rather than the acpi_pptt_cache referenced by the
>   processor node. This allows PPTT tables which "share" cache nodes
>   across cpu nodes despite not being a shared cache.
> 
> Normalize the socket, cluster and thread mapping so that they match
>   linux's traditional mapping for the physical id, and thread id.
>   Adding explicit scheduler knowledge of clusters (rather than just
>   their cache sharing attributes) is a subject for a future patch.
> 
> Jeremy Linton (6):
>   ACPI/PPTT: Add Processor Properties Topology Table parsing
>   ACPI: Enable PPTT support on ARM64
>   drivers: base: cacheinfo: arm64: Add support for ACPI based firmware
>     tables
>   Topology: Add cluster on die macros and arm64 decoding
>   arm64: Fixup users of topology_physical_package_id
>   arm64: topology: Enable ACPI/PPTT based CPU topology.
> 
>  arch/arm64/Kconfig                |   1 +
>  arch/arm64/include/asm/topology.h |   4 +-
>  arch/arm64/kernel/cacheinfo.c     |  23 +-
>  arch/arm64/kernel/topology.c      |  62 ++++-
>  drivers/acpi/Makefile             |   1 +
>  drivers/acpi/arm64/Kconfig        |   3 +
>  drivers/acpi/pptt.c               | 459 ++++++++++++++++++++++++++++++++++++++
>  drivers/base/cacheinfo.c          |  17 +-
>  drivers/clk/clk-mb86s7x.c         |   2 +-
>  drivers/cpufreq/arm_big_little.c  |   2 +-
>  drivers/firmware/psci_checker.c   |   2 +-
>  include/linux/cacheinfo.h         |  10 +-
>  include/linux/topology.h          |   4 +
>  13 files changed, 570 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/acpi/pptt.c
> 

