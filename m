From: "Rafael J. Wysocki via RT" <rt@kernel.org>
Subject: Re: [k.org requests #104] Please add 2 categories
Date: Tue, 30 Oct 2012 15:28:31 +0000
Message-ID: <rt-3.8.13-17378-1351610911-531.104-6-0@kernel.org>
References: <RT-Ticket-104@kernel.org> <508F40D5.2010109@kernel.org> <rt-3.8.13-793-1351610640-515.104-6-0@kernel.org> <1451306.UP2oztoM1Z@vostro.rjw.lan>
Reply-To: rt@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52207 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757499Ab2J3P2l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Oct 2012 11:28:41 -0400
In-Reply-To: <1451306.UP2oztoM1Z@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org

On Tuesday, October 30, 2012 03:24:00 PM Konstantin Ryabitsev via RT wrote:
> On Tue Oct 30 15:10:36 2012, lenb@kernel.org wrote:
> > Dear Bugzilla Admins,
> > 
> > Please add 2 additional Categories under Product "Power Management":
> > 
> > Run-Time-PM - Issues related to Linux Device Run Time Power
> > Management.
> > 
> > Thermal - Issues related to OS-visible Thermal Management, such as
> > throttling.
> 
> Sure, but I'll need "default assignee" for both of these.
> 
> Speaking of default assignees, kernel-bugs.osdl.org doesn't appear to
> exist any more either, so the following will need to be adjusted as well:
> 
> cpuidle             power-management_cpuidle@kernel-bugs.osdl.org 
> Hibernation/Suspend power-management_other@kernel-bugs.osdl.org 	
> intel_idle          power-management_intel_idle@kernel-bugs.osdl.org 	
> Other               power-management_other@kernel-bugs.osdl.org

Can we arrange things so that the _first_ message from every bug in
these categories goes to linux-pm@vger.kernel.org and then they are
assigned to a generic power management entity?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

