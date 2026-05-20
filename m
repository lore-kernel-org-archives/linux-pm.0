Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC461C5D59
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264799; cv=none; b=WTEghhkMvRU1/itoRNzIVFXIyMKm+t9SBbuTILc3iQJ5KNkt86vdOqhGR2x0mE8KtQ13ROp5V5thna2+VDH3g4bI3XPkamB9qFyqGtVj62Y81Mahp4ANy16TE7ufUb+GFe4HadZ4eiPxuFm49V5gPe9D9A8D173g7NZ1cGHzaoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264799; c=relaxed/simple;
	bh=aM3LstRHSOJxFjF8ZU/FK5N7zLXG43QNrxWlTGVnbOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anbExJJ2OaIPYfls9d6ykLJy/FoMqSAkY1CJ6W+30P3l8lGKBwijed296SgQeYiXYaQv/uFMj23f+ccTHiNTSkIhAT7Qtx74ld2hunH/k+zxI6WVc7wyjRl8c6n0ICPKnjHbmWDy8rUSKhwEGFbqbBbmzRHKVGG7RGMw38jzO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHQX1ThQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHQX1ThQ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36643b96b99so4237162a91.0
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 01:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779264797; x=1779869597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdSM4QlD7A9S/i3jzE6ls4hridk1+MAtdfgrvOqRq0I=;
        b=EHQX1ThQo/JnjryxV1mHwMsBxUfjqdqXwje4KqH4SWQzzi3WkrssvW5idlEcTjzKes
         +8jc47KmwcxChb/XVGodvEcfgsn5I5AYShvghkENz1WQXA7x/kj/xP626kU3mfQS7PkC
         0uARdydcBO2sece3C8gYUoOlTv4B2dR2CiTY2Ol4u2ok1yR2VxiB4v77PGbOBhMRYNs0
         TtsA/SS+1PMSPvvVATXD+5Dz7N+kVJ7YO7BLfIQKtc/YTI01+7Ss29AvIBK6V6XfZcX2
         fdZd4A8FEL1oITrLmZWr4NXgh6RjEPcdnmtjw85EwRbNo0tKRuIfnSn8ct4oinYsTGQr
         xtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264797; x=1779869597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdSM4QlD7A9S/i3jzE6ls4hridk1+MAtdfgrvOqRq0I=;
        b=igl3/7OAWWGzHLvZyZZcoJ200wX93EpuGrsxJC4QkIx3aOdYpIuA6uCmB4EeO/t1jE
         ylyiWRvdlH9iE0eJ3CjiPsCdPQB+jeS1YWxj8WXW7bcRVbfzyZfeprEuvAJjnp9OG/S8
         63eWt88+4GQxkj1w1LnGnD/8xPgXDyWP1DiK/iVuk7amGbArNZOxuz3LeKX0rn6aHNGw
         WVXAdqGDD0HsPl1NUqy+2e0FCXNTv5QSU2Mgfb35N1CNiaorlcC5uDxpRzR4N0m52ZYh
         wRmV103yCAHAZBQvIeO7HJ3rWfLmcL49iHWlU3usEGmtYT/bqUHvU/yziYC3aPb3e1Fo
         KzeA==
X-Forwarded-Encrypted: i=1; AFNElJ/HQ/Ra8Y8QG+eGp+PrRByl8W/HOKEGDp3lY+M81ToHiuPNx+fVjlzDtVcaEoT9pj3xljE4Hr8wag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKznD9nBp7uJ9V9DN+c8iOrcz25O+ODRiK1RZbTqOMv4BJjGh
	dy5UT9UUPJr4ZicT/0Ic4oS45DfCR/EVM/oFkoOnJjV+17qIrB+fHaQcoA43vlQiHAc=
X-Gm-Gg: Acq92OHLdHSPwpZKUpJEbk9dgQ24MUZEDbYApGnCTeCQGA2p7H/u07FkCN4u5uvWwVq
	U22BI/Y1heqY9p9YKTsKQkQH9suVfn1p/k/in0MhpirbGvsL5HJl9Lw7mh9UovUQMfa2bzXm2t2
	rVOWvVTmoFIRhcac7h7ysrdl2RI/C8t6Xrvitv0HDl+9kUMANGRTXIuAB9+IqGybta5FMlZ4Rlt
	BlePaSdKJKG2u3ApR9/TDn19EUlMzpKeK3ubV7bsFGEs1lcFcSqzno/i/WXoe4Gan9xl55y856s
	OIGy3b9HUclrZJkWxBiLDvkz1JxDDoMsGK71R/5sUdk2YcU+FJqpWClDSKLtQ49WltPRrsLpnSl
	x/4hIGdR+IJaoCNXjH3V5wkcnK7ivomtKSsif1ZEEnWuxfj9a28cygaqwHQXVPhetY6yWwVX/Wr
	VtwlNFAN4+wd8yjBjdcf/CzKY=
X-Received: by 2002:a17:90b:53d0:b0:367:db13:aca6 with SMTP id 98e67ed59e1d1-36951dc1cc3mr23062522a91.26.1779264796643;
        Wed, 20 May 2026 01:13:16 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695148d53asm16457819a91.15.2026.05.20.01.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:13:15 -0700 (PDT)
Date: Wed, 20 May 2026 13:43:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	pierre.gondois@arm.com, sumitg@nvidia.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] cpufreq: cppc: mask Desired_Excursion when autonomous
 selection is enabled
Message-ID: <ljw7yqeb5cuzvc2kytfb7u6eijrls3xrwgv4dvo47lkrkb5u3b@jhu3uzn7mxz7>
References: <20260515024242.14196-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515024242.14196-1-luoxueqin@kylinos.cn>

On 15-05-26, 10:42, Xueqin Luo wrote:
> According to the ACPI 6.6 specification, the Desired_Excursion field is not
> utilized when autonomous selection is enabled. In this mode, the bit is
> architecturally ignored and does not carry meaningful information.
> 
> Currently, the kernel exposes the raw Performance Limited register
> value to userspace through the cpufreq sysfs interface. This may lead to
> misinterpretation, as userspace may assume Desired_Excursion is valid
> even when autonomous selection is active.
> 
> To provide a stable and semantically correct ABI, mask out the
> Desired_Excursion bit when autonomous selection is enabled, so that
> userspace does not observe undefined or misleading values.
> 
> Writes are left unchanged, as the field is architecturally ignored in
> this mode and write attempts are harmless.
> 
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
> ---
> v4 -> v5 :
>  - Return -EINVAL instead of success when cpufreq policy is
>   unavailable, addressing Sumit Gupta's review comments.
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
