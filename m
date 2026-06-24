Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71033F361
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 06:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782281733; cv=none; b=JzmPrWw/mFaoP0ot7Jh7BQSU3ysea1utXn5BsQYCGnq4yF8Gp0nImLP9BRKmRNp4wQfM0dHQCgknrDuuijbBLPurBG712Y0b0dwYV91gq/31JtFHHKKF2AMSFL16d0ClxczZEQmAGMXl5WR4Z7P+qzp5Eu1zi2HVWYF3xScEBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782281733; c=relaxed/simple;
	bh=aH0b/lOP3E/eHs7Kj9MVmfcQXZdjz79GV7nBpFxLmW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFCT0B+Q4ej4kZ8lwTEVoX4i/xLq1oSIXN5du6/WWFsYM9TrJoeNrMObdzi4iLC8skzlUE2yxP2fF2jVJ4moofaoHXfTppLI56srxBV+os/V6JeIGSRpU9fAc0mM/VSAzApbWpqcHGLccFhKLrC1BNB4WVbD3m0x9e0i85pVCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4HKTw0R; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4HKTw0R"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c89fa656ea1so217217a12.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 23:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782281731; x=1782886531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=87QgyDoyxAcN2RlRMsIzcXMwRXx5rS1IvXCP9lPgo4A=;
        b=G4HKTw0RqQN8h0rktccL5ldPmGS/V8WFO+JRtwWsRBNJ1qsj6m/zDhSAeKu0nDdleo
         QT7Zj/k9OzFrnFPV5UXCCmR62WDZzhZUeoGh/8Uhwl8e7w5eIR27uyOiqd5WBv252QnI
         LiRaoAbPbdGaVvEcngnIWwI/Ueo/ATUahbvj5XUaQawnEZ/7jMSXKXc/FDInYbsjFuC3
         gQO90ZkjWKphg6ZtP0PcLCOPA9lnZ5RcBIh1MBwE/p9ODwgqYmJUj+Beu/IH7hFkvr6b
         YMbfmdlGEKcUG8tLY4bGtGD5XdxCTSKNNXK5N1UDzLcJY44oMiI7hdGMOdURmJ0qvsr1
         dCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782281731; x=1782886531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87QgyDoyxAcN2RlRMsIzcXMwRXx5rS1IvXCP9lPgo4A=;
        b=isuPQyLQcnaLD1AJGv/V9KRZPCUZD/cpuJFI3P3WF+8zuoJM5V0LL8EJys5GAw7P9O
         K+5GEj2mmkyVHNwLnaGxfl7q/d8B0n3BFs026Fvkm+KNcgceWA+nMfoHey2oAxJHkBhK
         y2zgAxb6Pos4OCt8kaHCrNci42IcPM5kdtWM4KoJA6Yfx5ch8zmIjYFH7Kdour9Zp8zt
         1XktIi2TDlzF7vb/VcPfyRiuVmP4IZo1LRI6F0LzwIOlcqo597O155QhTAPdxESDgwbI
         LNgg1m8wovZI6+J/+f2TZkBXfkfngbUf4gJ7y7xLG3lYc2EEG0T2qQYF/4GQaCPwHGeH
         L3Pg==
X-Forwarded-Encrypted: i=1; AFNElJ+HHNB3OyDgyCVMcaVXMexhaJU1TnvwZdvv+L37TBvdqgiAN4wxLXQ2iknp0EThc01+0lVtHRgDVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhambz78FqYNg4Z/yIwkzgdJHyA8N0xpvB97u0Z9Anq0gkQgdy
	AU67s8OR/an7Y0HR+PTE/HXEQ4SPHrS5Z2yYxs6jO0m6thoUkxraaRbZ/sfJcEuZ2o4=
X-Gm-Gg: AfdE7cnnd3+/ETJa+yA7A6AKirh+rpSpFmQI0lNF2pGB6xyt0BR1jEPfEaHhe5Ag9Mx
	9n0dPe/Rqb5FKFfLqDzuJhsVKJYaui3dVn409deU4uZR9s778sss/8Y0LAFhfRe2d8BK8zVVIqW
	JTWQynYwYrNMqx+5/nykVlxORzpNx1VgfPxr5Ir4nOIzPUnTvW6wou1fb5evv+jXxjv07u+93wt
	9YnGdcDjc6xHuAeyGg/ZBaacC2zcCstYAmRfHI+YnnUFw07zOPMJ9N8vMzYeGe8ufZ+yzFELoVW
	SXM6t4iIQvZUeMfC+iaaM162FtWrBVwDfH2hpAbt4Zr5VwWdFSPzxH4gMF+rRjMUKIcgWenUkVr
	Hx1Lc3eqMwstOPVEriW2KCPiK41VgDB70IU+IA2VMzPT4ZtKPQl/aLsyhhXN+33froGmhdIqfus
	NbEHJfh0IvSc88
