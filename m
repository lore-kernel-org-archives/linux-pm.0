Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBAF3F3295
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085907; cv=pass; b=cBFILgCxU8CYHDvjKVdS7oVbcvm1GIo+Irlkaw0mLlwmIhOkFfFCkX62mLSB6WoQpXImVGYLIWkI2M3N+r0tiFKYjbivufZ5ayMvbrW8rshxtBHQs0i7W3Oms+3MKy5/IDpwYo7KhDEmrbwrz4DKhm8gdxSyA/GpuN4ODgDDNW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085907; c=relaxed/simple;
	bh=bkxFv5PX8ujIxdonqIilaYDobdJDnLk8tXzGrWmcSt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XG/FDFRl8Q710YDlm49HBRt1oQen5nnwq3frgY29xsGyDulFSDJ3IpNDAc2xPZTNrFEddJuU6VooX8vBo1jbGZU5mg1h7AixvqsLx0c+/zkXMz6uEEkK005+UlAdeEaMwMKjl37YgVwGwfI83xefLiqiYm9FsG7Nxb51x5VGIGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdY0tTI6; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdY0tTI6"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6740e7ae219so4652562d50.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 10:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792085897; cv=none;
        d=google.com; s=arc-20260327;
        b=c+qgTZxYNBwF2NUZEsvcxCfuUCl4xyvWoRz31kfY4lzxon7IssxgLujIrrd7rji8dN
         aprvl7+vazDAW1kTI8rSSwfmHDyb0WPjsrAcDY2rFYOVyE4O9dk1c8LMiiazp3yn4rL6
         GZhGdaHhxORur2pa9ouz6BWXe1C/RCOiQlKvuj8LSXxAffG/G08FyXymle853vKzvC/X
         n44hxjguK5us+uQSW7kmznoV4heH1duAb0GQUjUqeTf3Xjo3H7HPDRsdsfBflD++wQt5
         WLaMBblGFxKqcObwmTqj6C3we2rA+KM37mfJA5sb97Nuw6/WkQMa7/aJhKMmw8K0R6aO
         MQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RNR7hf8UYLE+m8+IlSqf9D9Kn/JvEzNZNospuZY38uA=;
        fh=KAKZi3wig1rISgA4ITN1FJr5FURYs9OJyZh7oNKZyvA=;
        b=ZGZnJ6osrzulXpK0Pyh3Fsu1qebStn+EEoCUgXO3gygk4nWe3aN0kj6lVgmztV0Bd3
         6ByOZ+Qnh8GnYXfbCWXf5qN98/yj0lXhFwPwZXquvPHCVEUeehMizjysftVqIBhPYpBx
         gp+0FNt77VSrvAQT3SdBEiqAAlVDi1G3scljHwSKQIQjwjeozlmebwKv4Kkb1soFFJWS
         haiUR5TVjhCulHX2Ksp4UCZtKVHO+Op2g+CmniBi7HB3SW1v1eofJjHzbzJSH4MkbadG
         mJvlv6BlgSo1/SPVU7SjIZyjs+MepPJobagPtoELRb9H0yABoLy1mm/a8tjwwZOb8Y8x
         8eww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792085897; x=1792690697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RNR7hf8UYLE+m8+IlSqf9D9Kn/JvEzNZNospuZY38uA=;
        b=FdY0tTI65LLFbSDM/PkmptpQRO/LkHkyKCAY9mHUMFpQa/S6Ox3Yk0ohOXs6nYBv7a
         LSgYooxuKothhty/g1dDYggLu2Iwfl4MufA0UGt+NuH52fQdUvPhJviJnAKKXCVlE6FK
         MXueZ5y8g6dGvYt+I1JZLjj4anjvLk9Y+v2jV6gHpQyvX+pVyu/UGw5m4vSBhwwXqpDu
         7+6Y+OAd4F1e3qja7s14n57vtS3/yjc6Fn7Y5Nl63xNcVLEDjC/ulSeHQXea0Y4wBzPn
         xC7EeuMmbwSbY1P8cq6KORdYHXYDpN/iil6Mj8ehEULWWhpE+ehGB0H35YSm1NC8cyKD
         48ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085897; x=1792690697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RNR7hf8UYLE+m8+IlSqf9D9Kn/JvEzNZNospuZY38uA=;
        b=GuEGe1HJkqw6RG62o6U/leQj+H9kx87ZWkhQJ2to5amdDb5fwmPPoXvhd2h41pcrE4
         yjz+0wmcFVXE5We+gzNccwizingIodGYs8m8xGmVHS0pSh1wO9fuexL1rX1t60jB0nI8
         vM7Xv0uz4jmthlW691UjZ/PeCdUp7pco4OEhxoQqVKRJ0NtovC5jfIxh8yswqpr2WeUQ
         bNiqodfI1HMhqE2/i65T4oZstYX+Mw7W4lKPzoOKNhcNvJhRqVx43yLAqRFhwhw9IDnt
         kq5Bp7mhVNjLd/fzG4EF3suf26PR1GYA9deTiSrsJRWSK63dT5/Gtn5Ui9tQ13K74T7H
         uA+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxhSBQyM+t69hgFYwuvWeHJCiIQVm11XuKtS1exCUMANpe24I9eULTvv3YxqTb5u08A5a9tFpU8Ug==@vger.kernel.org
