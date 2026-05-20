Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E303D47D7
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271711; cv=pass; b=LeJWRRMwt65X6fmFvtR2wB+jBReMu1G/O32oCUBhr/GLsnHChw4ydpBmH79r/cOWZkOevKOBY5d5vXvWdNaJhsjDWqQHqYFtIOzDqlklx0vyhAlok5tkjt7xwj5H/k+qjBW3aHXbnH4rsbkRSamDKqH9+j/HdWfM73uoLZTIi6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271711; c=relaxed/simple;
	bh=G+RHRcrQuLFJOdUiEpoIvt1xeUTHOJ2UQpik+JvScyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5FgI9udw37iI7SgeS2v3iBRl6pT5NWF6YTnyTVOioTEu1i4V0iiaQmkJY+u0PSiOkW2Qgexy//7SIfaW74yLTeKFVUr4wd+rb8GE03TypnJQRpBJiip3+GIHmBF0ZwY+oSe/v+pVu9zYg3nfe9nvpXJOq3xlm9yxC8PAaS2GJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2MIEFrA; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2MIEFrA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48e82c23840so37833125e9.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 03:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779271708; cv=none;
        d=google.com; s=arc-20240605;
        b=kdS6cwTYuH8Yq1hq54FOMM34C+14W/gWfupQU6v0cymFHlI67PJWlAHMohDTdpUWs+
         iqc8LS8zdnau+gWi86Md3lDCVw3tCPZ1fBIOnLh3y/fo9jQuX8DjVYi2KVXpLJM1PnXt
         ZK7TmpQHNdV24yHakOH7YwY2q16N+/m18cwxXo084DJIOYawV6H2IEFBmtLJ+f7yqlMJ
         VE0H7fPUAl+GMd2plU7c8eiIoRt39hJeaJbw5+nNAspBCMm3AsnRffJDsdMv6D+bW7od
         zCkqm9ml5c8DstgsGow6u84uJ0POAO2y9IFg4Idrte6EYxuIlkaiGIe4f2cmn+GXhf3S
         6+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G+RHRcrQuLFJOdUiEpoIvt1xeUTHOJ2UQpik+JvScyY=;
        fh=d28mqhTXeJE6sCGH5x4ANxInGMjlIlu9wQvUXQNHATo=;
        b=X3G/ApIEHfZP/fcPTXW5UV7viClAmilsVe8QPkTkBZ6TwpOQFGfEef8ZWxW3Lek0tQ
         a4cpi+Nc+N/kKtxzCyqxr09aO0BDKzafUSjghXXlyy7roIXI4g97YtKr3V8P5GWutmp6
         wYO6KeT72DULJA2cj0FayeWl6fU5NDVoitaUFcOtpQSTZ7fusuaCcDw05e6rDrGwqDQV
         NVhGXLJnO15LbF/SXJ4/H8j3/VLCdMtPc4kePKPpNDrS/e+Pg9cE9uXmBP1M1Ot/yh8Z
         7Ew0gNY6I/MgeA/0BHo8yTqCnd43lbu/kR/E4DM4mHtQ3QYxdzEqddS/3ZKzelX+uO8V
         41xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779271708; x=1779876508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+RHRcrQuLFJOdUiEpoIvt1xeUTHOJ2UQpik+JvScyY=;
        b=Q2MIEFrAQbSqJqOeC1pUR/7qbdysVtyiJSS42KbHnpcGErqnd7YaksP/y9CYWU4Wuo
         qZ7grI3vDGci4xophDFJYBDgPpnPnZpv5yH/ugQfrC1jQ5XSC7T26hhOet/qB85fh51a
         LflpkfDNc3nT/ouPKj/bp6wwuBlI3Iv8iTNqehFFe/Z+6DpxudXC9IykHkqhWNhzEzNF
         tp6ORol+yDmROwOrKinzloBDVkiz4MS8HvCUwFcSTn4uz/s4vLUNdyeAWE5IFQ9vl2J2
         LMpYPG/EV2yxoQEli2Q6HrDhU9ImEWkXpaUnId2XYqqbwWCZ5kO6zekN3nI0Fk2lR6Zd
         4U5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271708; x=1779876508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G+RHRcrQuLFJOdUiEpoIvt1xeUTHOJ2UQpik+JvScyY=;
        b=LygDmW1u6trqzJQKhgjJPYXdfE8eDdVDgLpxRYDXHh+7j+Qo9pJvWOrQygGbdpv6Lr
         C11KvTHIIBh0LxtYL1+OcM2DfNDL8lZp+U0svP35Pr3kL0PXe/p8D4gDLUWm33LxMKeG
         zW8aQymgwn0jLHzOHvgKL4DteW3kqY9SY8M60KM0WpV1MsUBqr3pj0PuWkGreXT5rSYc
         hF08abPmSGUgXayEOwRPVi/dvNLgswZu0UEK9jpex7ui11PEpCmsOkRUT/HqmcYgNZwS
         uVAdxXowwqy6jMJbdHPmajk5bAo/5UI55zwIkR0V1E7Bs3JL/UFNYQnTu3MFwDIIiFi6
         uOcA==
