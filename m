From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 03/19] cpufreq: kill for_each_policy
Date: Tue, 12 Jan 2016 14:31:32 +0530
Message-ID: <20160112090132.GT1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-4-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35839 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934499AbcALJBf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 04:01:35 -0500
Received: by mail-pa0-f43.google.com with SMTP id ho8so75771404pac.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 01:01:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452533760-13787-4-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 11-01-16, 17:35, Juri Lelli wrote:
> for_each_policy() macro is not used anywhere. Kill it.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
