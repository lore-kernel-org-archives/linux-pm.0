From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [linux-pm] [RFC] the generic thermal layer enhancement
Date: Wed, 30 May 2012 10:44:25 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB5912C950@BGSMSX101.gar.corp.intel.com>
References: <1338367742.1472.128.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1338367742.1472.128.camel@rui.sh.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jean Delvare <jdelvare@suse.com>, "Brown, Len" <len.brown@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Rui,

> G1. supporting multiple cooling states for active cooling devices.
> 
>     The current active cooling device supports two cooling states only,
>     please refer to the code below, in driver/thermal/thermal_sys.c
>                 case THERMAL_TRIP_ACTIVE:
>                         ...
>                         if (temp >= trip_temp)
>                                 cdev->ops->set_cur_state(cdev, 1);
>                         else
>                                 cdev->ops->set_cur_state(cdev, 0);
>                         break;
> 
>     This is an ACPI specific thing, as our ACPI FAN used to support
>     ON/OFF only.
>     I think it is reasonable to support multiple active cooling states
>     as they are common on many platforms, and note that this is also
>     true for ACPI 3.0 FAN device (_FPS).
> 
> G2. introduce cooling states range for a certain trip point
> 
>     This problem comes with the first one.
>     If the cooling devices support multiple cooling states, and surely
>     we may want only several cooling states for a certain trip point,
>     and other cooling states for other active trip points.
>     To do this, we should be able to describe the cooling device
>     behavior for a certain trip point, rather than for the entire
>     thermal zone.
> 
> G3. kernel thermal passive cooling algorithm
> 
>     Currently, tc1 and tc2 are hard requirements for kernel passive
>     cooling. But non-ACPI platforms do not have this information
>     (please correct me if I'm wrong).
>     Say, for the patches here
>     http://marc.info/?l=linux-acpi&m=133681581305341&w=2
>     They just want to slow down the processor when current temperature
>     is higher than the trip point and speed up the processor when the
>     temperature is lower than the trip point.
> 
>     According to Matthew, the platform drivers are responsible to
>     provide proper tc1 and tc2 values to use kernel passive cooling.
>     But I'm just wondering if we can use something instead.
>     Say, introduce .get_trend() in thermal_zone_device_ops.
>     And we set cur_state++ or cur_state-- based on the value returned
>     by .get_trend(), instead of using tc1 and tc2.

Yes we should do that. I would also like to remove these values from the
registration API's. That makes the registration code way more simpler.
Right now, I do not see any driver using thermal_zone_device_register
with values other than 0's for these.

> 
> G4. Multiple passive trip points
> 
>     I get this idea also from the patches at
>     http://marc.info/?l=linux-acpi&m=133681581305341&w=2
> 
>     IMO, they want to get an acceptable performance at a tolerable
>     temperature.
>     Say, a platform with four P-states. P3 is really low.
>     And I'm okay with the temperature at 60C, but 80C? No.
>     With G2 resolved, we can use processor P0~P2 for Passive trip point
>     0 (50C), and P3 for Passive trip point 1 (70C). And then the
>     temperature may be jumping at around 60C or even 65C, without
>     entering P3.
> 
>     Further more, IMO, this also works for ACPI platforms.
>     Say, we can easily change p-state to cool the system, but using
>     t-state is definitely what we do not want to see. The current
>     implementation does not expose this difference to the generic
>     thermal layer, but if we can have two passive trip points, and use
>     p-state for the first one only... (this works if we start polling
>     after entering passive cooling mode, without hardware notification)
> 
> G5. unify active cooling and passive cooling code
> 
>     If G4 and G5 are resolved, a new problem to me is that there is no
>     difference between passive cooling and active cooling except the
>     cooling policy.

Correct...

>     Then we can share the same code for both active and passive cooling.
>     maybe something like:

Or just use TRIP_PASSIVE...

> 
>     case THERMAL_TRIP_ACTIVE:
>     case THERMAL_TRIP_PASSIVE:
>          ...
>          tz->ops->get_trend();
>          if (trend == HEATING)
>                  cdev->ops->set_cur_state(cdev, cur_state++);
>          else if (trend == COOLING)
>                  cdev->ops->set_cur_state(cdev, cur_state--);
>          break;

I agree with you here...

Thanks,
Durga

