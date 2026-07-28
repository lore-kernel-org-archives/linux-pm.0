Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D83A75A2
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 04:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785213261; cv=none; b=PrlSgGr1Abf8QA5CYhvnO0AgWCRrZPCONTxBs7o7NOsdG1TxZ525uJE0xoxh8X+nPhU5rjnrcaSngqLiiSpnDtXJuBvT33iApY1TfvPK0j1RtpLHfqq1TNJBFXhXDmt0gAZLzFmKHzDvZzJf31F9j3kR9nkVvbxPIOk2OIsmKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785213261; c=relaxed/simple;
	bh=+qHFYr/DAaP3b5zFp/5xk+xWxGfKHI/scQgUfJTH1Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfhaI8Ov9H+/b9Oq0v3lnYxG+xkuqybuXiVoN5ZeF0DYTeL0nEk3o7JAnAK+cwJsnTblwr+D8cmdsdy33xtbUDPCTexhzpf+kWLK40nZmKxg7dbYqsCqsUeoWOEu89moKar2ZETToYM1YlxV1ek9Ar0nWBKAsEO/K9e9JKea+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ED2L+FGF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ED2L+FGF"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8485ef63b68so3480433b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 21:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785213257; x=1785818057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6TqnoO2SG+nVlb0sfOqLHelHrztiPgMJCEBuoNNaZYU=;
        b=ED2L+FGF3IZhO+nq7eqEl0fhEEQGIkyzASLTMYMQA37E8BOHI51V3BSxQqPILY67oE
         eP8g3PWt0qG6oHTZs+jeKsBeFLhcB1z82HiZKU5nQxnSSZQduzNeLkC95Mh+InBRLx00
         D66rAoUl4vJmXpwGXnlYgAOLhZQziasx2Gj39NPX5ub2kD/9nF1h5o8oUu09R1unINlc
         egCKz5GH/gcW1HF1pf7G9RjvE3SsjvIjDvQB2ZgG/lS/yW6ouqJdNDKCToyxwav8x2LG
         n0EaW2PT+K5Xam4OXRrRRKTs3W4/Lr4XFXp4rwW4/gMWOzONOVFGRHjAGVAViHAX+O7y
         F85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785213257; x=1785818057;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6TqnoO2SG+nVlb0sfOqLHelHrztiPgMJCEBuoNNaZYU=;
        b=hPxDgCcfBEdzufd+PdmJQEBbjb8IHW4c+0KLPbhwz16RUxCZBXZlIMEVt0uLtQ2IJH
         VD3A9RK9ebeTphBtJVJExTGylS3MnLId5NxoKnWoybZztrT/jhFXwRJmOIkW9V28V9r0
         NIfJ8CQbjbah00t2YRS1Bmj5PTffggWwi7e+JDAMZvRr8qIdseUYaYYhWmWsUod9O/5z
         FhTZbMTR8UOYWQfbipjJtLuQtsaYXqQQJc2KdXOqQOnI1wmM4K7DkvroK2ZawgC5zG/C
         1tNh5okS9CUhG3B158jJ1uqk1ipBrHVjDTSC4qVHP2dmSsrpaQjjLi7LK65UM1N0wciJ
         xrHQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/dyDNb+P/LdlkzIjeGxSV3Yj7onX4S/U80noOPyHP2zmmXp2HsPLzPoLMubUbK4zj89u0XAM3iw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3quK8ir0mm4Zq+93RYrNEZESiCNiQmO2yYpnfghBmiPp/WR85
	RxABmBVo2u9riT2OEe5XVhvMa34rbk2dx4msygk+tLyf+kmpU3tLg6Z5IhQkI21O7TY=
X-Gm-Gg: AR+sD13KUKtfVyZOkCXMPQYeGXxIscbpGWoDl0oXG1O2wcEPFQm9Zpk2IL3AcXkMR4W
	o6zvMgh6k/uzHGyesxMPfxfEWqU+ZOI4DOrcuUYUhUrZ+36UBx+VVhrDw2N21VKOwHg42A/LFiA
	tke+hnM7KypTUKcHWVtYWXL4GgXe39zXCfaT+ewjUoN36aLTrTZHnp79DKj1qvGiLEnLHRWtBoW
	yfADEcW4V55HfSudxYlgpI9MmaLqhiK0wE1NWO8YEQqtmR18Dy4MKniJZy9sfLyqczDANLVCK7T
	Gf2NsaaCnBmz1dPRBHrg4jc5RRN5XfeSZWkVMFkNddnDH1zp4J2UgrTEpUUelbysOHam5Q+f8GA
	5+mBsGkvOgn0bH4/c0AldTOdVeMhtiaOxdXAbnOBvbdgDyb9eL0BUHuW0D9VXGTT2xFNRSULoEu
	7AKg==
X-Received: by 2002:a05:6a20:b40b:b0:3bf:a638:4376 with SMTP id adf61e73a8af0-3c8ab0e3b14mr1143054637.21.1785213256961;
        Mon, 27 Jul 2026 21:34:16 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e585ae882sm27733718c88.6.2026.07.27.21.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 21:34:15 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:04:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	chandana.chiluveru@oss.qualcomm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mukesh.savaliya@oss.qualcomm.com, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4] opp: Use clk_get_optional() to avoid leaving
 opp_table->clk as an error pointer
