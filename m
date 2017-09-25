From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: powernow-k8: pr_err() strings should end with
 newlines
Date: Mon, 25 Sep 2017 16:11:48 -0700
Message-ID: <20170925231148.GB3053@ubuntu>
References: <113fdc7d136811950c78a7cb2f11f9d98eeb26dc.1506332261.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:47787 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936426AbdIYXLu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2017 19:11:50 -0400
Received: by mail-pf0-f181.google.com with SMTP id u12so4590062pfl.4
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2017 16:11:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <113fdc7d136811950c78a7cb2f11f9d98eeb26dc.1506332261.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 25-09-17, 15:10, Arvind Yadav wrote:
> pr_err() messages should terminated with a new-line to avoid
> other messages being concatenated onto the end.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/cpufreq/powernow-k8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index 062d714..b01e31d 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -1043,7 +1043,7 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data) {
> -		pr_err("unable to alloc powernow_k8_data");
> +		pr_err("unable to alloc powernow_k8_data\n");
>  		return -ENOMEM;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
