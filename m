From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add statistics sysfs file for suspend to
	ram
Date: Mon, 8 Aug 2011 22:37:03 +0200
Message-ID: <201108082237.03559.rjw@sisk.pl>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E5741@shsmsx502.ccr.corp.intel.com>
	<201108052120.14901.rjw@sisk.pl> <1312775304.2043.37.camel@ymzhang>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1312775304.2043.37.camel@ymzhang>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: yanmin_zhang@linux.intel.com, Greg KH <gregkh@suse.de>
Cc: "Liu, ShuoX" <shuox.liu@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Monday, August 08, 2011, Yanmin Zhang wrote:
> On Fri, 2011-08-05 at 21:20 +0200, Rafael J. Wysocki wrote:
> > On Friday, August 05, 2011, Yanmin Zhang wrote:
> > > On Fri, 2011-08-05 at 09:57 +0800, Liu, ShuoX wrote:
> > > > > On Thursday, August 04, 2011, Greg KH wrote:
> > > > > > On Thu, Aug 04, 2011 at 01:13:38PM +0800, Liu, ShuoX wrote:
> > > > > > > >From a906b0b5b4ff3414ceb9fc7a69a3d7c9d66e46b1 Mon Sep 17
> > > > > 00:00:00 2001
> > > > > > > From: ShuoX Liu <shuox.liu@intel.com>
> > > > > > > Date: Thu, 28 Jul 2011 10:54:22 +0800
> > > > > > > Subject: [PATCH] PM: add statistics sysfs file for suspend to ram.
> > > > > >
> > > > > > What's this stuff here for?  That's not needed (hint, I would have to
> > > > > > edit it out by hand to be able to apply this patch.)
> > > > > >
> > > > > > Thanks for resending a version that passes checkpatch.pl and could be
> > > > > > applied, but all of my previous comments still stand.  This patch, as
> > > > > > is, is totally unacceptable.
> > > > > 
> > > > > Agreed, plus I'd like to know the motivation behind it.  That is, we have
> > > > > quite a few debug facilities in that code, so why are they insufficient?
> > > Thanks Greg, Rafael. We are changing the patch based on your comments.
> > > 
> > > > 
> > > > Some explanation from Yanmin,
> > > > "We are enabling power features on Medfield. Some testers and developers
> > > > complain they don't know if system tries suspend-2-ram, and what device 
> > > > fails to suspend. They need such info for a quick check. If turning on 
> > > > CONFIG_PM_DEBUG, we get too much info and testers need recompile 
> > > > the system.
> > > Comparing with PC/notebook, a mobile enters/exits suspend-2-ram (we call it s3 on
> > > Medfield) far more frequently. If it can't enter suspend-2-ram in time, the power
> > > might be used up soon.
> > > 
> > > We often find sometimes, a device suspend fails. Then, system retries s3 over
> > > and over again. As display is off, testers/developers don't know what happens.
> > > Teh system 
> > > 
> > > With the patch, we could know what the bad device is.
> > > 
> > > The patch doesn't hurt performance as it's just statistics collector.
> > > 
> > > CONFIG_PM_DEBUG is very useful for finer investigation about what happens behind. What
> > > we provide by the patch is to analyze the issues quickly, even by an ordinary tester.
> > 
> > Well, what about using dynamic debug?
> Thanks for the nice pointer. I checked dynamic debug. It's really a good debug tool.
> With the dynamic debug:
> 1) user need write a user space parser to process the syslog output;
> 2) Our testing scenario is we leave the mobile for at least hours. Then, check its status.
> No serial console available during the testing. One is because console would be suspended,
> and the other is serial console connecting with spi or HSU devices would consume power. These
> devices are powered off at suspend-2-ram.
> 
> Below is an example output of the statistics from my mobile (we are changing the output
> from sysfs to debugfs now):
> #adb shell cat /sys/power/suspend_stats
> success: 5
> fail: 1
> failed_freeze: 0
> failed_prepare: 0
> failed_suspend: 1
> failed_suspend_noirq: 0
> failed_resume: 0
> failed_resume_noirq: 0
> failed_devs:
>   last_failed:	alarm

OK, I see.  Greg, what do you think?

Rafael
