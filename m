Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944FA34AAE9
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591138; cv=pass; b=AGM1nUhhsX1O76IwTz5YgTVxt2BC2GLnDsfPNKZJHQtbssBMjjW5wMEEdJsGPCUnwddHalw8NofXR6sV6553/W2HLZI0iSUJrjDeqxn0KeIN03GgY/Mtn4GUNxz5b1CiVRHm2s7MlmEN7cBzlraVrZX1sen4SiGLfevh5LQBGys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591138; c=relaxed/simple;
	bh=YZplQ6Ddkpj2GJX3+/D7fSo3HWc2/s74s4mdCUpbfxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sydOxfPEQh6o2n5dL5kG1oSlnMSPoxhILCL9mlNai+OSuFi5ZEhydq2vxjXIbAGZ6Og2+udJKSr7IObafF2nmCN38XM3LXm0uLKJdcvZ+wBF2W+9pRe/16+DsOg6gSbFzwhi8CbD5+Q5Rk0FJ2NKG2NEbquHVEG2xv7Y1RkDbS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9ppV8ZT; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9ppV8ZT"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304f590dd91so4773912eec.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 23:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781591137; cv=none;
        d=google.com; s=arc-20240605;
        b=CamoDrLGheywhTPbW2aexFHLU5zQNZ5wfXj3CS6Lv/SKDTRpWKXExmWmg8XvfZMlSX
         SJ3KOpIivBrfAFvqqNypSI9jBFueY5zSkbFPcECFrN3R5LO1MWdaoz+Az7Xl0QZy3X+D
         li/ltRxASy4UVwXmkGXiTfbtkrGyuNL+OKGOhD5I0+fIB8mezVCy9M3huqg/ITt9nRwx
         /xLh9ZcfqA56/89WNKtI9rlKBg1A6pu0VPpr7R1ZZsArWkPP+mc0S4wEb2BDByBJYxqA
         ASnFiZQ7GvWq1HlOMjioy+9K7t78Fx5UCttOpvY19fzl3h/2kQ5cqKuaBiO94+k581ln
         g5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YZplQ6Ddkpj2GJX3+/D7fSo3HWc2/s74s4mdCUpbfxs=;
        fh=0WC9VlIoFU/gtBdfiWhvvAUwY2GSZONMy9r6sJXrhVI=;
        b=laT/77FAe8nOSC65CO3ICcGHdndUaixi9GNXMHAy9e4RE7paocCDe8bmNLRUhz3PJa
         iPdUx+t34i+JUZevLHkD6kQPIl3CRU6PoRU4pz6ReBJgLcLl8s4Rie78rGxJnlvNn2ar
         CKN2S5Uk1oLwL0lXkegd4utBP8vfCGYDjZV5Lpcl594PYYPXQ+0GdAS73A7ll+C/tG5h
         3+/GuGqozE8Th7hCyXJyeO3TBBrhR4rg51fRAyzT2b1dCUVkk6H6A208ybpWF0hR+T52
         XsJdxc8kJuLkjbQW/GZaPBWPNqFNZIvgR+LC4lpXtv9FH0ow9oDl6+nPsghiyVssbhuu
         d8gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781591137; x=1782195937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZplQ6Ddkpj2GJX3+/D7fSo3HWc2/s74s4mdCUpbfxs=;
        b=Y9ppV8ZTAJsGkPvzOdot+jVkZSpot2S/5K09jxMR9cndK3snzxUex6zEB7RijV/MhE
         d676Jd5D5crvU0ByXtjIRIyE5cfGMsNrD1/DzdNguEPz7m81ogiQVNHOVS95V500qCQS
         KA/ZVzykUnB/4utvkfwbgYi43Paecnjt10/nYwU++LXJp+fExcaFT2+WRgsFYgipR0Lf
         VlHbTudjLw+ZFrzcKyh9QdAe7KNSHTL2kHa0GAp5bXbJbfGUDeQ2fUCHwnQ1M3g7qq10
         7tMes9ttSCCEwlUapmWdmWZKGAACmONaU9fNpepigCdqX5PDHzEjCNLcNt9brCLhSmdZ
         GQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591137; x=1782195937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YZplQ6Ddkpj2GJX3+/D7fSo3HWc2/s74s4mdCUpbfxs=;
        b=I/qIE3TzIcFmO77gHe2vhrj/YRiNdwtGDOji+PG4rJllKLgGpg5AXup3UXGaTE6oHX
         +soZG/PH7hr2/uBdCjhTjKrKosp0lyt8XiWWwhBj0srFRzEGxV4Z488dOsvJJXRw1kPw
         juPqCkZgngFs2GTIaDe9ZkP1/eQIxFarADkWgWwaUExH7c53hw8boEvO4fVziAR/PplZ
         UxjXh4S45eWahkpxofHBbfBZyulKNR7yzdzecQXKd+AFQF39x8N3L2EhkHAIgn5g2Pkf
         XbGH4Pxut6VKcUPvNUIWn6mfHicMUcukJ/KEfJz3KLdcEO9IpWl6GqxjR5oyfn/Kq+F1
         fNeA==
