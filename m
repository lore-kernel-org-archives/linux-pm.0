Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C746AA9E
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273593; cv=pass; b=prh91plFX6ks3GEZv+G1cC71MIuhk8n5n3SkqxS/OdV/4zkwMGTChtufwIeZULBOmADV5r5G+jWGyj6YQqwSy9yaQxw8gJB9bSfpKWjWpmFX19K2H8SKFdAE3OHejBEawgg1R2sHPd2UMjx5YJw5H/rZC/fc1e5gIvkTvFRBJnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273593; c=relaxed/simple;
	bh=obM89duV/YDQdOLprqIx6ewSPHAr0cjoNZPC7dSU81A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEU4YtnVSvrLrjDcefUywZaMxaZom+A/mEKPnGOZL3LYE06EkqZrSDxM49KEVag9/UCoFeDeF/ORTKP4RZDakg+ha29x7Pige0NsAeFB+uGj4C1ky36ry/++jqgEN9fqukpJMhd2ck4g0yipAphuPMSoWZ5VITC0YSMUad+iZp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbvzXo7h; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbvzXo7h"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-670fee39d73so290294d50.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 11:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790273590; cv=none;
        d=google.com; s=arc-20260327;
        b=cCRmDJFMK8iVESYcNMn5M/Ah+deKbW5EsK0GbdZh+e0W2PN5xXa1dGNjU8w7/LRe5/
         zb3PNIIzBEvCj0LyS/Z0NBbG0NQJJw+AVxGXyAdI38+V96GZiYfEF02jWYgUYA9PdxZi
         dn96vpfOEuFCXekl1aZMBEoOTq+C9bU+YRU0AP5rjkLIBN/6RCzzPTI9NyvSLmCo6HMR
         7lYU9/8/drK3F8rymgwnysAvmk+1cbEzd5jaTSWCMyoHPO6gN4O4FL/nuzO3qG2M5RFP
         fxi4lNO3dYUHFe4Tbr/3FjQ/PiMxlauM3+b6MVLYgsS6DWf/eRPM7e1K+6YyUZObYcwU
         GByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K5/HMVOS3XLD3/CmnfQQxYp5K4Q9PjCgcZilabgKRo8=;
        fh=P3wXWz4TWU0yp/2paHh7Pjfk9A6GieNdgQpvY12ipn4=;
        b=EeVWgMeJbgcU9WlW1g5Ypr350m7EyfZMbbz0pcDGIRhIxLjNnl2YG50OiwoGR2rXh2
         ewYhyiCyNNmbr7VYqXJDTfVMDv2/BFMSqylw70iWb6hwpwqPG+SQgyYeVYT8cQIx8cnJ
         c6HVtAhACC0EE17b9xbrkDG4jlXGV511PBzHDMyCtVD79pRQ0OGXyZFi3ygwY5YrgWZD
         GERaC1bZjFp/mcxxmfMnnXJhciNgIdfXe0fvNLXCcFHYeJw7sDNSxleX9h7HgEA/9sYM
         ZLGIEbkIDkjw1eg+qDWbzjM1JKaY6iHsSZOY9qArg+QbU5JdIHFrIVLt3hfEVRDn2xg8
         3XVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790273590; x=1790878390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K5/HMVOS3XLD3/CmnfQQxYp5K4Q9PjCgcZilabgKRo8=;
        b=SbvzXo7hrk0G6IauEmNn8RcRTFDhXSYqND3iYB+yTSkk/RWTVAJUMeNbgREjaGaJht
         dlN1Eg/3m89JfwDHLE0FluvYhAG3q3xdg3l7jNZUUJrO+l21ou8qZFzxUfbvYJvzQXOg
         5/+ygTJVT+uaqLti+EfJmQA/N2W5pjkKps/R6ID31PGjFY4W5cJ8VvClXQeU/Ck/ZqAQ
         Y3WpYCjClKYmTsfxbbDWMvEQMJKv2FtuUgZQjWqydKctnyzYsWgzRtVwS8KSrcokkmr6
         KIqzntdUUlJs5UMpLtcBj6DmlwlgqYUD+4o6vaTavK6EWNOGL++xcPWaQBtsgV/s5fPB
         y9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790273590; x=1790878390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5/HMVOS3XLD3/CmnfQQxYp5K4Q9PjCgcZilabgKRo8=;
        b=bDZNgvXK8UtrgafgkxORK3C2ykrYM0gjkce8gKSrEalefa3Fv0Zhpd86rpE312ySUh
         GQcQSf8Ssuj5iQmbKU5WVFiiR8325u6ZRjQleil/PpLGMc8f07/JW3ENg1zwxr9uJIpp
         n90eL+lDkxJRbXig3ghxBbzoiryoplb/qXcNxkaRVW8kLf7ZhvyYi999ga8qqDrVV+87
         PPgWHIslYiuCakYI3RnEpEkoKdsv7qO+c5AMVmj5uDR3jO2hT8zL/zNP29FYqRplkK9c
         S01t00xfRz4uE01j5XNRk3t307eYIcYikfWn4nPMNgJwjs6w9RJLMvQezjViR2zNdKE4
         Z9Tg==
