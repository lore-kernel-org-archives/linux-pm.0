Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF32F7F1D
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504552; cv=pass; b=kAsdi4/qvaszq314r0WPEP8tZsFvdVqXjYjAa9YnRoEU7Xos5hTpx+4EWi99FP2fINhR5C1WnQM/7uOsk4FaeuVXUh5uJmUmCK3VN5DkcUqUPP04EkRtTLnUD/r4Xfzca8W0lzhhRqmO/MbLuqCNCuDBwwGT5Kjl/ZeqUoD8inU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504552; c=relaxed/simple;
	bh=XqPNvehOEnWaZnXTerBcQEWrkudRd/l6+h30K5DXrNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeYsSMPzAOYoVBJwaLVVqEwtDLf/s5pL4KqFBnO0+/ExgBLyOZsz1PfVOEBs+xB1mHZPN/EFqYnhHldsKHpAC7mPUn+1SgiMkdnGMgMAIAW5baU/UU0KTvAarFW5+wYescJE0o0a6KnJ7wLmEC6i4AQbuJXqKE9c7efd3wV+RT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt18b/C9; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt18b/C9"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13807d2f898so3190192c88.0
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 23:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781504550; cv=none;
        d=google.com; s=arc-20240605;
        b=AkY5f848MCBj6kZTOjz1hFp+HFHIdDTly7sX9btVO/i3B9Ax4TutI/hdA7b7qBiyGu
         H2MwyBuyz/z4hAutQTneRn0cX4p8cyARxaOqgF2wqdTo1QR9nRlTCs4fo9Isr64xBLnC
         wNe4gLa9TqiHS8RJlQRHRlIBA0g33sggH6jkgm6C3Ec2sRRanXswYl7J3wTjvtfh3sIN
         +Qmf0vQBRZUSr+HZYCriVX5W4W8IfIUoCQRg054MkitxO0nQq8TkvOLu+ctlYQ7Ajb4k
         uJYqQ1hm+gPZdLfnHrLP//f3b+3dxux71lyZWvTmHWHAe2fKPuWDfew8pxwE2ByOJgLo
         h3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aNcg/aOawlT6U3KWhnH7Etl0bqitFbIB3mf3WqNqrV0=;
        fh=yMpVO9NJNJvnGL8RWUmA69mAxbv4EH63QI7pJ4Iaka8=;
        b=UUIBcQi2eG9SzoSlHFx8suTA9UMkfFAkqQAB0CZ58WCDODFxPEVGWDBDiPjfek43N+
         Gs62MnX0ivbZ6pQCN+pYHC5LqSnHgn2Mo4rTyBbnLHkBwZRxH7LfSfrioEEfBaBWbzTQ
         u1VYboUBnAs2LjfVtLo2I1Bv9z21vwlZ2XmfhgxDysfx5JZFrjMRnHThQaSnDHUHPX8W
         rYVJReVmeLoVRHIg7C4sPkXbTkLYFjvh8xNRAFB8Pgh/EvTrio7ZBT7AW6knS2pwWp0F
         ks+sMYQ1nxn68lniOGtzy7odh+I95/cUmrMFJRaQGQj15f5+RAXgJoX0JG2wGyfe9vqR
         7ocg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781504550; x=1782109350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNcg/aOawlT6U3KWhnH7Etl0bqitFbIB3mf3WqNqrV0=;
        b=Lt18b/C9Sylhcm5L/XuLyFFbipurTD2/ybMblL6P7LxWeIt8KkJdB4kVxFrz7SmZGl
         7bRyScP7YI21bux4OWJo/kSHLydpe4KVXMRs+Ot4E4T0ba0r/qvcRaW+35ytO26+1tER
         4SMvdYINuXEaC8wcSt7BAXGo+qA02pfhWyC4RkF2iA0QOz8qL5HiNC4TDk/0iPPutCuq
         R/VjZr1R7/9LHwlJqkWk7UIgO6DslBj/bpiZvkh/VVtEiChAddeMgY8FOs9BoG9pdBtA
         kZZSZh0GiYI12rMA5bmxMJzjTr9qQNjsXLVx7y/dNjxSck4v3+PpezH7dRyu4OB+3GlI
         /DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504550; x=1782109350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aNcg/aOawlT6U3KWhnH7Etl0bqitFbIB3mf3WqNqrV0=;
        b=PHhZz+nQjuHfSw0gH8ICIye50G8w0wX7K4BJsXCZw1MER6JhRfxyCLkB7LF98IGo8H
         O/DA8BFQTHYpQeRrxErIvDjcPZ9vjX2gTjewAaLjQsaT53fhHKL4E/7aAIU7vEN67jXb
         ErPu+4L6H6sApBN9HLA2JOrd7oR4RONBJeDb5DAwAASxr1dWiYX0J63u03gy2O0t3oO9
         pWVNtI1qm6Ym0wkoDgRNkMezjON7eUdfGyUODhHmF8uCu++cZlBFQaLJcGHFFWV2Urim
         opCwf8kIRb+wkxTgpHceQQUGjo3gMet5zRu/TzkTTlKIfI/z9Rt6POWKup6/cL5C16wQ
         PW3A==