X-Forwarded-Encrypted: i=1; AFNElJ9A85S08JLOk2eSBObbgOCH01BaQc51K8fUSRXxT3djy61a+RRmtg6KuSy7EIp5WsOLcdO1YtWDgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVYfJKY0Ttswcrv2eDTUDJ7CyAPxyo5qCgTgx/5nzkGggZezR
	z/f7rQbKKSRW2kfV+Vi9OSEmUdpPJhxHNRd4kJIvSexIxxxuQ4qNJSRhX+eBizfTuQSl4601l9E
	OvGa1Ar8EeTkJodaUthmA+gj6W9HYB2M=
X-Gm-Gg: Acq92OHbVlfbaGjfmmrMS0OKn4lTg9PY2BwGI8Aqj98ky4R9zlKJcJiZ+xb4RP8LjhR
	nxB1tQfeZSAJpJyYmsi36s1ftEnWINlH7sL1UN/2EJOX0niDCz5XB9W9wQYPXk0SynW6IinYKWa
	GQ479g0n27UPpD0+FOseP5sQFwJdb3KB8yL9pMkcFU+aQ9CtN9EyGHZyRycie8GYTmmX1scX4xt
	c/RJkEjJ5KI+1eHSCkWiAAhNZw/tvHmKqQ3pTXLa1RI57h6FXCMy+zAtKfpAp8JuAtRg3Os7fKB
	xyMVJKqD
X-Received: by 2002:a05:7300:2202:b0:304:5db8:da95 with SMTP id
 5a478bee46e88-30ba5f6dc2bmr1364047eec.23.1781591136757; Mon, 15 Jun 2026
 23:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528053203.9339-1-clamor95@gmail.com> <20260528053203.9339-5-clamor95@gmail.com>
 <ajDPtOyr8GJYaVYQ@google.com>
In-Reply-To: <ajDPtOyr8GJYaVYQ@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 16 Jun 2026 09:25:25 +0300
X-Gm-Features: AVVi8CfyBzDLnTjfR4jMIsriu_x6XwPfClLdZn_4ROEykRr_gBRt_FIINro_bck
Message-ID: <CAPVz0n2fnM6zYtP9bCtsY9mcLdce_R+1UPmMo0o4JRgjnhuhKA@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 16 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 07:2=
6 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Thu, May 28, 2026 at 08:32:00AM +0300, Svyatoslav Ryhel wrote:
> > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > Add support for multimedia top button row of ASUS Transformer's Mobile
> > Dock keyboard. Driver is made that function keys (F1-F12) are used by
> > default which suits average Linux use better and with pressing
> > ScreenLock + AltGr function keys layout is switched to multimedia keys.
> > Since this only modifies codes sent by asus-ec-keys it doesn't affect
> > normal keyboards at all.
>
> I think using input handler to intercept ScreenLock + AltGr is quite
> awkward. I think this also passes the original key events (unless you
> make it a filter not a regular handler).
>
> I do not see benefit for reacting to AltGr+ScreenLock on other keyboards
> to activate the special mode on this one. So given the fact that you
> already mange the data stream when you split it into "serio" ports,
> maybe just intercept this key combo right there and create the input
> device and signal input events right there?
>

Though it seems awkward at a first glance, media keys are integrated
with a standard keyboard in a detachable dock. It is highly unlikely
that media keys will be used with a different keyboard then the one
that is integrated with dock. Additionally, the ScreenLock key has a
code specific to this driver and is not in general use, so even if any
standard keyboard has AltGr but none has ScreenLock specific to this
driver except the dock itself. Handler is also set as observer so it
should not interfere with work of other input devices.

> Thanks.
>
> --
> Dmitry
