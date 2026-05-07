Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498633711D
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135733; cv=none; b=feewkfeXXgqFmk+IDZdGLppJmWIQfsyX50ojB40lm9xVGTRRj6b6766HRzWPd+7CRcxzBsjyF3WL8yxgBttD9+jBz4oRNnSRAbN8Ua7GRDVlYS7J3POH1RES7C6ek2mh11+O1bn02QwXku+/9/9q3JgJSku/o3hBR2o+0Dy7CP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135733; c=relaxed/simple;
	bh=DdKlcsM1JPCstDaMNh5C+Y17veQdCrzoy0rEbMQfrZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psfhdev8GMXzoAlzDAJL+YUTRvq9xvt1xy/zD8n9iWu0SoO7AEaS0QsTLlZkqAdP+xfYPal6+oQQbDhOwikFAZ11R76KwsExorJxSLnadB4/2HJpxW8mo4gULf0bXSBlTjYheMBpT52a6Q6OwYvCQW62/h1lunSm+WKw8+rWolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NPl36+cy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPl36+cy"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-362e50b4641so273668a91.0
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 23:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778135731; x=1778740531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIJtmgptiKcHuuRdOlYDXdo4f8KMwWkVUv8sqndkDvE=;
        b=NPl36+cyEh6+k4DWTiNMAoseWSfD3Yumni2+8A4+dLWqTUfNufTaUfRdcW0EED4cwc
         4asK2NQ4hGZ1pGEHowLAf7S3PQTsZHIv6NKI1m8r/WLWwWIfXnnYC13Qy0hW16NfiFiZ
         1I9zA5EUtVlQlV3DGO6k5MjhCLWmqRw0ForkVk3nVIZfQ2DWzDA/eKO3iZfejfKw1g3p
         iQm5qRj1JOEsxd5IbXIIl+qcoSDhMqQoZmK7Cc4Me9YwlabaQQQ8/gPM8RtiwntIgAOs
         ja3zfHJpIUkSsJwHkb1xAZynNQqWPJKN5YtSDb3bS7wCZ3oDJboBbnxbFKvoZfRt5R5Y
         aqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778135731; x=1778740531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIJtmgptiKcHuuRdOlYDXdo4f8KMwWkVUv8sqndkDvE=;
        b=W+FaJB0BBC9zJjp7qY9HaGunFmT7M2T4YdcmV3BauWzue9gnsFxXMmOpxSn3lLYkJ7
         oHjKJ7IsyRsJ77vgIqeQFRa313vVkbS4e6nfUGQSM506yGONKZzmUNLLL/RaFVo1IOCL
         yJJYgbSZgKnbZ81jQbBDWMhoHpm0Lh1Bz5jNVQffVaydCtRAcey2Jqp2jmD6eV7+LWlV
         pLR2TEfMxhSGcERI+9QDbA3x01LYxNW+mAU/fnGDGu9f+OceJ3Our32PYv9MiOfXAFXS
         i1OWC1Jbb6MuhtrPYkC2CHqYwk9WZgtZSp8rvhNbAyi+zmewtlSB7tj1AXBydAORnpyO
         QdqA==
X-Forwarded-Encrypted: i=1; AFNElJ+pntiSKEGAtWi9McqBok9Maj/0hJsdTraz3flZSxiFn9ya8To+TYH8LhIOn5iT4/AuRAxoaE0A6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjznKSVmn0F+y2s402lde9anSsEzmdnUIct2pO2WIiho6bcrz
	ACDcebJ7cdCrEbNuxcDNhA7tdrE7n7S21EQMBnXpql3lgJE7iMtunVDQBb63BNxLhH8=
X-Gm-Gg: AeBDieuD4a7DYWodbe3i/vvKx3ZrUMNTVaHRd1XAlPa5jV/xh0g00UvFCeVYKXbHsLt
	bZYqZ425alPhjQgicBZSMPAgoA/QFsY6hFU5O7aP5rVYjxn7D5OLuEK2K3SGIIwaBJQwzuCPM0f
	/R1l4sDnEE4zbRK8GVWYP4dPwYgsrWkv1/VDuMb0L1ZwV5oN+MMxj+5OQXhldZLxiuymY9d3zwm
	PpBKdsPMviJ+K6D7BxegzDsgZwb6uoXW3Es2Fe5UIXmN1JyO7aTpzERUmWwaSJ1ZFc+/tXUklNM
	osSFrsh8axuBXHOTAPakH8EnIoARBT5Ax5Jq9Vg/m9kYRSSP8LDf9pLRQM50atlNjBDl9X38JDq
	ceuLlijgqdeaiE+/LFLAzttag6uSfaGkC9AGYJ+yxRtQZ0ak660/n4NUY6xZAB7i/Pu/QxhJglH
	DNn2rhQEJub0fl2+gaGCgvAWH4Uc1dyY96+w==
X-Received: by 2002:a17:90a:d88d:b0:361:45df:102 with SMTP id 98e67ed59e1d1-365ac27037cmr6732295a91.17.1778135731007;
        Wed, 06 May 2026 23:35:31 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4f75f25sm4751510a91.10.2026.05.06.23.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 23:35:30 -0700 (PDT)
Date: Thu, 7 May 2026 12:05:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sean Young <sean@mess.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 8/8] cpufreq: elanfreq: Drop support for AMD Elan SC4*
Message-ID: <ddzrutm7h7oeezh4zyehzn5b4b6ls7uvnljpd7evfabydtqbnp@s3ef3mqrg4gw>
References: <cover.1778071745.git.sean@mess.org>
 <ab6775ddd8aa71f3a5a329500de24ff7f5c25ac8.1778071745.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab6775ddd8aa71f3a5a329500de24ff7f5c25ac8.1778071745.git.sean@mess.org>

On 06-05-26, 15:42, Sean Young wrote:
> Since commit 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"),
> the AMD Elan SC4* is no longer supported, so the cpu frequency
> driver is no longer needed.
> 
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/cpufreq/Kconfig.x86 |  15 ---
>  drivers/cpufreq/Makefile    |   1 -
>  drivers/cpufreq/elanfreq.c  | 226 ------------------------------------
>  3 files changed, 242 deletions(-)
>  delete mode 100644 drivers/cpufreq/elanfreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
