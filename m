Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A584A30674B
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095904; cv=none; b=pJd+JrHRb3lzf/dFA2MGysVe8KJQry9r04F1TNITW+wlNW4CS6wtq58dvv2DXMnQ71j6bf6wGhvaXNNXGZf9fhbEplN8cTdBZjTkNbW4Fojbc8lhpREVZHPVClQHBaM1jRpQ1Q4Jmlhy/a6XdWgGTNxfFJ7fzKZ/VYEA0qxLDls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095904; c=relaxed/simple;
	bh=5jEtSCjFGINh8jZTvok+8s30ii9/i+UPEHsVez/292o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFG0h6hWnmkaZLa+5AeB3+StU5CgYQUw4V+pT9tI2FY+mquPKFdFpuPB9nTdTscYk5x063rOAXme8m5bJFkiZfO16Bo8pfpMFVmJy1GoUWjvsN0Cy/pwO8qvTl2r89KcR4Huf/LBk31XQHJ60RGpzcGorwDPDqD66pyVE+0OXP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VwFdpM03; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwFdpM03"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383cb94f742so4700433a91.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 23:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784095903; x=1784700703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xAmPTM8zhZyttGnxHW8eJEUF0vL7fUh/w5+5tabBlR8=;
        b=VwFdpM03UslmD9LR2mE+W8nrGYwHl2HT0IFOhPX5O7Ug+dXqlmznteUgqk4JXhIBM3
         skuqB/CkprcGTWVyjA6ci51bwv+jyrqHOgj+qntSSRZiBwBIBf8dPMe+RkQxsznBLgda
         6eg+Wwb6W3hb1eu8HoF7ROfxNuawu4taI34hV0t9TcKr6djxS1nocofaDGZQZ0bZW4Tk
         6UWofOGlwHDAJQXrGz+2iW5YFziMwAWQF8V7vmNJOecqt/FQ2AtiukOTq0SMiYvjBsrn
         yIma+OVNLTWWMvMuFgoPNR3JMF5b8eGX54TJVSd60w8lhBXqTGtyppZN3ES/Fs2I0kwp
         wP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784095903; x=1784700703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xAmPTM8zhZyttGnxHW8eJEUF0vL7fUh/w5+5tabBlR8=;
        b=pJ4vn4mB6eWAHejNOgbdQv/bx0AS7OJWPKaj0tT5WKzpmbHDdYwOusZrDpGPwITRJb
         m2sYcPV4e1e/XrITKIp0P9fcPbi3lvXNggfVc/azjlOlVP20tJLRmnsdjrppqGTozy0E
         nj/TphHXD5l93X6hokTy+ld310wsIvoJ+sxfUGmK2iHAmufaznEDtV9LkYCmldJJ9hCJ
         hCa/GVxtMg9/TYtJiOt+S8CNa/uwYykoW8TJdt5h9FmfJsUKjgg3ZPy2pyht/GX5skxc
         rvFUCqJKnYZg+BJcicu1lf8VqM1qVUuOUOUl/kV/Wx2WLCwM5v4Cr5jv+Q5/LN8RFc2I
         3xSA==
X-Forwarded-Encrypted: i=1; AHgh+RoPvlHb5tEcOa99FlMylgLPs9PdXr7sJeAeS8USQ6HUvWTlSEalqKsnZtLtjhMzeDEcJs2RXnUmMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Pca4W95w7F1jgP9mKZuCoXbo6i+dcoaaTh/arxok0PkcWo78
	Hz6M/UWMvBcZD2MyIz5kp0tncaI8SETibrPsWLj6jzwej4rFsa+zV1yq4jy9yTfiwxE=
