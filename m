From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] sched/cpufreq: optimize cpufreq update kicker to
 avoid update multiple times
Date: Mon, 25 Apr 2016 16:31:33 +0200
Message-ID: <20160425143133.GK3430@twins.programming.kicks-ass.net>
References: <1461316044-9520-1-git-send-email-wanpeng.li@hotmail.com>
 <571A1368.9060409@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43323 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbcDYObk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 10:31:40 -0400
Content-Disposition: inline
In-Reply-To: <571A1368.9060409@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@hotmail.com>, Linux PM <linux-pm@vger.kernel.org>

On Fri, Apr 22, 2016 at 02:04:56PM +0200, Rafael J. Wysocki wrote:
> [Added linux-pm to the CC - can you please do so for PM-related patches in
> the future?]
> 
> On 4/22/2016 11:07 AM, Wanpeng Li wrote:
> >From: Wanpeng Li <wanpeng.li@hotmail.com>
> >
> >Sometimes delta_exec is 0 due to update_curr() is called multiple times,
> >this is captured by:
> >
> >	u64 delta_exec = rq_clock_task(rq) - curr->se.exec_start;
> >
> >This patch optimizes the cpufreq update kicker by bailing out when nothing
> >changed, it will benefit the upcoming schedutil, since otherwise it will
> >(over)react to the special util/max combination.
> >
> >Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
> 
> The changelog looks better now, thanks!
> 
> Peter, do I think correctly that you're going to take care of this one?  Or
> do you want me to take it?

YEah, looks fine. I'll take it.

Thanks!
