Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086167;
	b=ecvsjxKGiOJKqpCoK+C8Y1Lj3Pk1uXXzwDweoKtjxXD5cYola60GZ6ZcEK0y5qS82uzb
	 NhseXsBmhcqBKDAJRwuGTPFEIVH+PJ4HfY0r25db+HPKv789DztblX+ZioQUZtaKiXqUL
	 6j1OK90aiCIdAqrb1jJvrg3O6txr/p5eXOtcc74ToGxgmOGIq9WwcOHY9jzNNl4MAROJ9
	 LZocKarmUJMDru5U4gU7uBZ1wH+emtbGTB2JQg3B9M7DxEDP9RPQ8yqrfZMjM2TcQrr/r
	 eex/B9lhvoSQY/e5YKJHYCfbxKRw9zTdS2R7TLYCXv5KuhuCPqHo3IX2ZhdAlWyL62A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=o4GEyz5U9vFXXKUrCPhLjfd8PplmyKlfLDn43zCRhVs=;
	b=f3v68Be3ji8+kJ66dq4iAjTyHt8MBwQ8VPMlfhgrb6Fm62UKCJGOq49rsR6MKNSL9mrj
	 jId5AiQ58LphxeM/4EoaRiz0SSUYqFD2nh2iEdHDOJx8gRmkv1UXS8Ai2d+vb+9SJG2UQ
	 GYeWn7RNPw1XFFgNjjl915N21jnhtQHpr5lPaK1SLpRxlmGmjR6IHbY+gm9rl2vHL1VIm
	 dDkek2aKwWAWmqNskAJD6SDEAIrTaObtE+dL6TadL1yzmMMKFIN7bNLtw8bkaAScpdQ1g
	 uTH6oyEr3W/KG7aI+t1CyCWugijOoNbA29h/PgEzkY4F0t7pS51tgjKS1IchZy3lGhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T4V05luj;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0892606A324
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 11:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0892606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T4V05luj
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15dd124bbe7so2776167c88.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 03:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795086166; x=1795690966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o4GEyz5U9vFXXKUrCPhLjfd8PplmyKlfLDn43zCRhVs=;
        b=T4V05lujtnDe6T57cMU8UNhsX3e9kw4jQSCMPHIU6BuvzvdDN+3mRW8LMCwIpgnhwm
         /5c4SomZ9d56eAEUvZ3etrxKP99QYBh4IdAiIlDn5kkqfy7CPgYv5g0G0XSXlPyQk4fL
         P4E1jBn1IQp+mgTmSwP8Sb5rfS+wOMNgaiKyoEdVKlBTl2c0QOe8vrxzZfMKQOUl1psY
         xolFmDpsMgWhRgpcEgKzr6WDzIQlkRSmMaDLjne5PYDHbOk+nDUo58SNQuUlj4Ck5Hzi
         +SmZlujklUvR5MYVga1ZuJydRMsbPGV0c5FHgaMDGEUqDQ9xEB8W4n2wK6YRvPgsTzYl
         SWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795086166; x=1795690966;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4GEyz5U9vFXXKUrCPhLjfd8PplmyKlfLDn43zCRhVs=;
        b=nfLQSwcGRLKB3FWJvoZWihZfHClpKHCgs3L8Pi6ea2Q0cx0YzgSpYfviXFfNS0GadL
         0HlghgHgsWvRRWtsqfzWsTKyzipVzaPYC+pu4VavdR9RwSqXGsbAH+mbziDDAStuA47C
         IUFkzOitUkBXELx6g89J3ac4kHdCtdnKgEdpJPfI0QC8msxIWfQCRN1v1kFVNq3/N+j3
         7Nf6VBovd/hqzXPbIf77oStctfCnR6WIXeUZ5ZjrEfgIqHVRa1qP95pTF2YflRLy28m1
         0zF+o8aTfk1wF+QjmpDdXPFFjukm64yQ+m6Alhq5qKpInjGymySjEmyKmtEj+WCmhUH7
         yxIQ==
