Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062B39060A
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116752; cv=none; b=HIdseqvmqNcTrnor4GQrx/u9Ry2CmfuK4dbqTFnFk/8nbSCXVQTE6yNR/N+JfHItr40Zn2n0tidwEMnA3lWcG5GnwcQ7k9UaIKuYGI2GJfB7BMbPUV3wUYMPRGNj+lx0QgMrwn6n960vvyu1zt4gR3LkYkOYip2I3zR8n/bKMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116752; c=relaxed/simple;
	bh=hA5oBlxJork1c4h5sHlQY0FI6yyM6hvjSrny1zE1RN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiMFnnpRo5Qx3SewtL3ztVgg0JB5vqS9JVH/OZFjEV/X57IWtNEfahSG/L6ekOq2zburIbdnDCHjNCrFY7vu+Xyp94LZl7g61OM8RARg5wdfKPJ6273IIJbZpRoKLMDfGGeIe5I3Wi4XUcv16/hAVXWXotCH73tZ0izpoA4bbVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qI46Lq70; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qI46Lq70"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37d82f3a244so483679a91.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782116746; x=1782721546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=urde0H5lw+l0w07oCZ5gmtixK9Wy1aHPm4CdpLxWffg=;
        b=qI46Lq70T2bnfKy1mAZKdGHorEGPeez4GJiUa4bi+1V9N6Xnj5+33lYTm9mY2jLnhs
         wbe+2U1GWTX7fdUOI4C9UuAzXKXZBldAxfcKQogiIeuXQxsfvV+f5yOJ2a1VedCxl3v0
         0Fh5IBWQgqz30umTulBYlj3oLDIvFXZPLBmTWgsdf56jOkg7JP+4JM+bO45bEvPt/yQH
         Yn8RVaXpesbNUiBfIkOQVIfaG2XvzuCtWc2BuArbVtr7X17DOqiZJokLl6eikCwQ+cLV
         RSSWQB5nvrDskWdgFLHi8Ld9pI2lPz6qK38wqfFsv6URdPaBboE1dNEerALekwrjhTqe
         vZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782116746; x=1782721546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urde0H5lw+l0w07oCZ5gmtixK9Wy1aHPm4CdpLxWffg=;
        b=HoeE2fSVswNNSgsCalALQLUpw7QL3Gxvr4kNSzjderYJcEmINgpRbUeJwq/CgnD3j0
         Dyanaw3z3+dt6/SRWCGR0W1QsGRrWKGuhher+IPul0BKI5I48jeuCC6aSWa57o8QcLbF
         KCsxArnQZwd5W9QCnytphWOLgnl3uIDsQJvpHIcsRRM9YrvvIlXzqlInC8xPTJKNEpWr
         f1bRzW5TR7HaCnADrv0W3z3shHX9Txc7NODKyG300vhzY086RUbntozyWSychy3LYLa8
         yStleSZMK4pd9gCr4BjT67RwGqrUCwYzggKmztMedURDT5V9EP1R6hTOYZzz3RwUep9h
         8snA==
X-Forwarded-Encrypted: i=1; AHgh+RoRQY6sGeWbIj9uB0AfwDi0OdhZzBZDfhO+NQQ+SyvDIoZJE431K5lzjqv5VaiDPJ5xup6Q0qxGfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBSvBQqcDDwkr7VCKvJKzpV54awf3v/ecHp5zqWXJdJbq+L1fM
	W2b15tF9o2UlL9lpkhqZLE4yWBnZYLJ6OlVwe9J4/XDhX+BvusS+2pgZ61dzDA5EVsM=
X-Gm-Gg: AfdE7cmpHxgQl8MIgLFLA41IhpwzXHfDw4Szs+zvGIO1uSeWaSqwJo0H1196xybsFzi
	MfNNOZoxB7EQ5sXVmvtpyIxgti1fzJDoobO+sOqdd98Q7TuLllumgtbrNfoIHrq9Bl9mRSz78II
	3AdoTC7nLkYjy6QDSYSRjk4jhhCe53wRvcXqTIl9TzTZ8bxJgBmvudk+4K4/CBxpGYLSFz02n+W
	YZwVUnlJkmD4SK1tuYEYr7wnlY1CqkoYkB1LlWQxu3oH/I0tEbpYAyWsLaNCBtj/Erm36SDRStO
	wpmv2qL02cNbR8iNmfq5XYkgGvlUrMnEpUF7czKdLIY7goitNrHWdh0UNtKYX8dpeQWRtEA102G
	s9Oc/+9iHGRKkeitTsjcmd9aPrdlY1DsT9GW0atpp+N40DgvgCn0IIVgvoCH/koxE5lGCKTo1aX
	K72pYR78PuxulnrcIjpQMYcWc=
X-Received: by 2002:a17:90b:3d47:b0:37c:18e0:90e4 with SMTP id 98e67ed59e1d1-37d4d71da02mr9453775a91.2.1782116745540;
        Mon, 22 Jun 2026 01:25:45 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af310sm71822885ad.2.2026.06.22.01.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:25:44 -0700 (PDT)
Date: Mon, 22 Jun 2026 13:55:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: sven@kernel.org, j@jannau.net, neal@gompa.dev, rafael@kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: apple-soc: Add missing OPP table cleanup on
 init failure
Message-ID: <p4gog5paa5czqzho6i4chgsncyjxsfau5zu3lkxwtkplk2y2f5@l3sa7gohfnqw>
References: <20260622063148.751787-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622063148.751787-1-haoxiang_li2024@163.com>

On 22-06-26, 14:31, Haoxiang Li wrote:
> apple_soc_cpufreq_init() adds the OPP table with
> dev_pm_opp_of_add_table(), but some later error
> paths can return without removing it.
> 
> Add the missing dev_pm_opp_of_remove_table() call
> to clean up the OPP table on init failure.
> 
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/cpufreq/apple-soc-cpufreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
> index 9396034167e5..4dae968e84df 100644
> --- a/drivers/cpufreq/apple-soc-cpufreq.c
> +++ b/drivers/cpufreq/apple-soc-cpufreq.c
> @@ -260,7 +260,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
>  	ret = apple_soc_cpufreq_find_cluster(policy, &reg_base, &info);
>  	if (ret) {
>  		dev_err(cpu_dev, "%s: failed to get cluster info: %d\n", __func__, ret);
> -		return ret;
> +		goto out_remove_table;
>  	}
>  
>  	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
> @@ -326,6 +326,8 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
>  	dev_pm_opp_remove_all_dynamic(cpu_dev);

This driver doesn't add any dynamic (non DT) OPPs, looks like this is incorrect
?

>  out_iounmap:
>  	iounmap(reg_base);
> +out_remove_table:
> +	dev_pm_opp_of_remove_table(cpu_dev);

This is also required to be done in apple_soc_cpufreq_exit() ?

>  	return ret;
>  }

-- 
viresh
