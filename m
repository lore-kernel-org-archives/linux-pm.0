From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v6 11/12] arm64: topology: enable ACPI/PPTT based CPU
 topology
Date: Fri, 23 Feb 2018 11:02:38 +0000
Message-ID: <20180223110238.GB20461@e107981-ln.cambridge.arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-12-jeremy.linton@arm.com>
 <928cb0c9-1d7a-3d0c-0538-a8bb0e2a86b1@huawei.com>
 <b4060cb0-6eed-f34a-00d5-4c2f55f20220@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <b4060cb0-6eed-f34a-00d5-4c2f55f20220@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: mark.rutland@arm.com, Jonathan.Zhang@cavium.com, austinwc@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, vkilari@codeaurora.org, Jayachandran.Nair@cavium.com, Juri Lelli <juri.lelli@arm.com>, jhugo@codeaurora.org, Xiongfeng Wang <wangxiongfeng2@huawei.com>, linux-acpi@vger.kernel.org, viresh.kumar@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org, ahs3@redhat.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, sudeep.holla@arm.com
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 25, 2018 at 09:56:30AM -0600, Jeremy Linton wrote:
> Hi,
> 
> On 01/25/2018 06:15 AM, Xiongfeng Wang wrote:
> >Hi Jeremy,
> >
> >I have tested the patch with the newest UEFI. It prints the below error:
> >
> >[    4.017371] BUG: arch topology borken
> >[    4.021069] BUG: arch topology borken
> >[    4.024764] BUG: arch topology borken
> >[    4.028460] BUG: arch topology borken
> >[    4.032153] BUG: arch topology borken
> >[    4.035849] BUG: arch topology borken
> >[    4.039543] BUG: arch topology borken
> >[    4.043239] BUG: arch topology borken
> >[    4.046932] BUG: arch topology borken
> >[    4.050629] BUG: arch topology borken
> >[    4.054322] BUG: arch topology borken
> >
> >I checked the code and found that the newest UEFI set PPTT physical_package_flag on a physical package node and
> >the NUMA domain (SRAT domains) starts from the layer of DIE. (The topology of our board is core->cluster->die->package).
> 
> I commented about that on the EDK2 mailing list. While the current spec
> doesn't explicitly ban having the flag set multiple times between the leaf
> and the root I consider it a "bug" and there is an effort to clarify the
> spec and the use of that flag.
> >
> >When the kernel starts to build sched_domain, the multi-core sched_domain contains all the cores within a package,
> >and the lowest NUMA sched_domain contains all the cores within a die. But the kernel requires that the multi-core
> >sched_domain should be a subset of the lowest NUMA sched_domain, so the BUG info is printed.
> 
> Right. I've mentioned this problem a couple of times.
> 
> At at the moment, the spec isn't clear about how the proximity domain is
> detected/located within the PPTT topology (a node with a 1:1 correspondence
> isn't even required). As you can see from this patch set, we are making the
> general assumption that the proximity domains are at the same level as the
> physical socket. This isn't ideal for NUMA topologies, like the D05, that
> don't align with the physical socket.
> 
> There are efforts underway to clarify and expand upon the specification to
> deal with this general problem. The simple solution is another flag (say
> PPTT_PROXIMITY_DOMAIN which would map to the D05 die) which could be used to
> find nodes with 1:1 correspondence. At that point we could add a fairly
> trivial patch to correct just the scheduler topology without affecting the
> rest of the system topology code.

I think Morten asked already but isn't this the same end result we end
up having if we remove the DIE level if NUMA-within-package is detected
(instead of using the default_topology[]) and we create our own ARM64
domain hierarchy (with DIE level removed) through set_sched_topology()
accordingly ?

Put it differently: do we really need to rely on another PPTT flag to
collect this information ?

I can't merge code that breaks a platform with legitimate firmware
bindings.

Thanks,
Lorenzo

> 
> >
> >If we modify the UEFI to make NUMA sched_domain start from the layer of package, then all the topology information
> >within the package will be discarded. I think we need to build the multi-core sched_domain using the cores within
> >the cluster instead of the cores within the package. I think that's what 'multi-core' means. Multi cores form a cluster. I guess.
> >If we build the multi-core sched_domain using the cores within a cluster, I think we need to add fields in struct cpu_topology
> >to record which cores are in each cluster.
> 
> The problem is that there isn't a generic way to identify which level of
> cache sharing is the "correct" top layer MC domain. For one system cluster
> might be appropriate, for another it might be the highest caching level
> within a socket, for another is might be a something in between or a group
> of clusters or LLCs..
> 
> Hence the effort to standardize/guarantee a PPTT node that exactly matches a
> SRAT domain. With that, each SOC/system provider has clearly defined method
> for communicating where they want the proximity domain information to begin.
> 
> Thanks,
> 
> >
> >
> >Thanks,
> >Xiongfeng
> >
> >On 2018/1/13 8:59, Jeremy Linton wrote:
> >>Propagate the topology information from the PPTT tree to the
> >>cpu_topology array. We can get the thread id, core_id and
> >>cluster_id by assuming certain levels of the PPTT tree correspond
> >>to those concepts. The package_id is flagged in the tree and can be
> >>found by calling find_acpi_cpu_topology_package() which terminates
> >>its search when it finds an ACPI node flagged as the physical
> >>package. If the tree doesn't contain enough levels to represent
> >>all of the requested levels then the root node will be returned
> >>for all subsequent levels.
> >>
> >>Cc: Juri Lelli <juri.lelli@arm.com>
> >>Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >>---
> >>  arch/arm64/kernel/topology.c | 46 +++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 45 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> >>index 7b06e263fdd1..ce8ec7fd6b32 100644
> >>--- a/arch/arm64/kernel/topology.c
> >>+++ b/arch/arm64/kernel/topology.c
> >>@@ -11,6 +11,7 @@
> >>   * for more details.
> >>   */
> >>+#include <linux/acpi.h>
> >>  #include <linux/arch_topology.h>
> >>  #include <linux/cpu.h>
> >>  #include <linux/cpumask.h>
> >>@@ -22,6 +23,7 @@
> >>  #include <linux/sched.h>
> >>  #include <linux/sched/topology.h>
> >>  #include <linux/slab.h>
> >>+#include <linux/smp.h>
> >>  #include <linux/string.h>
> >>  #include <asm/cpu.h>
> >>@@ -300,6 +302,46 @@ static void __init reset_cpu_topology(void)
> >>  	}
> >>  }
> >>+#ifdef CONFIG_ACPI
> >>+/*
> >>+ * Propagate the topology information of the processor_topology_node tree to the
> >>+ * cpu_topology array.
> >>+ */
> >>+static int __init parse_acpi_topology(void)
> >>+{
> >>+	bool is_threaded;
> >>+	int cpu, topology_id;
> >>+
> >>+	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
> >>+
> >>+	for_each_possible_cpu(cpu) {
> >>+		topology_id = find_acpi_cpu_topology(cpu, 0);
> >>+		if (topology_id < 0)
> >>+			return topology_id;
> >>+
> >>+		if (is_threaded) {
> >>+			cpu_topology[cpu].thread_id = topology_id;
> >>+			topology_id = find_acpi_cpu_topology(cpu, 1);
> >>+			cpu_topology[cpu].core_id   = topology_id;
> >>+			topology_id = find_acpi_cpu_topology_package(cpu);
> >>+			cpu_topology[cpu].package_id = topology_id;
> >>+		} else {
> >>+			cpu_topology[cpu].thread_id  = -1;
> >>+			cpu_topology[cpu].core_id    = topology_id;
> >>+			topology_id = find_acpi_cpu_topology_package(cpu);
> >>+			cpu_topology[cpu].package_id = topology_id;
> >>+		}
> >>+	}
> >>+
> >>+	return 0;
> >>+}
> >>+
> >>+#else
> >>+static inline int __init parse_acpi_topology(void)
> >>+{
> >>+	return -EINVAL;
> >>+}
> >>+#endif
> >>  void __init init_cpu_topology(void)
> >>  {
> >>@@ -309,6 +351,8 @@ void __init init_cpu_topology(void)
> >>  	 * Discard anything that was parsed if we hit an error so we
> >>  	 * don't use partial information.
> >>  	 */
> >>-	if (of_have_populated_dt() && parse_dt_topology())
> >>+	if ((!acpi_disabled) && parse_acpi_topology())
> >>+		reset_cpu_topology();
> >>+	else if (of_have_populated_dt() && parse_dt_topology())
> >>  		reset_cpu_topology();
> >>  }
> >>
> >
> 
