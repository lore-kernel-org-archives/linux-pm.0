From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: mvebu: Free the clock reference in the
 normal path
Date: Thu, 14 Dec 2017 08:26:32 +0530
Message-ID: <20171214025632.GO3322@vireshk-i7>
References: <20171213172914.6148-1-gregory.clement@free-electrons.com>
 <20171213172914.6148-2-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43903 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbdLNC4f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 21:56:35 -0500
Received: by mail-pg0-f65.google.com with SMTP id b18so2495600pgv.10
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 18:56:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171213172914.6148-2-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>

On 13-12-17, 18:29, Gregory CLEMENT wrote:
> In case of error the clock reference was freed but not in normal path
> once it was nor more used. This patch fixes it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/cpufreq/mvebu-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
> index ed915ee85dd9..c043aad8e3a0 100644
> --- a/drivers/cpufreq/mvebu-cpufreq.c
> +++ b/drivers/cpufreq/mvebu-cpufreq.c
> @@ -99,6 +99,7 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>  		if (ret)
>  			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
>  				__func__, ret);
> +		clk_put(clk);
>  	}
>  
>  	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
