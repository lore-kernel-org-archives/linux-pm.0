Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94C3AC0E6
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155275; cv=none; b=Bnu/rM4tGQYKqo0RmHnKm89SU/Yriw7nJhvtvBEbzVkA/qbMN6K1VsIjoPWbmQMySx5pgBpOgY64AEeOlmNB2WWCdaPIvGIF+spAxxmGbYp1ucGgnMEHiXBMRWdPHgu3EchWsef+ecyeEQQxnpoRKItDQ8x99xe0t28kaoQhp3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155275; c=relaxed/simple;
	bh=1Cr9Crhi92bFoZ6dXFFfRGLhsqecPCYqOkIc3s/639s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHc0MAL3UZVgkGxT9DSJVS6PQNhXh8fe3lyqwynGUa0V0nL+RuYD7N/q34/kNpG9KjgvWEWYWHnnjwXnU/bbi4gQRTP7YDFNrpgu3M4PRpIK0k8ixmeJbaX2zNFkjXMvdqL3XDQjN5slI5+QNjc0bphuR22jEzFEMbZYPUJZahU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AsFaSNLv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsFaSNLv"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so3474615a91.0
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 22:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788155273; x=1788760073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sN03zBsAwTdmYoLVtESuJo5a7SPFn2gcdu9r933yMXQ=;
        b=AsFaSNLvazdfkRHbCC9wYpr769C49YlDPx+pVDBpyHBPZkhLfzrnTBRYqwmXtJnXE3
         CFpQTfnP//pviCwQxL9sUTW11eGfyBVvRuwl0a1V5Ult6ULuue7sjNv+k8HZSoTw5Kar
         h89/ITbMc1G0vzEC1K9XXiR4vggatciKj7Me/ie5iUgRYb6+HW1V4KlgFzB7ooNr7AmX
         /ApkA/w64qlUvl+xK+j8FeF54xHpJOo/ygGJXUedfuLlzOIwdvf+iRcsvaS9sHD+5FI/
         JQLDzI84xkCMRBqx+XGT2z8Wq2NJfhnm5aaR4wYmlvII6Db/LgT5GgIuLc5n4zemlBOq
         Fmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788155273; x=1788760073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sN03zBsAwTdmYoLVtESuJo5a7SPFn2gcdu9r933yMXQ=;
        b=VS2oOs6ACnkpc27KZnOfHJqlXOCa5SyAIR9Ljs0xhKtFZ3lAYi51Nti+VodUtQmXnQ
         r/pG+TlBmTGqQcL7NW1E+M3jha5KSvEN4uABpaTWcu3NROk1rBuInUG56cCNiZRSZH7R
         pY2fvFf5YEYcWaiVwtjVrGGW436pqwMqxtR/RNXdFeLXWeJ7JvLtpDs5zqJNSg4K+Igw
         bWhhguBkJ4xMLtYDqlErlyPpreiMccUkhlLvErMw7UqDcmS0amRb84b1DAuqL2Ktvk+9
         U9CeyjV5SQTWnZwKUD1Tn4v8LPhoHATpMNcX1TTWREgUweu5z9VmrCTw/OBWkwItzA6h
         Eg4w==
X-Forwarded-Encrypted: i=1; AKwUvBxlP4/1CKlG/4gN/uDLH4ausHFEz7QizH71x72iPS6yv9v9e8P8PAalWkIw1C1RiM3fKm4esfYG6Q==@vger.kernel.org
X-Gm-Message-State: AFuF++nOT1z0dfOeXJvrPYpdaA3cdI8NKxTxofZ8Pq3E3woYy0v2J6pD
	WwCPcdIsRLuVjaBTfBKoH7nHftpQmm0ESzrn/EKFpOemA8kiXTMBR/sgsS/DOhkC3oLnaTMy4Wy
	1DuRtOE0=
X-Gm-Gg: AYBFou2RFFABHnloyZrrPB0jEnQgYfAUKyK31ZDx3BeS9QtcRvXqohEytvipQG25sue
	AGX6Vzl13aENvPqWpsWIxZCPc79a7/VUtyud9lQgzwe1xyr2kb+Yui1FaSGM1hy6kQLJJgO8Iad
	FXgmSEreiyxgfsNMth3iRCWDkOOx3hFs9zCoXI7vS020s2POb22t3QRFg9fRuvNxszbRufyTKEW
	7Le1Uu8U1DnfykQNGl8xjzY/6U1uyNatBMveisvmVbEz5+/CLNJmpaTfL0+L0ZzDsOlyLUS2cuG
	n4s5CtaoxQCGA5YsoCpjL2uV47eZVbA7ajZX7RUuXN3UkHBfWZMUlepzptZc8JpqYrmm4+gU8AI
	GAbPVf2SZLkMQ1qnsNxJ4kAzFB+Xvmnf8QqWWbuUxJTMQPQWmH136N2zC8ajd2E8DfUGigiQEoQ
	SyPXxzVOQo5BNUTbLcK0m0ogjh9pnX4l9JEGz9KCCyJ644XubGLhlrloXOmrX4oxQ=
X-Received: by 2002:a17:90b:5585:b0:398:9be8:ea64 with SMTP id 98e67ed59e1d1-398f858d5f4mr1616469a91.17.1788155273028;
        Sun, 30 Aug 2026 22:47:53 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0de4de3sm34648207c88.12.2026.08.30.22.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:47:52 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:17:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, zhongqiu.han@oss.qualcomm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: sparc-us2e: fix frequency table index
 copy-paste error
Message-ID: <apUVhZnScyPdP_t_@vireshk-B250M-D3H>
References: <20260831054438.3632612-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831054438.3632612-1-luoxueqin@kylinos.cn>

On 31-08-26, 13:44, Xueqin Luo wrote:
> In us2e_freq_cpu_init(), the last two frequency writes both use
> index [2] instead of [3] and [4] respectively, and the terminator
> uses [3] instead of [5].  This is a copy-paste error where the index
> was not incremented, causing the divider-6 and divider-8 entries to
> overwrite the already-written divider-4 entry.
> 
> As a result, only three frequency steps (div 1, 2, and 4) are actually
> available to the cpufreq core, while the intended dividers 6 and 8 are
> silently lost.  The struct us2e_freq_percpu_info::table[6] has room for
> 5 entries plus a terminator, matching the 5 hardware dividers.
> 
> Fix the indices so all five frequency steps are correctly populated:
> table[0]=div1, table[1]=div2, table[2]=div4, table[3]=div6,
> table[4]=div8, table[5]=TABLE_END.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
> v2: Correct commit message per Zhongqiu Han's review, no code change.
> ---
>  drivers/cpufreq/sparc-us2e-cpufreq.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Applied. Thanks.

-- 
viresh
