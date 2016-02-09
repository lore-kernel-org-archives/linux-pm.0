From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 15/16] cpufreq: dt: drop references to DT node
Date: Tue, 9 Feb 2016 09:52:47 +0530
Message-ID: <20160209042247.GF10843@vireshk>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <b0f0134c9d2488db1971d7be4b8bcdc27356eee4.1453965717.git.viresh.kumar@linaro.org>
 <20160202061132.GD31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34450 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbcBIEWv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 23:22:51 -0500
Received: by mail-pa0-f53.google.com with SMTP id kp3so1333873pab.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 20:22:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160202061132.GD31828@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, open list <linux-kernel@vger.kernel.org>

On 02-02-16, 11:41, Viresh Kumar wrote:
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> +static const char *find_supply_name(struct device *dev)
>  {
> +	struct device_node *np;
>  	struct property *pp;
>  	int cpu = dev->id;
> +	const char *name = NULL;
> +
> +	np = of_node_get(dev->of_node);
> +	if (!np) {
> +		dev_err(dev, "failed to find cpu%d node\n", cpu);
> +		return ERR_PTR(-ENOENT);
> +	}

I have updated that as:

+	np = of_node_get(dev->of_node);
+
+	/* This must be valid for sure */
+	if (WARN_ON(!np))
+		return NULL;

so that we don't have to check return value of find_supply_name() for errors, as
you pointed out in the other patch.

Will keep your RBY tag :)

-- 
viresh
