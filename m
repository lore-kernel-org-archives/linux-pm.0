From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][v6] PM / hibernate: Introduce test_resume mode for
 hibernation
Date: Fri, 29 Jul 2016 16:22:10 +0800
Message-ID: <20160729082210.GA8125@sharon>
References: <1469154647-5860-1-git-send-email-yu.c.chen@intel.com>
 <20160728193206.GC8837@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7287 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbcG2IOQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 29 Jul 2016 04:14:16 -0400
Content-Disposition: inline
In-Reply-To: <20160728193206.GC8837@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mail List <linux-kernel@vger.kernel.org>

On Thu, Jul 28, 2016 at 09:32:06PM +0200, Pavel Machek wrote:
> On Fri 2016-07-22 10:30:47, Chen Yu wrote:
> > test_resume mode is to verify if the snapshot data
> > written to swap device can be successfully restored
> > to memory. It is useful to ease the debugging process
> > on hibernation, since this mode can not only bypass
> > the BIOSes/bootloader, but also the system re-initialization.
> > 
> > To avoid the risk to break the filesystm on persistent storage,
> > this patch resumes the image with tasks frozen.
> > 
> > For example:
> > echo test_resume > /sys/power/disk
> > echo disk > /sys/power/state
> > 
> > 
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> (And yes, I'd still like documentation patch for this, but that can be
> done in separate patch.)
>
Thanks! Will update the doc in another patch.
Yu 
