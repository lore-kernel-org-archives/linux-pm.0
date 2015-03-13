From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/10] pm: domains: sync runtime PM status with PM domains after probe
Date: Fri, 13 Mar 2015 10:33:41 -0700
Message-ID: <7hzj7gpzt6.fsf@deeprootsystems.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
	<E1YWSN5-0006G5-Ld@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1YWSN5-0006G5-Ld-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org> (Russell King's
	message of "Fri, 13 Mar 2015 16:23:35 +0000")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> writes:

> Synchronise the PM domain status with runtime PM's status after a
> platform device has been probed.  This augments the solution in commit
> 2ed127697eb1 ("PM / Domains: Power on the PM domain right after attach
> completes").
>
> The above commit added a call to power up the PM domain when a device
> attaches to the domain in order to match the behaviour required by
> drivers that make no use of runtime PM.  The assumption is that the
> device driver will cause a runtime PM transition, which will synchronise
> the PM domain state with the runtime PM state.
>
> However, by default, runtime PM will assume that the device is initially
> suspended, and some drivers may make use of this should they not need to
> touch the hardware during probe.
>
> In order to allow such drivers, trigger the PM domain code to check
> whether the PM domain can be suspended after the probe function, undoing
> the effect of the power-on prior to the probe.
>
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

[ Since I hadn't seen this version yet, repeating comment from the
  previous version so it doesn't get lost. ]

I think this is a good fix to the existing problem.  One minor nit on a
comment below, otherwise:

Acked-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> +/**
> + * dev_pm_domain_sync - synchronise the PM domain state with its devices
> + * @dev: device corresponding with domain
> + *
> + * Synchronise the PM domain state with the recently probed device, which
> + * may be in a variety of PM states.  This ensures that a device which
> + * enables runtime PM in suspended state, and never transitions to active
> + * in its probe handler is properly suspended after the probe.
> + */

It's not the *device* tha needs to be properly suspended after the probe
(since it's already/still runtime suspended), but the pm_domain that
would be potentially powered down.  Hence, I'd reword the last sentence
slightly:

   This ensures that a device which enables runtime PM in suspended
   state, and never transitions to active in its probe handler gives an
   opportunity for the PM domain to be powered down after the probe.

Kevin
