From: Matt Longnecker <mlongnecker@nvidia.com>
Subject: Re: [PATCH] thermal: tell cooling devices when a trip_point changes
Date: Thu, 31 Jul 2014 10:17:17 -0700
Message-ID: <53DA7A1D.8010403@nvidia.com>
References: <53D97B70.1050305@nvidia.com> <1406795457.10148.17.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406795457.10148.17.camel@rzhang1-toshiba>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dtundlam@nvidia.com
List-Id: linux-pm@vger.kernel.org

I should have labeled my message RFC. My intent was to generate some 
public discussion about a problem I've hit -- not to get this particular 
patch merged.

On 07/31/2014 01:30 AM, Zhang Rui wrote:
> On Wed, 2014-07-30 at 16:10 -0700, Matt Longnecker wrote:
>> Some hardware can react autonomously at a programmed temperature.
>
> if you have a temperature sensor, then you should have a thermal zone
> device driver for it, right?
>

Yes, but....

In existing "downstream" Tegra kernels, thermal sensor drivers directly 
register thermal zones with thermal_core.c. Drivers get information for 
the zone (e.g. trip points, cooling maps, etc). Each driver has its own 
format for this zone-related information.

Now we're moving away from board files and toward device tree.

of-thermal offers a canonical way to encode zone-related information in 
device tree. I don't want to invent a competing alternative.

As of-thermal parses device tree, it creates thermal zones. Sensor 
drivers no longer need to register zones -- they just register with 
of-thermal as sensor drivers.

of-thermal hides trip points and cooling maps from sensor drivers. This 
is good and bad. It's good because it eliminates a _lot_ of thermal zone 
boilerplate code from sensor drivers. It's bad because it breaks an 
existing usecase:
* the kernel configures the hardware thermal reaction (e.g. catastrophic 
shutdown) according to platform-data provided at boot
* a user adjusts the shutdown temperature at runtime by poking at 
/sys/class/thermal/thermal_zone*/trip_point_*_temp

My patch offers one way to support this usecase in systems using 
of-thermal to manage thermal zones. I'm happy to discuss alternatives.

>> For example, an SoC might implement a last ditch throttle or a
>> hardware thermal shutdown.
>
> And it should be handled by the thermal zone driver, who has the
> knowledge of when to do throttle/shutdown.
>

of-thermal doesn't support this because it doesn't propagate trip point 
changes to sensor drivers.

Thanks,
Matt Longnecker