X-Forwarded-Encrypted: i=1; AKwUvByCP68nUNtsk7fGT6zSDGXq3+PnpG9MdmHeOKsT57Zk7ptgH9PB7Z1zGJ0HsikgGqWOcHA+xupkKw==@vger.kernel.org
X-Gm-Message-State: AFuF++mLr75EhzSYf/Z0XmXydRTvqJuhF+bSyRsljUugfvmpwJYvnT7r
	JQVW2+ztNtlI5tgtPPgeTGGofmnkSl5SaKBXrjXUGVgQtR5J/SqRgG/5UHxHY0PocrZAeqXTmEt
	1cfu4dbe5CBtVi3ElRL63Eg4P7kJyq7k=
X-Gm-Gg: AYBFou10Vw9ObSuKmbY4bfwYI64VHlyzrajEVHHl/dh1ZYpFVM6OYPfmHMCBkn6oUHr
	pwe53cZjfC+mhbHppegT1ECWKbsTZb/n878XkE4XvVY65pknK/ca1jFl0lvljWm9vV1MHWWyEnG
	DEmtLyJI2GZ6pIz8eOqas/ZGeJW6rBTqFOjoMkuNeiflfBOatHL+AiZZYkQwPG8zD3Fc0BRgJhq
	j2lerp+58UUD6evxJH157gHRRk7YmM5BpwG9eVlC7b2Q9sGn4XwHhqRQCSX4ybtQiKPNbn79VIo
	lGqmOZnTW766aAsqag5gEijfZRbH5tQlL/7E5lJ0304tj3G8wdfEbmhX
X-Received: by 2002:a05:690e:418b:b0:671:5ede:96e2 with SMTP id
 956f58d0204a3-672ed2603d0mr2064645d50.8.1790273590483; Thu, 24 Sep 2026
 11:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912191156.185448-1-sumeet4linux@gmail.com>
In-Reply-To: <20260912191156.185448-1-sumeet4linux@gmail.com>
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
Date: Thu, 24 Sep 2026 23:42:59 +0530
X-Gm-Features: AclHuK9xd3dlB_Cgp98d7h2ns81HK8suGpMur6yXKcYJOLZ9LOtfHEkjox28BFY
Message-ID: <CAJ9orWTDrTTRLqwnwu9YMQQKt0k2g7qZEpH6fDcMFcTbTs55KA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] PM: Use %pe to print error pointers symbolically
To: rafael@kernel.org, krzk@kernel.org, amit.kachhap@gmail.com, 
	daniel.lezcano@kernel.org, thara.gopinath@gmail.com, talel@amazon.com, 
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org, mmayer@broadcom.com, 
	viresh.kumar@linaro.org, sumitg@nvidia.com, peter.griffin@linaro.org, 
	myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, 
	Frank.Li@nxp.com, s.hauer@pengutronix.de, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, sven@kernel.org, j@jannau.net, 
	marcan@marcan.st, casey.connolly@linaro.org, sre@kernel.org, wens@kernel.org, 
	t.schramm@manjaro.org
