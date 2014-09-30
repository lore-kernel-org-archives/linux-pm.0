From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH 0/9] powerpc/powernv: Support for fastsleep and winkle
Date: Tue, 30 Sep 2014 22:13:45 +0200
Message-ID: <2668893.Uahb5Sli9g@vostro.rjw.lan>
References: <1408989673-14137-1-git-send-email-shreyas@linux.vnet.ibm.com> <128377046.aOTypBOIY8@vostro.rjw.lan> <542A65D5.4090003@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <542A65D5.4090003-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shreyas B Prabhu <shreyas-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "Srivatsa S. Bhat" <srivatsa-3s7WtUTddSA@public.gmane.org>, "Preeti U. Murthy" <preeti-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Vaidyanathan Srinivasan <svaidy-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 30, 2014 01:42:05 PM Shreyas B Prabhu wrote:
> Hi Rafael,
> 
> On Tuesday 30 September 2014 04:58 AM, Rafael J. Wysocki wrote:
> > On Monday, September 29, 2014 03:53:06 PM Shreyas B Prabhu wrote:
> >> Hi,
> >> Any updates on this patch series?
> > 
> > I have a couple of patches from there in my tree it seems.  Please have a look
> > at linux-pm.git/linux-next and please let me know if that's the case.
> > 
> 
> I checked linux-pm.git/linux-net (Last commit 067c17382165). None of the patches
> in this series are present in the tree. 

OK, thanks for checking.

Would you mind resending it with any ACKs or Reviewed-by tags received so far?


> >> On Thursday 18 September 2014 08:41 AM, Shreyas B Prabhu wrote:
> >>> Hi,
> >>>
> >>> In this patch series we use winkle for offlined cores. I successfully
> >>> tested the working of this with subcore functionality.
> >>>
> >>> Test scenario was as follows:
> >>> 1. Set SMT mode to 1, Set subores-per-core to 1
> >>> 2. Offline a core, in this case cpu 32 (sending it to winkle)
> >>> 3. Set subcores-per-core to 4
> >>> 4. Online the core
> >>> 5. Start a guest (Topology 1 core 2 threads) on a subcore, in this case
> >>> on cpu 36
> >>>
> >>> This works without any glitch.
> >>>
> >>> Thanks,
> >>> Shreyas
> >>>
> >>> On Monday 25 August 2014 11:31 PM, Shreyas B. Prabhu wrote:
> >>>> Fast sleep is an idle state, where the core and the L1 and L2
> >>>> caches are brought down to a threshold voltage. This also means that
> >>>> the communication between L2 and L3 caches have to be fenced. However
> >>>> the current P8 chips have a bug wherein this fencing between L2 and
> >>>> L3 caches get delayed by a cpu cycle. This can delay L3 response to
> >>>> the other cpus if they request for data during this time. Thus they
> >>>> would fetch the same data from the memory which could lead to data
> >>>> corruption if L3 cache is not flushed.
> >>>> Patch 4 adds support to work around this.
> >>>>
> >>>> 'Deep Winkle' is a deeper idle state where core and private L2 are powered
> >>>> off. While it offers higher power savings, it is at the cost of losing
> >>>> hypervisor register state and higher latency.
> >>>> Patch 5-9 adds support for winkle and uses it for offline cpus.
> >>>>
> >>>> Patch 1 - Moves parameters required discover idle states to a location 
> >>>> common to both cpuidle driver and powernv core code
> >>>> Patch 2 - Populates idle state details from device tree
> >>>> Patch 3 - Enables cpus to run guest after waking up from fastsleep/winkle
> >>>>
> >>>>
> >>>> Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> >>>> Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
> >>>> Cc: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
> >>>> Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> >>>> Cc: Srivatsa S. Bhat <srivatsa-DPNOqEs/LNQ@public.gmane.org>
> >>>> Cc: Preeti U. Murthy <preeti-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> >>>> Cc: Vaidyanathan Srinivasan <svaidy-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> >>>> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >>>> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>>> Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>>> Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> >>>>
> >>>> Preeti U Murthy (2):
> >>>>   cpuidle/powernv: Populate cpuidle state details by querying the
> >>>>     device-tree
> >>>>   powerpc/powernv/cpuidle: Add workaround to enable fastsleep
> >>>>
> >>>> Shreyas B. Prabhu (6):
> >>>>   powerpc/kvm/book3s_hv: Enable CPUs to run guest after waking up from
> >>>>     fast-sleep
> >>>>   powerpc/powernv: Add OPAL call to save and restore
> >>>>   powerpc: Adding macro for accessing Thread Switch Control Register
> >>>>   powerpc/powernv: Add winkle infrastructure
> >>>>   powerpc/powernv: Discover and enable winkle
> >>>>   powerpc/powernv: Enter deepest supported idle state in offline
> >>>>
> >>>> Srivatsa S. Bhat (1):
> >>>>   powerpc/powernv: Enable Offline CPUs to enter deep idle states
> >>>>
> >>>>  arch/powerpc/include/asm/machdep.h             |   4 +
> >>>>  arch/powerpc/include/asm/opal.h                |  10 ++
> >>>>  arch/powerpc/include/asm/paca.h                |   3 +
> >>>>  arch/powerpc/include/asm/ppc-opcode.h          |   2 +
> >>>>  arch/powerpc/include/asm/processor.h           |   6 +-
> >>>>  arch/powerpc/include/asm/reg.h                 |   1 +
> >>>>  arch/powerpc/kernel/asm-offsets.c              |   1 +
> >>>>  arch/powerpc/kernel/exceptions-64s.S           |  37 ++---
> >>>>  arch/powerpc/kernel/idle.c                     |  30 ++++
> >>>>  arch/powerpc/kernel/idle_power7.S              |  83 +++++++++-
> >>>>  arch/powerpc/platforms/powernv/opal-wrappers.S |   2 +
> >>>>  arch/powerpc/platforms/powernv/powernv.h       |   8 +
> >>>>  arch/powerpc/platforms/powernv/setup.c         | 217 +++++++++++++++++++++++++
> >>>>  arch/powerpc/platforms/powernv/smp.c           |  13 +-
> >>>>  arch/powerpc/platforms/powernv/subcore.c       |  15 ++
> >>>>  drivers/cpuidle/cpuidle-powernv.c              |  40 ++++-
> >>>>  16 files changed, 439 insertions(+), 33 deletions(-)
> >>>>
> >>
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
