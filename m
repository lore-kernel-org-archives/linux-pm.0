Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E2F31DDBF
	for <linux-pm@vger.kernel.org>; Sun,  6 Sep 2026 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715358; cv=pass; b=PDRc+Pifiw8jtCqZn0MWEIHO7xnZWv15vfOAXhPtq2+6OhPADTiB53/Z9csE9M80l88fWllSN8pnwrl8OyB7r0FX6Q/1bb0ieLLHzJaEPF4c7anp1xhcBnWeIeip5siNM2YTG04MPhQYtdnz4rhCwSpqcfpHer7Vei9+LLmIS8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715358; c=relaxed/simple;
	bh=xlfHTmswkSpLXO/4f4jYBhuVejOLiGyJyM/ej83cLuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BElwTHOwxssmgY8w6tixMZzIC7RG4sj+pSILJn8Hb9WTadPdz9ZShPpjE7ctSSpAM0d0yeSOeVIJoNar4NsQ2zIl7jxzRQFh/vjXe3Q+UXJ6PAO7Pd3fwCAb1hdeqdMmoE8Om8loZ0BZ/Z9nNvRGc19gVOmla33LcbWndF0tc0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTvN/LN1; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTvN/LN1"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9e7391839cso2906650a12.0
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 10:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788715355; cv=none;
        d=google.com; s=arc-20260327;
        b=TLDyBqyOpRH4w3sZsteAhuDzrFEcLP+igBING+s1SeqQsxzJDM98032Qs1ic8bNeV6
         bFDetK2hGIwpBRgo2RvEmqKRiHI31gcTjAgqAEO2efM0Z9Bk1lROkj18ipHiCpoWgV44
         27+BK1M3Kf9rTQok2ZVuyM2tyJc5vw8iBEwl5OshoX1/sJauplM2T9ApE/Dha810q8Nu
         RsP2AiWNMY2Wz6zttH7tGlAlPJzLzFDgK+AgIW+ae+oS3urVp5e8vRgNQtMxuLGbM6H2
         9QTTHkGY8Ao1VpVccHn+Nb8oGAgN2tYVOxx/9A5IizDupz1GLne+0WvThjrWroNIH8rJ
         K98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F+vIa+Qy5L/8ukG4yH01NZv4BrUlQHr2FP5xxn3kwXw=;
        fh=OhIHx7IRao+34N2sot/scr6n0hPjictnKuNySPwY4Mk=;
        b=BbncQ3x9IyIEDRdiIJvKAUVWmf59a3jhKJbpNsG2U3ViJsbqTvAo4vG2cCV46w7PW0
         ueF3pTScjfdA/P0qAWY9JUVAkcty5mSc1BNybQC/rjooRBkSpX/Xx/GWqm333OPXRYFL
         Bii8BG108cKxpUrN51N7foGdEAsk3N/shVNWcbpWP0DGXt/xbA6jHJ/xxTBgYIll5HVo
         921evRVsEcj8zlnHE+j6Z2txwytbMPc+JgWnbgqcQUAtvcDxFC6STSTFXvS+WgbC2dOQ
         oal6gTFO6Ed8F7xWcCgbJr7B2mFlHNTcBDZJcucqyh7BTUWDL2SMy952TYHkySIo5iST
         05VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788715355; x=1789320155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F+vIa+Qy5L/8ukG4yH01NZv4BrUlQHr2FP5xxn3kwXw=;
        b=DTvN/LN1EdaERFqCd/Pf18xk3C2W9zOejXGnr4Zon7F3zor5rZQ344+GQ1BawH8Yia
         oxrLD6jEEaJ3VX4H9A0LkI7AjDZUBT/QzS5oBGB1SLqzR9dFcpoQQwfqMFrTwPEZaB1P
         0m3rvOHTFdLh9lLU4yfbJxyweFX42h5JIcRnl9ozmPY9sAFcxuGYjAFBsARs2CATPDls
         EhZJEkWhdvjriIJ3fwyBDu21MkwGTZDYmGjDktjCV4tKkevbckt6Pii2RruUjekLWGsV
         lYM1DxyvWC7EKZK+Cm7hvHm3hx8cVCRAWMfHElaWUrYSGogaVhj9sxCmEemyKJdrhxYS
         hjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788715355; x=1789320155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+vIa+Qy5L/8ukG4yH01NZv4BrUlQHr2FP5xxn3kwXw=;
        b=F69KHwhxHCa98seHbk1iyEWTkjjy2JSV4zXYa/SHSF1h+tuhQfhqNp+3Gxcm5TRewV
         ezGHVI26qqWR+mmhpVRtF2byVAYJiY3W72NqtCIhsHCu+0PdnkJ11eIGPtjcr/mHK46n
         mY/nyBjL45czh48N/1jbUEl2LYwgw9yNJ7hvBusu8ocAwPNUlYPLehVMetm40QTnmnv6
         ekjnB4gAVJmpgWF7UP2p9Q2+kN8IMf8xmTFwas04QvgAGhj++GPzIRWUVi6KuFZbscsA
         FLgyn07GTgCDSPtf96xcsO6YD0M8ScIT0z6mMjaJw/car9FbE1xCyBChG8lnU0GK/H4R
         voQA==
