Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795494050;
	b=lM6pv/HVydAfiUX/eWUvgEb3GmWYjJFcW0b1NcYTSdR+J50d9rnT6Neo06ABnNzb8O4o
	 FJi0mqCK6CeXatLmeFaetNn8t30bjjSirUQORTimJmhZI+hg3dMgE9ccKggyRoe0HpjKB
	 e6V+ecFwDpGAEdU7vKJbl0E+JxtKFd1S48HL5mtYz3InNFF4Un7cIayCksO/qn21F6m5R
	 Xqv/1IV/JLL4J6KUQJXpMW/muqltx2PAV77LnANtkM5iWlN/IHrMoqLZp7nOXj42tVR8C
	 zexl0SNheBU1PZN9Zx2lXL27Fe4Z5/boYiKguWj4QNdKNHeGj2F6K+HIAujMjyD/hcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=Iwz99gTCxCIUCcRsgbRPplQdxHuMdIk+bgQDXj94h8k=;
	b=uhY0ZMXyd08qB2J3Ig1PSYcp5GuPS5DVI+8PsOYlfb9LSMN5Xf0m2bOMGZEcAGFdiW4b
	 S5UlCZDwb5ISpgSYbG6SPN64Khb6hjkgk2rZ0Yr67BiJCEo4hENlA9jve5NylI0YmenLT
	 OWwJv8oxIPLirhDB4ahfBJo7Zm6vqQK9B4OMParIikVQrCyBqZQcMg5E57oLpm0SJNvar
	 hdVN519fQzBymI5Ry6lxcyTziJtl4VzD6BxFnvGxNfaAiV0FdCNhV56HhQe6El5a4zHm6
	 B2QygGx4ArHYOH1/Orl/ue5V8rnYTf6Is0nBaPZUqeYGoc42IUo68B9dDoxUqjBVlng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LngA7yn+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E993606A321
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 04:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E993606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LngA7yn+
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ba12b00c76so4187301a12.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 20:20:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795494047; cv=none;
        d=google.com; s=arc-20260327;
        b=pOaqPK+SRTAoIJS5yCYNDdeTI46FSlz8rKHZ8Eo/Tg0X/pSg/qSgI4ixIC7J22uSbm
         bMA2oogAyswQAUbHU9eKW9qFkh99Agm/Z7SCuX3cUpTtZTZD8nC14IDopWovee/Ba6Bx
         4C/AiELrDlu2RbpFIoQhz3x0egyxQ06j390KpNzparMkVcP3Zct8+zVa2/MHJqCcFylz
         l+uF4lTNF9AaK83JjkVJ9ebyi3el3HPQqBsjFX0MJWC8txFWiUB93/wpnAYlj8LBwIAC
         fQc6V04haEXSfdsqePG56ViNko8MFhSOqGi+GjRql2YGO3qC8QhMzISCIDOd2dUcejxu
         WyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=Iwz99gTCxCIUCcRsgbRPplQdxHuMdIk+bgQDXj94h8k=;
        fh=L0GU8zPW8Fnn/zOti2OMPR4/BITwD2+wkZ45m7dUzqM=;
        b=cOV43TZMBArzMvf7D/VJ7v+uTDfVGctlhRNczya3pRmwMDQGBd2Gx048K5myiwC14Y
         sY8w4Z4NIt3KWWk/RyUibJ42koZovrz+R4nmkHdsWVL1jEtB82rmzoEWqmTfwCQa1K11
         oKLXOVGYrwcuG3pevt8kIaNO1aIKTmBu4EnpL2arC5hiSsP1xQDDSW5alSRFhBFNXpl/
         vMEUO6eCeY3q2newpOuJIJF80MZgC/sbdOEkqbp5GhE7E7b5dBlVFao+ui50N4ybao7d
         pyy9B+7i1l8vaIQZAOIVo4H5pngU6FPl59agbvcxmBUd61eJhO3u5OHg6nlnqTejDzh3
         Z56Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795494047; x=1796098847; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iwz99gTCxCIUCcRsgbRPplQdxHuMdIk+bgQDXj94h8k=;
        b=LngA7yn+TYj3oBq32jsDML3Wtm1oLrVRjkDolfkMT1Oz7Qj+6OuF3gfr65+3X4izA5
         Y11HGSqlPp5/pQ8gk5fHZAUH95KMDhMm9TtyIWpaPzHIKc8uirsZmilPhpVqOO+DaHuY
         2Y2wGIOE/s59Td8aJONIlq6OE+j+tHh2gzIglSCjjgBI4WKEooJvAEXqT4JksOKevaNP
         37m32naJDe/zEuog+obxzxCI+SFVsDI26JPSx/HNztwYEMrKi34wXl/n2ghjLzxCC2Dj
         qk5XXenBf3Qs41nOUSPrbXNUT+mfMB32+2o648Nw0cq4+CJaibNaJf5NbvFEjNyCuxdb
         h5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795494047; x=1796098847;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iwz99gTCxCIUCcRsgbRPplQdxHuMdIk+bgQDXj94h8k=;
        b=VvoT7Jr8kH44KtJtZ5exiEwVluKBHyX9MMeRHMM4ThkFdILguggCBRM2DvRWWzoC4w
         YSEao/a+Xc7mb1kMixoxxdVmZNL73ISI2j8q7FnsjAHLNCqxc3bA+CaLw5ByXAea2SFS
         OIsXRzMYwDnfjy7n7bBSxcxKGELt6BNHpAIXLh87MNrexmS7ToOmONVQwjQmTraldRLZ
         1D7I7J+rzTanPywlKIpBEgX0iSUqNxUAOsaWBvIX0si2f/OXa1ixXzQkAnWBsM4EoEZ8
         B/bfi/fhDeYYOzKUGnuxV0zcg4wk5rXTuuSCxywqrUq2f2JiQgppfCk4om2oB8T/pSaE
         1gvQ==