X-Forwarded-Encrypted: i=1; AL+hErE+KmOiYE5QDrZcjgcm69wKq2b6Fc1SuVzMbrIHUnkix5o7bo75YTUKhtmRrQO++7VtKt0tutJJLA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9JdKkkyTgP4Stl1evgtqKqSRLovBHRB8QN3H1CcCxsprCeowAf
	Uq3hgF6YATnNIVdWN1h5Dj+YgtAQtnVMvvqOl41X+DmzAgnZ6rjpDP+hZ2E54uAafp0=
X-Gm-Gg: AYBFou2bAS/hkjySpRLN3d/pJA0DdMLYBgqYehc5G0oKOQQvBLJjXtFhX/GIUgznqyU
	YEHzYG9V9/2gMw2LxbUhCxw1YIhfZNr8oXTpM4tfQv1FWSNc9IVpLGz9Gx8tfKmrEBoCekrr0+w
	Y7SLXhLPxRX436rfBmfhcSLeHcwTdQH4zS3Ss/Tv3x2rMSY9mj05GMc70j2qxvHlVu0Qi0viNmc
	Aqzc36bsJmMjUc7OQMCtKRlGoBVabBvHzUlzIEEAF4KVC57BgR4VMZClaLiO+L/qQaFRUic7Cjg
	aaKQJOsXN4a0GbFVNmvvgRhLxj6fVgMQbq4oLkJ49q5lJRmfoGvKylsEUx+hqL3d9w2bEvbBh9N
	qNdirO5Sv64LjBP0eR59u9w+5SgxQm9jMWcC+o+oyAS/cdtYBVChcIVhTEfh9xc5iXZZdlPWgh1
	MUM+QdgUPfyAXmVX9Izt2+6nQQ406U795pVSUSVlCnEGPnaxTg2EjCc5Zf60a31jnae9zx5Ndj5
	nthYWtg7wm4mFL/RrthqfR3QGBjFbwTcfkdpzuD62p9iqRvbrt/CujKKemIU4/r6XD7gwH7nyP0
	UNtXHmNAp9Ym97ySmzhaNqOqlzOpjQ==
X-Received: by 2002:a05:701b:205b:20b0:1b2:559b:67ed with SMTP id a92af1059eb24-1b543c144c7mr5006926c88.26.1795086165423;
        Thu, 19 Nov 2026 03:02:45 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447c5ec9sm14665466c88.8.2026.11.19.03.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 03:02:44 -0800 (PST)
Date: Thu, 19 Nov 2026 16:32:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: rafael@kernel.org, zhongqiu.han@oss.qualcomm.com,
	hector.yuan@mediatek.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] cpufreq: mediatek-hw: Fix initialization resource
 leaks
Message-ID: <av7XUQCgTkhJB43V@vireshk-B250M-D3H>
References: <20261119052811.2877720-1-haoxiang_li2024@163.com>
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
In-Reply-To: <20261119052811.2877720-1-haoxiang_li2024@163.com>

On 19-11-26, 13:28, Haoxiang Li wrote:
> This series fixes two resource cleanup omissions introduced by commit
> d776790a5536 ("cpufreq: mediatek-hw: Fix double devm_remap in hotplug case").
> 
> Patch 1 releases the resources when the CPUFreq hardware fails to become
> enabled.
> 
> Following Zhongqiu's suggestion during review, patch 2 handles the
> additional failure path where mtk_cpu_create_freq_table() fails after
> the registers have been mapped and the memory region requested.
> Thanks to Zhongqiu for pointing out this omission and suggesting a
> separate fix.
> 
> Changes in v2:
> - Keep the original hardware enable failure fix unchanged as patch 1.
> - Add patch 2 to clean up on frequency table creation failure, using
>   the same Fixes tag.
> 
> Haoxiang Li (2):
>   cpufreq: mediatek-hw: Release resources when hardware enable fails
>   cpufreq: mediatek-hw: Clean up on frequency table creation failure

Applied. Thanks.

-- 
viresh
