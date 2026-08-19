Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A271C4399F2
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131288; cv=pass; b=bO98OUEKJdvDIFuCK2KUw1DCMJJvCNbDyfblLIIe3mafWqoxbMTLGzZKSlFIxQeM/4E0hIpQEF7TeRNmj7+8X9EC62FMwMd/fhbjifGDOOypmjxwNV9JFfuKjZOohyMPHhe7VLKuOLWlxCAj4GA/M9c3etSXPPZOvJxxHhfklTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131288; c=relaxed/simple;
	bh=SRKu1RMP8lCKPR+HYznxClqvbk9Ij8Tx9Yd8BcRgYPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpUE/jYpQSP/NzWSGdlAQx4QpqDNTBDsDhdgy2nT7jfSEZgCl/ZC5RXVDu9gvCsik9S1sk+2k5dcZ+jpl1Nuer1XPAbjLifP+oK2luIQ8T5PezRCvxjghlD6+NQmAnHw4y3CntqI1meI9S4nFuz4gudlCoqXHM4xA57EY18/Arc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dt9ETela; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt9ETela"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c197eaaab00so132804866b.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 02:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787131273; cv=none;
        d=google.com; s=arc-20260327;
        b=mkXY5e2EvUu5hjoVQ4rqLY0S7iBym7s4FWSkazR57px0plCrmzjzSmzkLDPslhmSod
         lNWlMH8DrBIcRyB7nUVSPXIhe1bKv1zpeCavgkZDD26Q2JGMFu0lQmaTpqrDo9YD31ej
         YrGMoWz5M+RA1xYg7ZegpibkhmAB3nDoPvp1fN8HO/hqCOZ+a70CTD28aYZBnpYFor4i
         MPqd0nbGy0cIq7tmV5aj/wTuxWMRh2MMTn4DyTV5Hsx1WX+uQ7au9m1xEcZLZuBCW8Dj
         D06M3PV32Bh868N5Z4WippWD8LjN7asdbbbmZdQmbd/htLBrd3KWVFdqcvJQ2BC2GZEp
         pBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vi8ghfGMWZmpwEtSeTZjCsYAT31WP+MRhmUIZU07Nc4=;
        fh=4NWzmZPiadmxwChOXePMx/a6tB08S8BwbfNvXYL7+m8=;
        b=mi0QnUZ1HWBnkIUWXIExwAmr23LL7MJBHGn1iAk8msk/7GZ/mf2fUtMAJpItkaUchk
         YLeD57iqzuCiC/ZL+nKn9C5PAfvhbvZWLGm2v9lMhXIDKfyHV3ICyCj0GCzZsA6JPro9
         zZEyp0SWXkgiIqMtwz242cLrXvSGXimkZbKyHzCXVM49tNVKgIghxmzxU+sQd+a3ZciM
         09lpepRhSHLukQ4h3muHoPpxBmia82ZslQKbqhiobqEkHu9E7WXJcuSPKIzxZQpwau1x
         2cNmeq4tinJoEfl/aitubWpDoT6Tfrs+FrlgRA/FZlTmROcFPd3ZQ3KXb9cEBPalJBxl
         Cjrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787131273; x=1787736073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vi8ghfGMWZmpwEtSeTZjCsYAT31WP+MRhmUIZU07Nc4=;
        b=dt9ETelalYwPNHWrr7GzEURejWE6D9Ja4V/si2XFpml/u2fYfMjWLEllo50zrCZBvN
         GjhrV2jBxWSVkgg0y7IWniXkxNgRpoGLtAuWNG9vY0NXblDMu/xsECF6ohQjMA/GZmUX
         SDLHUkXwJlrxtTgnIK2+ZGwxCPKx60I2SjL5TptNpgGGPK3quZccmkaaG7DdG/mYeMDX
         yTx8JkK3Yzg582kqwzWTk+5j7Syvgwu+Ig0VMuknW0Sc9FeWFFBk2kMEr3PjDPgCJIdB
         Ih4uEmuYPJmCAIOsBWZ6WSGUMQw/kTRfkcwI0qnG/k0dvaPCTGw6c7JSqfFbeC1MphA/
         m39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787131273; x=1787736073;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vi8ghfGMWZmpwEtSeTZjCsYAT31WP+MRhmUIZU07Nc4=;
        b=fhvNCnrm8OUF4h9o7G/8O0MrLX11zPICCXBLZAErdPl8a7TMtWGmjQyTzkPCQdEK3H
         KF4NWH+Ll9xY3LgJjSM4Jd6eYmTdyGJbq2lNR42WvZmV3WSJMgr+ClI0EKigcF8k5q7U
         ZTTcXNrCZyBLzwrCnetJOMAi5ch6ppSWZ1751b9fsR2olcE4M5JrNqGBbssH3yTRlaqe
         5N9636UOWUAeSAo/u7333fZ3nGH7Pad/r7rEtzVDVcgMMutijWV+NuRyNsB1rqOVmWDN
         +6wSkussDij91IKGF/Q7a05Kjr19SgBM2Y7kNuScVYpyJOTCHDNpfNGxFBW4C2AqjI8x
         fFGw==