X-Forwarded-Encrypted: i=1; AKwUvBzKSnllbYqtUVUPS5N4WBnr7R3oWKG6UHXdVMCRSvJh75pyA5iJk9h6TR352OL7O0XjbvWnxCkD2g==@vger.kernel.org
X-Gm-Message-State: AFuF++kIBIAADIj3D9U/IqvqFyguur43EM55O2kqsvN2VJgGPKQwX5B9
	e/nwOajasEjL0V2DIgVJdrKJmIqZujYdacJi2BgdCJ2/pDXU6kxvqGTEIV8V/vEsmCzmKbtQhYG
	S5wd5ggCXknmBaAKlLyLjEEK8Q1SxBv4=
X-Gm-Gg: AYBFou0OLuXoCZHGc8lHgcwDufR3jn78ZCwttx4c2kEX7Ql1uCeKsgYwSzBFaj3pVJD
	nOTRvKAXi5FxLqUMRc4bBSAPihoQv+jwgCE03VULGKOuf7UmyCGYsrDfbNlDcFDbdShcU61stJM
	LwkBp9fB28xqGx5rzjgzdTcCKOPJl1fW3+mzzU7KFzNr3gdJC8TxPKKIcGbXskfHqzv7P177GMb
	QaRmOjG0PvBIhHGRMIZ12KQZeJejNX0ZHsEbtzfUexCUh40orrn2qj7U7lr9wTfePis1/cWIMIc
	Ufc/pnYW29/1qC2NXDn7JK5tJkjCZ0IzNNt6CXWt4CvkAg+rOlKPyqhUcQIoeIPedUKhDX7zs3d
	5LQ==
X-Received: by 2002:a05:6a20:e607:b0:3d3:ae50:97c6 with SMTP id
 adf61e73a8af0-3da3a154de6mr29258954637.19.1788715355297; Sun, 06 Sep 2026
 10:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095233.420823-1-clamor95@gmail.com> <20260721095233.420823-5-clamor95@gmail.com>
 <CAPVz0n2rhZk0fjM06u=C5H4LgVOsN6ACriO1o+byx0dyqTwGzQ@mail.gmail.com>
In-Reply-To: <CAPVz0n2rhZk0fjM06u=C5H4LgVOsN6ACriO1o+byx0dyqTwGzQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 6 Sep 2026 20:22:23 +0300
X-Gm-Features: AcwNN1XDTtBNxGlzLOpLQ3w1y2Et6HgHVsvlBacLuEsWHZNblAyHEWGt7R_cBqA
Message-ID: <CAPVz0n2mzwp-ffUu7tw5ojXgM=+G-PT3V9pHN--dT=dnYw5hHw@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 19 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:2=
0 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=B2=D1=82, 21 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:53 Sv=
yatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > Add support for multimedia top button row of ASUS Transformer's Mobile
> > Dock keyboard. Driver is made that function keys (F1-F12) are used by
> > default which suits average Linux use better and with pressing
> > ScreenLock + AltGr function keys layout is switched to multimedia keys.
> > Only Dock keyboard input events are tracked for AltGr pressing.
> >
> > Co-developed-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/input/keyboard/Kconfig                |  10 +
> >  drivers/input/keyboard/Makefile               |   1 +
> >  .../input/keyboard/asus-transformer-ec-keys.c | 310 ++++++++++++++++++
> >  3 files changed, 321 insertions(+)
> >  create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
> >
>
> Hello Dmitry!
>
> May you please take a look? ATM only ACK on input patches left.
>
> Thank you!

Hello Dmitry!

May you please take a look? ATM only ACK on input patches left. I
would like this patch set to move forward.

Thank you!
