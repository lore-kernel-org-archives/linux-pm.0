From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 0/12] generic thermal layer enhancement
Date: Mon, 11 Jun 2012 12:49:40 +0300
Message-ID: <20120611094940.GA3649@besouro>
References: <1339384751.1492.153.camel@rui.sh.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1339384751.1492.153.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Amit Kachhap <amit.kachhap@linaro.org>, "R, Durgadoss" <durgadoss.r@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, eduardo <eduardo.valentin@ti.com>, "Len, Brown" <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

On Mon, Jun 11, 2012 at 11:19:11AM +0800, Zhang Rui wrote:
> Hi, all,
> 
> this patch set is made to enhance the current generic thermal layer.
> It fixes several gaps discussed in
> http://marc.info/?l=linux-acpi&m=133836783425764&w=2
> and introduces a simple arbitrator to fix the "one cooling devices
> referenced by multiple trip points in multiple thermal zones" problem.

Thanks for taking this further. With code it is much better to progress.

BTW, are you keeping this series somewhere in a branch?

>  
> The whole idea is
> 1) make sure we have multiple cooling states for both active cooling and
>    passive cooling devices. (patch 1,2,3)

Nice!

> 2) remove passive specific requirement, aka, tc1/tc2, and
>    introduce .get_trend() instead, for both active and passive cooling
>    algorithm. (patch 4,5)

Cool. The .get_trend() might be also helpful in case there are sensors
that provide trending computation, or at least, some history buffer.

So, I definitely agree with this approach.

> 3) introduce new function thermal_zone_trip_update(), this contains the
>    code for the general cooling algorithm. (patch 6)

Ok.

> 4) rename some thermal structures. Use thermal_instance instead of
>    thermal_cooling_device_instance, as this structure is used to
>    describe the behavior of a certain cooling device for a certain trip
>    point in a certain thermal zone.
>    thermal_zone_device has a list of all the thermal instances in this
>    thermal zone so that it can update them when the temperature changes.
>    thermal_cooling_device has a list of all the thermal instances for
>    this cooling device so that it can make decision which cooling state
>    should be in when the temperature changes. (patch 7,8,9,10)

Ok.

> 5) introduce a simple arbitrator. (patch 11)
>    When temperature changes, we update a thermal zone in two stages,
>    a) thermal_zone_trip_point() is the general cooling algorithm to
>       update the thermal instances in the thermal zone device
>    b) thermal_zone_do_update() is the arbitrator for the cooling device
>       to choose the deepest cooling state required to enter.

The arbitrator is good starting point. I will have a deeper look on it.

But we may be careful to solve the constraint issue only at thermal code
level. There might be conflicting constraints coming from PM QoS layer,
for instance.

> 6) unify the code for both passive and active cooling.

This is good.

> 
> TODO, add locking mechanism. I know this is important but as this patch
> set changes the thermal layer a(lot, I just want to make sure I'm in the
> right direction before going on.

Right. I second you on the incremental approach.

> 
> BTW, in theory, they should make no change to the behavior of the
> current generic thermal layer users. But I have just done the build
> test.

OK. I will fetch them and give them a trial on my side, then send better review.

> 
> Any comments are welcome.
> 
> thanks,
> rui
> 
> --------------------------------------------------------------------
>  drivers/acpi/thermal.c                   |   76 +++++++--
>  drivers/platform/x86/acerhdf.c           |    4 +-
>  drivers/platform/x86/intel_mid_thermal.c |    2 +-
>  driverk/thermal/spear_thermal.c          |    2 +-
>  drivers/thermal/thermal_sys.c            |  293
> ++++++++++++++++++------------
>  include/linux/thermal.h                  |   22 ++-
>  7 files changed, 271 insertions(+), 148 deletions(-)
> 
> 

--
Eduardo Valentin
