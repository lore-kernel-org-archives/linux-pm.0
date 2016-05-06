From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH] sched/fair: Invoke cpufreq hooks for CONFIG_SMP unset
Date: Fri, 6 May 2016 12:08:25 -0700
Message-ID: <20160506190825.GA15729@sky.smuckle.net>
References: <6282396.VVEdgVYxO3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33329 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758232AbcEFTI3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2016 15:08:29 -0400
Received: by mail-pf0-f171.google.com with SMTP id 206so52954988pfu.0
        for <linux-pm@vger.kernel.org>; Fri, 06 May 2016 12:08:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6282396.VVEdgVYxO3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>

Looks good to me.

Also re-tested with intel_pstate on i7-3630QM !SMP, confirmed issue
is resolved. I didn't retest with ondemand because for some reason
that wasn't showing the problem before.
