From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime
	suppliers
Date: Thu, 15 Feb 2018 17:14:45 +0000
Message-ID: <7406f1ce-c2c9-a6bd-2886-5a34de45add6@arm.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
	<CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
	<CAF6AEGs8qcRTvz6srSfc39ybZrPYMVg2w6qkaO2AdWL1GD4mQw@mail.gmail.com>
	<CAAFQd5BKRumpEfAKNF_RKS-ZZ8D671DfOz4vB2+w1SV3aG9NxQ@mail.gmail.com>
	<CAF6AEGuNZJKtwGZ5mLfqNND2jtU+HYM11UONfAtVTzoM0QVpdg@mail.gmail.com>
	<CAAFQd5BZJ1G0RG32hYErNzPRvisBhhiSNCBsjbzfm0WzO=DnsQ@mail.gmail.com>
	<CAFp+6iHaycK=CcE1S15EeuMkaw8LnW0ebptU0hM6tUtWdeEOtA@mail.gmail.com>
	<CAAFQd5Afj-Bj+3wHwmF2tT7y=46EsYEtO_mXfY6stXBgHutEUg@mail.gmail.com>
	<CAFp+6iGX6pr+MdPSSHHG=qOnhHky_8OHiDqAcJ9UudEUv=JMHg@mail.gmail.com>
	<CAAFQd5DiwAugGnPOTw0+XrEfef9x-n-vx59JFuXpNawjiXHwCw@mail.gmail.com>
	<CAFp+6iEW0faeHDfzN_F1bRrHGcVo3sPCk4HSY=t9dnEvHkDkYw@mail.gmail.com>
	<b003ecda-1cbe-4e5f-872b-107154ac40e5@arm.com>
	<CAAFQd5AmG1zSm+CouXOCJbs8SNGFk1-RqfU1nWGjMGJMB-qfvw@mail.gmail.com>
	<CAAFQd5A9B-di9svtiJbvk2hz1U1xo61rTY5vt6AD+KR5iMcG-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5A9B-di9svtiJbvk2hz1U1xo61rTY5vt6AD+KR5iMcG-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 15/02/18 04:17, Tomasz Figa wrote:
[...]
>> Could you elaborate on what kind of locking you are concerned about?
>> As I explained before, the normally happening fast path would lock
>> dev->power_lock only for the brief moment of incrementing the runtime
>> PM usage counter.
> 
> My bad, that's not even it.
> 
> The atomic usage counter is incremented beforehands, without any
> locking [1] and the spinlock is acquired only for the sake of
> validating that device's runtime PM state remained valid indeed [2],
> which would be the case in the fast path of the same driver doing two
> mappings in parallel, with the master powered on (and so the SMMU,
> through device links; if master was not powered on already, powering
> on the SMMU is unavoidable anyway and it would add much more latency
> than the spinlock itself).

We now have no locking at all in the map path, and only a per-domain 
lock around TLB sync in unmap which is unfortunately necessary for 
correctness; the latter isn't too terrible, since in "serious" hardware 
it should only be serialising a few cpus serving the same device against 
each other (e.g. for multiple queues on a single NIC).

Putting in a global lock which serialises *all* concurrent map and unmap 
calls for *all* unrelated devices makes things worse. Period. Even if 
the lock itself were held for the minimum possible time, i.e. trivially 
"spin_lock(&lock); spin_unlock(&lock)", the cost of repeatedly bouncing 
that one cache line around between 96 CPUs across two sockets is not 
negligible.

> [1] http://elixir.free-electrons.com/linux/v4.16-rc1/source/drivers/base/power/runtime.c#L1028
> [2] http://elixir.free-electrons.com/linux/v4.16-rc1/source/drivers/base/power/runtime.c#L613
> 
> In any case, I can't imagine this working with V4L2 or anything else
> relying on any memory management more generic than calling IOMMU API
> directly from the driver, with the IOMMU device having runtime PM
> enabled, but without managing the runtime PM from the IOMMU driver's
> callbacks that need access to the hardware. As I mentioned before,
> only the IOMMU driver knows when exactly the real hardware access
> needs to be done (e.g. Rockchip/Exynos don't need to do that for
> map/unmap if the power is down, but some implementations of SMMU with
> TLB powered separately might need to do so).

It's worth noting that Exynos and Rockchip are relatively small 
self-contained IP blocks integrated closely with the interfaces of their 
relevant master devices; SMMU is an architecture, implementations of 
which may be large, distributed, and have complex and wildly differing 
internal topologies. As such, it's a lot harder to make 
hardware-specific assumptions and/or be correct for all possible cases.

Don't get me wrong, I do ultimately agree that the IOMMU driver is the 
only agent who ultimately knows what calls are going to be necessary for 
whatever operation it's performing on its own hardware*; it's just that 
for SMMU it needs to be implemented in a way that has zero impact on the 
cases where it doesn't matter, because it's not viable to specialise 
that driver for any particular IP implementation/use-case.

Robin.


*AFAICS it still makes some sense to have the get_suppliers option as 
well, though - the IOMMU driver does what it needs for correctness 
internally, but the external consumer doing something non-standard can 
can grab and hold the link around multiple calls to short-circuit that.
