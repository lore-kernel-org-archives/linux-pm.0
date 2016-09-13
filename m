From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 3/4] cpuidle/menu: stop seeking deeper idle if current
 state is too deep
Date: Tue, 13 Sep 2016 22:01:30 +0800
Message-ID: <57D806BA.7050702@linaro.org>
References: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
 <1472114562-2736-3-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35608 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753804AbcIMOBg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 10:01:36 -0400
Received: by mail-pf0-f173.google.com with SMTP id z123so9947473pfz.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Sep 2016 07:01:36 -0700 (PDT)
In-Reply-To: <1472114562-2736-3-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: open list <linux-kernel@vger.kernel.org>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Ping..

On 08/25/2016 04:42 PM, Alex Shi wrote:
> The obsolete commit 71abbbf85 want to introduce a dynamic cstates,
> but it was removed for long time. Just left the nonsense deeper cstate
> checking.
> 
> Since all target_residency and exit_latency are going longer in deeper
> idle state, no needs to waste some cpu cycle on useless seeking.
> 
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> To: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Alex Shi <alex.shi@linaro.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 03d38c2..bb58e2a 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -358,9 +358,9 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  		if (s->disabled || su->disable)
>  			continue;
>  		if (s->target_residency > data->predicted_us)
> -			continue;
> +			break;
>  		if (s->exit_latency > latency_req)
> -			continue;
> +			break;
>  
>  		data->last_state_idx = i;
>  	}
> 
