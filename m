From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] drivers/idle: make intel_idle.c driver more explicitly
 non-modular
Date: Tue, 5 Apr 2016 14:22:52 -0400
Message-ID: <20160405182251.GX1778@windriver.com>
References: <1459099777-4962-1-git-send-email-paul.gortmaker@windriver.com>
 <20160404195535.GQ1778@windriver.com>
 <20160405031152.GA22836@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:37704 "EHLO mail5.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbcDESXI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Apr 2016 14:23:08 -0400
Content-Disposition: inline
In-Reply-To: <20160405031152.GA22836@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rcochran@linutronix.de
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org

[Re: [PATCH] drivers/idle: make intel_idle.c driver more explicitly non-modular] On 05/04/2016 (Tue 05:11) rcochran@linutronix.de wrote:

> On Mon, Apr 04, 2016 at 03:55:35PM -0400, Paul Gortmaker wrote:
> > > This was done in commit 6ce9cd8669fa1195fdc21643370e34523c7ac988
> > > ("intel_idle: disable module support") since "...the module capability
> > > is cauing more trouble than it is worth."
> 
> The reason given in that commit was that "it lost the init race with
> ACPI", whatever that means.
> 
> > > Since this was done over 5y ago, it is safe to say there is no big desire
> > > to overcome the issues with modular versions.  So lets remove the modular
> > > code that is essentially orphaned, so that when reading the driver there
> > > is no doubt it is builtin-only.
> 
> So you want to make the driver non-modular due to lack of desire to
> fix it?
> 
> > This patch will no longer apply since there were several updates to this
> > driver by Richard Cochran dated March 29th.   Before I go and refresh
> > the patch for a v2, is there any objections to the general goal of what
> > the patch was aiming to achieve -- avoiding use of modular infrastructure
> > in non-modular code, and not having module_exit code that can't be run?
> 
> On the one hand, the better way is to fix the issues, keeping the
> driver's modular form.  That way, by loading and unloading, you can
> observe how well it works.  I already started by fixing several bugs
> WRT module init/exit.

So, to be clear, I really don't have a horse in this race.  Be it
built-in or be it modular, I don't care.  But if code pretends to be
modular and is not, and hence has dead code, then I care.  So fixing
this driver to be functionally tristate is just as good as killing
the (currently) unreachable module_exit code IMHO.

It sounds like this discussion will lead us to one of the two, so that
is good.

Paul.
--

> 
> On the other hand, if there is some technical reason why the modular
> form is impossible, then the patch should state it.
> 
> Thanks,
> Richard
