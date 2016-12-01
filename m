From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Do not print PM domain add error message if EPROBE_DEFER
Date: Thu, 01 Dec 2016 15:25 +0100
Message-ID: <2449753.iPCUDMXyRB@aspire.rjw.lan>
References: <1480508696-19294-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61305 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756009AbcLAO27 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2016 09:28:59 -0500
In-Reply-To: <1480508696-19294-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Wednesday, November 30, 2016 01:24:56 PM Geert Uytterhoeven wrote:
> EPROBE_DEFER is not an error, hence printing an error message like
> 
>     renesas_irqc e61c0000.interrupt-controller: failed to add to PM domain always-on: -517
> 
> may confuse the user.
> 
> Suppress the error message in case of EPROBE_DEFER to fix this.
> 
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/base/power/domain.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 64164aac6ae3990a..f22137b52dcb641b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2032,8 +2032,9 @@ int genpd_dev_pm_attach(struct device *dev)
>  	mutex_unlock(&gpd_list_lock);
>  
>  	if (ret < 0) {
> -		dev_err(dev, "failed to add to PM domain %s: %d",
> -			pd->name, ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to add to PM domain %s: %d",
> +				pd->name, ret);
>  		goto out;
>  	}
>  
> 

Applied (with ACKs etc).

Thanks,
Rafael

