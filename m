From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: pxa2xx: fix pxa_cpufreq_change_voltage prototype
Date: Mon, 25 Jan 2016 22:05:23 +0530
Message-ID: <20160125163523.GD3322@vireshk>
References: <1453736683-1959283-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36305 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbcAYQf0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2016 11:35:26 -0500
Received: by mail-pf0-f178.google.com with SMTP id n128so84264213pfn.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2016 08:35:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1453736683-1959283-1-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Joe Perches <joe@perches.com>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 25-01-16, 16:44, Arnd Bergmann wrote:
> There are two definitions of pxa_cpufreq_change_voltage, with slightly
> different prototypes after one of them had its argument marked 'const'.
> Now the other one (for !CONFIG_REGULATOR) produces a harmless warning:
> 
> drivers/cpufreq/pxa2xx-cpufreq.c: In function 'pxa_set_target':
> drivers/cpufreq/pxa2xx-cpufreq.c:291:36: warning: passing argument 1 of 'pxa_cpufreq_change_voltage' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>    ret = pxa_cpufreq_change_voltage(&pxa_freq_settings[idx]);
>                                     ^
> drivers/cpufreq/pxa2xx-cpufreq.c:205:12: note: expected 'struct pxa_freqs *' but argument is of type 'const struct pxa_freqs *'
>  static int pxa_cpufreq_change_voltage(struct pxa_freqs *pxa_freq)
>             ^
> 
> This changes the prototype in the same way as the other, which
> avoids the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 03c229906311 ("cpufreq: pxa: make pxa_freqs arrays const")
> ---
>  drivers/cpufreq/pxa2xx-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
> index efe3b215fd34..46fee1539cc8 100644
> --- a/drivers/cpufreq/pxa2xx-cpufreq.c
> +++ b/drivers/cpufreq/pxa2xx-cpufreq.c
> @@ -202,7 +202,7 @@ static void __init pxa_cpufreq_init_voltages(void)
>  	}
>  }
>  #else
> -static int pxa_cpufreq_change_voltage(struct pxa_freqs *pxa_freq)
> +static int pxa_cpufreq_change_voltage(const struct pxa_freqs *pxa_freq)
>  {
>  	return 0;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
