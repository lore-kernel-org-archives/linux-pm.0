From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 0/4] ARM: K2G: Add support for TI-SCI Generic PM Domains
Date: Tue, 25 Oct 2016 10:02:39 -0700
Message-ID: <7hr374uztc.fsf@baylibre.com>
References: <20161019203347.17893-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161019203347.17893-1-d-gerlach-l0cyMroinI0@public.gmane.org> (Dave Gerlach's message
        of "Wed, 19 Oct 2016 15:33:43 -0500")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> writes:

> Hi,
> This is v2 of the series to add support for TI SCI PM Domains. v1 of
> the series can be found here [1]. Several things have changed since v1:
>
> - New patch to add a void *data to struct generic_pm_domain_data to
>   allow to store per device data associated with a genpd
> - From v1, squash patch 1 and 2 to introduce docs and dt-bindings in
>   one patch based on comment from Ulf
> - Fix some grammar errors in Documentation
> - Based on comments from Ulf, rework actual genpd implementation to
>   avoid creating one genpd per device and instead use device start/stop
>   hooks provided as part of genpd to control device state based on pm_runtime
>   implementation. Also make use of new of_genpd_add_provider_simple API
>   introduced by Jon Hunter and do not provide custom of_xlate to genpd core,
>   instead registering devices as they probe through attach_dev hook provided
>   by genpd framework.
>
> Most of the changes were motivated by the comments from Ulf Hannson on v1 that we
> should not use a 1-to-1 genpd to device mapping. The new approach allows us to
> create a single genpd and store information about each device as they attach to
> the genpd. Then the device start/stop hooks for that genpd leverage the
> per-device data to control power states over the TI SCI protocol.
>
> This driver makes use of the ti_sci driver sent here [2] by Nishanth Menon and
> applies on top of his series on v4.9-rc1.

Reviewed-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
