From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: cpufreq/ondemand: unpinning an unpinned lock.
Date: Thu, 16 Jul 2015 08:42:41 -0400
Message-ID: <20150716124241.GA20320@codemonkey.org.uk>
References: <20150715220422.GA13789@codemonkey.org.uk>
 <3682267.1lcDzeZuDs@vostro.rjw.lan>
 <20150716051150.GA15404@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arcturus.aphlor.org ([188.246.204.175]:58607 "EHLO
	arcturus.aphlor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbbGPMmt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2015 08:42:49 -0400
Content-Disposition: inline
In-Reply-To: <20150716051150.GA15404@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

On Thu, Jul 16, 2015 at 10:41:50AM +0530, Viresh Kumar wrote:

 > > > WARNING: CPU: 1 PID: 29529 at kernel/locking/lockdep.c:3497 lock_unpin_lock+0x109/0x110()
 > > > unpinning an unpinned lock
 > > > CPU: 1 PID: 29529 Comm: kworker/1:1 Not tainted 4.2.0-rc2-think+ #3
 > > > Workqueue: events od_dbs_timer
 > > >  0000000000000009 ffff880094d5baa8 ffffffffae7f5e6f 0000000000000007
 > > >  ffff880094d5baf8 ffff880094d5bae8 ffffffffae07b91a 0000000000000118
 > > >  00000000000000e0 ffff880507bd5c58 0000000000000092 0000000000000004
 > > > Call Trace:
 > > >  [<ffffffffae7f5e6f>] dump_stack+0x4f/0x7b
 > > >  [<ffffffffae07b91a>] warn_slowpath_common+0x8a/0xc0
 > > >  [<ffffffffae07b996>] warn_slowpath_fmt+0x46/0x50
 > > >  [<ffffffffae0d0ec9>] lock_unpin_lock+0x109/0x110
 > > >  [<ffffffffae7f93cc>] __schedule+0x3ac/0xb60
 > > >  [<ffffffffae7f9c41>] schedule+0x41/0x90
 > > >  [<ffffffffae7f9ff8>] schedule_preempt_disabled+0x18/0x30
 > > >  [<ffffffffae7fbcef>] mutex_lock_nested+0x16f/0x3e0
 > > >  [<ffffffffae69207f>] ? gov_queue_work+0x2f/0xf0
 > > >  [<ffffffffae690ec7>] ? od_check_cpu+0x57/0xd0
 > > >  [<ffffffffae69207f>] ? gov_queue_work+0x2f/0xf0
 > > >  [<ffffffffae69207f>] gov_queue_work+0x2f/0xf0
 > > >  [<ffffffffae6918dd>] od_dbs_timer+0xbd/0x150
 > 
 > I don't know why this will happen. Just to confirm, you are getting
 > this over 4.2-rc(1 or 2)? And you weren't getting these on 4.1 at all?
 > And its always reproducible? How ?

I've hit it once, on rc2.  I didn't have a lot of time for testing rc1.

 > There have been races in cpufreq core since sometime and what got
 > pushed in 4.2-rc1 is just half of the fix. The other half is present
 > here:
 > 
 > http://marc.info/?i=cover.1434713657.git.viresh.kumar%40linaro.org
 > 
 > Please try this and let us know if things work well or not.

Sure. Though proving the absense of a bug like this is always fun.

	Dave
