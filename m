From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: sfi: make freq_table static
Date: Thu, 15 Jun 2017 15:28:43 +0530
Message-ID: <20170615095843.GA3942@vireshk-i7>
References: <20170615095559.21973-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36305 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdFOJ6q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jun 2017 05:58:46 -0400
Received: by mail-pf0-f178.google.com with SMTP id x63so5304332pff.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Jun 2017 02:58:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170615095559.21973-1-colin.king@canonical.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On 15-06-17, 10:55, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> pointer freq_table can be made static as it does not need to be in
> global scope.
> 
> Cleans up sparse warning:
> "symbol 'freq_table' was not declared. Should it be static?"
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/cpufreq/sfi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
> index 992ce6f9abec..3779742f86e3 100644
> --- a/drivers/cpufreq/sfi-cpufreq.c
> +++ b/drivers/cpufreq/sfi-cpufreq.c
> @@ -24,7 +24,7 @@
>  
>  #include <asm/msr.h>
>  
> -struct cpufreq_frequency_table *freq_table;
> +static struct cpufreq_frequency_table *freq_table;
>  static struct sfi_freq_table_entry *sfi_cpufreq_array;
>  static int num_freq_table_entries;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
