From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [v2][PATCH 00/21] clockevents_notify() removal
Date: Fri, 03 Apr 2015 01:45:58 +0200
Message-ID: <3410621.5uMny9y0B7@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <20150402123935.GA31934@gmail.com> <2186067.gb1n6y4Zoc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49740 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753160AbbDCAQ1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 20:16:27 -0400
In-Reply-To: <2186067.gb1n6y4Zoc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Friday, April 03, 2015 12:19:41 AM Rafael J. Wysocki wrote:
> On Thursday, April 02, 2015 02:39:35 PM Ingo Molnar wrote:
> > 
> > * Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > 
> > > Hi,
> > > 
> > > This is the next batch of patches from Thomas that remove clockevents_notify().
> > > 
> > > I've reordered the set (to put more stratightforward things to the front) and
> > > rebased it on top of the timers material currently queued up for 4.1.
> > > 
> > > This series in based on the bleeding-edge branch of the linux-pm tree (which
> > > for all practical purposes is my linux-next branch with timers/core from tip
> > > merged into it).
> > > 
> > > Please let me know how to proceed with these.
> > 
> > Would you mind to resend these merged on top of the very latest 
> > tip:timers/core (or tip:master) tree?
> > 
> > These changes conflict (mildly) with the other series from Thomas 
> > which needed some fixes/enhancements.
> 
> I'll do that later today.
> 
> This series also depends on:
> 
> http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=acpi-pad&id=6e9f8b5f1f319cbdb4cfe3696fc74fbe39318960
> 
> which is in my acpi-pad branch at the moment, but I'll add it to the front of
> the series in case you prefer to apply it directly.

The patches follow as per the above.  [2-21/21] rebased on top of the current
timers/core.

Thanks,
Rafael
