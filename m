From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Resend][PATCH] PM: Move disabling/enabling runtime PM to late suspend/early resume
Date: Sun, 16 Dec 2012 02:30:11 +0100
Message-ID: <3558004.3QJ46yYCyI@vostro.rjw.lan>
References: <1988667.JSHu2WyJuF@vostro.rjw.lan> <3307221.dy6xvn45xe@vostro.rjw.lan> <alpine.LNX.2.00.1212152215300.3487@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:35042 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab2LPBZD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 15 Dec 2012 20:25:03 -0500
In-Reply-To: <alpine.LNX.2.00.1212152215300.3487@pobox.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jan-Matthias Braun <jan_braun@gmx.net>, Alan Stern <stern@rowland.harvard.edu>

On Saturday, December 15, 2012 10:16:29 PM Jiri Kosina wrote:
> On Sat, 15 Dec 2012, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Currently, the PM core disables runtime PM for all devices right
> > after executing subsystem/driver .suspend() callbacks for them
> > and re-enables it right before executing subsystem/driver .resume()
> > callbacks for them.  This may lead to problems when there are
> > two devices such that the .suspend() callback executed for one of
> > them depends on runtime PM working for the other.  In that case,
> > if runtime PM has already been disabled for the second device,
> > the first one's .suspend() won't work correctly (and analogously
> > for resume).
> > 
> > To make those issues go away, make the PM core disable runtime PM
> > for devices right before executing subsystem/driver .suspend_late()
> > callbacks for them and enable runtime PM for them right after
> > executing subsystem/driver .resume_early() callbacks for them.  This
> > way the potential conflitcs between .suspend_late()/.resume_early()
> > and their runtime PM counterparts are still prevented from happening,
> > but the subtle ordering issues related to disabling/enabling runtime
> > PM for devices during system suspend/resume are much easier to avoid.
> > 
> > Reported-and-tested-by: Jan-Matthias Braun <jan_braun@gmx.net>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Hi Rafael,
> 
> just curious what is the reason for resend? Do you want to gather more 
> Acks before pushing this upstream?

Well, I thought that some people might actually look at it when they found it
again in their mailboxes. :-)

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
