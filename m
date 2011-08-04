From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add statistics sysfs file for suspend to
	ram
Date: Thu, 4 Aug 2011 11:32:35 +0200
Message-ID: <201108041132.35399.rjw@sisk.pl>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E5741@shsmsx502.ccr.corp.intel.com>
	<20110804052729.GA12707@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110804052729.GA12707@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>, "Liu, ShuoX" <shuox.liu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 04, 2011, Greg KH wrote:
> On Thu, Aug 04, 2011 at 01:13:38PM +0800, Liu, ShuoX wrote:
> > >From a906b0b5b4ff3414ceb9fc7a69a3d7c9d66e46b1 Mon Sep 17 00:00:00 2001
> > From: ShuoX Liu <shuox.liu@intel.com>
> > Date: Thu, 28 Jul 2011 10:54:22 +0800
> > Subject: [PATCH] PM: add statistics sysfs file for suspend to ram.
> 
> What's this stuff here for?  That's not needed (hint, I would have to
> edit it out by hand to be able to apply this patch.)
> 
> Thanks for resending a version that passes checkpatch.pl and could be
> applied, but all of my previous comments still stand.  This patch, as
> is, is totally unacceptable.

Agreed, plus I'd like to know the motivation behind it.  That is, we have
quite a few debug facilities in that code, so why are they insufficient?

Thanks,
Rafael
