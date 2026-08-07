Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764E542D74B
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100704; cv=pass; b=nyc9avecK5DEq60b2OKXXUQ1Q9j8aqEZRgIVdwbjSGOkRk6PNyWqKIHvl9Wp3lguoBUCp35fw68L734FAf/u/RB0wfwduferPA3y9E2JdZWyJ+QMkEren3KPWeXucheFtr526Huw8SDTuzYx4I3wOCC1uT1UCx42rxcO1uibvok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100704; c=relaxed/simple;
	bh=7KhMblWPk9Mxjw0VSwSuCZtpex2QSzhBO4rxVqclDig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5ew2fjapwNkyp1Kol613+8pvslEZDU70gnNd0lLIRA9ds79YB2L7mjRlFLRmFgEmOL6XRa7yXvNtljdzkz+jVwX5SjFgRHcwSxufgYgsoXFPaZZa0iXeagLqw4fhPsN6feNOpH6Hz8h34+9ub0l03xlefJ45ODvf2YTvb9W2nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjxPWYnv; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjxPWYnv"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso2200641a12.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 04:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786100700; cv=none;
        d=google.com; s=arc-20260327;
        b=J3Xx90riMjeLiJw+YNQbmFuCjM+6MR0FGRzgeAxLktTxXOfv+lsYTVKQDo05qKBmdb
         1EZWZWsWwTPcLQzRVj/MwdMaE3ylOtYwPgsuYNPxdkiYMhHVKZ7HweSfAN3R5KKL6DXV
         eOw+zhPvLE2e+M1Cqm1H2c+28iPnP9y3sxGHINQ2FzFo7b19ubgolBDt42bKttjVyB4E
         t7EorTo9mStFQMjDjkDXeGKU2ZPPbOuwuwkONLbkrCA8Bm7Od5NnLJiHfVwIg9forH5+
         T19495Kifegv45DIKX5XOnXJZFLuzBrA5zxX8Uf69Hz/H3tE+epTzlgKHZ/VElef5Uip
         UAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lIbXpFTj/4jIXWlkQ6czPnMrtaq4DBoRJvyvQNnOL8U=;
        fh=sfNj3oGloB1DBLZa/fBkG81QleM0p+B9WRWfnrEgmVw=;
        b=Ym5/32ydNJ60mY/WHhEyIHvNXXVcXDWr6PRsfNe5+FMM4xV1umy0+JhPxMrpwaMV+R
         umDrTX+0GCrK+RVTwAtgqYfZM6lNmfLhNFUbZbfcmytiMa5xVbViELGUBkGmxRVTcqEl
         75Iyt3PwIGrBtQiYQlP+woEuZ221tH0Rda5MzI/ZjfTtJRrrAFn7lBkKPE2uxhzPEDoP
         VABkqYiale3wDA3jvqKUE0SGrz2EADYnnqbduVEkd6c81Ktz4IH0tvEwcRPIDQF+3Ecq
         G1Z5lYtQn7VkkEGLsEB4yt7fhICBkic2Qo6rFn5t758pSFhg2pCeO2v8N/dmjCXvVWNX
         MGeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786100700; x=1786705500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lIbXpFTj/4jIXWlkQ6czPnMrtaq4DBoRJvyvQNnOL8U=;
        b=pjxPWYnvqtTgD9d6wWVRFzczQ0HU90bmwUNzz6V3qoHFdWhvDNqdIcqt4aumV7a+Vz
         ynvSJCrn9m84x6zFJZyvhogftq7+phyM95OuvpEtU2qkpKj7kPEih3S/+RYnfFGj3BU1
         W/nWHypHtGRi0DTYWBgICZTpnoeL16vWpvXyM9TuRVEx0bpiOQYIK5ivaCFomfsyb0fi
         UfS8Rg1DhD8emqjRIzTCVsREqyixDPcIP7Wsnv1v8cSePGDsjCfHW6U3EAcRzRuAep+y
         UFiJq119tIqdMpckQmV6ZnWkiPDlg6u9wP5hIv+gu+igMzzDIiu/clVD0koLGw9Q2mti
         RbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786100700; x=1786705500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lIbXpFTj/4jIXWlkQ6czPnMrtaq4DBoRJvyvQNnOL8U=;
        b=ErLIt01XI0iAyuGzlUsXZ4fJmXEvb/81h0mAE3IvCRz/5gqdsbXNOgA2zO/PwTQ9Uw
         VrWhTEzeqjHOhpd5IdlzQtYyhgQdLiMHpCTW5WXUSv6j163TZD5vbOxDJERv0TSIXNpM
         LmQ+RDEW/Tu8+LFgsaWscS8EO+RWt3vEZB5nbNhsJwH7t6bj8Sa/9FaQM7FEG5d8TFk2
         A6YVAbq5vk1mhhglNf9D3dvvcO13uhrjjNKOe+v/2WL6TkfDz0dIkVMnyVfxIaNZynv0
         KCbGMfkefYOLTLo4iqjijezZ7BLgM/CUZVQFLbaJFu9a21E2r0glk24CpYX1YwrSyGla
         fjHw==
