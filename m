From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [RESEND PATCH v3 2/2] thermal: core: introduce thermal zone
 device mode control
Date: Thu, 28 Jun 2018 17:33:02 -0700
Message-ID: <20180629003302.GT129942@google.com>
References: <20180226144118.24693-1-enric.balletbo@collabora.com>
 <20180226144118.24693-2-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180226144118.24693-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: rui.zhang@intel.com, rjw@rjwysocki.net, groeck@chromium.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, snanda@chromium.org, lenb@kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

I stumbled across this patch since I'm currently poking around with
early thermal bringup on a platform and this patch has been integrated
in our development tree.

I'm seeing some unexpected behaviors, which could entirely due to
wrong expectation from my side. I only have some basic working
knowledge of the thermal framework, just want to double check and
perhaps learn a thing or two.

On Mon, Feb 26, 2018 at 03:41:18PM +0100, Enric Balletbo i Serra wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Thermal "mode" sysfs attribute is introduced to enable/disable a thermal
> zone, and .get_mode()/.set_mode() callback is introduced for platform
> thermal driver to enable/disable the hardware thermal control logic. And
> thermal core takes no action upon thermal zone enable/disable.
> 
> Actually, this is not quite right because thermal core still pokes those
> disabled thermal zones occasionally, e.g. upon system resume.
> 
> To fix this, a new flag 'mode' is introduced in struct thermal_zone_device
> to represent the thermal zone mode, and several decisions have been made
> based on this flag, including
> 1. check the thermal zone mode right after it's registered.
> 2. skip updating thermal zone if the zone is disabled
> 3. stop the polling timer when the thermal zone is disabled
> 
> Note: basically, this patch doesn't affect the existing always-enabled
> thermal zones much, with just one exception -
> thermal zone .get_mode() must be well prepared to reflect the real thermal
> zone status upon the thermal zone registration.

>From my perspective this looks like a pretty significant change. For
the platform I'm working on I added a thermal zone to the device tree,
with the expectation that it would be enabled. Judging from the code
without this patch this expectation seems to be naive, since
of-thermal.c sets tz->mode to THERMAL_DEVICE_DISABLED, so apparently
either userspace or some driver should call _set_mode(tz,
THERMAL_DEVICE_ENABLED). However even without this the thermal zone
appears to be active (I didn't really test end-to-end yet, but at
least thermal_zone_device_update() is called and calls
handle_thermal_trip()). Not sure why this is the case with
THERMAL_DEVICE_DISABLED, but before I learned about the existence of
the flag my expectation was that the zone would be enabled.

With this patch thermal_zone_device_update() is skipped if the zone
hasn't been explictly enabled, which may be consistent with the state
of 'tz->mode', but effectively changes the previous/current behavior.

Not sure if I'm just dumbly overlooking something obvious or if there
is an actual problem with of_thermal (and maybe others).

Any insights?

Thanks

Matthias
