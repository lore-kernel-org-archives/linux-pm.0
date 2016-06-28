From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC] cpufreq: Avoid warning during resume by return EAGAIN if cpufreq is unavailable
Date: Tue, 28 Jun 2016 03:31:11 +0200
Message-ID: <91695540.4NGfil38DW@vostro.rjw.lan>
References: <1466872128-14566-1-git-send-email-yu.c.chen@intel.com> <2394728.0JDBHijQ6J@vostro.rjw.lan> <20160627072027.GC3341@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160627072027.GC3341@vireshk-i7>
Sender: linux-acpi-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, June 27, 2016 12:50:27 PM Viresh Kumar wrote:
> On 27-06-16, 03:12, Rafael J. Wysocki wrote:
> > ---
> >  drivers/cpufreq/cpufreq.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > Index: linux-pm/drivers/cpufreq/cpufreq.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> > +++ linux-pm/drivers/cpufreq/cpufreq.c
> > @@ -1544,9 +1544,6 @@ static unsigned int cpufreq_update_curre
> >  {
> >  	unsigned int new_freq;
> >  
> > -	if (cpufreq_suspended)
> > -		return 0;
> > -
> >  	new_freq = cpufreq_driver->get(policy->cpu);
> >  	if (!new_freq)
> >  		return 0;
> > @@ -2280,6 +2277,10 @@ int cpufreq_update_policy(unsigned int c
> >  	 * -> ask driver for current freq and notify governors about a change
> >  	 */
> >  	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
> > +		if (cpufreq_suspended) {
> > +			ret = -EAGAIN;
> > +			goto unlock;
> > +		}
> >  		new_policy.cur = cpufreq_update_current_freq(policy);
> >  		if (WARN_ON(!new_policy.cur)) {
> >  			ret = -EIO;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks, but this needs to go in in two pieces, because cpufreq_start_governor()
in the mainline doesn't check cpufreq_suspended (the linux-next version of it
does that).

So the second part of the patch is needed in the mainline/stable to get rid
of false-positive WARN_ON()s and the first one can go in on top of the
previous linux-next changes.

Thanks,
Rafael

