From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Wed, 17 Apr 2013 13:15:12 -0400
Message-ID: <516ED8A0.5050706@ti.com>
References: <1365437258-31412-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365437258-31412-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, eduardo.valentin@ti.com
List-Id: linux-pm@vger.kernel.org

Rui,


On 08-04-2013 12:07, Eduardo Valentin wrote:
>
>
> Here is a sequence of fixes and documentation improvements
> thermal code base. This should be first of a series of changes
> I am planing to send out.
>
> On this very first there is no change in functionality, as
> the patches only change symbol names and updates kernel-doc
> comments and their formants.

I am going to rebase this series on top of your latest -next branch and 
resend with your comments.

I believe name standardization could be still be applied though.

>
>
>
> Eduardo Valentin (11):
>    thermal: use strlcpy instead of strcpy
>    thermal: update driver license
>    thermal: rename notify_thermal_framework to thermal_notify_framework
>    thermal: rename get_thermal_instance to thermal_instance_get
>    thermal: rename get_tz_trend to thermal_zone_trend_get
>    thermal: use EXPORT_SYMBOL_GPL
>    thermal: update kernel-doc for thermal_zone_bind_cooling_device
>    thermal: update kernel-doc for thermal_zone_unbind_cooling_device
>    thermal: update kernel-doc for thermal_cooling_device_register
>    thermal: update kernel-doc for create_trip_attrs
>    thermal: update kernel-doc for thermal_zone_device_register
>
>   Documentation/thermal/sysfs-api.txt |    6 +-
>   drivers/thermal/fair_share.c        |    2 +-
>   drivers/thermal/step_wise.c         |    2 +-
>   drivers/thermal/thermal_sys.c       |   90 ++++++++++++++++++++++++-----------
>   include/linux/thermal.h             |    6 +-
>   5 files changed, 70 insertions(+), 36 deletions(-)
>