X-Gm-Message-State: AFq9FYIrRSd13FsI9tPE5GoZpQMqQkSr1cOHHagheuSrds3eDFP/zdyS
	4wdsMNBQm9rMgu3XfDuw2olHryp/sjobIYxezgNtZcEqJOA4Q3WNYmTnHj9DXhZceUVdLtkSfT5
	O1Ed+Ng4+t04EuDuk9/mrsElJ4XPHfJ0Jag==
X-Gm-Gg: AYBFou0inRl3ZqDriEPwWXIOEZ4NMCRKRMseWYxv0BgYA4iDJMVq8BAHvPBov8cS/96
	lFA9GnxzW1rk1b0ohJbKxasHBFzdrX1iG8B0axnew/r5raqne5MURM56F3GYx0gsZIomO8SNaJa
	joRd4H9uQ8nahStewakjPQtqa/PEKR6sMZVhGLh5oH3vVaBEPCiA580sRGcGJcepvhMy5/GEr1d
	tsk94AJQGbPhgYFX84WS3c686b5XPJsg8EFxzf0vqO+HTeEY4J0BDn3WLmpcaKxcp5siFi+yUoZ
	OMa8fSQQEE1FsIi5AvVTWpfrb7wB8xvd4U1KynlHbD9cKmildhNoVulQp9twplv4yBM=
X-Received: by 2002:a05:690e:1c07:b0:679:aa90:d272 with SMTP id
 956f58d0204a3-679aa90dd58mr432536d50.108.1792085897078; Thu, 15 Oct 2026
 10:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org> <20261008-04-k3-pm-support-v2-2-6f778a53dd2d@kernel.org>
In-Reply-To: <20261008-04-k3-pm-support-v2-2-6f778a53dd2d@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Thu, 15 Oct 2026 19:38:00 +0200
X-Gm-Features: AclHuK-mkmvLNzpAloyGNWEU1xEwlRugYfUHBOpsjJVuzj_o9PRbUr7KYWotes8
Message-ID: <CABdCQ=PAHxwH1+1OkLiW2ad+PTxNY6OmmPwOwAR3EoDe6Mt7Zg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pmdomain: spacemit: Add power domain driver
To: Yixun Lan <dlan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El jue, 8 oct 2026 a las 5:45, Yixun Lan (<dlan@kernel.org>) escribi=C3=B3:
>
>   SpacemiT's PMU (Power Management Unit) consist of several power domains
> which can be managed independently, depending on different application
> scenario, each domain can be powered on/off for saving power.

Tested on an OrangePi RV2 with the PowerVR GPU power domain. A few
comments below.

> +struct spacemit_pm_domain_param {
> +       int reg_pwr_ctrl;
> +       int bit_hw_mode;
> +       int bit_sleep2;
> +       int bit_sleep1;
> +       int bit_isolation;
> +       int bit_auto_pwr_on;
> +       int bit_hw_pwr_stat;
> +       int bit_pwr_stat;
> +       int use_hw;

bit_* fields hold values 0-15, u8 would be more precise than an int.
Similarly, reg_pwr_ctrl fits in u16 and use_hw could be bool.

> +static int spacemit_pd_power_on(struct generic_pm_domain *domain)
> ...
> +               dev_err(&domain->dev, "power-on domain: %d, error\n", spd=
->pm_index);

You could include the domain name failing, that would help identify
what's causing the problem. You are already including the name in the
"power-off" error message.

> +static int spacemit_pm_domain_probe(struct auxiliary_device *adev,
> +                                   const struct auxiliary_device_id *id)
> ...
> +       pmu->genpd_data.domains     =3D (struct generic_pm_domain **)pmu-=
>domains;

This cast relies on genpd being the first member of struct
spacemit_pm_domain. Reordering the struct silently breaks it. Consider
allocating a separate struct generic_pm_domain ** array and storing
&pd->genpd explicitly

Tested-by: Iker Pedrosa <ikerpedrosam@gmail.com>
