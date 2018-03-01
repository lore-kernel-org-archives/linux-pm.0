From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH v6 11/12] arm64: topology: enable ACPI/PPTT based CPU
 topology
Date: Thu, 1 Mar 2018 14:19:03 +0000
Message-ID: <20180301141903.GH4589@e105550-lin.cambridge.arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-12-jeremy.linton@arm.com>
 <928cb0c9-1d7a-3d0c-0538-a8bb0e2a86b1@huawei.com>
 <b4060cb0-6eed-f34a-00d5-4c2f55f20220@arm.com>
 <20180223110238.GB20461@e107981-ln.cambridge.arm.com>
 <2d248f08-79b6-d5e2-7e34-31a21efcdc07@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2d248f08-79b6-d5e2-7e34-31a21efcdc07@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 24, 2018 at 11:05:53AM +0800, Xiongfeng Wang wrote:
> 
> Hi,
> On 2018/2/23 19:02, Lorenzo Pieralisi wrote:
> > On Thu, Jan 25, 2018 at 09:56:30AM -0600, Jeremy Linton wrote:
> >> Hi,
> >>
> >> On 01/25/2018 06:15 AM, Xiongfeng Wang wrote:
> >>> Hi Jeremy,
> >>>
> >>> I have tested the patch with the newest UEFI. It prints the below error:
> >>>
> >>> [    4.017371] BUG: arch topology borken
> >>> [    4.021069] BUG: arch topology borken
> >>> [    4.024764] BUG: arch topology borken
> >>> [    4.028460] BUG: arch topology borken
> >>> [    4.032153] BUG: arch topology borken
> >>> [    4.035849] BUG: arch topology borken
> >>> [    4.039543] BUG: arch topology borken
> >>> [    4.043239] BUG: arch topology borken
> >>> [    4.046932] BUG: arch topology borken
> >>> [    4.050629] BUG: arch topology borken
> >>> [    4.054322] BUG: arch topology borken
> >>>
> >>> I checked the code and found that the newest UEFI set PPTT physical_package_flag on a physical package node and
> >>> the NUMA domain (SRAT domains) starts from the layer of DIE. (The topology of our board is core->cluster->die->package).
> >>
> >> I commented about that on the EDK2 mailing list. While the current spec
> >> doesn't explicitly ban having the flag set multiple times between the leaf
> >> and the root I consider it a "bug" and there is an effort to clarify the
> >> spec and the use of that flag.
> >>>
> >>> When the kernel starts to build sched_domain, the multi-core sched_domain contains all the cores within a package,
> >>> and the lowest NUMA sched_domain contains all the cores within a die. But the kernel requires that the multi-core
> >>> sched_domain should be a subset of the lowest NUMA sched_domain, so the BUG info is printed.
> >>
> >> Right. I've mentioned this problem a couple of times.
> >>
> >> At at the moment, the spec isn't clear about how the proximity domain is
> >> detected/located within the PPTT topology (a node with a 1:1 correspondence
> >> isn't even required). As you can see from this patch set, we are making the
> >> general assumption that the proximity domains are at the same level as the
> >> physical socket. This isn't ideal for NUMA topologies, like the D05, that
> >> don't align with the physical socket.
> >>
> >> There are efforts underway to clarify and expand upon the specification to
> >> deal with this general problem. The simple solution is another flag (say
> >> PPTT_PROXIMITY_DOMAIN which would map to the D05 die) which could be used to
> >> find nodes with 1:1 correspondence. At that point we could add a fairly
> >> trivial patch to correct just the scheduler topology without affecting the
> >> rest of the system topology code.
> > 
> > I think Morten asked already but isn't this the same end result we end
> > up having if we remove the DIE level if NUMA-within-package is detected
> > (instead of using the default_topology[]) and we create our own ARM64
> > domain hierarchy (with DIE level removed) through set_sched_topology()
> > accordingly ?
> > 
> > Put it differently: do we really need to rely on another PPTT flag to
> > collect this information ?
> > 
> > I can't merge code that breaks a platform with legitimate firmware
> > bindings.
> 
> I think we really need another PPTT flag, from which we can get information
> about how to build a multi-core sched_domain. I think only cache-sharing information
> is not enough to get information about how to build a multi-core shced_domain.
> 
> How about this? We assume the upper layer of the lowest layer to be multi-core layer.
> After that flag is added into ACPI specs, we add another patch to adapt to the change.

I'm not sure what you mean by upper layers of the lowest layer.

As I see it for non-numa-in-package system, the PPTT physical package
flag should define the MC domains, any levels above should be
represented in the DIE level, any level below should be ignored, except
the lowest level if we have SMT. If have SMT the lowest level in PPTT
should define the SMT domains.

For numa-in-package, the MC domains should be shrunk to match the NUMA
nodes and DIE is ignored.
