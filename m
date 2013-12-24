From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 2/3] fuelgauge: max17042: Add IRQF_ONESHOT flag to use
 default irq handler.
Date: Mon, 23 Dec 2013 19:00:16 -0800
Message-ID: <20131224030016.GH10223@lizard>
References: <1387338834-4046-1-git-send-email-jonghwa3.lee@samsung.com>
 <1387338834-4046-3-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:54931 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab3LXDFc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2013 22:05:32 -0500
Received: by mail-pa0-f42.google.com with SMTP id lj1so6026427pab.29
        for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2013 19:05:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387338834-4046-3-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, MyungJoo Ham <myungjoo.ham@samsung.com>

On Wed, Dec 18, 2013 at 12:53:53PM +0900, Jonghwa Lee wrote:
> This patch adds IRQF_ONESHOT flag to max17042's irq since it uses primary
> default handler. Without this flag, requesting irq will be denied with returning
> error.
> 
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---

Applied, thanks!

>  drivers/power/max17042_battery.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
> index bbb2e01..c611ce7 100644
> --- a/drivers/power/max17042_battery.c
> +++ b/drivers/power/max17042_battery.c
> @@ -710,9 +710,9 @@ static int max17042_probe(struct i2c_client *client,
>  
>  	if (client->irq) {
>  		ret = request_threaded_irq(client->irq, NULL,
> -						max17042_thread_handler,
> -						IRQF_TRIGGER_FALLING,
> -						chip->battery.name, chip);
> +					max17042_thread_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					chip->battery.name, chip);
>  		if (!ret) {
>  			regmap_read(chip->regmap, MAX17042_CONFIG, &val);
>  			val |= CONFIG_ALRT_BIT_ENBL;
> -- 
> 1.7.9.5