X-Forwarded-Encrypted: i=1; AHgh+RqUF7YzAeBKW17ddjNhbrbFaZgp8kzCzC35/gQjm+0gepalOubdAvYchy7mweaoX66y9GylWPS/Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLu5G4XW/UyuJTmfEb4nsL9F/2RPcpUB7cMzIxdb5rMB4/Xdjn
	K/tCR2fnLdrEtzmNPNVPjWakuDZ8UQAb1ldTLp1TlFMzS0nbsi3FiIZWZDouR86CVbqpGLoMntw
	rZGEZmL1RFURH4/YHQnROLaKmOsof2Zo=
X-Gm-Gg: AR+sD13xy3V/LQGeyO/aJkmEv4r2cCq7PvcEJvFrg9U+QHi9UhkoZhqthiMVJeE0hFh
	F5/Td5OS/6yBnJb1WSNdhBjv4ddYO29rAYWaEt4xayB3SAlIKgd9cqY5k2HTGWED2F1raPikG2z
	p0B/kMGPmPrcnJRt8WsE2dZGXSbDdg8dIVMtDxFwEJL03AVNrFo7EjfZOSDLgxlIGeFKXLadS+G
	kbQay+TEGWJ0zLUaPxdbDZZr6vNcBk8UNbE8l2NP+YW1hyk2VxriMYK63OwrgK9HjPXr9SwH0ZA
	aqpHpccwkbiCEte9d5uWlL5t4Uhwe5dLcS5+z5QYXajOZJVli3juQtCBND8/HAtFT75P7zF4NJE
	DlQ==
X-Received: by 2002:a17:907:c16:b0:c1f:bda0:a771 with SMTP id
 a640c23a62f3a-c242e22d850mr188578366b.13.1787131272600; Wed, 19 Aug 2026
 02:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095233.420823-1-clamor95@gmail.com> <20260721095233.420823-5-clamor95@gmail.com>
In-Reply-To: <20260721095233.420823-5-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 19 Aug 2026 12:20:59 +0300
X-Gm-Features: AcwNN1VQ1pRWSA2IPSzjj2VjuH6jUfN6i7gcHLhHAkq5FyaNBjl025TKLUB959w
Message-ID: <CAPVz0n2rhZk0fjM06u=C5H4LgVOsN6ACriO1o+byx0dyqTwGzQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Svyatoslav Ryhel <clamor95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 21 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:53 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>
> Add support for multimedia top button row of ASUS Transformer's Mobile
> Dock keyboard. Driver is made that function keys (F1-F12) are used by
> default which suits average Linux use better and with pressing
> ScreenLock + AltGr function keys layout is switched to multimedia keys.
> Only Dock keyboard input events are tracked for AltGr pressing.
>
> Co-developed-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/input/keyboard/Kconfig                |  10 +
>  drivers/input/keyboard/Makefile               |   1 +
>  .../input/keyboard/asus-transformer-ec-keys.c | 310 ++++++++++++++++++
>  3 files changed, 321 insertions(+)
>  create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
>

Hello Dmitry!

May you please take a look? ATM only ACK on input patches left.

Thank you!
