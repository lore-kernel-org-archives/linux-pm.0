Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88FB26ED41
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 04:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784177954; cv=pass; b=ZglW/4NrMIatMa30K5kmb+U01EDq6Qn45cLd43Z3szHqU8kBjsHvsJLD9NyO6In/UT+qwlfkK40Ef4nYX3JoFr5nTvI+b5Mr6yZBh5H04ugPB+qDjhai0jcJRogTBvbjEMsQpWJh1MB85Ayg/NntGLSjrcWAlmueTpPZUPNYBgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784177954; c=relaxed/simple;
	bh=wYBaQ8XwVTIMSwIIpuk8mhwuYTe+2pxVToi3w/umSE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAqWWeAxCzMH0Uxs6OeZ87dLH23ybMCarSHkpi71A5il3fLXCUwRo8kOeEZl7r0ZgjenjqNUE2IgRkqmm59FmLPmW1A/V1BUpug96/0RLlTs5q2lufaGkxHaH47zB8dRn7/0bzRGiDq/pjpXyqiIdeOh6itv3x++dXNPY4/6rAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lORVSP9i; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lORVSP9i"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6682259cb3dso401491d50.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 21:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784177952; cv=none;
        d=google.com; s=arc-20260327;
        b=AUxcU6Uyb17AGg2/rme1mjYq5P0Mf7dR0fQRBsjZJNHiaT6cuxnkG0v5DTNalCOACg
         ro+ZFV7e61K7UmIDf9jYwZxYC4W62wqO+VwZQXqcI8CL/WZZyGCc2c11GXMBnSicxvss
         kjeM3qmTuhuFt382TN0B982sxH1wnnyL1T0xVmxJLYouIH02SiwdKe+DWsxD6mdjo662
         9/mXKnGMVj2Msx9EkqXtXMsqyUDGyItINvOqdHqZ56bUrDuMMItjd1OF4aba24v9u7C5
         Y5c/kwLYx7Ho2sS6RYuuv4rGxsVhNjoPLQLgCFJICEYnUCGGoIsEL0T2ijIryKpZ5/EX
         H4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z8dI52NQd5mdA4AuWKzP1mtoK+n7nzP2uY77NXwFDCM=;
        fh=2+d2sgOTnlB8J+wg27PSZACe4sekcdcYv/mO/xGJeJc=;
        b=MhBokNz4xj5V8PaP7exCnFKQcW09JDlDAHd6aY6RqTwINFK1RJI//ZZvug6keLyDaW
         J2B1LR3ieOjGT2ILbyHvcTXhast65jBg/JxxlHL0Z4NmlPbb9Rydt3CqjPsLh218OMKA
         cksHIkDArYGNRqFtfftgjRK2vk/mWtylWcaL93ZfeOnwg2awjsXeP4cZu0jGca/H8mbB
         K/+DQctOb9ZzQZP3H3XmKbA6h4df//O/oQhIN5e/gypZ55vpjf+z3c7nlWqNml98GT7e
         WS46dlCvTv3L5ANbOAL+q6JIvu34Xrkxob/LoVSym83mZBOVo2aKBTt8CdUsKOHXsAh0
         Zq5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784177952; x=1784782752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z8dI52NQd5mdA4AuWKzP1mtoK+n7nzP2uY77NXwFDCM=;
        b=lORVSP9ifVJ5Czr3v+5Isv3jhIIjZBkC9sryjLysjdwkMBfxclWDa71JGfz8pk6Qnj
         /40j8/WK/P7lXw/XIIdMVyklagrk3ZN7bs2reZkWjyVV3khmc0R7jzM/2S4AIymnmSci
         f7WcILaqA3AQ9U6ita7v/9x/Lu54P3lIoVsus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784177952; x=1784782752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8dI52NQd5mdA4AuWKzP1mtoK+n7nzP2uY77NXwFDCM=;
        b=PlhC8LYK0BBr74OMbm/KJ+xBsmEo9D/M3XJbMVBmbzmFPJ3FS680vow2wPsZ4DI7Bk
         xZasOW+VOjVwj3bBhbFtEEv1vKJPCd/67YyFpaTYer2QXz2R5XfOxM20PjCv0PFLOdEv
         BQ4/SdIne+Opr9sk7lypVPDCg5D0Zbl4lRnvJFvYGuJhHuDwTzIi1P9s91uWBfsEva0E
         15AF4LoZyjzVTX40sI4o/gikaz1sO3wHo0kJIDWNrNGn7XK2iNHIzo2O15KSs3s7HCoZ
         ymXMittZU2jRbSH8mVm+E/TX1o9WC/AUnUb/AOyBcwnQoq6e8iv7ma8HmMa74wbprv3A
         oj5g==
