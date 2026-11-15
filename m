Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794783424;
	b=inyA9Raufvg93qnhF/tBHYs8+/GCXZ7nrFqbqblq4MOV3EpUQ0zY8aP8rYwV4y87lqIc
	 imnDk9zkHR+Tnl3/W09ZR7IGA3ZCrjbQ4DUaJsLKbuwFmC0VrE/gCqtzIHtzL+3ZDA+UU
	 wPp4ETDRWo/NcmADNWh1/aVbLsGUrTiEwGfkvpllw5t/qVA3MeY63js+j2VGfkIJbtF50
	 2DoDhtZIiZZj64SsfhG2ZBTHYbObQh38QrXacE8KttS8xXDOrtv4On4BCIqKQbUtdQ60Q
	 jpeQ0et3KiHkoNuowhMvQed1y4DrBUT99GVWeV/HYBPTiw8CVwg/aRYjeHhuqYkUwdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794783424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WpSIe4tLJIwZsVjPZznB7WvuZ2lyXPI8G0YCiWHPn/Q=;
	b=Ks4Z0F7UsznY41zH1Itoy0/5oCSmh5F9EwsYzcwkjIsnKuCp4SxRbblNPimMf0efB1OZ
	 k3T/2FgpdbAXaRTz0UolRcvbtDbfr8oMQO34ZuPK+Z0vIjtVjCyXKsH74z8Plyi4APUC7
	 QFUaQ13207s/3Pjv6B2ZDl+aLkjk8Kv6+lm2ERItVqVyMcOesedi2YOVzXkw139Ksv8Uh
	 50rZTHMZ+t42hucYtdv/PzSEReQkqy8esZRGdG1q6VqMRkQB5qyMXn4i+kgN+Md2QAEKI
	 lHP+JRtMvRwZsYV+z3NX5bXqDEAzWacl/NfbJK3e7u+DKb4fKMj3MtNIOweZjy1GqdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zJAzbxLL;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2728606A32C
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 22:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2728606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zJAzbxLL
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36dbde64409so4173158eec.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 14:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794783423; x=1795388223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WpSIe4tLJIwZsVjPZznB7WvuZ2lyXPI8G0YCiWHPn/Q=;
        b=zJAzbxLLJfqk9yA2eC3kpKBXCxMa2jNFOheVKVl8d+f1BhsoNlJr1vailxT3fV4aNh
         wsIxeUvlpzjqUPydUUFh3juEsi90wpvUE6bEffVwojrq8u5/k+Rb3KInJn94jYL8tBV4
         YuwwfU7Ldeg27w4likYqMzN7xmM18hRL4DeefKJZ55jwwxL8VXkpNfd9HEtE44FUDRnw
         zjurKf0TMY0nouiRkgcxelUw+8SA4Cnd7NSfGIiGkeLF3OYRNfXq0OYT05NcFzBlePQO
         dgIuH75zbo+5ZZgLTNdmtVOClxxy9x9YyTyWWD+tbRZvQkigXIObXTQCv2T7h3wkg7Pi
         C1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794783423; x=1795388223;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WpSIe4tLJIwZsVjPZznB7WvuZ2lyXPI8G0YCiWHPn/Q=;
        b=JukyluOb0w1DYO9wMymNaCvO8CxUzw4XxlSwYzU2qanAYyNLAvnGi6uyH95nklEDX2
         78lMrPlnQEHOLGlsN3Zkc5B+hecaeRfaiEaZmimXzn1PGMAp4ccE7vE0QaGBqqbVbjH8
         4T0WsxwH2B869kkMDKAtVuy+ivSnIoXdJxGgNDigbPyyvm0OxagsHNjnhbHwbbwP00tU
         RdXPhs3X0MVyQY6dXaiCyCd+BywU3B+CDpHw3/dd/ZReu8zp+6kkfJJPKlGR/B+nPC1C
         r6UYm5R4IXo2t/AP3sgsEUltLb21h4aBsk0073fOL1hK+0Qxhdk9eTzrL+rZRLvRNrRb
         p3Uw==
X-Forwarded-Encrypted: i=1; AL+hErGe9zFsjd4tkCCPJXG+cqklrhR6Sk5jHPCjvcZK/teBOUybqbkavRhhX20xVZjajkj+8kpuaFrPLQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8pNy8j8JoQJwieto7ziAz88Ga+esmmixN2NXkc2a5aQsWdDkww
	s8yG1Ck37tVFZy10hoONc4yiWHfZt/+/RfrmlkdMCnzerBe+IrpLooFC
X-Gm-Gg: AYBFou2klDI1Ic2yziULCgyR7q8IMMkF+wo96AjrYcsgu2CwJJqLrFx5ay1mDdg35MA
	RqsdXakAiYjQMlWeuAjdcCM5WTVl0ZeBZjbU41yqbHUoC74phcKqZO2rw622ZdjJcTqtpSVdi4X
	T/1p7lDSbCdyb2oiT12ABcN1f4vS8IAUP1Aqps+7Zjr6o0OtlCUjcMO4yhsNR9mSjG7TiT3dKxS
	+Fxa7doqC6/nHzehXJ5RuceM+NtoI5WWZnD2pPBFwfye65AFFPh+YynoGtb3XtEEKJuk9lUMQKk
	8ItkygjFxMYUFw+xMoQAAScJi7q4R0eu5b9aCZRX3/kWEQ94ITAQHbMABHT4gKZ0Ao1D6Lw6cNT
	x47uQJoijphEyBe8ahKywt0mAf4+nRQrfOUh2i/cgtpugxKZFKqkIbp+eAjb+vnrRIf3z0iW0fU
	aFaWOdyeB9D35i9J2s+a2kMvX2XKE4sxR3SzgAsYDQP1iLBW3CRmROZwdb/XPdQVlj2BDexDKmn
	nFX7wrwDy9zi3eoBS8DJpC7JCsi7cDpKkCk4wzhOWzP6QuYV/5JBd27dv2UfGqmfZ3XhU0TnmTB
	TX5wpwNLVzsbF51YN5ezb1KHoCfsbwuJP6pCkRnKNB9A8iVL6NExboFEW5DnPHk7spNCF4q+A0R
	vIU6RyhDRCPUGrxY=
X-Received: by 2002:a05:693c:4153:10b0:37b:e40:397e with SMTP id 5a478bee46e88-37b0e403d73mr6432496eec.14.1794783423022;
        Sun, 15 Nov 2026 14:57:03 -0800 (PST)
Received: from [192.168.35.214] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm28183468eec.3.2026.11.15.14.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 14:57:02 -0800 (PST)
Message-ID: <2af4c490-8655-4afd-8c1d-1894f910dcc3@gmail.com>
Date: Mon, 16 Nov 2026 07:56:59 +0900
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chanwoo@kernel.org
Subject: Re: [PATCH] PM / devfreq: tegra30: Remove redundant dev_err()
Content-Language: ko
To: Pan Chuang <panchuang@vivo.com>, Dmitry Osipenko <digetx@gmail.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 "open list:MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA"
 <linux-pm@vger.kernel.org>,
 "open list:MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA"
 <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260713131316.322358-1-panchuang@vivo.com>
From: Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20260713131316.322358-1-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/2026 10:13 PM, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 401aac6a9f07..d149694becd9 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -880,10 +880,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
>  					actmon_thread_isr, IRQF_ONESHOT,
>  					"tegra-devfreq", tegra);
> -	if (err) {
> -		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
> +	if (err)
>  		return err;
> -	}
>  
>  	err = devm_pm_opp_set_config(&pdev->dev, &config);
>  	if (err) {

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