X-Forwarded-Encrypted: i=1; AFNElJ+Q9aHAh6RWQxYA5gLyW5sX30dAtr6ZekV6wwTNvCUGFsQ1a1mvVbKiSkIYgIFRVK2wrgPJ5CZELg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmBMsT3pn+tymNlhdnO8FkipuDjDBT5PhsArn+ZrjChClCrYlW
	caVaQ7wL3SXZkDC3u7bw38oet9pJVOg108EqXwjq5kZPEtbTenG2FQcFzAMJ1joSHhfEznfcGZe
	+TpEeOh0m+McEltyqpmckYhQ232mNjFo=
X-Gm-Gg: Acq92OFRrkAQQJv6/lnYV17rYeB3EI7a6PnCe5TOam7ezWsRlcHX0GZkvRy5unilQYm
	RXXbAwZmXqzxHCfWfus6rK7uhsQJDREJQjbsuVHJBfKeb68hi/rQHriBPLyXCUS1hAdZ5pqZPwC
	mJ7IfvToiYYLXu82l6A81W16OOv5GY39BKqrrt7jbnhSSY7hKBP8ghGJfSYwQ8EFmPpfPx0TvT8
	3mM8QeNVpR0LliVO3HKYmBsKGRW3AWeDmUE/YsaKmxP0P+SNnNh467nyBsFwCn/rTBNCB+WgmMC
	3cbXg1QXhUd2Sm1dXxT0eX2fPSRDvWmlSd01LZwhWV178fPsvaFR+t2j1hb+cDkVrVfiwA==
X-Received: by 2002:a05:600c:8189:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-48fe6323addmr339237555e9.21.1779271708314; Wed, 20 May 2026
 03:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520091638.68370-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXDdS1_69+36h=HRKGvbZQ9j8_ma_sFW=ajXy=sn1M2Cw@mail.gmail.com> <TY3PR01MB113460DF331AF8A6FF89FF37186012@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113460DF331AF8A6FF89FF37186012@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 20 May 2026 11:08:01 +0100
X-Gm-Features: AVHnY4IeMKd81qP5KY9sl61jzoiL_UHLXsJvDnEfRbh5YnW3GcVHa85CuOeui3w
Message-ID: <CA+V-a8un-MUoR9ak=a8XxUp=x8DOhjoVjuXCyd+XMsvK6VHw3Q@mail.gmail.com>
Subject: Re: [PATCH] thermal: renesas: rzg3e: Drop stale syscon documentation
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: geert <geert@linux-m68k.org>, John Madieu <john.madieu.xa@bp.renesas.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Wed, May 20, 2026 at 10:38=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.c=
om> wrote:
>
> Hi Geert,
>
> > -----Original Message-----
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 20 May 2026 10:24
> > Subject: Re: [PATCH] thermal: renesas: rzg3e: Drop stale syscon documen=
tation
> >
> > On Wed, 20 May 2026 at 11:16, Prabhakar <prabhakar.csengg@gmail.com> wr=
ote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Remove the stale kernel-doc description line for the 'syscon' member
> > > from struct rzg3e_thermal_priv.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> >
> > Fixes: c33edd8f936ccf2e ("thermal: renesas: rzg3e: make calibration val=
ue retrieval per-chip")
> >
> > If commit bf746e2a41efd986 ("thermal: renesas: rzg3e: Remove stale @tri=
m_offset kernel-doc entry")
> > would have had that Fixes-tag, perhaps it would have been noticed that =
that commit removed _two_
> > members?
>
> I posted a patch removing both the members, Somehow that patch missed fro=
m the thermal patchwork [1]
>
> [1] https://lore.kernel.org/all/20260208092848.5313-1-biju.das.jz@bp.rene=
sas.com/
>
Sorry I missed this. A partial change was already applied with commit
bf746e2a41efd986 ("thermal: renesas: rzg3e: Remove stale @trim_offset
kernel-doc entry"). You can take over this patch and send a v2.

Cheers,
Prabhakar