X-Forwarded-Encrypted: i=1; AHgh+Rpm3WwxDPTE/+TghGMd6F4U2NXporodSlEFvG4ZN2ZpztaZlUqV1o+b0kdrV5NJxQwaQwfpzkZD5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKXhku3U1GpCSPBV6OrswazzSE39pzIWQ7qX0LQCg9ZMC0+peh
	tvshW6hGafMs6r5o+wVOk7pvcgHUXq3eF8wW8khrFGAZZW4eOy7IcXrdf8lyNPSwlOtcKrwBS2y
	80V+X/VUFC575MkRyyRJEDgNOeR7Kg1c=
X-Gm-Gg: AR+sD10PpQVHDqPVzPVm0bu4BuPuxe7FLHZB1vpuIXaFTwihmuI0DSDp9wEyp5ViIa2
	q+ZSFOpp0W67/4s3UElM2+C+I8XHiGlQQElsZlnhnaWtrZxU8qUIV+xGWWHBOQyyjUldH5chzJR
	tXXXKLrDaOSwe9WuJnipBl8lqZwk3Ot707+WkeVpmIW3f1uzk1B7cOcnVmuQt+3gW9aqTZ26gqB
	vXoJKWsV5UNQnbqYDmFsIV01/zBkOj5rAmilimmMwIQMoj/sITZVElx2y+HEji2Pd+dQpXpcRUZ
	jFciM1X1uTkWVgpCrVKu8AFt2ejo3fS6MsRS4Y9w1LxpOsQBUF2OP+4Mk7TRUlOysoncWFE0hU/
	CEeD2GfparNRJE+1IYi5MsdzJXwvVFCfkYJJs4nM5adrYEDPuDXb5fuMq
X-Received: by 2002:a05:6300:670b:b0:3c0:ac0f:6558 with SMTP id
 adf61e73a8af0-3cb85e99259mr26552578637.2.1786100700044; Fri, 07 Aug 2026
 04:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807093058.42840-1-phucduc.bui@gmail.com> <CAMuHMdWJ3W2JKmxaKaa-A-Zk633cf4UwbESi+F1_h4tX1AhRng@mail.gmail.com>
 <CAABR9nF7sAT4C+W_qE8GVKhrtTjdm=DcpJH548RzFaYLuED+3A@mail.gmail.com> <20260807103645.GE1316230@ragnatech.se>
In-Reply-To: <20260807103645.GE1316230@ragnatech.se>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 7 Aug 2026 18:04:48 +0700
X-Gm-Features: AUfX_myqnP9cM0o7YKZHIMOZ9idGY0mI36nu52n1v9bZ-QIC3TPihkA-_6FUpl4
Message-ID: <CAABR9nGAY6BjA2mRsv+2hkB1kv0QDJX6osXyEMw6jsjE+j2+vQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/drivers/rcar_gen3: Handle -ENXIO from
 optional IRQ lookup
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Markus Mayer <mmayer@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, rafael@kernel.org, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas S=C3=B6derlund,

Thank you for your feedback .

> > Regarding the caller, I only found rcar_gen3_thermal_request_irqs()
> > being called here:
> > https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/thermal/renesa=
s/rcar_gen3_thermal.c#L530
> > It does not appear to handle the error return there, so I don't think
> > the caller currently handles these failures explicitly.
>
> Yes it does. If it can't get the optional interrupts the driver does not
> support setting trip-points in hardware. No?
>

Yes, for -ENXIO, you're right.
The caller treats it as the absence of optional IRQs and disables
hardware trip-point support.
However, this also means that -EPROBE_DEFER, -EINVAL, and other errors
are currently treated the same way.
The caller does not distinguish these errors from -ENXIO, so the probe
continues instead of propagating the actual error.

I think the caller should distinguish -ENXIO from other errors:
keep the current behavior for -ENXIO, but propagate -EPROBE_DEFER,
-EINVAL, and other errors.

ret =3D rcar_gen3_thermal_request_irqs(priv, pdev);
if (ret =3D=3D -ENXIO) {
        priv->ops.set_trips =3D NULL;
} else if (ret) {
        return ret;
}

Best regards,
Phuc
