From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/4] PM / core: Direct handling of DPM_FLAG_SMART_SUSPEND
 and DPM_FLAG_LEAVE_SUSPENDED
Date: Tue, 2 Jan 2018 14:26:25 +0100
Message-ID: <20180102132625.GA23199@kroah.com>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan>
 <2174279.mj3UjPCxfO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45638 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeABN0T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 08:26:19 -0500
Content-Disposition: inline
In-Reply-To: <2174279.mj3UjPCxfO@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, Jan 02, 2018 at 12:32:55PM +0100, Rafael J. Wysocki wrote:
> On Sunday, December 10, 2017 12:55:23 AM CET Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > This series is a follow-up for
> > 
> > https://marc.info/?l=linux-doc&m=151101644105835&w=2
> > 
> > Patches[1-3/6] from the above have been reviewed and agreed on, so
> > they are in linux-next now and here's a next version of the rest.
> > 
> > Patches [1-2/4] are preparatory.  The first one is just really small
> > code duplication avoidance on top of this recent fix:
> > 
> > https://patchwork.kernel.org/patch/10097563/
> > 
> > and the second one simply moves some code to separate functions.
> > 
> > Patch [3/4] causes the PM core to carry out some optimizations for
> > drivers of devices with DPM_FLAG_SMART_SUSPEND set whose "late"
> > and "noirq" suspend (or equivalent) driver callbacks are invoked
> > directly by the core.
> > 
> > The underlying observation is that if the device is suspended (via
> > runtime PM) during the "late suspend" phase of a system transition,
> > invoking the "late" and "noirq" callbacks from the driver for it is not
> > going to make it more suspended, so to speak, so it doesn't make sense to
> > invoke them at all.
> > 
> > [That optimization is only done for devices with DPM_FLAG_SMART_SUSPEND
> > set, because drivers setting that flag are expected to be prepared for
> > skipping their "late" and "noirq" callbacks if the device is already
> > suspended.]
> > 
> > Patch [4/4] makes the core do an analogous thing for devices with
> > DPM_FLAG_LEAVE_SUSPENDED set whose "noirq" and "early" resume (or
> > equivalent) driver callbacks are directly invoked by the core.
> > 
> > In that case the observation is that if such devices can be left in
> > suspend after the system transition to the working state, running
> > resume callbacks from their drivers is simply not necessary.
> > 
> > Pathes [3-4/4] have been reoredered and reworked a bit since the last
> > iteration, so they are regarded as new.
> > 
> > The series is on top of the linux-next branch of the linux-pm.git tree
> > that should be merged into linux-next on Monday.
> > 
> > [I have developed debug bus type and driver modules to test that code,
> > but they are not ready to be made available at this point.]
> 
> While I acknowledge that Ulf doesn't appear to be convinced by my
> arguments, I also see no technical reason why this cannot go in.
> 
> As I said during the discussion, I have tested it and it works for me
> as expected.  I also need it to make progress on the drivers front.
> 
> Moreover, it should not matter for any drivers that don't set the flags
> in question, so the optimizations introduced here are super-easy to avoid
> by leaving those flags unset.
> 
> So I'm going to apply the series.
> 
> Greg, please let me know if you have objections.

No objection from me at all, please apply.

thanks,

greg k-h
