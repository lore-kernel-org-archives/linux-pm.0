From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Tue, 1 Mar 2016 20:49:41 +0100
Message-ID: <CAJZ5v0gS2eOjbYWYj_hDMinm3De6Q_bCt8MMp_1aHev6hdz=xA@mail.gmail.com>
References: <20160211122429.GM11415@e106622-lin>
	<20160211152625.GM6357@twins.programming.kicks-ass.net>
	<CAKfTPtCRAyqx96rNuotHD2qtxBQkBa6K+-kk5bGQB2VbMq+k2A@mail.gmail.com>
	<20160212140415.GS6357@twins.programming.kicks-ass.net>
	<CAKfTPtA42zK+2pm71gDpodynYWXtKBqc-G5bFBh8aCKU=GPh_g@mail.gmail.com>
	<20160301135811.GQ6356@twins.programming.kicks-ass.net>
	<20160301141706.GJ18792@e106622-lin>
	<20160301142459.GR6356@twins.programming.kicks-ass.net>
	<20160301142620.GX6375@twins.programming.kicks-ass.net>
	<20160301144210.GL18792@e106622-lin>
	<20160301150402.GT6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:33608 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbcCATtn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 14:49:43 -0500
In-Reply-To: <20160301150402.GT6356@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Mar 1, 2016 at 4:04 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Mar 01, 2016 at 02:42:10PM +0000, Juri Lelli wrote:
>> Agree. My point was actually more about Rafael's schedutil RFC (I should
>> probably have posted this there, but I thought it fitted well with this
>> example). I realize that Rafael is starting simple, but I fear that some
>> aggregation of util coming from the different classes will be needed in
>> the end; schedfreq has already something along this line.
>
> Right, but I'm not sure that's a hard thing to add. But yes, it needs
> doing.
>
> It also very much has a bearing on the OPP state selection. As already
> pointed out, the nearest OPP thing Rafael did is just wrong for DL.
>
> It probably makes sense to pass a CPPC like form into the (software) OPP
> selector.
>
>> IMHO, the general approach would be that every scheduling class has an
>> interface to communicate its util requirement. Then RT will probably
>> have to ask for max, but CFS and DL will do better.
>
> Right, so on IRC you mentioned that we could also use the global (or
> cgroup) RT throttle to lower the RT util/OPP.

The current code simply treats RT/DL as "uknknown" and will always ask
for the max for them.  That should work, although it's suboptimal for
DL at least.  However, I'd prefer to add something more sophisticated
on top of it just to keep things simple to start with.
