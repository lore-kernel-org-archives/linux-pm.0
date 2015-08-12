From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v2 1/4] thermal: power_allocator: relax the requirement of
 a sustainable_power in tzp
Date: Wed, 12 Aug 2015 19:05:17 +0800
Message-ID: <CAGS+omCOi88oXD7P4oODOmWfBZVA3CaZkqiQcHr7ff8ojV=2tA@mail.gmail.com>
References: <1439222692-3535-1-git-send-email-javi.merino@arm.com>
 <1439288493-19740-1-git-send-email-javi.merino@arm.com> <1439288493-19740-2-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439288493-19740-2-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chung-yih Wang <cywang@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <punit.agrawal@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Javi,

One Tiny nit below...

On Tue, Aug 11, 2015 at 6:21 PM, Javi Merino <javi.merino@arm.com> wrote:
> The power allocator governor currently requires that a sustainable power
> is passed as part of the thermal zone's thermal zone parameters.  If
> that parameter is not provided, it doesn't register with the thermal
> zone.
>
> While this parameter is strongly recommended for optimal performance, it
> doesn't need to be mandatory.  Relax the requirement and allow the
> governor to bind to thermal zones that don't provide it by estimating it
> from the cooling devices' power model.
>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---

[snip]

> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -997,6 +997,34 @@ int power_actor_get_max_power(struct thermal_cooling_device *cdev,
>  }
>
>  /**
> + * power_actor_get_min_power() - get the mainimum power that a cdev can consume
> + * @cdev:      pointer to &thermal_cooling_device
> + * @tz:                a valid thermal zone device pointer
> + * @min_power: pointer in which to store the minimum power
> + *
> + * Calculate the minimum power consumption in milliwats that the
                                                 ^
                                                 milliwatts

Thanks,
-Dan
