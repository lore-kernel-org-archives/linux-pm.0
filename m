Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150340;
	b=MSnVwXhHBPHt+P9h4vlCZjL2zlEXnfZPfHy7oId8BvWVXG3Nr1QAqyozRRerYYFMX28/
	 /1U95c9D71Hji73LumXXBP0XVWfrchvUbo8aCcSiP8J8RMVqMtGdjuc3M0DOHP4MI7r3s
	 SJtNoiwxzzscN/yCYj5ldKI5CBYINFEJL7vgXDenyz2pU3hpdGb8i1BsPeE52HmYCa/YX
	 xGVfTzRC33VVqscHgdzxIYWT3uTJfdU1ZiYmfNi+tsXQDSurItWibHSdU6sggBDyxaWXb
	 NJQZjB6qZbawQUCo8VbO/VIUxQefAKyKbrYIrJaVpyfzGk4ZTKiCss/rpsAUyI+nqdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+rPTbtnQOxgg4ps2+oCkkvTGsh362mR1Rpl2s/oucf8=;
	b=br2N75O4urwNszvs3Qw0vR6f6EVIZkZlvoBWAid9vBIpHBKNF+AclNhrbGUfxeEVLIkE
	 wpDLES8AK3Aoikb4LDbvFDaYw6/0LwEdcDhP1VKGHhHZkLCJvytPVDUupoYtpRt3JrDRR
	 s153gqEfwJ4LXU6czG6nXRM1AH4/DewWRAq6In7J2xF4IDg82kEbc6B/E4eI6uYhftLlt
	 7euGVK1di6FhRPhPkYny3nUFtV79LlEIj9nCTs80VG/eqTdkms9DCrLhMPzgsLDCLW+DF
	 EBLC+uwP40WfOxaXu1iqSsfLdgSeW4/ALyx5cAU1rbECoefHPfM+k/dCmDaftltSF5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H98u83vO;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3BD606A339
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 04:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3BD606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H98u83vO
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a315ed211so517051eec.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 20:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795150335; x=1795755135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+rPTbtnQOxgg4ps2+oCkkvTGsh362mR1Rpl2s/oucf8=;
        b=H98u83vOkfalU240xjpIMlt+5Ai3M+igDGGqnu2J4T3WCinYN4eU3bjbNo25Xqf3GF
         3WH6R0e3kVkH/lk5gSMI2AGxA91HKrwcHgfdDz0M8AulF6QLgCJyNwyfULF/lonPCDpV
         en9LyytncUYqyVy7+z6lg1edwwhc3OKhtX1T6vT/fsk371aXcWn1SiWTLkkjkslB0t39
         Whymd2zckO97J5hdawRoOrwlTTgz81tt6o0BL4C1S1I2A4+TM6Vu6i14lqtkEWeMwjJl
         41lcd87Q2w4LfGGWkMEG2SpWDV3jUynqkUnltR20y+2qZLAKvbW8T4UfoJrFfaLLJOFL
         CxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795150335; x=1795755135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+rPTbtnQOxgg4ps2+oCkkvTGsh362mR1Rpl2s/oucf8=;
        b=TCFjJZseckijPj1WPTSGpE9Yd5iL5TNcXx4edqia4yhtAWLte4rg9vVvALqm/An9fg
         iBpfNqDEkhjBuPnpU+TlY03T7wPbni5R7knuWNczV0C1chpZ69oX/4/RfGZshwFA+esl
         SkwmO9w4eBgyOzi/1Sd6A9RI+arlDYlZ8FIokv/cgH/UpORl6VVgkOCHuXNAboeqWQsa
         sL5mbI0msFp7bMq2P1rRzjZbUZXpkGrI22K0c6viumUqXSZC9iJAFtjsEzXziRP7gwGZ
         LccyOTp0d/HlYEXMRE0raE7Z7ykTwsKt/lB4wQDjWM7LEqzV9lktyeifQi03NKNgnXU2
         sRgA==
X-Forwarded-Encrypted: i=1; AL+hErGOT4cLy38JHd70HrrQef2NOgrW+7rs5XWes6mjmZFwWMG5adKqv2f3LvlAILL1WyhE393mBhReuw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/qTQwb9V3PHeg9/Rfve6e44SI0mdaWNUNBCXkNwZStDDBw0wNK
	UcTFlywop/BChzjcfckK2kOJ4Qt6fn+YQ4bzs+PgjbKAondIdPWAQOiqlTNTIC6OfuM=
X-Gm-Gg: AZFdTZeec/hqkaeSlk3rkMknXe480mg7VQgkjunEyv8hAJKxXKOcyZDK4HB5vnhtIIO
	KpW78HWqKcVCJcB7aokq91AcqBEYi5SrYsycCyAtFq/00qcEnJPukXSkS92xOP6MaOUdoC+1XWA
	uJ17NdhbQMhzp4aQdt3HnVS63FrhIaRvcb5vU2FNP493FxmgXAAQfOFfxv44zg8tva2Q6kTwXSF
	NJk17gctOkRcb3RJEpZqJIraW33YPHRFO3b84iabYR4EyL/ui2AWoSPQKPt9cc8h02SvempTd5M
	Wxt7elRiaPNGHXHkR++jYtw52KMFMMIzlE7G2h1EYng236Lt0dAH+e3yQu6TfzGvjK9eBAsw7mj
	nO3f2RgmP0zhNy29v9UGo6taZaXq5hCnNYdvMYAFgq1LlNso2fKan41+C6qWedsy3hEY5RbKez6
	BAIDOlXcuJMx/2D1olLIoTIVWp07aCrW7zQGn6WTtMcrJPdlFCnJzO81qVrzkyEDa76IPzLG8sU
	k27EDGjd/PraKDn2iNLbKQtNpB500ONepCWMfUmyx2k7rJ86kOu5JV7ZmQ8Tp7SN0IslSpdhQ8K
	OqzPevSQqe2xfnube9jezXsA80mghFTANruBQTmKxuWfygnpnAY=
X-Received: by 2002:a05:7300:51f8:b0:375:85ac:d14f with SMTP id 5a478bee46e88-384b3e786bdmr3144891eec.14.1795150335207;
        Thu, 19 Nov 2026 20:52:15 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm3768338eec.7.2026.11.19.20.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:52:14 -0800 (PST)
Date: Fri, 20 Nov 2026 10:22:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	zhongqiu.han@oss.qualcomm.com, conor+dt@kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, bbasu@nvidia.com
Subject: Re: [PATCH v3 0/9] cpufreq: tegra194: add Tegra264 support
Message-ID: <av_R-8aMX7lL83ln@vireshk-B250M-D3H>
References: <20261119111217.902071-1-sumitg@nvidia.com>
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
In-Reply-To: <20261119111217.902071-1-sumitg@nvidia.com>

On 19-11-26, 16:42, Sumit Gupta wrote:
> This series adds cpufreq support for Tegra264, which joins the SoCs
> already supported by the tegra194-cpufreq driver.

Please rebase over

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

The current series doesn't apply cleanly anymore.

-- 
viresh