X-Forwarded-Encrypted: i=1; AHgh+Rqm2QHh5MDGdNnDdkwbeZ2j8EJK2Ur6P8PayNeLz9uDsGj7qNrR4Exmph4499FF65zRbTPotaAPmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcGorOfr/Sy95FBw0RWUSqWJcJGode4tLkHZ8uMM77dxAep1KU
	ZC9HQquvu7RSJK66jjbTwqK04fez00/+rH7uTefsw/3tMfs8xAGsdQTnRTAvtuOt0VKluT86ZCU
	0+azjpd2xWv5iFDP2fFW5sQ8sN5ELvDmWpJ4kcYKC
X-Gm-Gg: AfdE7ck6kGvsV0FjySx32sBuyNWyZs6ptJ0DVIYVuCpYcnNVd2M+1V1S2FVKogY+0jO
	loVTbxdxtQrcHYrPjxLKZxBtMs/vdvueO/5LFqZ52nc3ZDbV2dBwPYfNjbk3LXCsfopDG/t6KDC
	pdoEAIFUHJZ2QxXzIpMNM277nxkNiLV6HKxLfeoNWRQAG0HYR07gC8kWeioFBDWXSEN7b1v4Eoc
	d7XJjxfR6WyltBN/1Z/FnqOXpcZVuPS992C92F3H6P8weTBF8Ot19rSndMwYDcBWu8i1pFBqam9
	bpzUA8Ro5VTfd3ec
X-Received: by 2002:a53:b784:0:b0:664:b559:d524 with SMTP id
 956f58d0204a3-66829f39e58mr611543d50.4.1784177951944; Wed, 15 Jul 2026
 21:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715085348.3457359-1-wenst@chromium.org> <20260715085348.3457359-4-wenst@chromium.org>
 <aldS3qTympJuVXYj@ashevche-desk.local> <CAMRc=MfHmejks83bPfe3fKzAzFySGXk2GHMA9oZdMQj0f44eTA@mail.gmail.com>
In-Reply-To: <CAMRc=MfHmejks83bPfe3fKzAzFySGXk2GHMA9oZdMQj0f44eTA@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 16 Jul 2026 12:59:01 +0800
X-Gm-Features: AUfX_myfMUyRbxWwYQRsbuThILT6idiwmNtqsd830qG3sUgPLjemD-RPoobAiuo
Message-ID: <CAGXv+5HGjGTrqqzJrpiQhLrCn3C6H20LXq3niPnoujQLOwgqPw@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] power: sequencing: Add pwrseq_power_is_on()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 8:10=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Wed, 15 Jul 2026 11:29:02 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Wed, Jul 15, 2026 at 04:53:33PM +0800, Chen-Yu Tsai wrote:
> >> The power sequencing consumer API already does power on state tracking
> >> internally. Expose the state to consumers through pwrseq_power_is_on()
> >> so that they don't have to reimplement it locally.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > ...
> >
> >> +/**
> >> + * pwrseq_power_is_on() - Queries the last requested state of the pow=
er sequencer.
> >> + * @desc: Descriptor referencing the power sequencer.
> >> + *
> >> + * This returns the last requested state of the power sequencer.
> >> + *
> >> + * Returns:
> >> + * On success, 1 for on or desc is NULL (optional) and 0 for off;
> >> + * negative error number on failure.
> >
> > I would rephrase it a bit.
> >
> >  * On success, 1 for on and 0 for off; negative error number on failure=
.
> >  * If desc is NULL (means optional) return 1.
> >
> > And this rises a question: why 1? Shouldn't it be some "unknown" state?
> > (But since Bart Acked this, this doesn't prevent the patch to go, you
> >  got my tag above.)
> >
>
> No, this is good feedback. Maybe we should prefer an enum like so:
>
> enum pwrseq_state {
>         PWRSEQ_POWER_UNKNOWN,
>         PWRSEQ_POWER_ON,
>         PWRSEQ_POWER_OFF
> };

Well I think the crux of it is whether the API considers the descriptor
optional. The power on/off functions suggest that is the case.

I modeled this on reset_control_status(). I believe the rationale is that
if the reset control or pwrseq is optional, then either there is some
other mechanism to deal with the reset (GPIO) or pwrseq (GPIO + regulator),
or it's always on and operational.

In such cases and the rare case where one has to query the state, the
queries are possibly chained together and I think it makes sense to
assume the "operational" state as the fallback.

If this returns an enum, then I think the previous approach of returning
an error value for an invalid descriptor is better. One doesn't need to
learn a new set of return values.

I'm fine either way. I would just move the checks over to the consumer
side. But I think the principles guiding the overall API design is
something you need to provide:

  - Is the descriptor optional? What should the action functions
    (power on / off , or query status) return when NULL is given?
  - Is the subsystem optional? Should the stub functions besides
    pwrseq_get() return 0 instead of -ENOSYS?

Right now the API feels like the descriptor is optional but the
subsystem is not. One has to add IS_ENABLED(CONFIG_POWER_SEQUENCING)
around the consumer API to make it an optional feature.


Thanks
ChenYu
