From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: avoid division by zero in power allocator
Date: Thu, 1 Oct 2015 11:17:00 +0100
Message-ID: <20151001101659.GA2817@e104805>
References: <1443475714-19871-1-git-send-email-aarcange@redhat.com>
 <1443475714-19871-2-git-send-email-aarcange@redhat.com>
 <20150929133330.809e7058004395e6db79dec1@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:59774 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754533AbbJAKRJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 06:17:09 -0400
Content-Disposition: inline
In-Reply-To: <20150929133330.809e7058004395e6db79dec1@linux-foundation.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>

On Tue, Sep 29, 2015 at 09:33:30PM +0100, Andrew Morton wrote:
> On Mon, 28 Sep 2015 23:28:34 +0200 Andrea Arcangeli <aarcange@redhat.com> wrote:
> 
> > During boot I get a div by zero Oops regression starting in v4.3-rc3.
> > 
> > ...
> >
> > --- a/drivers/thermal/power_allocator.c
> > +++ b/drivers/thermal/power_allocator.c
> > @@ -144,6 +144,16 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
> >  		switch_on_temp = 0;
> >  
> >  	temperature_threshold = control_temp - switch_on_temp;
> > +	/*
> > +	 * estimate_pid_constants() tries to find appropriate default
> > +	 * values for thermal zones that don't provide them. If a
> > +	 * system integrator has configured a thermal zone with two
> > +	 * passive trip points at the same temperature, that person
> > +	 * hasn't put any effort to set up the thermal zone properly
> > +	 * so just give up.
> > +	 */
> > +	if (!temperature_threshold)
> > +		return;
> >  
> >  	if (!tz->tzp->k_po || force)
> >  		tz->tzp->k_po = int_to_frac(sustainable_power) /
> 
> a) Are we sure this won't leave tz->tzp fields uninitialized?

They will be all zeros.  That's good enough.

> b) I'm not understanding that code at all.  The "proportional" term
>    in a PID controller is supposed to be proportional to the (desired -
>    actual) difference (aka "the error").
> 
>    But estimate_pid_constants() appears to be setting the
>    "proportional" term to be proportional to 1/error!

estimate_pid_constants() calculate the constants that you use in the
PID algorithm.  Say:

k_p * error + k_i * integral_of_error + k_d * diff_of_error

This code is calculating a reasonable k_p, k_i and k_d when they are
not provided by the platform.

>    Maybe a description of local `temperature_threshold' would help
>    clue me in.

The `error' in the above definition is:

target_temperature - current_temperature

whereas `temperature_threshold' is:

`target_temperature' - `switch_on_temperature'

`switch_on_temperature' is the temperature above which the thermal
governor starts operating and throttling cpus (or whatever cooling
device is configured).

The `switch_on_temperature' and `target_temperature' are defined using
trip points.  A platform that sets two trip points to the same
temperature is not properly configured.  With Andrea's patch we
provide degraded behavior instead of crashing.  I agree with that
approach (hence my Reviewed-by, maybe it should be an Acked-by?).

Cheers,
Javi
