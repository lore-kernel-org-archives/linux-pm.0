Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BD23C3BF3
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514926; cv=none; b=Htt2WiKqvyS5gbjc+9eZxEwDR8qm3qzQ7abRqz65rjxETJqoczseckQt2wGj8Wj4NIrbi+dKgA8muoPGvhtz2lmYFhg6YNY6e+k26VDLWHMkUP1k8s60jBVfUyTXDR5/M/L1FnI2kPlm7/AmGErojEYl2d3b+RgNOgVvuVzgfHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514926; c=relaxed/simple;
	bh=XS4hIZksIDcPoRF78CESnCBC+gXItqsIaQ5+GJ5O6Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txKqFGqazMRa/WLYLtBD2sR8iVwgfN3CHXQOfdjjgtB8VkY1p01Ws+Ebi8BSFknqH2c+qilNHDVL85QRtXQ3icoCKMC6bGqrivSogRxcAT6k7urlQ4O+AnFeXO0yzt68NWAkQRNnx5JR5yaqiZ9BJZyPu4FjkHpyeCPQ2BWyil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rbJA8/Do; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbJA8/Do"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824c9da9928so674990b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 01:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774514924; x=1775119724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFKAJmCqyCUR1rHA5vvir+TkMWlbbGUkJWjXl24Ykro=;
        b=rbJA8/Do6F4qqB9Omp+c10XO2hMSgrQn4/ZgTVLVCyelt/wifihvHSUS2/94Lhs7hM
         9WBZcSFBdzM1aqSOChevMjLRD7we7icOe6urN3Illd7MSUsr5FIycIS2iK7gW2uFMPFL
         0JxVNvYu53dpnGtu8r3YHJgWrLaHBzXVrjJqZ7zL+TU9oHNkwujlSJD5XZQuq0zcKED3
         DGxy8SX4ps1EZbdjgfy34g5fSmYK9EAgEl2vyK0RW66SPt6xFuH6p71mXsFsXNIAREjZ
         vLgfxlXTUNtpOwY9OQSYeYe7S52hW4F194P3gQnjq8NHV2KUjPXOnOOP+vqdsd200XVe
         2gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774514924; x=1775119724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFKAJmCqyCUR1rHA5vvir+TkMWlbbGUkJWjXl24Ykro=;
        b=iuTLMrIoKUK2essfcUGPV/yvxu9iV6ASNhkLzkuEPdcf9dNA099GVX8jaucfzh783s
         zgpv64THOIMGLY4p8yLpB1s1o+Xy/MUjGZy+2UbZrkqp4LMoER/yOi9PTYh/QjOtyYwr
         p03wYwkbOPX1fyHKz/taoGXm+ufSh+ghRCsd+WcLCLaDtU5kVQmZ+TOy4psKvxE8sKqA
         hYFoJ1uI2uKejACEcjWemU8c+eWl9KREET4gZ3SmNrUkafp4mElu2UTPpufdLkcwYGRJ
         uPCcgn6bG5p1sL50+xv/H+enXgLuE/E1t0DqNRtPhKC0npCUPNYFv1l+dgayIEyCVwXu
         exIg==
X-Forwarded-Encrypted: i=1; AJvYcCXws5TkPSj83I5g1Xkwlbzud8km3nK2XTAF120CHvG5qLOTmRDD7KTgAV1M3mA/odwwRPDo7LLrYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVjmlO6DNvqBRqDb8Qm2CM0B2UDg6J3mKa7DNTpDWrpYU1B+ol
	fQLtipRj4tRyLiku7HAwNF+IGoXMn4LW800zLXa4dSvR/8oGBXa+Jxgptmlc6eRYpxo=
X-Gm-Gg: ATEYQzx5TvQm9UmEktwNo6CbEaOrAqUW9RJw+sdpQxVkxfwQJYnlBLuefwTzf27RoLs
	MbWx+ZoadCcZqV2Vovg/Ptipsup4LVj+XldfH28KX6HffDhAtjlrppSmMzfrruZM0ONk94poUMN
	/idq7sk6AOeU8/Xm9VZLjlAPBOmAd1mJ1XavJC5JOdGbb7deFhhEanD1muQ8O3Xp2ZxfOwYfryQ
	wRvPnVhAEi/l0rrVmur3ZBQQzU5wCzMJFSEniRBg0tucHnjAV6CbbZFFqqjcenMHuiF2qEJzAcu
	BQ9QNCRaxcX2XxMIQ/Fs+/yoDmwjFsIossbtDVXeo9s+0QHyB8sKH1OdWYuBsx4ClnxGo9cS42T
	0U2eBrSKGF3dpKeTr/O1EHaCGaWB3HUlXhtWoCBFrBdMeAgCRT259puGM8/HBhWXujweTX6AQGB
	pHoId+8ywlFUXW67pczTWZljSB
X-Received: by 2002:a05:6a00:230a:b0:829:8a84:b9fc with SMTP id d2e1a72fcca58-82c6de8c0a0mr6255311b3a.8.1774514924081;
        Thu, 26 Mar 2026 01:48:44 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d1e63c7sm2325179b3a.2.2026.03.26.01.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 01:48:43 -0700 (PDT)
Date: Thu, 26 Mar 2026 14:18:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 2/2] cpufreq: Add boost_freq_req QoS request
Message-ID: <hajhezqrujiky7eo4eidogvjomixmhtdxpzfjibrd2xbhxawbd@ptljcesqpyqx>
References: <20260325165255.386576-1-pierre.gondois@arm.com>
 <20260325165255.386576-3-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325165255.386576-3-pierre.gondois@arm.com>

On 25-03-26, 17:52, Pierre Gondois wrote:
> @@ -1377,6 +1386,8 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  	}
>  
>  	freq_qos_remove_request(policy->min_freq_req);

Since this doesn't check min_freq_req (and depend on the routine to return
early), shouldn't we do the same for below one ?

> +	if (policy->boost_freq_req)
> +		freq_qos_remove_request(policy->boost_freq_req);
>  	kfree(policy->min_freq_req);
>  
>  	cpufreq_policy_put_kobj(policy);

-- 
viresh
