Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086151;
	b=CJkrJyTP6U4+qT2gGxl3EDHsgtR0Bp80ihga1RNaSur7NrNhTxxDRgK270f1JpBHulLP
	 3tN6wCze//GmsHZkOxTeYiV4df6wEjQI4znvTxvoD/zERT5X1DIMg4Tn4KT/vLaP9KUqD
	 bUWnp1WPJPFFUPvDJZVMW5f33tqmRwINwVTfOwRJorMKaIXw90tk3mcje5Ps2u5KWfvoE
	 oqwYAEx5+gm4SfdJ9vz+iVo+VgdPOF4LFxEG9B4Hv3zAP0G9FqLy4nMFG9r6F4og4mxLP
	 a44DxL60PEB+DPs+u2BFPIjp5lLA+ehsZSdeRuPVNxDHO3RlbfhfVx11IXc5dTNC71w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YBYI5yOFznNLCRYUavN12AVVw0pUH4aGS0ICRUU2hM8=;
	b=rvTLgAaN+cPMoFfC7X1Q5Lx3eD7Qt5BbBXiSomJkkCAb+IXFJCmuM3BUUjW1gey8vYO3
	 YsFQKqfVKd3AmJPlRy0TvCgurbKH5r3SUWj5Xr9j1jdhoFDBhj4EWQK65IjGLfQFhWm1Y
	 YsXqE/lE7zYYHknpwJ5v9R1wJTULJV+MzglHL7wwHu18pO6zMJG2y7fk0t6yIht4lDeon
	 +rmgAnLNY4jFUi9crGs4o5jKalfPkERKe1V8udQ0al5wIT+SASfcLP+4Q9E+Al7WDuomd
	 HEKAtNr7A/2pGqEUbJI3epzMVFCZUK2NBp52WpvXG1saAc06tzALdphkQ7t3qCFxwGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ty3gq9Ki;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD5606A320
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 11:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57FD5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ty3gq9Ki
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso3143278eec.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 03:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795086150; x=1795690950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YBYI5yOFznNLCRYUavN12AVVw0pUH4aGS0ICRUU2hM8=;
        b=ty3gq9Ki5MNt95VzFDCTdFiPeC4Y+kAPi0zY/TjuJ+uccfvHkLiHnzte7xnUEwA9jO
         Lv4kYDlFcIWr4IA6lbFm5qljXFh+upfWpQCXvgiqi2EkmdDUyS4OLCR7W0APt9t44bvw
         2NkPsdM5ppgCFCTjwjvOKwjJ1yc/22d283INA0YH+Q+9/9e85vuc7SRO2Kg2HPoXbZXU
         EGQz/ByZXoSfAy0meQ/Lq7czFb9fsqsQAFVX05ls5xbK97uFlt9oHu9m6CH3fAmqyk0c
         6Q1h2SoifSCJ+/JZxm/2T27F9NfGPIbjbx7efjcl1IClRAvg4hmTlBzPWMzsXtCwYkzV
         lJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795086150; x=1795690950;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBYI5yOFznNLCRYUavN12AVVw0pUH4aGS0ICRUU2hM8=;
        b=qDmdL+TpvbtxxgVuAjtxfbB52B1lQsD+SB5aIuzvZ01F/NbqaLdV+yiqbSqgyES8Na
         3lIdDqO+tw5TSxY+QNkyyvEu4Xv4R5iXOv+fP6fM0w42acn14FZfkYAU6fQSqh7XEfoD
         AVPBclTXXisuNK4OnXkkBl3I2F2A6LPD3T7qItsvr4Y9ngvO8CtRIjn82MiM/ghbZ4Xg
         xkoYhQLLglA9UJq7DxchGxAwPcJrcjpRJi08m96vkTvZJdiouHAhaoOYavTrQRUJdG9m
         ofsmjAqYJvFI+dvk5ToIH4IOfHRO5JLk5YPEAk53p1BktfifiS6rpw9ea5dhBiTF2pyD
         yVpg==
X-Forwarded-Encrypted: i=1; AL+hErEDtlU7CRIHplHO1cLlB3o483+i1mxtybwWfa4DXXL6cTUwClsU55BCEZTiMcYz0MrRWjy/DP504Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z92VqVN6nDf2I4WgU7bjejlZ0uj/WsT6UcrUY+jzjNsJWR+qpWs
	8ytlWjKdRMgDPMKh4bl5YCnJIwR6BI6YjuOT4Q69I+cgBvEXf4zffuEt6QkYIvfd2ro=
X-Gm-Gg: AZFdTZcJBUjAmdg3MoCXNjzLs7rZB26f/gxNJGHX3appWTaW4f2DSrXLIyNIEvot5Tw
	52rpcl12K/2jHCMYdU5Q7LI5MLi5lpRdVoLe0LhLrpdUxTC4+gRq2xfh6ynEelxxeqVG1R4GHri
	AJifCVKeYK+tnsxyglbW2ezPjZTz6r/VVOnp3KrGbxZvFB5Yy86QoHNvj1KOO5cG7VaHSdQwAIx
	TneY6ev/Sx0VpCnzG/QVDLVWbOT3EawR7d94HEBF2HvH93n1utHUNwswn6HNkHfkmgK/7vx43gy
	JFqx+CQlqVZe0hL2jmEKXvbtQidMWdCQDHBzZEyd0L11i2JW6/SBt526lwmiWN6Twy/+FESpliP
	/Rzy3ISHoccR4fZXu9PBLehgBMjGQdkpHAZ7IDb9pSa7fJ2y4qgi/0US9jKJjdsjQk5siCpEe4j
	oDFk7OSLbn3iCdfac+3sd/C74EEDHKRIfJrz9wj6qBOtxuvzjRHrHEU6F6uroXGsjdnJOH8cRhi
	NbsadNiZJTFoMV9My2upQHljGjv/cXAL4L1S0THPMJkk3LxOE5QD+vS+XvmEm0sLOCWNAFnuLaR
	z9HwasYYTPiNzgtLjxtKBJfNyDSOCw==
X-Received: by 2002:a05:693c:415c:10b0:37c:6001:8757 with SMTP id 5a478bee46e88-3827db0e372mr5918051eec.4.1795086149631;
        Thu, 19 Nov 2026 03:02:29 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3843559c264sm6391671eec.22.2026.11.19.03.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 03:02:28 -0800 (PST)
Date: Thu, 19 Nov 2026 16:32:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: rafael@kernel.org, deepak.sikri@st.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: spear: Fix clock reference leak in
 spear_cpufreq_target()
Message-ID: <av7XQX2IeJ6gySyX@vireshk-B250M-D3H>
References: <20261119092107.2996479-1-haoxiang_li2024@163.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119092107.2996479-1-haoxiang_li2024@163.com>

On 19-11-26, 17:21, Haoxiang Li wrote:
> spear1340_cpu_get_possible_parent() acquires a clock reference with
> clk_get() for each frequency transition. However, spear_cpufreq_target()
> never releases this reference, leaking a clock consumer object and its
> reference on both success and error paths. Add a common cleanup path to
> release the source clock reference.
> 
> Fixes: 420993221175 ("cpufreq: SPEAr: Add CPUFreq driver")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
>  - Add the missing space after the comma in the commit message.
>  - Rename the common cleanup label to out_put_clk. Thanks, Zhongqiu!
> ---
>  drivers/cpufreq/spear-cpufreq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
