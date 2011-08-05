From: "Liu, ShuoX" <shuox.liu@intel.com>
Subject: Re: [PATCH] PM: add statistics sysfs file for suspend to
	ram
Date: Fri, 5 Aug 2011 09:57:12 +0800
Message-ID: <6E3BC7F7C9A4BF4286DD4C043110F30B5B7932BF1D@shsmsx502.ccr.corp.intel.com>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E5741@shsmsx502.ccr.corp.intel.com>
	<20110804052729.GA12707@suse.de> <201108041132.35399.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108041132.35399.rjw@sisk.pl>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <gregkh@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Yanmin_zhang@linux.intel.com" <Yanmin_zhang@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

> On Thursday, August 04, 2011, Greg KH wrote:
> > On Thu, Aug 04, 2011 at 01:13:38PM +0800, Liu, ShuoX wrote:
> > > >From a906b0b5b4ff3414ceb9fc7a69a3d7c9d66e46b1 Mon Sep 17
> 00:00:00 2001
> > > From: ShuoX Liu <shuox.liu@intel.com>
> > > Date: Thu, 28 Jul 2011 10:54:22 +0800
> > > Subject: [PATCH] PM: add statistics sysfs file for suspend to ram.
> >
> > What's this stuff here for?  That's not needed (hint, I would have to
> > edit it out by hand to be able to apply this patch.)
> >
> > Thanks for resending a version that passes checkpatch.pl and could be
> > applied, but all of my previous comments still stand.  This patch, as
> > is, is totally unacceptable.
> 
> Agreed, plus I'd like to know the motivation behind it.  That is, we have
> quite a few debug facilities in that code, so why are they insufficient?

Some explanation from Yanmin,
"We are enabling power features on Medfield. Some testers and developers
complain they don't know if system tries suspend-2-ram, and what device 
fails to suspend. They need such info for a quick check. If turning on 
CONFIG_PM_DEBUG, we get too much info and testers need recompile 
the system.

The patch records the suspend-2-ram fail/success statistics and the last 2 
failed devices. Users could find what device causes the failure quickly."

If you guys agree, I will modify the patch as Greg said and resend.

Shuo
