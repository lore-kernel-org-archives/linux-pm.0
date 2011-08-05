From: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Subject: Re: [PATCH] PM: add statistics sysfs file for suspend to
	ram
Date: Fri, 05 Aug 2011 11:19:49 +0800
Message-ID: <1312514389.2043.27.camel@ymzhang>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E5741@shsmsx502.ccr.corp.intel.com>
	<20110804052729.GA12707@suse.de> <201108041132.35399.rjw@sisk.pl>
	<6E3BC7F7C9A4BF4286DD4C043110F30B5B7932BF1D@shsmsx502.ccr.corp.intel.com>
Reply-To: yanmin_zhang@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <6E3BC7F7C9A4BF4286DD4C043110F30B5B7932BF1D@shsmsx502.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Liu, ShuoX" <shuox.liu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>
List-Id: linux-pm@vger.kernel.org

On Fri, 2011-08-05 at 09:57 +0800, Liu, ShuoX wrote:
> > On Thursday, August 04, 2011, Greg KH wrote:
> > > On Thu, Aug 04, 2011 at 01:13:38PM +0800, Liu, ShuoX wrote:
> > > > >From a906b0b5b4ff3414ceb9fc7a69a3d7c9d66e46b1 Mon Sep 17
> > 00:00:00 2001
> > > > From: ShuoX Liu <shuox.liu@intel.com>
> > > > Date: Thu, 28 Jul 2011 10:54:22 +0800
> > > > Subject: [PATCH] PM: add statistics sysfs file for suspend to ram.
> > >
> > > What's this stuff here for?  That's not needed (hint, I would have to
> > > edit it out by hand to be able to apply this patch.)
> > >
> > > Thanks for resending a version that passes checkpatch.pl and could be
> > > applied, but all of my previous comments still stand.  This patch, as
> > > is, is totally unacceptable.
> > 
> > Agreed, plus I'd like to know the motivation behind it.  That is, we have
> > quite a few debug facilities in that code, so why are they insufficient?
Thanks Greg, Rafael. We are changing the patch based on your comments.

> 
> Some explanation from Yanmin,
> "We are enabling power features on Medfield. Some testers and developers
> complain they don't know if system tries suspend-2-ram, and what device 
> fails to suspend. They need such info for a quick check. If turning on 
> CONFIG_PM_DEBUG, we get too much info and testers need recompile 
> the system.
Comparing with PC/notebook, a mobile enters/exits suspend-2-ram (we call it s3 on
Medfield) far more frequently. If it can't enter suspend-2-ram in time, the power
might be used up soon.

We often find sometimes, a device suspend fails. Then, system retries s3 over
and over again. As display is off, testers/developers don't know what happens.
Teh system 

With the patch, we could know what the bad device is.

The patch doesn't hurt performance as it's just statistics collector.

CONFIG_PM_DEBUG is very useful for finer investigation about what happens behind. What
we provide by the patch is to analyze the issues quickly, even by an ordinary tester.

> 
> The patch records the suspend-2-ram fail/success statistics and the last 2 
> failed devices. Users could find what device causes the failure quickly."
We are modifying the patch.
1) move the sysfs entry to debugfs;
3) Add an explanation in file Documentation/power/basic-pm-debugging.txt.
2) Add more explanation, especially about the motivation, and how to use it, into
the patch comments.

Thanks again.

Yanmin