X-Forwarded-Encrypted: i=1; AFNElJ+GOGsnwV00V4GLqmOkenWl8gzDM518CBnEWkP6mPumvmd/yP22LtYzJANdLtZ2U4VPUl4fwwYdMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8HoYlJix2GCEqBebhWBp24M+Jt1Dakvlfo2FeC06s4uNqHN3s
	65eb60K2mdnvyXkpzRmj4k/kki0gyoT7aHrA1ttnnyHXn2M3+mExu+kuB7ANfuIaXD/4CB1TSKy
	OKDk2NdUAxrQoDRTxr/ijmyRmTr7tv/8=
X-Gm-Gg: Acq92OGqRgXoZjiEtrwXrQOAxpBB95opBE4FYk3as8ZLk6isLLTq6VHtv9UYs96HoCJ
	gTo5wQrE0mdUk2ZozIpA77zwNUjx8xq27H+gVjuFr1n/yMorhvja7J2VfLhGiNYMuhR1uVL4loS
	ZSyPprZcy6XX+9zJL0aK5n08KL4DxM6v2sKeJkuimk6QC6MmQfFIjjjbiDp46npU8+TbiXKaUN2
	Fj0+jbDV9mPeO6+CQaDyQMcmPJ7Sco8p35ISJ1VMMQr5eeK+PtsuVOVqlODikfdxFXz2lq9Pizq
	t+Yhnw7s
X-Received: by 2002:a05:7022:f111:b0:137:8bc2:f501 with SMTP id
 a92af1059eb24-1384baef050mr4646305c88.7.1781504549538; Sun, 14 Jun 2026
 23:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528053203.9339-1-clamor95@gmail.com> <20260528053203.9339-4-clamor95@gmail.com>
In-Reply-To: <20260528053203.9339-4-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 15 Jun 2026 09:22:17 +0300
X-Gm-Features: AVVi8Cc0Nlsxbb5zkVkx0TdFg33anyYPsTjQbMqYQfW4SlpkYRj23DSVmIPKM94
Message-ID: <CAPVz0n0g3iHniWH2inESPf+xNv52QW4bc0h-Fh3KtVRpiwZGfg@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] input: serio: Add driver for ASUS Transformer dock
 keyboard and touchpad
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 28 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 08:3=
2 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>
> Add input driver for ASUS Transformer dock keyboard and touchpad.
>
> Some keys in ASUS Dock report keycodes that don't make sense according to
> their position, this patch modifies the incoming data that is sent to
> serio to send proper scancodes.
>
> Co-developed-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/input/serio/Kconfig                   |  15 ++
>  drivers/input/serio/Makefile                  |   1 +
>  drivers/input/serio/asus-transformer-ec-kbc.c | 158 ++++++++++++++++++
>  3 files changed, 174 insertions(+)
>  create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c

Hello Dmitry! May you please take a look and Ack it if you are fine
this this driver or tell what I should adjust? That would be very
helpful. Thank you.