Message-ID: <jyddvc6eki2l3jebtcvux36wujd2veb2wellsb6o2xsbuypeco@7bvs6piwrraq>
References: <20260727-fix_ptr_check_on_clk-v4-1-97969fa7826a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-fix_ptr_check_on_clk-v4-1-97969fa7826a@oss.qualcomm.com>

On 27-07-26, 22:33, Praveen Talari wrote:
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Reviewed-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

You added ^^ and ..

> Changes in v4:
> - Rebased on
>   https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=cpufreq/arm/linux-next
> - Removed ret variable.
> - Link to v3:
>   https://lore.kernel.org/all/20260727-fix_ptr_check_on_clk-v3-1-94629ac7aaae@oss.qualcomm.com
> 
> Changes in v3:
> - Added OPP framework maintainers
> - Link to v2:
>   https://patch.msgid.link/20260725-fix_ptr_check_on_clk-v2-1-7f269f7d33f3@oss.qualcomm.com
> 
> Changes in v2:
> - Switched from guarding clk_round_rate() against error pointers to
>   fixing the root cause in OPP core: use clk_get_optional() instead
>   of clk_get() in _update_opp_table_clk(), so opp_table->clk is left
>   as NULL (not ERR_PTR(-ENOENT)) when a device has no Linux clock,
>   per Sebastian Reichel's review suggestion.
> - Dropped the drivers/clk/clk.c change entirely.
> - Link to v1:
>   https://patch.msgid.link/20260723-fix_ptr_check_on_clk-v1-1-568a7ed87746@oss.qualcomm.com
> 
> To: konrad.dybcio@oss.qualcomm.com
> To: Viresh Kumar <vireshk@kernel.org>
> To: Nishanth Menon <nm@ti.com>
> To: Stephen Boyd <sboyd@kernel.org>
> Cc: mukesh.savaliya@oss.qualcomm.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

and this ^^

Only one line with `---` is enough and you can add non-commit part
after that.

>  drivers/opp/core.c | 54 ++++++++++++++++++++++++------------------------------
>  1 file changed, 24 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index ab0b0a2f85a1..f2b2ffdb410d 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1582,8 +1582,6 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
>  					       struct opp_table *opp_table,
>  					       bool getclk)
>  {
> -	int ret;
> -
>  	/*
>  	 * Return early if we don't need to get clk or we have already done it
>  	 * earlier.
> @@ -1592,39 +1590,35 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
>  	    opp_table->clks)
>  		return opp_table;
>  
> -	/* Find clk for the device */
> -	opp_table->clk = clk_get(dev, NULL);
> +	/*
> +	 * There are few platforms which don't want the OPP core to manage
> +	 * device's clock settings. In such cases neither the platform
> +	 * provides the clks explicitly to us, nor the DT contains a valid
> +	 * clk entry. The OPP nodes in DT may still contain "opp-hz" property
> +	 * though, which we need to parse and allow the platform to find an
> +	 * OPP based on freq later on.
> +	 *
> +	 * This is a simple solution to take care of such corner cases, i.e.
> +	 * make the clk_count 1, which lets us allocate space for frequency
> +	 * in opp->rates and also parse the entries in DT. Use
> +	 * clk_get_optional() instead of clk_get() so opp_table->clk stays
> +	 * NULL for such devices, instead of holding an ERR_PTR(-ENOENT) that
> +	 * consumers must remember to special-case.
> +	 */
> +	opp_table->clk = clk_get_optional(dev, NULL);
>  
> -	ret = PTR_ERR_OR_ZERO(opp_table->clk);
> -	if (!ret) {
> -		opp_table->config_clks = _opp_config_clk_single;
> -		opp_table->clk_count = 1;
> -		return opp_table;
> +	if (IS_ERR(opp_table->clk)) {
> +		dev_pm_opp_put_opp_table(opp_table);
> +		dev_err_probe(dev, PTR_ERR(opp_table->clk), "Couldn't find clock\n");
> +		return ERR_CAST(opp_table->clk);
>  	}
>  
> -	if (ret == -ENOENT) {
> -		/*
> -		 * There are few platforms which don't want the OPP core to
> -		 * manage device's clock settings. In such cases neither the
> -		 * platform provides the clks explicitly to us, nor the DT
> -		 * contains a valid clk entry. The OPP nodes in DT may still
> -		 * contain "opp-hz" property though, which we need to parse and
> -		 * allow the platform to find an OPP based on freq later on.
> -		 *
> -		 * This is a simple solution to take care of such corner cases,
> -		 * i.e. make the clk_count 1, which lets us allocate space for
> -		 * frequency in opp->rates and also parse the entries in DT.
> -		 */
> -		opp_table->clk_count = 1;
> -
> -		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
> -		return opp_table;
> -	}
> +	if (opp_table->clk)
> +		opp_table->config_clks = _opp_config_clk_single;
>  
> -	dev_pm_opp_put_opp_table(opp_table);
> -	dev_err_probe(dev, ret, "Couldn't find clock\n");
> +	opp_table->clk_count = 1;
>  
> -	return ERR_PTR(ret);
> +	return opp_table;
>  }

Applied. Thanks.

-- 
viresh
