From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: st: add missing \n to end of dev_err message
Date: Mon, 26 Sep 2016 09:23:38 +0530
Message-ID: <20160926035338.GF17336@vireshk-i7>
References: <20160925214013.12430-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35229 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034859AbcIZDxm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Sep 2016 23:53:42 -0400
Received: by mail-pa0-f50.google.com with SMTP id oz2so58192727pac.2
        for <linux-pm@vger.kernel.org>; Sun, 25 Sep 2016 20:53:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160925214013.12430-1-colin.king@canonical.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: trivial@kernel.org, Patrice Chotard <patrice.chotard@st.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 25-09-16, 14:40, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trival fix, dev_err message is missing a \n, so add it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/cpufreq/sti-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> index 0404203..b366e6d 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -163,7 +163,7 @@ static int sti_cpufreq_set_opp_info(void)
>  
>  	reg_fields = sti_cpufreq_match();
>  	if (!reg_fields) {
> -		dev_err(dev, "This SoC doesn't support voltage scaling");
> +		dev_err(dev, "This SoC doesn't support voltage scaling\n");
>  		return -ENODEV;
>  	}
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
