From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 3/9] pm: domains: sync runtime PM status with PM domains after probe
Date: Fri, 13 Mar 2015 09:45:39 -0700
Message-ID: <7hlhj0vob0.fsf@deeprootsystems.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
	<E1YW7sv-0003mA-JP@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:46862 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054AbbCMQpm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 12:45:42 -0400
Received: by pabli10 with SMTP id li10so30701377pab.13
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 09:45:42 -0700 (PDT)
In-Reply-To: <E1YW7sv-0003mA-JP@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Thu, 12 Mar 2015 18:31:05 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

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
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I think this is a good fix to the existing problem.  One minor nit on a
comment below, otherwise

Acked-by: Kevin Hilman <khilman@linaro.org>

[...]

> +
> +/**
> + * dev_pm_domain_sync - synchronise the PM domain state with its devices
> + * @dev: device corresponding with domain
> + *
> + * Synchronise the PM domain state with the recently probed device, which
> + * may be in a variety of PM states.  This ensures that a device which
> + * enables runtime PM in suspended state, and never transitions to active
> + * in its probe handler is properly suspended after the probe.
> + */

Tt's not the *device* tha needs to be properly suspended after the probe
(since it's already/still runtime suspended), but the pm_domain that would
be potentially powered down.  Hence, I'd reword the last sentence slightly:

   This ensures that a device which enables runtime PM in suspended
   state, and never transitions to active in its probe handler gives an
   opportunity for the PM domain to be powered down after the probe.

Kevin
