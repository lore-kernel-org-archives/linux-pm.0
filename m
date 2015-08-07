From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 11/31] cpufreq/sfi: use kmemdup rather than duplicating
 its implementation
Date: Fri, 7 Aug 2015 14:28:57 +0530
Message-ID: <20150807085857.GA6939@linux>
References: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
 <1438934377-4922-12-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34015 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbbHGI7D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2015 04:59:03 -0400
Received: by pawu10 with SMTP id u10so84211186paw.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2015 01:59:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438934377-4922-12-git-send-email-a.hajda@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 07-08-15, 09:59, Andrzej Hajda wrote:
> The patch was generated using fixed coccinelle semantic patch
> scripts/coccinelle/api/memdup.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2014320
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/cpufreq/sfi-cpufreq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
> index ffa3389..992ce6f 100644
> --- a/drivers/cpufreq/sfi-cpufreq.c
> +++ b/drivers/cpufreq/sfi-cpufreq.c
> @@ -45,12 +45,10 @@ static int sfi_parse_freq(struct sfi_table_header *table)
>  	pentry = (struct sfi_freq_table_entry *)sb->pentry;
>  	totallen = num_freq_table_entries * sizeof(*pentry);
>  
> -	sfi_cpufreq_array = kzalloc(totallen, GFP_KERNEL);
> +	sfi_cpufreq_array = kmemdup(pentry, totallen, GFP_KERNEL);
>  	if (!sfi_cpufreq_array)
>  		return -ENOMEM;
>  
> -	memcpy(sfi_cpufreq_array, pentry, totallen);
> -

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
