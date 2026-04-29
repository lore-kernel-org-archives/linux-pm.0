Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CBD36EAA5
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499380; cv=none; b=Q04/Cgah9pY9acpOZtolXO5OkO5O42MM4PpF17gSUNB8MlR80Md/hxPw+0sWxH/dqMynqXxDuQqch4wb5x2TNlGQmwcTSGy+UUCQ5sW3+Y8DNM52XB/GKKawrIN9bGrrTFSsvTfkootpYvZUOoWUt2RIAMvbAZ1hduRhvbZ4/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499380; c=relaxed/simple;
	bh=ZmkqzhMMP11XCzSg26BiMBdZCdJYhvNeWw1cAnR4Uc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSy9PPy24rSc9elWQ+92qVLpBHp7EQr0vnVDYdfgrgdC+TJg+klMHImy8gVtwoy9D3oTr8mXnd+d2IRbj8GfrE3q8byuSTuq7LSqijuZJlJCfeiJksGr/IWh58uEfezaseGKwm9JFUfmRhkPV43aM76lAay4zewKH3u2qQ08W2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sY6Rr0eu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sY6Rr0eu"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so153446a91.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777499379; x=1778104179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zUDeCVrU2RndRutPu+Gw6Dc2703OlKI/8IByVNw9b0s=;
        b=sY6Rr0eu0sI3NkDyQtXL/U5qjxMY5ov6+Zm+enn/F2wAu2j2wddwM7rO80fz+Sx8hD
         rValOgvrH3AhvVrvhr3mMvELnf4+KpVRGoX5AXB+yg9RYG6eRAaA+yTh26aVKyQqkAgr
         Va2kiebS8MAKLF9i/O3snWrAU1bdnnayEJvrZ6aLG6DlOJhUFYiXxCGj3CI2xxXvfCLb
         X2ThR4NmErYoybzHh4mes5I+tKdgS63dHIrLXczGOHHaueVGf1T4eXgHsyl5N1Dpb7sW
         AkzLvXQJxNoDjRZx5DeBJ6Q+x03KO0JKTMvauUypRniJhfLEB/3lRuLdUyIE9fJDVYSR
         s3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777499379; x=1778104179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUDeCVrU2RndRutPu+Gw6Dc2703OlKI/8IByVNw9b0s=;
        b=OPzf6RnCsjCOGpbc0Uq8LR/GiB8BZgKqz7adOtEQ7Lm1jlAI7YgsxKrZffX+0gGFLY
         4BdLNBlJ1Ahm/xmyxA3IkWfgGNVatdowK60Dl4FbGGw07Q7WsjjN03W2rc4o099DzGnE
         G9JOT3tEQjn0c20tHwBYBYeNGimwIIZVHgV5grjuC6kQCvzVvifPWywBAO98SXPvbIj1
         E1pTkrq83JZH+0fOxiKXTs0eDfNYCd3mo7mAB3y9cgazByZTTL4C3PMWRRhhOPRca6kT
         HTGlikAYJTNFdoBi4X8zR2/E0cbJX3bqBl19QNOUAcIrvmTaVeiJeWumwx4BODJBs6ES
         WHrw==
X-Gm-Message-State: AOJu0YwcvsBrh2uV3Nru8LgX/+K1xlAObpYwaT0hpmeNLqRjTnXpR9NH
	ji6d1VK6emB/LtUSd2UdvI8G7lsl/Cg8poS2KeplnvTFLlaCgAwsBMKk
X-Gm-Gg: AeBDiesEOZzWKmNk8obXuVVZ2lFECZMuHzrEru6urELqYHVQjjsPkJjKHlIWC7s6nRE
	xo1DnRClo8iJ0XYu9eHkIRX4FqaGMUil2uPzRTmihbHopacipZybrI082K/KAVyWuJ/9b/GG6Xa
	etenpldQvubykgdDnzSa11jiNbxAOg8DN06RUfImYRh0P8RA2om3xsXPuhvYV9vCV3pgjvmvqav
	3Zp4RV0cDeAYDETCyzcyOYe44IBOrxDlx/bKJfO+x1aNDmr0fMwo0alFdwiG1qKTzKE6zA7j8Do
	PoYEYX/udWBpL24w91Xorbdmlnp+Oezs3rLpBJarsXmCwVsiXtEH/tuoMJRBCm7IzPtC1G1pOyF
	G55dpQQzShn04jOhM4ndZlEGZgLOEFVC43nHkayKBZMU7NynF97Wev39L9D3w/bOGlqBgKKAiir
	KBJaksGsJh5Vq4LaiGWzbhlDbUyH4OAC8UTuJjoitiUPEL92Y8Cw==
X-Received: by 2002:a17:90b:5627:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-364c34606c5mr43083a91.12.1777499378936;
        Wed, 29 Apr 2026 14:49:38 -0700 (PDT)
Received: from [172.30.1.27] ([222.106.243.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a1213600sm1396043a91.3.2026.04.29.14.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 14:49:38 -0700 (PDT)
Message-ID: <2260c470-0fb2-475a-b415-e0f485ebe619@gmail.com>
Date: Thu, 30 Apr 2026 06:49:35 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] PM / devfreq: Fix available_governors_show() when
 no governor is set
Content-Language: ko
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, zhanjie9@hisilicon.com,
 nm@ti.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
 <20260401033055.67608-1-tianyaxiong@kylinos.cn>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260401033055.67608-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



2026-04-01 PM 12:30에 Yaxiong Tian 이(가) 쓴 글:
> Since devfreq_remove_governor() may clear the device's current governor
> in certain situations, while governors actually exist independently of
> the device, directly returning EINVAL in this case is inaccurate.
> 
> To fix this issue, remove this check and use df->governor for validity
> verification in the following code.
> 
> Fixes: 483d557ee9a3 ("PM / devfreq: Clean up the devfreq instance name in sysfs attr")
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  drivers/devfreq/devfreq.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 994984f7b6e1..2977b07be939 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1468,16 +1468,13 @@ static ssize_t available_governors_show(struct device *d,
>  	struct devfreq *df = to_devfreq(d);
>  	ssize_t count = 0;
>  
> -	if (!df->governor)
> -		return -EINVAL;
> -
>  	mutex_lock(&devfreq_list_lock);
>  
>  	/*
>  	 * The devfreq with immutable governor (e.g., passive) shows
>  	 * only own governor.
>  	 */
> -	if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)) {
> +	if (df->governor && IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)) {
>  		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
>  				  "%s ", df->governor->name);
>  	/*


Hi,

Applied it. Thanks

Thanks,
Chanwoo Choi
