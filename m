Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2459B359A7E
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 05:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957648; cv=none; b=tMVQ2ScqafgiW6Wudz3eTPrKtnHXGz0kdahVXeBjnKIcYTDBWFGaSxvwah8DRqmWpYbSxSnWovb7yCgTa/1LI0X4522/wdry9KjqYHtjn0m5am9hDMG+K4PxktwpGUXtIkA8QBXre5WDxReEIzBA3BGJWxLmMKCmHYduMAfIwXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957648; c=relaxed/simple;
	bh=XCLbQaX5H0q4NgbXR5hov/vTvjqu4THP1s6uQDct1jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwc2kY2ht35wTh3EuMZRTSViBoSF3cwHFzjPJt9BU7HInSPP2N/9uiCYy/AoX/r3QBI03JLG3DCZ9lrU89azY4eVuDjTVqXY3DeGpwv2Ih45pxm/lPXX+5zibnXR29yvKvQ7JanVNSbu3K9vorLDFJPi4VGDVFJ12gp/LZwXp8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IV8VDwjn; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IV8VDwjn"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c796163fac5so2977682a12.1
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 22:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777957646; x=1778562446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H2vQvv4FtjvUNTqA39aikDyJ0rYrZTr9y6osRy+CkrA=;
        b=IV8VDwjnu4Bt28L6QERQESMwo708Ke8a3JWp1ygRXygoSCrzHoD0COGJYg4ObE5SXx
         hgL9wqbe6lInYRDis5GiOJYOm6tPLM2mV6xoDux9ucvOBfEsGX7ni7cF7QAh3N0FiZP9
         Lho/AbULskQh6SRmYO2KJSdY13Gf22jhKUpSFor81+D7skT6E45BRSrB23bBd0KX+04Y
         kTlTLq9fozKptyCLUAXYbUCPJrT1uHImVBQ5pjP/PDvjCiPoLqV4bV4C8Y0g2gZJ3LzJ
         L7LbKugHOUFAA9EE4kvjq3qQRnq80CkNCyusaKv1etd+fJEM7hircIg13MMolCLLcW/0
         ZW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957646; x=1778562446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2vQvv4FtjvUNTqA39aikDyJ0rYrZTr9y6osRy+CkrA=;
        b=ZrT4Z4A0uOdWokxJcLF0L4SlhXdx4Y+w8GJja2WIJgtc/kVaasp2jaqCw8BM+jkO3Z
         1ssRR0X5LlBKMyNt3G4SFzalhRcpmm5fZSie0qQvjyyjJ6NcUXVbfH/5tf8wIauZ1SYb
         4WyU6h54XlH/q4sOQvLn/GdNlkpOtIpoj8HJE3tD8OMpccuoq9ljBGfpNQbmpkwLEizM
         RozmdJ26ZoNdLHjQO5rOID3MwX7B4UuLvGT+myBn4Hqji9kkhhKb6kMNxFzYnW68P6DQ
         LZrqJ/sNvNfLdy+KbPANRN5V9/0sctU0VuOam7rKGHrOJNSIPSGdPMok07C12u8hJ7R5
         dDyA==
X-Forwarded-Encrypted: i=1; AFNElJ8Nr1/KaxXUiQf7JXgViqAYBF2/6ZU/zyvdNK4XGBvRnXlTtPyUFN3mJx50VpkCMhwQV71CxnqLdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/DZKdsHlEIjBqoMKHQNZaWDGyAG76F+qNYLP+T8mhK03dYrFv
	gegAkpd8e3mOYFObA5VtljjXQFMqhfWDonV994mfwLqJc8r2u6+5KUlPVdxiHt5MzWjs2VY3wuq
	kD/Sv
X-Gm-Gg: AeBDieu7wtxEXE1kv+6mjD5Si3y1M23C4apXiYYSAk0wR6XXcyExalvDtgxeSs6b8GJ
	/3/7PQxIfLXGTEbsua7emA3UoLV97TqRtCFmPOgb2++AXSPTanhCsvpriCNMHUXOHMGG7lrWGJz
	qCk4kgpPFol23ipLQwpWbPjX/ydsXWiu/TwL4Vln03f1qzllxCAGqCb5+9UhvTvGMuB5fc8diXv
	fYM8RS5ZK43BnrrCT+IJbQMMGg5HFDx0uIgr7VqmADjHYFQg4ACBvrq3nElzQFZG5JIRgaMNK0v
	dmkCiFufR43oOTWU8eUzq/c1fe6gvKLF+wv2c98+LYUvj7y6roRkBY0qHWRY+7gO4qAMvKeLkRG
	GVXP19F+XGngaIvya3HbittvSLL4Dy3np4CoOxXG0DR8in0lwNVNqQ31AZ5AwK86MUIwRwnvjlv
	hoqqUzi00+daeD4ABPOkbLEZnc+Be51+kLWg==
X-Received: by 2002:a05:6a21:6d95:b0:39b:dc44:eceb with SMTP id adf61e73a8af0-3a7f1c85643mr13796001637.42.1777957646203;
        Mon, 04 May 2026 22:07:26 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6f0efsm11251801a12.18.2026.05.04.22.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:07:25 -0700 (PDT)
Date: Tue, 5 May 2026 10:37:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: Fix possible double free
Message-ID: <5xk7uk6jhpcdsrryi4agn4apcjdbzzkntz5ie3x4675kxeuur7@22ue7vhgq6i3>
References: <20260501190005.504962-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501190005.504962-1-lgs201920130244@gmail.com>

On 02-05-26, 03:00, Guangshuo Li wrote:
> qcom_cpufreq.data is allocated with devm_kzalloc() in probe() as an
> array of per-domain data. qcom_cpufreq_hw_cpu_init() stores a pointer to
> one element of this array in policy->driver_data.
> 
> qcom_cpufreq_hw_cpu_exit() currently calls kfree() on policy->driver_data.
> This is not valid because the memory is devm-managed. For the first
> domain, this can free the devm-managed allocation while the devres entry
> is still active, leading to a possible double free when the platform
> device is later detached. For other domains, the pointer may refer to an
> element inside the array rather than the allocation base.
> 
> Remove the kfree(data) call and let devres release qcom_cpufreq.data.
> 
> This issue was found by a static analysis tool I am developing.
> 
> Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 1 -
>  1 file changed, 1 deletion(-)

Applied. Thanks.

-- 
viresh
