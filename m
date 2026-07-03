Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6636EAA4
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111969; cv=none; b=jYKpTwbeFAZm+ojF4Ju+MOBFD81idn69DM6v1ZLk2V3KDmRtsWSVBGcHvx6HlKd7RixA5FBUfHbRWgeRs+Uf8KlZSKAOFJzGxdAVNVJyHz9hz8Xm7Ha3fvSLBqIccNlVGjQni+twoeE8EoV6h/4R2Gg9Z9xYkYQBv019MHfnmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111969; c=relaxed/simple;
	bh=ve2iCvc48gIh6oKHzVFM5RBDggJo0jkLEQ4dRPdJUk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIhhJfsSKYMC0CsNdU6Zo3zrugusI2D3ApkbAh9eoqlFR3bw2DtgHLwTrueGKM2z7h2/YXeN+RLloR++KUY+0lYQTXo+IIxq2aOyhbIrW74oM9XPsgUb01IOT7aYRiBWY3IPvZJxp0poCD+AiDuTpjSHdajyMLtMmhtYYFTsIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9kIwGNk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9kIwGNk"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493be1b9564so6907815e9.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783111966; x=1783716766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iHBixXF0joeUv/ZwlLB2ZHCvM2TQE0OYai8QhyfV/nQ=;
        b=b9kIwGNk5iXkmcpkpZN9HSweaeehlXg3BWwYxsCyKocjPca5p3M+Y6h59pe0KfM64Y
         +QWKwQyBRbq0NtUXuxAd3IjGhnp0Sav8E2BLxm6QvsYs1Gzbpe6dgunfMRIAOEyXTBlT
         zfhlkh4qRc5sqKr62Ac0n6j4EjJStELYDc+VQ93UQdJdMjPkR1BJKwAtFkh/0L8OkCt0
         Io/PJ19I/ZLGs5+uoQnjHn9cR8ISg97m77MTfFBpWOTb2wRI+HdztSXbyYfaPa1uLWia
         YlKtB3X9c1IYVNvgL8rr9QelVwQkANsfakpNhyuosQ53mG1E0MqdSuGBCWOUDZ5kzJQm
         FgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783111966; x=1783716766;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHBixXF0joeUv/ZwlLB2ZHCvM2TQE0OYai8QhyfV/nQ=;
        b=L9uwxamUMj825FzgeycCM41r43TLrABYzcrcwgoREp8NkAoHEdHEggVAezbl2luOsY
         9XeQ1kaAEjhIJcaNqTFaeSKK0HJrHx6p8fZLH+j/3OCjA6AhCekQWgytcCXfBzIzSAHg
         vFEktDxvR+E84opn8rbfdZmQg20xEhy9F1c3NvciRhXTBDCzmtPQVDD6SyZ4rtIVYs0Y
         rHHDBGqalZtGBmcqw8011LrUTah6/nQg50Fvx1BVmAJ9n2aGE33rjqU7La0unPLzV/0c
         qL68j2A1TYl7qwnzK8KScJZVfVlDuVgAe8Pa3Lg5JCf4Y1ErdWzJVnd0Dv4IanqXlSY5
         x+FA==
X-Forwarded-Encrypted: i=1; AFNElJ/6niYquOBhBN9kx+KSaBtJRHGS4D90W3kmlyGOS6xq6Dcl/0q26vsY0/+LCePuoHKzwFvOX0DDww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvdB8ftoRctWk00FKMvuPLGka2cvOzMfAj6G4cJVYYaNhxgQI
	Ep07Nhn0uObb9FDBTa3d17wG6XplLwROo+k1hrxU+ftUblykelmIuMkh
X-Gm-Gg: AfdE7ckSB3oT2Um+iK9GJbWQ6H6satjIqbeIBMQlexkfnB3pY+0nWALOHxIZy/YG/uJ
	DKk0Yx/SdlkkOXDLCiwG5z2l5jKX/2PaWRlcjJiF7IGuTWOZV/X71jI3QlLUykV9OS9RS+i4S5O
	nCFoEApocc93PaySprgVM2RUCRUmnxZ5lP/1PLNe+Z/YYwhH4dCfYUtdy5scOFtowmU2Sl2VkKN
	wPrhwfmhknOg71zVbMPzPg/eiVnvbFn3Z2M0d15Almhml2GRKzLnXro7Z01+UA29GgbF4iE95RA
	kTrsMgYMR0PXEjsmzWoQ3F8KDt6dkxeGIRRVmGFlLCW+DM9pD59jYZsS15loDv8MqZeV0MUHf7V
	4kOJkS+nGBHlxBg3JtlcVc/J8BgMDosjocLryeLgYxCxs8vJJrglL/1qvsTRWrnIK4NKrSApExG
	IwhV9YFV0mo+P/wYUJYKijfynl4RCy3fNr/xScKEID2P8UYB/AtPjSHJm3
X-Received: by 2002:a05:600c:4e13:b0:493:b729:3a9 with SMTP id 5b1f17b1804b1-493d11f577amr8863935e9.27.1783111965965;
        Fri, 03 Jul 2026 13:52:45 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef183e7sm259988995e9.2.2026.07.03.13.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:52:45 -0700 (PDT)
Date: Fri, 3 Jul 2026 21:52:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Sasha Finkelstein <k@chaosmail.tech>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa
 <neal@gompa.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: apple-soc: Calculate frequency as a 64-bit
 value
Message-ID: <20260703215244.437ec9ac@pumpkin>
In-Reply-To: <20260703-cpufreq-64-v1-1-c406c705319a@chaosmail.tech>
References: <20260703-cpufreq-64-v1-1-c406c705319a@chaosmail.tech>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 Jul 2026 20:52:48 +0200
Sasha Finkelstein <k@chaosmail.tech> wrote:

> The current frequency calculation is done in 32 bit, causing problems
> if run on a future SoC that can boost higher than 4.2GHz.

If it matters you need to fix it for 32bit builds as well.
It is pretty much really wrong to use 'unsigned long' for frequencies.
IMHO the should either be 32bit or 64bit.

	David

> 
> Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
> ---
>  drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
> index 638e5bf72185..6a0f1d36578f 100644
> --- a/drivers/cpufreq/apple-soc-cpufreq.c
> +++ b/drivers/cpufreq/apple-soc-cpufreq.c
> @@ -288,7 +288,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
>  
>  	/* Get OPP levels (p-state indexes) and stash them in driver_data */
>  	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
> -		unsigned long rate = freq_table[i].frequency * 1000 + 999;
> +		unsigned long rate = freq_table[i].frequency * 1000UL + 999UL;
>  		struct dev_pm_opp *opp = dev_pm_opp_find_freq_floor(cpu_dev, &rate);
>  
>  		if (IS_ERR(opp)) {
> 
> ---
> base-commit: 4a50a141f05a8d1737661b19ee22ff8455b94409
> change-id: 20260703-cpufreq-64-2a23d7261e09
> 
> Best regards,
> --  
> Sasha Finkelstein <k@chaosmail.tech>
> 
> 

