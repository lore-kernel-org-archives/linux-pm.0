Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8802E7370
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156557; cv=none; b=LbMeRdPdIUOCfl9V5N7ZgYU8r4GgRCtPZvymTYYOHL/ZCE3BdYjYxCbq89oJ6b4w3EqhRRGQJEroU5kodCyF7mRlwADDK7MRPsCZZs9gRcI4kxV8UkFR+2PMIRskJkDKAIrv8+ESlOSntAFnRd5mgqOm78NkBW1iRHP6PT17QoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156557; c=relaxed/simple;
	bh=g0/fWI4kaAH49ZjyjviEpK4wrWOx/yLhKN6DwAytVVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbUpTSnj2fdzI56iL4QxQQAW2NgONuSSgIRKA1LR3Zqxfb32Khevamj9cypc02CRhebr5eZ2Fjk2kuUMlhtDplkaYChm/mQgTfNYKU8TMAcjouQPWZUQbC7XIkI/NPrdfxScWQHxBbxj/Zjm/EurPaC4+2Eg7R+gKZKS3QVZkCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=afkCIMbq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afkCIMbq"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so2405542a12.2
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 23:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788156555; x=1788761355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GnV26Q/NYKfR4yRZkITW+Mqd2oTMukvcHneE1HMVheY=;
        b=afkCIMbq6yw47jhZ5QrR1ZeYg4lNjUv2RkdXWwODcy+hZIr/FeJyKX7NelsQLRNZ5n
         VxPNUxnd2X/DVPgon8zA2S3N/Hvwj7SCV4j75BhTjYH/bvw57ZTLQ8jyOG9wTaC6wA/6
         3L5shuPBe3pXkqr9G6yj4VlP8W5hXS6J7qnvIMeHImLy9t0+AfAnZdEZuROKbIB57agP
         D2N252epq+HhXtjNTyoiHWwy8fSnSjvqIUrDSoYfk+jpRB7Tv2vEqQ/LrHsoaKks2m8Y
         ml+XAyQ2hVvD0Oa138UPG0jArJGYLtZu1HAMrGro5ROyIZPABoqVczFaqnuwXSC5Ckeq
         Z3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788156555; x=1788761355;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnV26Q/NYKfR4yRZkITW+Mqd2oTMukvcHneE1HMVheY=;
        b=tCH56f9/SnLwEwlSMhgp+GWBUiXnYAMAqiEDb4a2Q9C0+WrV0a//QrmwrfxLv+lInk
         WKIqO8coYY9Yn18yUmyoAZk75CutCpI//j2dYfqU+sip1par9ecCCnF2pRL90GGgR/gG
         j+vnnkWtE4E/hTyM29Rx67DIswk86dlXpsAEmmsrs+CALcuCQVI3gx3QoommscK0JmU4
         K2BbRKhjtIaCB4sv6lVRLGvz0JxgcNJibs4V2MISVUmhZfEqDv8dCwT3VSB/342WLBtl
         iIWbgWdReDvd5tx8NB540/z2eKzm104q70G5jLKb2FrjbOH1BUMbDtIupWZvBR1i9FpV
         RVJg==
X-Forwarded-Encrypted: i=1; AHgh+RrktIxWmB3caufdWU1OAuNKKUquyUxxar9dwScVbgUqL3smxxuU+KSlYPcjdX9c3NyVd5Fj982h6g==@vger.kernel.org
X-Gm-Message-State: AFuF++lpKlaQY4h/OdLMZr8B2Hu8fVIkiDmu9DeKRUYtlyyHJSSdPNhj
	PdDcW1BDfjiVlGdn9GgHQkEa/O8j8b7XOgVIfJr65WDJxlpUtGpHsLik6MM+A1siTzA=
X-Gm-Gg: AR+sD123Rk8xN59X5WaH3sxFSIaRd8AUdlrowMp/Xwnd/CbgaOgXe4iLuCsSO0pUorp
	39aJWnqOuP2laFbYwGoiXMMIuOdFVSlN6rGc4xc//Hg1IzVKhiGC3U4sBl87s6/P1R8gYer7R94
	TnG/Edobv5yaK4rCJvVKH81+Z/av0T6AAVfLbwDIgiq4cVhHlo3QKpQWa90dhtJYWDVTZzUKzaX
	NnSuOkLulZK3PySSX+RJx1UOwK55x7zuYbHeQiRNN7sNqT73qIYxzwGo6WXc5EoTKOnIWjUn0ro
	geSrUmZE8AB+SAvnkjoLhHKgL+cpb2Rb028KIi1t47nHIef7SzaNmTtQ2ImMt4ryuWUcuytvUYU
	aWYuLMDbm8QfrTnLp27xW71lftzWLK0rS9s3OCBSJj2oyWqqxg/3YVrxxgA2ExK9icws+RBXhUY
	lG7TddDdJ4f0vVL/juKkp3AU+/87ZzdqjD447EE22G/pF1gFIC3GlIO8qcKSnt13fhmwskKiKAz
	Yk=
X-Received: by 2002:a05:6a21:6b87:b0:3cc:f008:8123 with SMTP id adf61e73a8af0-3d266582c55mr42074601637.8.1788156554788;
        Sun, 30 Aug 2026 23:09:14 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7bc825sm31297019eec.9.2026.08.30.23.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 23:09:14 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:39:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Use %pe to print symbolic error name
Message-ID: <apUahwItxSCj-dE-@vireshk-B250M-D3H>
References: <20260829134925.8883-1-sumeet4linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829134925.8883-1-sumeet4linux@gmail.com>

On 29-08-26, 19:19, Sumeet Pawnikar wrote:
> Replace PTR_ERR() and %ld with %pe and pass the original pointer directly
> to dev_dbg(), dev_warn(), dev_err() or pr_err(). The %pe format specifier
> prints a symbolic error name (e.g. -ENOMEM) when CONFIG_SYMBOLIC_ERRNAME
> is enabled, otherwise it falls back gracefully and prints the raw integer
> value. This makes error messages more readable without any functional
> change.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/opp/core.c | 24 ++++++++++++------------
>  drivers/opp/of.c   |  4 ++--
>  2 files changed, 14 insertions(+), 14 deletions(-)

Applied. Thanks.

-- 
viresh