X-Received: by 2002:a05:6a21:1bc1:b0:3b4:88e7:87c7 with SMTP id adf61e73a8af0-3bc51c683c9mr19446329637.17.1782281730631;
        Tue, 23 Jun 2026 23:15:30 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc563c131sm13199347a12.18.2026.06.23.23.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 23:15:29 -0700 (PDT)
Date: Wed, 24 Jun 2026 11:45:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: sven@kernel.org, j@jannau.net, neal@gompa.dev, rafael@kernel.org, 
	linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sumit.semwal@linaro.org
Subject: Re: [PATCH v2] cpufreq: apple-soc: Fix OPP table cleanup
Message-ID: <x3lom5jew2w4i7aftjxl4qpgupggw74bsjnzqiu5pjbejztti4@j33hgft6gt3b>
References: <20260624033756.2702021-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624033756.2702021-1-haoxiang_li2024@163.com>

On 24-06-26, 11:37, Haoxiang Li wrote:
> dev_pm_opp_of_add_table() adds the DT OPP table but not all failure
> paths remove it. The driver also uses dev_pm_opp_remove_all_dynamic(),
> which is not the right cleanup helper for OPPs loaded from firmware.
> 
> Remove the DT OPP table with dev_pm_opp_of_remove_table() on init
> failure paths and from apple_soc_cpufreq_exit().
> 
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Please add Fixes and Stable tags.

> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
> @@ -320,10 +320,10 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
>  	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
>  out_free_priv:
>  	kfree(priv);
> -out_free_opp:
> -	dev_pm_opp_remove_all_dynamic(cpu_dev);
>  out_iounmap:
>  	iounmap(reg_base);
> +out_remove_opp_table:
> +	dev_pm_opp_of_remove_table(cpu_dev);
>  	return ret;
>  }
>  
> @@ -332,7 +332,7 @@ static void apple_soc_cpufreq_exit(struct cpufreq_policy *policy)
>  	struct apple_cpu_priv *priv = policy->driver_data;
>  
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
> -	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
> +	dev_pm_opp_of_remove_table(priv->cpu_dev);
>  	iounmap(priv->reg_base);
>  	kfree(priv);

The order of cleanup calls should match in the above two sequences and there are
other missing pieces as well.

I think this would fix it:

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 9396034167e5..150deae8c31d 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -251,21 +251,19 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
                return -ENODEV;
        }

-       ret = dev_pm_opp_of_add_table(cpu_dev);
-       if (ret < 0) {
-               dev_err(cpu_dev, "%s: failed to add OPP table: %d\n", __func__, ret);
-               return ret;
-       }
+       priv = kzalloc_obj(*priv);
+       if (!priv)
+               return -ENOMEM;

        ret = apple_soc_cpufreq_find_cluster(policy, &reg_base, &info);
        if (ret) {
                dev_err(cpu_dev, "%s: failed to get cluster info: %d\n", __func__, ret);
-               return ret;
+               goto out_priv;
        }

-       ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
-       if (ret) {
-               dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n", __func__, ret);
+       ret = dev_pm_opp_of_cpumask_add_table(policy->cpus);
+       if (ret < 0) {
+               dev_err(cpu_dev, "%s: failed to add OPP table: %d\n", __func__, ret);
                goto out_iounmap;
        }

@@ -273,19 +271,13 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
        if (ret <= 0) {
                dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
                ret = -EPROBE_DEFER;
-               goto out_free_opp;
-       }
-
-       priv = kzalloc_obj(*priv);
-       if (!priv) {
-               ret = -ENOMEM;
-               goto out_free_opp;
+               goto out_free_table;
        }

        ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
        if (ret) {
                dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
-               goto out_free_priv;
+               goto out_free_table;
        }

        /* Get OPP levels (p-state indexes) and stash them in driver_data */
@@ -320,12 +312,12 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)

 out_free_cpufreq_table:
        dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
-out_free_priv:
-       kfree(priv);
-out_free_opp:
-       dev_pm_opp_remove_all_dynamic(cpu_dev);
+out_free_table:
+       dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 out_iounmap:
        iounmap(reg_base);
+out_free_priv:
+       kfree(priv);
        return ret;
 }

@@ -334,7 +326,7 @@ static void apple_soc_cpufreq_exit(struct cpufreq_policy *policy)
        struct apple_cpu_priv *priv = policy->driver_data;

        dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-       dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
+       dev_pm_opp_of_cpumask_remove_table(policy->cpus);
        iounmap(priv->reg_base);
        kfree(priv);
 }

-- 
viresh
