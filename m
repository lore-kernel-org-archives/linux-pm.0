From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 2/8] sched/fair: add margin to utilization update
Date: Tue, 15 Mar 2016 19:52:59 -0700
Message-ID: <56E8CA8B.8080506@linaro.org>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-3-git-send-email-mturquette+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35610 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbcCPCxE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 22:53:04 -0400
Received: by mail-pf0-f173.google.com with SMTP id n5so54754488pfn.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Mar 2016 19:53:03 -0700 (PDT)
In-Reply-To: <1457932932-28444-3-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On 03/13/2016 10:22 PM, Michael Turquette wrote:
> +unsigned long cfs_capacity_margin = CAPACITY_MARGIN_DEFAULT;
> +
>  #ifdef CONFIG_CFS_BANDWIDTH
>  /*
>   * Amount of runtime to allocate from global (tg) to local (per-cfs_rq) pool
> @@ -2840,6 +2853,8 @@ static inline void update_load_avg(struct sched_entity *se, int update_tg)
>  
>  	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
>  		unsigned long max = rq->cpu_capacity_orig;
> +		unsigned long cap = cfs_rq->avg.util_avg *
> +			cfs_capacity_margin / max;

Doesn't rq->cpu_capacity_orig get scaled per the microarch invariance?
This would mean that the margin we're applying here would differ based
on that.

I'd expect that the margin would be * (cfs_capacity_margin /
SCHED_CAPACITY_SCALE) which would then reduce the division into a shift.
