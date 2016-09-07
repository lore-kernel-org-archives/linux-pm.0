From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: Add support for r8a7792
Date: Wed, 7 Sep 2016 10:32:59 +0530
Message-ID: <20160907050259.GL27345@vireshk-i7>
References: <1473164300-22017-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33246 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbcIGFDU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2016 01:03:20 -0400
Received: by mail-pa0-f43.google.com with SMTP id cm16so2342842pac.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Sep 2016 22:03:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1473164300-22017-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On 06-09-16, 14:18, Geert Uytterhoeven wrote:
> Add the compatible string for supporting the generic cpufreq driver on
> the Renesas R-Car V2H (r8a7792) SoC.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Untested due to lack of hardware.
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 285ed3e6494e9d22..276378a43321a4e0 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -52,6 +52,7 @@ static const struct of_device_id machines[] __initconst = {
>  	{ .compatible = "renesas,r8a7779", },
>  	{ .compatible = "renesas,r8a7790", },
>  	{ .compatible = "renesas,r8a7791", },
> +	{ .compatible = "renesas,r8a7792", },
>  	{ .compatible = "renesas,r8a7793", },
>  	{ .compatible = "renesas,r8a7794", },
>  	{ .compatible = "renesas,sh73a0", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
