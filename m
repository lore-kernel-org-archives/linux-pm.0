From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: s5pv210: add missing of_node_put
Date: Mon, 17 Jul 2017 14:13:45 +0530
Message-ID: <20170717084345.GN352@vireshk-i7>
References: <1500147653-31229-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33019 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdGQIns (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2017 04:43:48 -0400
Received: by mail-pf0-f180.google.com with SMTP id e26so5348720pfd.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2017 01:43:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1500147653-31229-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Kukjin Kim <kgene@kernel.org>, kernel-janitors@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 15-07-17, 21:40, Julia Lawall wrote:
> for_each_compatible_node performs an of_node_get on each iteration, so a
> return from the loop requires an of_node_put.
> 
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> local idexpression n;
> expression e,e1,e2;
> statement S;
> iterator i1;
> iterator name for_each_compatible_node;
> @@
> 
>  for_each_compatible_node(n,e1,e2) {
>    ...
> (
>    of_node_put(n);
> |
>    e = n
> |
>    return n;
> |
>    i1(...,n,...) S
> |
> +  of_node_put(n);
> ?  return ...;
> )
>    ...
>  }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -u -p a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -612,6 +612,7 @@ static int s5pv210_cpufreq_probe(struct

Just before this location we also called of_find_compatible_node()
directly and never did a of_node_put() for that. Can you please fix
that as well ?

>  		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
>  			pr_err("%s: failed to get alias of dmc node '%s'\n",
>  				__func__, np->name);
> +			of_node_put(np);
>  			return id;
>  		}
>  
> @@ -619,6 +620,7 @@ static int s5pv210_cpufreq_probe(struct
>  		if (!dmc_base[id]) {
>  			pr_err("%s: failed to map dmc%d registers\n",
>  				__func__, id);
> +			of_node_put(np);
>  			return -EFAULT;
>  		}
>  	}

-- 
viresh
