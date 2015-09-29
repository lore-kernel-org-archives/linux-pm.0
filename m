From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] thermal: avoid division by zero in power allocator
Date: Tue, 29 Sep 2015 13:33:30 -0700
Message-ID: <20150929133330.809e7058004395e6db79dec1@linux-foundation.org>
References: <1443475714-19871-1-git-send-email-aarcange@redhat.com>
	<1443475714-19871-2-git-send-email-aarcange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39218 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbI2Udc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2015 16:33:32 -0400
In-Reply-To: <1443475714-19871-2-git-send-email-aarcange@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>

On Mon, 28 Sep 2015 23:28:34 +0200 Andrea Arcangeli <aarcange@redhat.com> wrote:

> During boot I get a div by zero Oops regression starting in v4.3-rc3.
> 
> ...
>
> --- a/drivers/thermal/power_allocator.c
> +++ b/drivers/thermal/power_allocator.c
> @@ -144,6 +144,16 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>  		switch_on_temp = 0;
>  
>  	temperature_threshold = control_temp - switch_on_temp;
> +	/*
> +	 * estimate_pid_constants() tries to find appropriate default
> +	 * values for thermal zones that don't provide them. If a
> +	 * system integrator has configured a thermal zone with two
> +	 * passive trip points at the same temperature, that person
> +	 * hasn't put any effort to set up the thermal zone properly
> +	 * so just give up.
> +	 */
> +	if (!temperature_threshold)
> +		return;
>  
>  	if (!tz->tzp->k_po || force)
>  		tz->tzp->k_po = int_to_frac(sustainable_power) /

a) Are we sure this won't leave tz->tzp fields uninitialized?

b) I'm not understanding that code at all.  The "proportional" term
   in a PID controller is supposed to be proportional to the (desired -
   actual) difference (aka "the error").

   But estimate_pid_constants() appears to be setting the
   "proportional" term to be proportional to 1/error!

   Maybe a description of local `temperature_threshold' would help
   clue me in.

