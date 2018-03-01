From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH v6 11/12] arm64: topology: enable ACPI/PPTT based CPU
 topology
Date: Thu, 1 Mar 2018 11:51:10 +0000
Message-ID: <20180301115110.GG4589@e105550-lin.cambridge.arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-12-jeremy.linton@arm.com>
 <928cb0c9-1d7a-3d0c-0538-a8bb0e2a86b1@huawei.com>
 <b4060cb0-6eed-f34a-00d5-4c2f55f20220@arm.com>
 <20180223110238.GB20461@e107981-ln.cambridge.arm.com>
 <52a4e58b-b5dd-cf68-1207-b43e60efee4b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52a4e58b-b5dd-cf68-1207-b43e60efee4b@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 23, 2018 at 10:37:33PM -0600, Jeremy Linton wrote:
> On 02/23/2018 05:02 AM, Lorenzo Pieralisi wrote:
> >On Thu, Jan 25, 2018 at 09:56:30AM -0600, Jeremy Linton wrote:
> >>Hi,
> >>
> >>On 01/25/2018 06:15 AM, Xiongfeng Wang wrote:
> >>>Hi Jeremy,
> >>>
> >>>I have tested the patch with the newest UEFI. It prints the below error:
> >>>
> >>>[    4.017371] BUG: arch topology borken
> >>>[    4.021069] BUG: arch topology borken
> >>>[    4.024764] BUG: arch topology borken
> >>>[    4.028460] BUG: arch topology borken
> >>>[    4.032153] BUG: arch topology borken
> >>>[    4.035849] BUG: arch topology borken
> >>>[    4.039543] BUG: arch topology borken
> >>>[    4.043239] BUG: arch topology borken
> >>>[    4.046932] BUG: arch topology borken
> >>>[    4.050629] BUG: arch topology borken
> >>>[    4.054322] BUG: arch topology borken
> >>>
> >>>I checked the code and found that the newest UEFI set PPTT physical_package_flag on a physical package node and
> >>>the NUMA domain (SRAT domains) starts from the layer of DIE. (The topology of our board is core->cluster->die->package).
> >>
> >>I commented about that on the EDK2 mailing list. While the current spec
> >>doesn't explicitly ban having the flag set multiple times between the leaf
> >>and the root I consider it a "bug" and there is an effort to clarify the
> >>spec and the use of that flag.
> >>>
> >>>When the kernel starts to build sched_domain, the multi-core sched_domain contains all the cores within a package,
> >>>and the lowest NUMA sched_domain contains all the cores within a die. But the kernel requires that the multi-core
> >>>sched_domain should be a subset of the lowest NUMA sched_domain, so the BUG info is printed.
> >>
> >>Right. I've mentioned this problem a couple of times.
> >>
> >>At at the moment, the spec isn't clear about how the proximity domain is
> >>detected/located within the PPTT topology (a node with a 1:1 correspondence
> >>isn't even required). As you can see from this patch set, we are making the
> >>general assumption that the proximity domains are at the same level as the
> >>physical socket. This isn't ideal for NUMA topologies, like the D05, that
> >>don't align with the physical socket.
> >>
> >>There are efforts underway to clarify and expand upon the specification to
> >>deal with this general problem. The simple solution is another flag (say
> >>PPTT_PROXIMITY_DOMAIN which would map to the D05 die) which could be used to
> >>find nodes with 1:1 correspondence. At that point we could add a fairly
> >>trivial patch to correct just the scheduler topology without affecting the
> >>rest of the system topology code.
> >
> >I think Morten asked already but isn't this the same end result we end
> >up having if we remove the DIE level if NUMA-within-package is detected
> >(instead of using the default_topology[]) and we create our own ARM64
> >domain hierarchy (with DIE level removed) through set_sched_topology()
> >accordingly ?
> 
> I'm not sure what removing the die level does for you, but its not really
> the problem AFAIK, the problem is because MC layer is larger than the NUMA
> domains.

Do you mean MC domains are larger than NUMA domains because that
reflects the hardware topology, i.e. you have caches shared across NUMA
nodes, or do you mean the problem is that the current code generates too
large MC domains?

If is it the first, then you have to make a choice whether you want
multi-core scheduling or NUMA-scheduling at that level in the topology.
You can't have both. If you don't want NUMA scheduling at that level you
should define your NUMA nodes to be larger than (or equal to?) the MC
domains, or not define NUMA nodes at all. If you do want NUMA
scheduling at that level, we have to ignore any cache sharing between
NUMA nodes and reduce the size of the MC domains accordingly.

We should be able to reduce the size of the MC domains based on in the
information already in the ACPI spec. SRAT defines the NUMA domains, if
the PPTT package level is larger than the NUMA nodes we should claim it
is NUMA in package, drop the DIE level and reduce the size of the MC
domain to equal to the NUMA node size ignoring any PPTT topology
information above the NUMA node level.

AFAICT, x86 doesn't have this problem as they don't use PPTT, and the
last-level cache is always inside the NUMA node, even for
numa-in-package. For numa-in-package they seem to let SRAT define the
NUMA nodes, have a special topology table for the non-NUMA levels only
containing SMT and MC, and guarantee the MC isn't larger than the NUMA
node.

Can't we just follow the same approach with the addition that we have to
resize the MC domains if necessary?

> >Put it differently: do we really need to rely on another PPTT flag to
> >collect this information ?
> 
> Strictly no, and I have a partial patch around here i've been meaning to
> flush out which uses the early node information to detect if there are nodes
> smaller than the package. Initially I've been claiming i was going to stay
> away from making scheduler topology changes in this patch set, but it seems
> that at least providing a patch which does the minimal bits is in the cards.
> The PXN flag was is more of a shortcut to finding the cache levels at or
> below the numa domains, rather than any hard requirement. Similarly, to the
> request someone else was making for a leaf node flag (or node ordering) to
> avoid multiple passes in the table. That request would simplify the posted
> code a bit but it works without it.

I don't see how a flag defining the proximity domains in PPTT makes this
a lot easier. PPTT and setting this flag would have to be mandatory for
NUMA in package systems for the flag to make any difference.

Morten
