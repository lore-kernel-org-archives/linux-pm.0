From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: fix off-by-one bug in
 dev_pm_opp_get_max_volt_latency loop
Date: Tue, 21 Feb 2017 09:18:25 +0530
Message-ID: <20170221034825.GV21911@vireshk-i7>
References: <CGME20170220185824eucas1p227fb1d8679f66825702296113c776095@eucas1p2.samsung.com>
 <1487617077-21865-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33873 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdBUDsb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Feb 2017 22:48:31 -0500
Received: by mail-pg0-f44.google.com with SMTP id 1so9990853pgi.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Feb 2017 19:48:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1487617077-21865-1-git-send-email-a.hajda@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On 20-02-17, 19:57, Andrzej Hajda wrote:
> Reading array at given index before checking if index is valid results in
> illegal memory access.
> 
> The bug was detected using KASAN framework.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/base/power/opp/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 91ec323..dae6172 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -231,7 +231,8 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
>  	 * The caller needs to ensure that opp_table (and hence the regulator)
>  	 * isn't freed, while we are executing this routine.
>  	 */
> -	for (i = 0; reg = regulators[i], i < count; i++) {
> +	for (i = 0; i < count; i++) {
> +		reg = regulators[i];
>  		ret = regulator_set_voltage_time(reg, uV[i].min, uV[i].max);
>  		if (ret > 0)
>  			latency_ns += ret * 1000;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
