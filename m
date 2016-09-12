From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 0/8] CPUs capacity information for heterogeneous
 systems
Date: Mon, 12 Sep 2016 08:24:24 +0100
Message-ID: <20160912072424.GL10409@e106622-lin>
References: <1473085372-2840-1-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473085372-2840-1-git-send-email-juri.lelli-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

this is a ping for people interested in this series. Patches 2,4,7-8
still needs ACKs.

I know it's only been a week since I posted v7, but this series would
pair nicely with asym cpu capacity support bits already sitting in
tip/sched/core. I also know that it might be already late for 4.9 merge
window; nevertheless, still hoping we can make it.

Thanks!

Best,

- Juri

On 05/09/16 15:22, Juri Lelli wrote:
> Hi all,
> 
> version 7 of "CPUs capacity information for heterogeneous systems" patchset [1]
> (please refer to previous postings to get some context).
> 
> A few changes from v6:
> 
>  - rebase on top of mainline (4.8-rc5)
>  - some ACKs collected
>  - changelogs fixes
>  - use cpuinfo.max_freq
>  - add delayed work to unregister notifier
> 
> Patches high level description:
> 
>  o 01/08 introduces documentation for the new optional DT binding
>  o [02-06]/08 add cpu-capacity attribute to TC2, Juno and Juno r2 DTs and
>    provide parsing of such information at boot time
>  o [07-08]/08 introduce sysfs attribute
> 
> In case you would like to test this out, I pushed a branch here:
> 
>  git://linux-arm.org/linux-jl.git upstream/default_caps_v7
> 
> This branch contains additional patches, useful to better understand how CPU
> capacity information is actually used by the scheduler.
> 
> These patches also form the basis for Morten/Dietmar's "Clean-ups and
> asymmetric cpu capacity support" series [2] (and the EAS stack in general).
> 
> Best,
> 
> - Juri
> 
> [1] v1 - https://lkml.org/lkml/2015/11/23/391
>     v2 - https://lkml.org/lkml/2016/1/8/417
>     v3 - https://lkml.org/lkml/2016/2/3/405
>     v4 - https://lkml.org/lkml/2016/3/18/350
>     v5 - https://lkml.org/lkml/2016/6/15/291
>     v6 - https://lkml.org/lkml/2016/7/19/419
> [2] https://lkml.org/lkml/2016/8/31/292 
> 
> 
> Juri Lelli (8):
>   Documentation: arm: define DT cpu capacity-dmips-mhz bindings
>   arm: parse cpu capacity-dmips-mhz from DT
>   arm, dts: add TC2 cpu capacity-dmips-mhz information
>   arm64: parse cpu capacity-dmips-mhz from DT
>   arm64, dts: add Juno cpu capacity-dmips-mhz information
>   arm64, dts: add Juno r2 cpu capacity-dmips-mhz information
>   arm: add sysfs cpu_capacity attribute
>   arm64: add sysfs cpu_capacity attribute
> 
>  .../devicetree/bindings/arm/cpu-capacity.txt       | 236 +++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/cpus.txt     |  10 +
>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |   5 +
>  arch/arm/kernel/topology.c                         | 228 +++++++++++++++++++-
>  arch/arm64/boot/dts/arm/juno-r2.dts                |   6 +
>  arch/arm64/boot/dts/arm/juno.dts                   |   6 +
>  arch/arm64/kernel/topology.c                       | 232 +++++++++++++++++++-
>  7 files changed, 721 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt
> 
> -- 
> 2.7.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
