From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 08/19] cpufreq: fix warning for cpufreq_init_policy
 unlocked access to cpufreq_governor_list
Date: Wed, 13 Jan 2016 11:37:46 +0530
Message-ID: <20160113060746.GI6050@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-9-git-send-email-juri.lelli@arm.com>
 <20160112100945.GZ1084@ubuntu>
 <20160112155200.GC18734@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35645 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbcAMGHt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 01:07:49 -0500
Received: by mail-pa0-f49.google.com with SMTP id ho8so91863813pac.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 22:07:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160112155200.GC18734@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 12-01-16, 15:52, Juri Lelli wrote:
> Other users (i.e., cpufreq_parse_governor and cpufreq_register_governor)
> needs to take the mutex externally. So, we need to unify this behaviour.

No they don't have to.

And that's why I have been saying that we better nail down the exact
thing the mutex is supposed to protect.

There can be two cases here:
- It protects the governor list, in that case we can move it to
  find_governor().
- It guarantees that the governor pointer stays valid: That's not true
  as we are using the governor pointer outside of the lock.

And so I said, "No they don't have to" :)

-- 
viresh
