From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v12 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Mon, 23 Jul 2018 13:05:22 +0200
Message-ID: <CAJZ5v0h4FLhMJY0fg5q0vBewnNssmpvXHzADg=iDFSfq6Dg=rw@mail.gmail.com>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
	<20180708173413.1965-2-vivek.gautam@codeaurora.org>
	<17407514.unFVTGoGrn@aspire.rjw.lan>
	<CAFp+6iHxJucfzJJeEvSToG4p2zADjDb9F0L8h053x-JKAy55mg@mail.gmail.com>
	<CAJZ5v0gbkdkx_+oHYiPz=SFdFCLm38hsi1TmJ2Jdc7j73TNtzg@mail.gmail.com>
	<CGME20180711125157epcas1p3712f4a02f4442287c18e470d0a8d516f@epcas1p3.samsung.com>
	<CAAFQd5Cqd=J+_nqRc_sx=sq2ayxwSRMgygvffuHH9nC5R_LjdA@mail.gmail.com>
	<20180711134054eucas1p208566383b25dd74787034929b3081901~AVDO-rPhL2314323143eucas1p2n@eucas1p2.samsung.com>
	<CAJZ5v0g0NwkLmd=tJ0sT4pc8FJSRE8sEu5GRQ7KUUd+YedzjMg@mail.gmail.com>
	<20180723055959eucas1p15a381f2a1287a28e4f78f1fb5fc8e37d~D6gOgxXLK0412704127eucas1p1R@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180723055959eucas1p15a381f2a1287a28e4f78f1fb5fc8e37d~D6gOgxXLK0412704127eucas1p1R-MHMrYXj8g+pqW5MlFJXMulaTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 23, 2018 at 7:59 AM, Marek Szyprowski
<m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi Rafael,
>
> On 2018-07-11 22:36, Rafael J. Wysocki wrote:
>> On Wed, Jul 11, 2018 at 3:40 PM, Marek Szyprowski
>> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

[cut]

>>> Frankly, if there are no other reasons I suggest to wire system
>>> suspend/resume to pm_runtime_force_* helpers:
>>> SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>>>                           pm_runtime_force_resume).
>> Not a good idea at all IMO.
>>
>> Use PM driver flags rather I'd say.
>
> Frankly, till now I wasn't aware of the DPM_FLAG_* in struct dev_pm_info
> 'driver_flags'.

They are a relatively recent addition.

> I've briefly checked them but I don't see the equivalent
> of using SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> pm_runtime_force_resume): keep device suspend if it was runtime suspended
> AND really call pm_runtime_suspend if it was not runtime suspended on
> system suspend.

DPM_FLAG_SMART_SUSPEND is expected to cause that to happen.  If you
want the device to remain in suspend after the system-wide resume from
sleep (if possible), you can set DPM_FLAG_LEAVE_SUSPENDED for it too.

Currently a caveat is that genpd still doesn't support the flags.  I
have patches for that, but I haven't got to posting them yet.  If you
are interested, I can push this work forward relatively quickly, so
please let me know.

>>> This way you will have everything related to suspending and resuming in
>>> one place and you would not need to bother about all possible cases (like
>>> suspending from runtime pm active and suspending from runtime pm suspended
>>> cases as well as restoring proper device state on resume). This is
>>> especially important in recent kernel releases, where devices are
>>> system-suspended regardless their runtime pm states (in older kernels
>>> devices were first runtime resumed for system suspend, what made code
>>> simpler, but wasn't best from power consumption perspective).
>>>
>>> If you go this way, You only need to ensure that runtime resume will also
>>> restore proper device state besides enabling all the clocks. This will
>>> also prepare your driver to properly operate inside power domain, where it
>>> is possible for device to loose its internal state after runtime suspend
>>> when respective power domain has been turned off.
>> I'm not sure if you are aware of the pm_runtime_force_* limitations, though.
>
> What are those limitations?

First off, they don't work with middle-layer code implementing its own
PM callbacks that actually operate on devices (like the PCI bus type
or the generic ACPI PM domain).  This means that drivers using them
may not work on systems with ACPI, for example.

Second, pm_runtime_force_resume() will always try to leave the device
in suspend during system-wide resume from sleep which may not be
desirable.

Finally, they expect the runtime PM status to be updated by
system-wide PM callbacks of devices below the one using them (eg. its
children and their children etc) which generally is not required and
may not take place unless the drivers of those devices use
pm_runtime_force_* themselves.

So careful there.
