Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011DC3DCDBB
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169105; cv=none; b=jLILbpLbvuE+Y+D9G8VWDIhRegcQR0Otf8RpdNI2kV5YdRpj3jne/qJOgu7GBBHi1aNjNxw+3Y/1DUd12fgm/dsbdAOMtqrpqaLC7jrbPuPKPZ67Ce1w3CtkZg17pjEPVD3MNqdkoSi1QA9UbOmBkr2ZN6vVl6BbEoyIiRv+dCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169105; c=relaxed/simple;
	bh=vTLeb2dANt+uqoDhcmB3qy+iNJr68ED+PMnVlEuYXPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bppXiou2e6FViJNUm8QVBC+UGym6qk4qm8A9wZXR4nAqlm6Msly/CCI1J1EfpSquFeZT7lWAI+6GWu8PFgXEXo8yBSsqYC2P/kAnn/qbU1M3YEP8y+kCVuzS8E3HPUf9QGYPCcIgXZ+pjbN+36XijJTG5oyr93rbQdpJhkU93qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=izrbNq43; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="izrbNq43"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1e1ff659bso2812578a12.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788169103; x=1788773903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CW23LQEB4WoxPcN9t72NgpaNRCQygSurIOdrvN/ogho=;
        b=izrbNq4386i7U7SQkhDTHRQec9DSipC56N4jA8bslNLjb9Eb959hapiSFfzn4snHmz
         D95tj6Ru4nkFhR1fukvxLFq4pDLHSxqpT1F/dknIFpPN6z/j1iIyHzkvgUr/L1sEX8qB
         4ziyJxGJNJpcw17d85Rpuq+GaaEGVs/Hf/yJylswLBmMvAALOFadTfbFlSEkbsXUcyDp
         TZoManHQWZoX0ecjO791FobtNRP5cc1CUjoIH+2zjhqMPrJNSOdJyYEgJ2gmoHwv4d5p
         kBXxlSWs0OuNftwqJqWGryBW1qNr/WwAZhFIk/QHLmrkYL3ILyeNecZDv/FZtFy5EvjU
         Oifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788169103; x=1788773903;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CW23LQEB4WoxPcN9t72NgpaNRCQygSurIOdrvN/ogho=;
        b=O8Z6HMSx5FrW+KRyS+HXE30Zux0xXS4IiAM55WodDkZaPCNfbY8n0dMmFY3IYavxwi
         6gKXuV5UORC6yTNC6y1zR2RXhxoNQgQDiwD94XgiLwQUl0mEnfkmIjEs529LjEg7IJMP
         9Z0oHqoa2H0RiCXzx1Qn2aYaLDWvX2HsbVXpFX50yGlflTH7B7t2IrM1VFT/4QrBEjIv
         utL793/s4jVLQuNkIfgWmzyQK/fwOulRdEmAO+ZYJmuoJEA2P+Hjl/pkXYLsLfUOzWVG
         dy34sHhXpfedJ39J9L9c2BIkNjM6yroRqzmSm11S1EjWgC2sVROKEGgfGcczkCyDwr+w
         7y1w==
X-Forwarded-Encrypted: i=1; AKwUvByLpubWSO0B2eP0yyCZrksbkrcH+s/R6S5TjHcxLNtIjovUk2C4fEAk/8cvZoCAnw1ivcgSvmBvOg==@vger.kernel.org
X-Gm-Message-State: AFuF++kQc4XON81WT0wK55feEHQJi6Ov8z45FE3Qu2sVTgFf1T3IM0wq
	2KMLbS7WGMb0e5RQeZkW/Dg+BtlItwb5+aJIHUPXskrhnQiJVkMVZXgRTvx6Y4rCgts=
X-Gm-Gg: AYBFou1lNXe2Uv3S+GoMOkrdZ+e2izv+w8GTXoaO97Y0B5SSylvPqRB8sSCjw446Xap
	AEnD1ZRWQqgVXYbC7RwVkhuj04mRkyveMoSVKAuGyIkB1+gFFCgf5Eg7w+PGh+BOvt7DLtAFsHa
	+OyhAZVPFCUFSUkYuug5lPfxn6QXtAR/0+GmjFYITAif/iFq9aBG+DUryE8mMiRKA3w8LturD9Y
	YmiLVpMUF1ERFMi+X7mke6UYgZeE72ccnq4WwPgwvAMtFOHrDePI6CwzqUwhL4tCnoO4Fl2lb9j
	CYVij0pG5SJxzZGfyBH/PP51XyUB+axvzF9kZTevNIl6t6MX2N3I2Hn1rOXvG6OX1x8bHE3w2gc
	vVBrwLsXJl/LhQA7gnS/7lWCccD6vBtapDoDq+JagWcEfS7y964flVtFfvADDtXKgswTYoNr6dy
	kF7uABZGMleyimB2fK26Vzf1ViAog++mh4MDWpgZjhqCPPW0Vh+NnGL3guf6mt344=
X-Received: by 2002:a17:90b:5287:b0:398:9c07:8907 with SMTP id 98e67ed59e1d1-3989c0797c7mr26090507a91.24.1788169103218;
        Mon, 31 Aug 2026 02:38:23 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7be440sm32786117eec.7.2026.08.31.02.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:38:22 -0700 (PDT)
Date: Mon, 31 Aug 2026 15:08:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: patrice.chotard@foss.st.com, rafael@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sti: avoid NULL dereference in dev_err()
Message-ID: <apVLi1Lej-5lwkqd@vireshk-B250M-D3H>
References: <20260831091159.3906287-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831091159.3906287-1-luoxueqin@kylinos.cn>

On 31-08-26, 17:11, Xueqin Luo wrote:
> ddata.cpu is NULL-checked, then immediately passed to dev_err().
> Replace with pr_err() to avoid dereferencing NULL.
> 
> Fixes: ab0ea257fc58 ("cpufreq: st: Provide runtime initialised driver for ST's platforms")
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  drivers/cpufreq/sti-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh
