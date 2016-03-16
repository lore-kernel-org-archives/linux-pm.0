From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4)
Date: Wed, 16 Mar 2016 01:37:06 +0100
Message-ID: <1572099.uEUyShe1tB@vostro.rjw.lan>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com> <1458007395.8898.19.camel@redhat.com> <2600831.Qfymhh5Hpv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2082125.4BplBn3TAP"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61337 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965009AbcCPAfF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 20:35:05 -0400
In-Reply-To: <2600831.Qfymhh5Hpv@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>


--nextPart2082125.4BplBn3TAP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, March 16, 2016 01:32:19 AM Rafael J. Wysocki wrote:
> On Monday, March 14, 2016 10:03:15 PM Rik van Riel wrote:
> > On Mon, 2016-03-14 at 23:55 +0100, Rafael J. Wysocki wrote:
> > > On Mon, Mar 14, 2016 at 6:45 PM, Rik van Riel <riel@redhat.com>
> > > wrote:
> > > > 
> > > > A lot of the logic (especially the load correction) in
> > > > menu.c was last fine tuned before several bugs in the
> > > > corresponding measuring code were fixed.
> > > > 
> > > > I don't understand your patch well enough to object to
> > > > it, but the "start the loop at poll instead of HLT"
> > > > logic is becoming rather convoluted...
> > > 
> > > That logic has been there for quite a while, though.
> > > 
> > > Really, the choice is between a simple revert of commit
> > > a9ceb78bc75ca47972096372ff3d48 and doing something in addition to it
> > > to mitigate the "C1 is hopelessly slow" issue.
> > 
> > That is fair.  I suspect your patch will be better than
> > a revert on systems where C1 is really slow, and just as
> > good as a revert on systems where C1 is fast.
> > 
> > We can worry about the choices between deeper C states
> > in a future version, but for 4.5 your patch would be the
> > way to go.
> 
> OK, so here it goes again with a changelog etc.
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpuidle: menu: 

Ah, missing subject.

What about this: cpuidle: menu: Restore next_timer_us check in menu_select()

> Commit a9ceb78bc75c (cpuidle,menu: use interactivity_req to disable
> polling) modified the condition to decide if C1 should be used as
> the fallback state instead of polling to check the value of
> interactivity_req rather than the time to the next timer event.
> That turned out to cause polling to be used as the fallback state
> most of the time, though, so idle state residencies dropped
> significantly even on systems with relatively low C1 exit latencies
> which resulted in increased energy consumption.
> 
> That was not the intention of commit a9ceb78bc75c, so restore the
> time to the next timer event check replaced by it, but in order
> to mitigate the original problem it attempted to address, add an
> extra C1 exit latency check to the condition in question, so C1
> is not used as the fallback state if its exit latency is too high.
> 
> Fixes: a9ceb78bc75c (cpuidle,menu: use interactivity_req to disable polling)
> Reported-and-tested-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -327,11 +327,13 @@ static int menu_select(struct cpuidle_dr
>  		data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
>  		/*
>  		 * We want to default to C1 (hlt), not to busy polling
> -		 * unless the timer is happening really really soon.
> +		 * unless the timer is happening really really soon.  Still, if
> +		 * the exit latency of C1 is too high, we need to poll anyway.
>  		 */
> -		if (interactivity_req > 20 &&
> +		if (data->next_timer_us > 20 &&
> +		    drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency <= 2 &&
>  		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
> -			dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
> +		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
>  			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
>  	} else {
>  		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;

--nextPart2082125.4BplBn3TAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJW6KqzAAoJEILEb/54YlRxFmMP/3X5x/XNzdnNcJOXRezidp8S
5Gxo0K5VA3fZmZSIeyFyrQUy9MjkF/UdnSSrUX4OV+RKeUNgT8NClVsfEM4WUm7t
AVLUHRiegzlrAWzjKQCcxlt+MRhlEYAwg7R3Te0bR5CQBqUCswExPn3WMC9DaO2q
djnXJtBZWQbAHFhbzPI/+0xr1BQCAXuWGOVDFyeBwbsel0XiFbiB+8mrnWcFRRJ+
en3k6T6fck11w+jhj27cn3bxb9wP2y4KqHoBLaFoUpfnFwV+yLMi8ogdCPomwcbs
n5Fykx7vPqGW2acqJ/Taqj0ctX8TqtgMw/mmXUGcE/xEtSK/Q17ZnU5LryWovq2l
Z0Lg4/2G3S0yawYHLURUrsSs9Zm4Fmr7ef5YHTyEpIPY0ndief77i4esQJB559tZ
+lMEubvk16+ezXKliT5Bdfmax1tS91UiaYJGVMJc3DVnuhqd3nvPgFt/dbRsq+Sf
LVZRxSOPqc/D1dROvCuz1GYNHbh/ogAuM4bzvlfg3ScCSTjztV/uelq9dFUguvCi
Yzo7EIWSRHkRzvGV3Mxl5kbMmS9pJpUnt24860jCGP2cYV36/PfLebwaQXTZRgbV
KlpoOaX1wkEjQaZh3cGGXKMnBQwFf1WQfKCsGLEU1Zp56E7dxMzjKsXAuQm2HCv+
weeAg8ldhbO7VbS0GGIu
=lrI3
-----END PGP SIGNATURE-----

--nextPart2082125.4BplBn3TAP--

