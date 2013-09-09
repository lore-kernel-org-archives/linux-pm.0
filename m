From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
Date: Mon, 9 Sep 2013 23:42:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1309092330560.12376@axis700.grange>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
 <1883706.eFcILAzoo8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1883706.eFcILAzoo8@vostro.rjw.lan>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael

On Mon, 9 Sep 2013, Rafael J. Wysocki wrote:

> Hi,
> 
> On Monday, September 09, 2013 05:11:10 PM Guennadi Liakhovetski wrote:
> > Sorry guys, I'm trying my best to stop this patch from propagating to 
> > stable and to get it fixed asap, so, the CC list might be a bit excessive. 
> > Also trying to fix the originally spare cc list, which makes it impossible 
> > for me to reply to the original thread, instead have to start a new one.
> 
> I'm not sure what you're talking about.  What exactly was wrong with the
> original CC list in particular?

I think you advised once to cc cpufreq related mails to linux-pm too at 
least. I haven't found this patch in my pm archive, have I missed it 
there?

> > Commit
> > 
> > commit dceff5ce18801dddc220d6238628619c93bc3cb6
> > Author: Viresh Kumar <viresh.kumar@linaro.org>
> > Date:   Sun Sep 1 22:19:37 2013 +0530
> > 
> >     cpufreq: fix serialization issues with freq change notifiers
> > 
> > breaks .transition_ongoing counting.
> 
> Do you know how exactly it breaks that?  If so, care to share that knowledge?

No, I don't. I only know that in __cpufreq_driver_target() the check for

	if (policy->transition_ongoing) {
		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
		return -EBUSY;
	}

is failing with this patch and cpufreq-cpu0.

> > This leads to cpufreq-cpu0 not working any more. In particular switching the
> > governor from performance to powersave directly after boot doesn't result in
> > a frequency switch any more. Reverting this patch fixes the problem again.
> 
> However, this is a regression fix, so I'd prefer to fix the problem on top of
> it instead of reverting this commit entirely.

If I understood correctly, this patch fixed some warnings, that, however, 
didn't disrupt functionality, is this right? Whereas the patch really 
seems to break working set ups.

Anyway, we know about the problem now and I believe it'll get fixed one 
way or another.

Thanks
Guennadi

> > Tested with today's 
> > -next.
> > 
> > Please, refrain from including into "stable" until clarified!
> 
> Well, dropping the commit altogether and dropping the "CC stable" tag are
> equally disruptive at this point, so I think I'll just defer all of the
> cpufreq fixes I wanted to push for 3.12 before the ending of the merge
> window.
> 
> Thanks,
> Rafael
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
