From: "Kim, Milo" <milo.kim@ti.com>
Subject: Re: [PATCH] power: supply: lp8788: prevent out of bounds array access
Date: Tue, 28 Mar 2017 08:23:43 +0900
Message-ID: <84e9b377-30c6-d0f2-b869-6382d6c9f770@ti.com>
References: <20170325160049.18943-1-giedrius.statkevicius@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:29046 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752443AbdC0XYZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 19:24:25 -0400
In-Reply-To: <20170325160049.18943-1-giedrius.statkevicius@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Giedrius_Statkevi=c4=8dius?= <giedrius.statkevicius@gmail.com>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 3/26/2017 1:00 AM, Giedrius Statkevičius wrote:
> val might become 7 in which case stime[7] (array of length 7) would be
> accessed during the scnprintf call later and that will cause issues.
> Obviously, string concatenation is not intended here so just a comma needs
> to be added to fix the issue.
>
> Signed-off-by: Giedrius Statkevičius <giedrius.statkevicius@gmail.com>

Acked-by: Milo Kim <milo.kim@ti.com>

> ---
>  drivers/power/supply/lp8788-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
> index 509e2b341bd6..677f7c40b25a 100644
> --- a/drivers/power/supply/lp8788-charger.c
> +++ b/drivers/power/supply/lp8788-charger.c
> @@ -651,7 +651,7 @@ static ssize_t lp8788_show_eoc_time(struct device *dev,
>  {
>  	struct lp8788_charger *pchg = dev_get_drvdata(dev);
>  	char *stime[] = { "400ms", "5min", "10min", "15min",
> -			"20min", "25min", "30min" "No timeout" };
> +			"20min", "25min", "30min", "No timeout" };
>  	u8 val;
>
>  	lp8788_read_byte(pchg->lp, LP8788_CHG_EOC, &val);
>