X-Forwarded-Encrypted: i=1; AL+hErE/bKq6ulTgHUmDkV+AVTB2Y2Rkq85khk03E1mPvPmrC9jBmFJitY6na2YXIC+JfxMZuATII27bfQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/g4d5L5fVRaBe0lZZZNu3aOiHafp8cEWGpBYtEoWMdnvPlTjiu
	V9mxWKB+4Y/HlFm+hVJLX1qVJkN3HwYLeQ06QtMlld9FBnbRPVm1S1j6fa5RgoOLN2oUm6ZNQVQ
	WJMEh6OsOMA0UlX+BKUJ8Vq6kcDxe7Dg=
X-Gm-Gg: AZFdTZfALKIyP8c86vRfi+wqyuPC9BXOdSC1TIK6cBaxKn81MwyTqM1TeptQVq+TI2i
	9cMcmNbxc1AaZI9VvN48YsmukS7C9PDm81Y4+3ag4GQriaJ6gPTA46w21rz54YkBYQVNVvWnEFv
	XOjBI21Teqypqyqy+0veFMhVF9D/BG0mwoeTPTQSO+IrtZDQll9qysDKcNqpjE9ATX/T0jrCWC3
	9BTNx7he7NHz8NbiOsM2FX7W2guBf+IP2zPoGYG4UsKA4ASqHpnE9TqZo71RAHKjajknArIGhBf
	4EdGcnSMixDA9SIHJ96ObFcdV4hT8AXOfz/NKlVBEKdZCobtNizHM2KoLdzasKyEbynk/qyMb/Q
	AvJ9XNcyTQaqSyJALuokITfqy3g081eXQVR4=
X-Received: by 2002:a05:6402:234a:b0:6ba:7762:3dc6 with SMTP id
 4fb4d7f45d1cf-6ba7762424cmr5526320a12.31.1795494047241; Mon, 23 Nov 2026
 20:20:47 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118104935.1716-1-linux.amoon@gmail.com> <20261118104935.1716-3-linux.amoon@gmail.com>
 <awS84s2FVdzy3j4Y@aurel32.net>
In-Reply-To: <awS84s2FVdzy3j4Y@aurel32.net>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 24 Nov 2026 09:50:34 +0530
X-Gm-Features: Aa3M54o2V3tALqDtTk5FmFGSg-XejOz73sQbTVaEuMBBmEBfiB2hu2jposXV5Ww
Message-ID: <CANAwSgQXRojN2x4NypLajJ8tUf2cyNfdfFLnaOFPd1hXuOMkJA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] power: reset: Remove SpacemiT P1 reboot driver
To: Anand Moon <linux.amoon@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, 
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Aurelien,

Thanks for your review comments.

On Tue, 24 Nov 2026 at 03:53, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> Hi Anand,
>
> On 2026-11-18 16:19, Anand Moon wrote:
> > The SpacemiT P1 reboot driver uses I2C-backed regmap operations to
> > request system shutdown and restart through the PMIC.
> >
> > The system-off handlers run in atomic context, where regmap operations
> > may sleep. This can trigger invalid wait context and
> > scheduling-while-atomic warnings during shutdown or restart.
> >
> > On SpacemiT K1 platforms, system poweroff and restart are handled by
> > OpenSBI through the SBI System Reset (SRST) extension. The Linux PMIC
> > reboot driver duplicates this firmware functionality and is no longer
> > needed.
> >
> > Remove the driver along with its Kconfig and Makefile entries.
> > The P1 MFD driver and its other functionality remain unaffected.
> >
> > Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > New patch
> > ---
> >  drivers/power/reset/Kconfig              |  9 ---
> >  drivers/power/reset/Makefile             |  1 -
> >  drivers/power/reset/spacemit-p1-reboot.c | 87 ------------------------
> >  3 files changed, 97 deletions(-)
> >  delete mode 100644 drivers/power/reset/spacemit-p1-reboot.c
>
> The patch is correct, but you might also want to remove the
> spacemit-p1-reboot entry from drivers/mfd/simple-mfd-i2c.c.
>
> Anyway, while I support removing this driver on the long term, it might
> be a bit early to remove it. Indeed, while the driver is available in
> OpenSBI 1.9, using this version requires either patch the vendor U-Boot
> or using the upstream U-Boot which still has some limitations (thanks
> for your efforts improving it).
>
> At the end with your patch 2, keeping this driver a bit longer doesn't
> hurt, as it is only used as a fallback if the SBI SRST extension is not
> available.
>
Ok I have no issue keeping this as a fallback driver.
> Regards
> Aurelien
>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net

Thanks
-Anand
