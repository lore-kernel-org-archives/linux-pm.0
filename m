From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] intel_pstate: Change the setpoint for atom params
Date: Mon, 13 Apr 2015 09:29:22 -0700
Message-ID: <20150413092922.72f7a39c@kcaccard-desk.amr.corp.intel.com>
References: <1428689203-3204-1-git-send-email-kristen@linux.intel.com>
	<002601d073f7$31780550$94680ff0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:34730 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932151AbbDMQ3X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Apr 2015 12:29:23 -0400
In-Reply-To: <002601d073f7$31780550$94680ff0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org

Hi Doug,

On Fri, 10 Apr 2015 18:31:10 -0700
"Doug Smythies" <dsmythies@telus.net> wrote:

> On 2015.04.10 11:07 Kristen Carlson Accardi wrote:
> 
> > Change the setpoint for the Baytrail and Cherrytrail cpus.  This
> > will cause more aggressive pstate selection and improves
> > performance on a variety of workloads with little power penalty.
> >
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > ---
> > drivers/cpufreq/intel_pstate.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 872c577..204e43e 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -636,7 +636,7 @@ static struct cpu_defaults byt_params = {
> > 	.pid_policy = {
> > 		.sample_rate_ms = 10,
> > 		.deadband = 0,
> > -		.setpoint = 97,
> > +		.setpoint = 60,
> > 		.p_gain_pct = 14,
> > 		.d_gain_pct = 0,
> > 		.i_gain_pct = 4,
> > -- 
> > 1.9.3
> 
> That is a drastic change in setpoint.
> Doesn't it push the response curve very close to
> the performance mode response curve, but with an
> increased tendency to oscillate? I'm asking why don't you
> just use performance mode?

Not quite - the power is still better with this setpoint vs. just 100%
with performance mode.

> 
> With such a big change shouldn't you also then be able to eliminate
> the integral gain? As far as I can determine the integral gain was
> only to compensate for such a low proportional gain and the very
> finicky integer math, where it will never bump up to the final pstate
> at the old setpoint of 97, whereas the integral of the error eventually
> will (which is not the normal reason for using an integral term).
> 
> For example, for the old settings a 100% load would give an fp_error of 3.
> When multiplied by a gain of 14 percent would be 0.42 which would round to 0.
> Meanwhile the integral term at 4 percent would take 5 passes through
> the driver to integrate to the point of rounding to a pstate increase. Hence
> sluggish response time.
> 
> By the way, I am about to submit a patch set for review that eliminates
> setpoint and the PID controller entirely.

I'm super happy about this, as eliminating the PID controller has been
on my list of things to do.  However, I'm going to need to do a lot of
benchmarking on a variety of platforms to make sure we haven't regressed
anything. I'm not sure if we can get these changes in or not this
version, in which case the above patch immediately improves things for
atom without too much risk and has already been regression tested on
the affected platforms.

> 
> The attached graphs detail what I have been saying.
> (I hope I can include 123K bytes of attachments in this on-list e-mail.
> It used to work in 2012.)
> 
> The first is the CPU frequency verses load response curve.
> The load is fixed, independent of the CPU frequency, i.e.
> not a realistic real world scenario. There is no "before" this
> patch reference line on the graph because the CPU frequency never
> went up from the minimum pstate for that reference test, with my
> processor.
> 
> The second is the CPU frequency verses load response curve,
> where the load is roughly what it would be if the CPU frequency
> was forced to be the non-turbo maximum, i.e. a more realistic real
> world scenario.
> 
> Note that the same average "load" can be obtained from many different
> CO state verses not C0 state frequencies, or what I call work / sleep
> frequencies. For no particular reason, the graphs were done at 200
> and 75 Hertz work / sleep frequencies.
> 
> Note that I do not have a baytrail CPU, and used my i7-2600K CPU for
> these tests.
> 
> As a teaser, the graphs include the response curves for the patch set
> I hope to submit for review shortly.
> 

Thanks for the work, I'm eager to try out your patches and will keep
you informed as testing progresses.

Kristen
