Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFE330AAD8
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 05:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897663; cv=none; b=U49FPUCY7Ke6aWxTmYt1fkEoylO120mv9k5gonNJapxqH2dvWKe2gydBZaYsmFpfzT4Ntq0XJyGR3hM6W+uIpiW+5XJyWiHiV2CIUYPuoeGaRrVmzoaIqJsAoCVrIdbhTTghkDfLxTd7A6SIcrxNDmzIljMZtBiy33wrmxoUgD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897663; c=relaxed/simple;
	bh=pemJUHXcANp1pzSxzOeHk7j2vJoCSGjAZWh8y6+CTus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/GRVre88DpMgGDr+Q6RtmmHGWrRlusEkUj/fGHvcPbNcVRjKfEYYxgY25wGPi0gSeXf6vTInLaINFhapEoqw0+Oxg5CnEBDLsKmCOfNxNhOGCgev73vbp3t6myDvvizQcU6fuGPNJQGaz9aoTvJh7fMYpYiiJbG0NAmO3Q+bss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GrbW3L2f; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GrbW3L2f"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8585cd8400so1414382a12.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 22:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780897662; x=1781502462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zPubW3ttWvsuRhBbuHJPuvpRw4INXwigMlEmqJDZ3Cc=;
        b=GrbW3L2fQrOK+gGRQkoYAXoSE+ZABMvuFtxpDUpD5P4wtMnw4n/30pejTijCxJrLjg
         UQO+2uxApGL+m83zlbl6lUi/Bo1VjwaEGYceTO3MezP2rRQrArubcDGedjX03hJRTjoU
         oBCR2hK8uEvcpnoiXIfR6ZsMw5uz4anpVqbUK9kh7gNaxzr6dGlreSHUju5cpXTTtK49
         G0/plcJ8aeIp04eiFHO0DGu/g+Nhz2nTrNitMHpWAndyU/OdSm8uwGQzwkh3C7anv96A
         rip3xgWWwd36l7j92ZQd+5Vvmz4XmMAofW0vl3suXE49wNjygv+EVLhHPYDTtXSuNOJI
         xn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780897662; x=1781502462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPubW3ttWvsuRhBbuHJPuvpRw4INXwigMlEmqJDZ3Cc=;
        b=ZXx5zH8vJ6rw467+SEvTjHIPFwe/wHdxeZOX6YYmaXX/QQn8DS0exo4ZKA/YGZtH2M
         KuVjKxJvT2iSEdiKUpH+9PrezlsHKomBKRxLg0mN/CPxoPY1fUEGoQTuzlARY65CWeyv
         ONfVhmvg//ctS1pAt2R1kRCOd6mQiSzMccGhsg5DC8ORy3nLqZTcfOsL1F/x2dskZw9e
         4ul2j1RAifVISwZjgYWAb1ZOY0Tv5BAFlRaCEVrGbFeN9w2xYXYRCbFSw1Z577/GOEYz
         nn4L794IGxHHsfKfOSHaIjlL4lva1Qozru+9Vl86WqkxrpcW0mc9jaCrQXpt/H9iwDIO
         HrDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Wt996Jm14QzR6GQJ50+GB1uC1q9QfNYHY3UwVRE/nfsRg78nO7HA0fFi4cBtoDaq2+zhWRg6Yww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrEOfrEY0YI9Kx6Po0NSqOG7+z7v38XoVX3dtmRyPEB5Lp4kq3
	i2e43qK392V9abeevpePPQL/OBbawf3msMU1wn8tBmS0v+ud8yb4K24cOyVWbT54f5wqwUt0ZQX
	pm/GQ
X-Gm-Gg: Acq92OFv3xAnMwVs7pJR9E4/57GKiXrgauolv9Ag5I0MKtYywxN9yYjSqHsKrSuzoCj
	EVavBLRTgWOVmmg5HtPbOmNMVdgDSJEwsJNItF2EybYUJY59/2nl7RawZ5qQLecD5/be58P159M
	EwwmE/ac+FZvJrMJ9EIs+yvO/5unjjSCr4wnX3L6/a26gE2Ouj0Kfb41jMXpkLCWLcnUdDp3Wwh
	f6XqirVoGgklvsp5cOufWs+Pi7p0hLdcQwO0Ma/VVfZp6oyAybZ3bJC01DXZyrkt0l0bTpoY+UU
	6ljflOnhWKzjOTnA+PpGb6We7Yb+aPSGjYy9/pDmWc/38BTVsIscSgsAQc5MnhUPEnrSFUnFeNf
	fT3jVSxWf0pjs8rhsheGsZznk85OriO4oxyfY/3gdQnEIk6Gq8o8qzDZWDVo4XT1RJnuroqJnre
	sv71WVWhsSpIJODZ7n3dS3j1bUbWftwb1s7A==
X-Received: by 2002:a05:6a00:90a7:b0:842:732c:5687 with SMTP id d2e1a72fcca58-842b0e8f802mr13999457b3a.22.1780897661522;
        Sun, 07 Jun 2026 22:47:41 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372868sm18939176b3a.17.2026.06.07.22.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:47:40 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:17:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akashdeep Kaur <a-kaur@ti.com>
Cc: zhongqiu.han@oss.qualcomm.com, praneeth@ti.com, nm@ti.com, 
	vigneshr@ti.com, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vishalm@ti.com, sebin.francis@ti.com, k-willis@ti.com
Subject: Re: [PATCH v4 1/1] cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
Message-ID: <xwtmornykrquycx62tz6qeom5qeotmfhj4qo6ycruk2a2sw7gm@osvdgypaxrbl>
References: <20260528090510.829513-1-a-kaur@ti.com>
 <20260528090510.829513-2-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528090510.829513-2-a-kaur@ti.com>

On 28-05-26, 14:35, Akashdeep Kaur wrote:
> On K3 SoCs, ti-cpufreq relies on k3-socinfo to register the SoC
> device before soc_device_match() can return valid revision
> information. If ti-cpufreq probes before k3-socinfo,
> soc_device_match() returns NULL, leading to incorrect CPU frequency
> scaling behavior.
> Defer probe when k3-socinfo hasn't registered the SoC device yet.
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied. Thanks.

-- 
viresh
