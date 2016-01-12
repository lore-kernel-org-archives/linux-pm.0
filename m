From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 01/19] cpufreq: do not expose cpufreq_governor_lock
Date: Tue, 12 Jan 2016 14:26:19 +0530
Message-ID: <20160112085619.GR1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-2-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34579 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934384AbcALI4X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 03:56:23 -0500
Received: by mail-pa0-f50.google.com with SMTP id uo6so319923412pac.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 00:56:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452533760-13787-2-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 11-01-16, 17:35, Juri Lelli wrote:
> From: Michael Turquette <mturquette@baylibre.com>
> 
> Since commit 3a91b069eabf ("cpufreq: governor: Quit work-handlers early if
> governor is stopped") cpufreq_governor_lock is not used anywhere outside
> cpufreq.c. Make it static again.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Michael Turquette <mturquette@baylibre.com>
> ---
>  drivers/cpufreq/cpufreq.c          | 2 +-
>  drivers/cpufreq/cpufreq_governor.h | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
