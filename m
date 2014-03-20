From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC 0/1] thermal: rcar-thermal: add cpu cooling
Date: Thu, 20 Mar 2014 13:55:02 +0800
Message-ID: <1395294902.3571.8.camel@rzhang1-mobl4>
References: <1393599758-17315-1-git-send-email-ptitiano@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1393599758-17315-1-git-send-email-ptitiano@baylibre.com>
Sender: linux-sh-owner@vger.kernel.org
To: Patrick Titiano <ptitiano@baylibre.com>
Cc: magnus.damm@gmail.com, kuninori.morimoto.gx@renesas.com, eduardo.valentin@ti.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2014-02-28 at 16:02 +0100, Patrick Titiano wrote:
> Hi,
> This not-yet-ready-to-merge patch proposes to enable CPU thermal management on
> Renesas platform. Currently these platforms only register a thermal zone,
> but do not implement or register any cooling device.
> 
> With this patch:
>  - CPU0 cpufreq driver is registered as a cooling device,
>  - a new passive trip point is defined to trigger CPU scaling when temperature
>    crosses it,
>  - CPU0 cooling device and thermal zone 0 are being bound together,
>  - set_trip_temp callback is implemented to facilitate experimentation and 
>    platform tuning. 
> 
> Developed on a RCar-H2 platform, it is intended to support multi-platform.
> It leverages CPUFreq support from the series Benoit Cousson recently shared
> (http://www.spinics.net/lists/linux-sh/msg29236.html).
> The passive trip point temperature is arbitrarily set to 70C, as no HW data was
> available at the time this patch was developed.
> 
> Being multi-platform, this patch is expected to run smoothly in any situation:
>  1/ Platform has no thermal sensor,
>  2/ Platform has a thermal sensor and is DVFS capable,
>  3/ Platform has a thermal sensor but is not DVFS capable.
> 
> This patch has no side-effect in case 1/ (thermal driver wouldn't be loaded).
> Case 2/ is the regular case, no issue.
> case 3/ is the problematic one.
> Using cpufreq driver as a cooling device adds a dependency between those 2
> drivers. This is taken care by deferring rcar-thermal probing until
> cpufreq driver is up, but this becomes an issue when a platform does
> not have DVFS support. cpufreq driver will never be probed, blocking
> rcar-thermal probing.
> 
> We are still investigation what would be the best way to go, however we would
> appreciate a lot any advice from the community.

Then why you make the rcar-thermal depends on the success of
cpufreq_cooling_register()?
IMO, you can just register two trip points first, and bind the cpu
cooling device to passive trip point only if cpufreq_cooling_register()
succeeds.

thanks,
rui
> Thanks!
> 
> Regards,
> Patrick.
> 
> Patrick Titiano (1):
>   thermal: rcar-thermal: add cpu cooling
> 
>  drivers/thermal/rcar_thermal.c | 103 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 96 insertions(+), 7 deletions(-)
> 


