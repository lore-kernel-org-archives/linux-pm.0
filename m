From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/cpufreq: don't trigger cpufreq update w/o real
 rt/deadline tasks running
Date: Wed, 20 Apr 2016 16:01:17 +0200
Message-ID: <20160420140117.GZ3448@twins.programming.kicks-ass.net>
References: <1460958684-32105-1-git-send-email-wanpeng.li@hotmail.com>
 <6087716.bi8vDPiZNy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55136 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104AbcDTOBW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 10:01:22 -0400
Content-Disposition: inline
In-Reply-To: <6087716.bi8vDPiZNy@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Wanpeng Li <kernellwp@gmail.com>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@hotmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>

On Wed, Apr 20, 2016 at 02:32:35AM +0200, Rafael J. Wysocki wrote:
> On Monday, April 18, 2016 01:51:24 PM Wanpeng Li wrote:
> > Sometimes update_curr() is called w/o tasks actually running, it is
> > captured by: 
> > 	u64 delta_exec = rq_clock_task(rq) - curr->se.exec_start;
> > We should not trigger cpufreq update in this case for rt/deadline
> > classes, and this patch fix it.
> > 
> > Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
> 
> The signed-off-by tag should agree with the From: header.  One way to achieve
> that is to add an extra From: line at the start of the changelog.
> 
> That said, this looks like a good catch that should go into 4.6 to me.
> 
> Peter, what do you think?

I'm confused by the Changelog. *what* ?
