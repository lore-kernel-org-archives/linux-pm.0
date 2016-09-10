From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC v5] timekeeping: Ignore the bogus sleep time if
 pm_trace is enabled
Date: Sat, 10 Sep 2016 17:40:49 +0800
Message-ID: <20160910094049.GA12100@sharon>
References: <1472402439-1146-1-git-send-email-yu.c.chen@intel.com>
 <4130556.MNmyvLDyHH@vostro.rjw.lan>
 <alpine.DEB.2.20.1609022119160.5647@nanos>
 <20160904153739.GA5400@sharon>
 <alpine.DEB.2.20.1609050941180.5647@nanos>
 <20160909053749.GA4564@sharon>
 <alpine.DEB.2.20.1609091551110.5679@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609091551110.5679@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org, John Stultz <john.stultz@linaro.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Xunlei Pang <xlpang@redhat.com>, "Zhang, Rui" <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,
On Fri, Sep 09, 2016 at 04:33:59PM +0200, Thomas Gleixner wrote:
> On Fri, 9 Sep 2016, Chen Yu wrote:
>
> > +extern void pm_trace_untaint_timekeeping(void);
> 
> And how exactly do you untaint it? Just by clearing the flags. That makes
> the RTC time magically correct again?
> 
> > +int arch_pm_trace_taint_pclock(void)
> > +{
> > +	return (x86_platform.get_wallclock == mach_get_cmos_time);
> > +}
> 
> Groan. I told you to do it in the mc14xxx related places. There are not
> that many in the kernel
> 
> Here is a completely uncompiled/untested patch which should address the
> issue in a halfways clean way.
> 
> Thanks,
> 
> 	tglx
> 
OK, I made some small adjustment to make it compiled without pm_trace
configured, and this version is absolutely more professional than
my previous one. I'll do some testing based on it.
Besides I have another question related to the untain
of the pm_trace_rtc_abused flag: after resume back, if the user disabled
the pm_trace, then the following suspend/resume sleep time should become
valid again IMO, because we use the delta rather than the RTC itself for
suspend/resume. So in this version it disable the injection of sleep time
once pm_trace has been used? 

Thanks,
Yu
