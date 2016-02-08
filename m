From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3 v3] cpufreq: governor: Replace timers with
 utilization update callbacks
Date: Mon, 8 Feb 2016 17:22:48 +0530
Message-ID: <20160208115248.GC8294@vireshk>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <20160207091040.GA6112@vireshk>
 <1855005.ZFAA5ekheo@vostro.rjw.lan>
 <2172360.cldhrkXzeh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36504 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbcBHLwv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 06:52:51 -0500
Received: by mail-pf0-f170.google.com with SMTP id e127so13319186pfe.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 03:52:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2172360.cldhrkXzeh@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On 08-02-16, 03:08, Rafael J. Wysocki wrote:
> Moreover, update_sampling_rate() doesn't need to walk the cpu_dbs_infos,
> it may walk policies instead.  Like after the (untested) appended patch.
> 
> Then, if we have a governor_data_lock in struct policy, we can use that
> to protect policy_dbs while it is being access there and we're done.
> 
> I'll try to prototype something along these lines tomorrow.

I have solved that in a different way, and dropped the lock from
update_sampling_rate(). Please see if that looks good.

-- 
viresh
