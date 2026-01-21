Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC6378D62
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014103; cv=none; b=SQrWy78NAXZwOCk4/qHL7Y8vtL666JbGyasVxeA8ke9ZBASnuauaS7BvKTv0eDKWM8ntXM6N6UHvaIiMZR6QDbwobT+TPE1AhuGH+KO2sLPUF6fN5B9J/FRcTY1hnyZ5Su7PJM/WQXUKX7PKLp5U+QZF2Rmn/WkSdXBN+uNJ4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014103; c=relaxed/simple;
	bh=rNJomwMJ6I/ZsA+Et/eCPlSbTldssWm0BOj97RPFXM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duBse4w6P1DhS5hRCo6asThr35av5yWLs54kbAb0YJ0jvquDBqmgaZgts/Mt9FPqIio6ne9KGoGm/W98VsgaSBimOo/T5OjJUqGEbrjcl3aK0k6E9IRgFyz6DoTiSAiVAoV/O2ynVsyjLecJcEMdel/mRu04v1ETh+OHO3stXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nhBRI4cW; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nhBRI4cW"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4801bc32725so522065e9.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 08:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769014100; x=1769618900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykTbvmHT9/WGpPskvmRNezx6+t+3FtJHW4PlWu+Aw8o=;
        b=nhBRI4cWiqvQwaJxOj22ZVPYAdBdMCFBujjsquHRAwQKMsj0BE2QrXGNZCqQunv8Tr
         4I4VCR8RVqTrraBEEOSf/NRniHOBB8dak2TVm4ll45dVsXrmGO/UPpY9ySUeaQehKhgs
         7mXbiPNikosM4Qnos5suTbZCtno3VF50Gm009IKZzxwAdBAOEo/Gf8pVVCRj+3CyEOiu
         fpEzJpJSxZwsTPSuUJcLeYI7BEPeTDaADR4IaSmn+f2Gh821pK3VflNEb24I8FXBbGpM
         9O5mbBBtQLSJzhpf3MSQV//HnWuwWp+k6IVDHn0dgHQ8lbygcq51RvLG1ILEepBdTccB
         wZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014100; x=1769618900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykTbvmHT9/WGpPskvmRNezx6+t+3FtJHW4PlWu+Aw8o=;
        b=Z9ILt/88/8kuZsPe1G1IGsmAXmrppeNVxI8wmfJhgA+pmSo55vNqXpFCoA6GzMHwsF
         A4v3J0huJ7jnrMgNC0mW0mEg4pajz/MpvWc+dIjea4wXqb5zwFoIsPdCeMsRYyyypOR+
         9r+k6YKsNxxTsX2BH8jdncuW3iir8xx6ktroTd63B9lAPa4tB0qavgoQRvOdkZM/ymMk
         yzkSF1htAJ1sZab+W/nemLJdUqLPc0fGxHbaOCSdV1eqYEa1Pnp6uQXefdD8OuMORycq
         5FsMCwaqGuDCsPgx1Var4hf8wEj4yxNdLcngrYoU2PfLev+dqXeKZ5G2rLEhMMv427k2
         XnQA==
X-Gm-Message-State: AOJu0YxlQ3zkA5Us4Qh8H8MMiVt3Sumq3iviy791ekUMpL6/2aDJ8xVg
	9FBsI+13PgI2eLY7Wa1lEkLOYA0xt6FUR9LPHk03CRuQWrXX++GARpiJ1xE9Lw1y8dM=
X-Gm-Gg: AZuq6aJMm01LeJFJI3xtom6DOHgpJHWWFNMZ3ba/MqeQW8d3RhEhJ+oOA9FICzHhWHp
	rTTJ0Uyq+6HYfuZwhUc9I2fkU3UyMgCK2Hst4YkVfkffg+yfzO2DRH9smWmiVDTNJUfdGponD7L
	AmIOkgVyhmhgInuC7IhHVXfEl+vwdHwnN7d+4T9/qZu7855Md5vtmk/PybXgYh9KZWCp/H1IwrA
	1A+4+vZUi9/WzjWkO9XkhLu5J9vIniHVNmIwKzEXIhiRrwChaNKBheLZ7SUlSJIWPENz7+Cqp9d
	504T5FiaZ1aY1mwowE9E1aLzrc8U0mVIplLRaE108zpURZMLqNwqu7pvBuNXjMbcR+lN5ZOsGrf
	iayweXEfZXpSgdZYg+Cn8krGjbg86/UMJgQiiBkj/PGkuaUXtoInnmf0e14s2a2fXKrEpvKWU4f
	fhR40OgEULd+FL1gX57KkRtcSUvWiCuh5Kdr3OVXV1ZN5mkT4kchSTv7hxF37obv8=
X-Received: by 2002:a05:600c:4587:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-4801ea340d1mr232570525e9.0.1769014100219;
        Wed, 21 Jan 2026 08:48:20 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:ebda:5627:9bc:1ede? ([2a05:6e02:1041:c10:ebda:5627:9bc:1ede])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-480424b64a8sm28528915e9.3.2026.01.21.08.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 08:48:19 -0800 (PST)
Message-ID: <529bb029-cae6-4c83-bbbf-7f7ea2637431@linaro.org>
Date: Wed, 21 Jan 2026 17:48:18 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] thermal: broadcom: Use clamp to simplify
 bcm2835_thermal_temp2adc
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260105121308.1761-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20260105121308.1761-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/5/26 13:13, Thorsten Blum wrote:
> Use clamp() to simplify bcm2835_thermal_temp2adc() and improve its
> readability. Explicitly cast BIT() to int to prevent a signedness error.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/thermal/broadcom/bcm2835_thermal.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
> index 685a5aee5e0d..c5105dfc6ec9 100644
> --- a/drivers/thermal/broadcom/bcm2835_thermal.c

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