Cc: bcm-kernel-feedback-list@broadcom.com, linux-samsung-soc@vger.kernel.org, 
	kernel@pengutronix.de, imx@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 12:42=E2=80=AFAM Sumeet Pawnikar <sumeet4linux@gmai=
l.com> wrote:
>
> This patch series is a cleanup for subsystems under power management
> (linux-pm) that converts several instances of error pointer printing
> to use the `%pe` format specifier instead of explicitly casting with
> `PTR_ERR()`.
>
> Currently, many drivers use `PTR_ERR()` paired with `%ld` or `%li` to
> print error codes returned as pointers. By switching to `%pe` and passing
> the error pointer directly, the logging subsystem will automatically
> print the symbolic error name (e.g., `-ENOMEM`, `-EPROBE_DEFER`) when
> `CONFIG_SYMBOLIC_ERRNAME` is enabled, and gracefully fall back to the
> numeric value otherwise.
>
> This change significantly improves the readability of kernel logs and
> dmesg traces during debugging, without introducing any functional changes
> or side effects.
>
> The cleanup has been applied across the following PM subsystems/drivers:
> * powercap (intel_rapl_msr)
> * thermal (cpufreq_cooling, devfreq_cooling, qcom)
> * cpufreq (bmips, cppc, qoriq, s3c64xx)
> * devfreq (imx-bus, imx8m-ddrc)
> * power/supply (various battery and charger drivers)
>
ping for review request on above listed changes in this v2 series.

Thanks,
Sumeet.

> ---
> changes in v2:
>  - Krzysztof kozlowski suggested to use dev_err_probe instead of dev_err
>    for *_probe() functions during review of v1 series. This will be done
>    in different patch series.
>  - Here in v2, reverted the changes for dev_err under *_probe() functions=
.
>
>  - Link to v1: https://lore.kernel.org/all/20260906061755.5103-1-sumeet4l=
inux@gmail.com/
>
> ---
>
> Sumeet Pawnikar (5):
>   power: Use %pe to print error pointers symbolically
>   devfreq: Use %pe to print error pointers symbolically
>   cpufreq: Use %pe to print error pointers symbolically
>   thermal: Use %pe to print error pointers symbolically
>   powercap: intel_rapl: Use %pe to print error pointers symbolically
>
>  drivers/cpufreq/bmips-cpufreq.c            | 4 ++--
>  drivers/cpufreq/cppc_cpufreq.c             | 4 ++--
>  drivers/cpufreq/qoriq-cpufreq.c            | 4 ++--
>  drivers/cpufreq/s3c64xx-cpufreq.c          | 5 ++---
>  drivers/devfreq/imx-bus.c                  | 4 ++--
>  drivers/devfreq/imx8m-ddrc.c               | 3 +--
>  drivers/power/reset/macsmc-reboot.c        | 4 ++--
>  drivers/power/supply/cpcap-charger.c       | 4 ++--
>  drivers/power/supply/intel_dc_ti_battery.c | 2 +-
>  drivers/power/supply/qcom_smbx.c           | 2 +-
>  drivers/powercap/intel_rapl_msr.c          | 4 ++--
>  drivers/thermal/cpufreq_cooling.c          | 4 ++--
>  drivers/thermal/devfreq_cooling.c          | 4 ++--
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c   | 4 ++--
>  14 files changed, 25 insertions(+), 27 deletions(-)
>
> --
> 2.43.0
>
