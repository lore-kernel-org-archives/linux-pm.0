From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH 0/2] cpufreq: schedutil: Updates related to the rate limit
Date: Mon, 10 Apr 2017 02:07:23 +0200
Message-ID: <3498238.liCqOyIkGA@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41352 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752727AbdDJASB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Apr 2017 20:18:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>

Hi,

These two patches result from the discussion at the OSPM-summit last week
and are targeted at alleviating some issues related to the frequency change
rate limitting in schedutil.  They are intended to be used along with
https://patchwork.kernel.org/patch/9655173/ and are based on the current
linux-next branch of the linux-pm.git tree (which should be equivalent to
linux-next from the PM material perspective).

The first one is to allow scaling drivers to specify their own (smaller) latency
multipliers for computing the default value of rate_limit_us.

The second one makes schedutil store the maximum CPU utilization value seen
after the previous frequency update and use it for computing the new frequency
next time to address the problem with discarding intermediate utilization values.

They have been lightly tested on a Dell Vostro laptop with an Intel Sandy Bridge
processor.

Thanks,
Rafael