X-Gm-Gg: AfdE7cnsAwXTBpo7q3Vflff75diy+KL2h3Q4y/9lINoTjOQ/wSf42OGuTSjWJo6FGnR
	XOw08sKWng6B+wEA/ELLZ8bt0lpk0wesetO6f39CQ7wPeuggaiCCEohjOA4x1Xax9CYVqupc9yC
	64N5vnkoU3Hj4VYcHNbGjpCXrcGAD9EqPRdama7jrFMsyFFCxPmMXfib+DpHcPsaICNXlBctrDq
	fO6Ljw/Gom5wifL/D0lCqLEvWm96vK4ee72P6dwsWngj2DSUMImHoYfS1SBFpnpEJY1kpQz1klj
	Tp6cWjYQRSboL0KGUZHLcxqINdBH4wUcZ9aKwLOve3DYTvE+FjkSg7XgZ7P9nzsRsaG4BU7Su4V
	dvUZ9GiUhIJKQAxowv5VWdExB0/X79MJ0KFhhSg101kHw98EWt4sA9F/0qJxOH04BgU6YkBdCQx
	+1tPGXuCRE0JJo
X-Received: by 2002:a17:90b:2650:b0:37f:ef32:d444 with SMTP id 98e67ed59e1d1-38e29ff9805mr1337073a91.1.1784095902763;
        Tue, 14 Jul 2026 23:11:42 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm93198720eec.0.2026.07.14.23.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:11:41 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:41:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: rafael@kernel.org, ojeda@kernel.org, boqun@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, ardalan@uci.edu, zhiyunq@cs.ucr.edu, 
	dzueck@uci.edu, ytan089@ucr.edu
Subject: Re: [PATCH 1/1] rust: cpufreq: Fix temporary write in
 Registration::bios_limit_callback
Message-ID: <ouf2qqkiqgvn5yy6umr36ii5ltgacx3qthyhbol7ly3qn6lypv@pmkv27ngsbcf>
References: <cover.1783456063.git.pgovind2@uci.edu>
 <f56e1010822963b2f8133c63de47645834281007.1783456063.git.pgovind2@uci.edu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f56e1010822963b2f8133c63de47645834281007.1783456063.git.pgovind2@uci.edu>

On 14-07-26, 20:30, Priya Bala Govindasamy wrote:
> Writes made by `T::bios_limit` go to a temporary on the stack instead of the 
> limit pointer passed by C. 
> Fix by creating a mutable reference to the actual memory location of
> the limit pointer.
> 
> Additionally there is a creation of a reference from the 
> uninitialized limit pointer which is unsound. 
> Fix by initializing the limit pointer to 0 before 
> calling `T::bios_limit`.
> 
> ---
> Fixes: c6af9a1191d042839e56abff69e8b0302d117988 ("rust: cpufreq: Extend abstractions for driver registration")
> Reported-by: Dylan Zueck<dzueck@uci.edu>
> Reported-by: Yuan Tan<ytan089@ucr.edu>
> Signed-off-by: Priya Bala Govindasamy<pgovind2@uci.edu>
> Assisted-by: ChatGPT:gpt-5.4
> 
>  rust/kernel/cpufreq.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 58ac04c650a1..0f9385d41b64 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1349,12 +1349,12 @@ impl<T: Driver> Registration<T> {
>      unsafe extern "C" fn bios_limit_callback(cpu: c_int, limit: *mut c_uint) -> c_int {
>          // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
>          let cpu_id = unsafe { CpuId::from_i32_unchecked(cpu) };
> -
> +        unsafe { core::ptr::write(limit, 0); }

Maybe add a comment over this on why this is done ?

Miguel, can we get around this somehow ? The driver is supposed to fill the
`limit` field and not use the uninitialized value.

>          from_result(|| {
>              let mut policy = PolicyCpu::from_cpu(cpu_id)?;
>  
>              // SAFETY: `limit` is guaranteed by the C code to be valid.
> -            T::bios_limit(&mut policy, &mut (unsafe { *limit })).map(|()| 0)
> +            T::bios_limit(&mut policy, unsafe { &mut *limit }).map(|()| 0)
>          })
>      }

-- 
viresh
