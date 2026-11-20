Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164329;
	b=0JHQP0TgYihGzPRqRJGi2E0vW+CReqaxDnbV1i3fHpqnhX9P8/vv9yx6a78FRLUAKyW+
	 lJzPABeOmLdTt6vk/gUekT7WvsTjqJ61oYnn7UGYS+E/9JrMEJKTtiL2hokhinBPCjSZ/
	 35c34cVdE6HQYEmR44TV/OTvHe8zGx6UCK0zC0ZAxgNgbgy9FxxS8kCYINMQt+uSqDm8D
	 xxq2CJ8PolvIEblSRYBDxnNqc1y0yJYbWvzLuXI3or3HS7kjoqLOMB1qPoFcKyfAXdQw5
	 aai5L3D4bPZDp0SYYK+PTNssjL9ZyI2PA5kJATX4CXWNXjoKp4yZVUtlvnobIwOrDsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164329;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kKe/4cMcpovlVlLqvT7qtlmn5xNAbW7n/dTNm3KFNs8=;
	b=bACBRE74bcdD54pZEsS1Fq5S+6IiQGK4eAZRFDH7E6BSabO1mHihM35E/eYsWU7My34G
	 YXpC1uaEUpdYZ/IHGr/9fG5zQoOQakX/0bhuPHIYlnUTH5tVpdyawkF5/3v3KQ7/rTV+k
	 VjTw1UyhfovrpjaMd0mk7vCIt7hgnYkifejhdLanDPgMSB5tLvEgooTX1HPAg9xfNF4RM
	 TqjXV0n/lp6ab7I6WrDOhOOlZyhkpJVpnNDSX7oDpiR1Cn9SoWZ4dteePEOdYhlqxc0Yh
	 mKojk8EuAbN2n/sFD+wqsK+1onYHNZUf4D514XlVHO9z0OTvjNcIsix9zzCLLzZaKGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C750606B4A0
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 08:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C750606B4A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7a6e560f580so435572137.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 00:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164328; x=1795769128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kKe/4cMcpovlVlLqvT7qtlmn5xNAbW7n/dTNm3KFNs8=;
        b=BMtjMEC58WjPlP0Xqj2kQB4PWlkGX1XAiZSbwx/QTLXx/j78Vrf+SVQjTsZCLlonIu
         mkgS2p/FRULjoNhYWVa9Brk/dBZSFwVM0X3B1O25rsbpoFbEWW0wLDdwiGWHdQgikZg8
         IcxVhQSoTZ5pZkVjjXsBZXqoiqYu84Q6G+vdEPfmGd2VYmHlsKfuKBiGSEceRIZSR10N
         qpkqsvPHdY+KunAeI4MRNC0JON1YrccUqozeGaLoPBhKAt34xi3AiluRyX7bR/Rl07wd
         pR27lKWMAWnM7YEJe2wC1e2Z4QZON9G/yugvt9SB+VxjZPmuKVVXyDVZ5dD2/zp+W5hB
         psDg==
X-Forwarded-Encrypted: i=1; AL+hErHed5pgyOwciEzWHIi7p/MVR8eZk/Rhy40kVqB/IauRmvqaZ3GKOH1w0iW+ndfcruB8iUxOxAX5sw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+5E8Jf48yytXzIQDmAYvxMraVUA5KdYVFtfmGUG60AOvk4ywU/
	FENZfSTmKVDvT+Qk5CiNtilh5Gpt6L2B/chRno1KFE9F7VBmUwLEJchYDbOA8zfb
X-Gm-Gg: AZFdTZePeAJfGSx0Kenc7hez2aYxmbSAfHWP5+NIaYiW8jgB86AgpCX5j2R1NJR2Cle
	QHRvSIHD7Xe5AIz3qQ53lXYNefvuBuQ/sdXgXs/yUf/+n8jVi5lXk6BpW0JKbCXOa/poBl2SiTL
	F+nmh9EUl5fiYtbu2CaJ0YwBUa4nFhBCb5MMpvOwMyqLH3Cz4SKTSuqHtoSj01HOuUcBJbZCZSE
	W94EbipS0kSndJKHp18DP96GyNMjqzWan+NYmBy/aZt/e/Yhnn0u6HeMVVouBjwEEs+CDukyZzi
	hIkKaKIrsUq6SzcNzHnS2YNlQwTKNozQ41ZFbcwxWKQDL8ZFxg4C8dF2JQG8oaOMLAjrdJ6WX3g
	nVmhV46g2jnmQ8XBS1CH0j/lB2t5Du45I8n5EaUEXlHGfYwkR6c4pPlgL+RbITMqzgF4bGqF9nJ
	v+6z2OwA8NXC/iuDkvk9Qdqxf6eIkGvPMGiBTAJlDGZW/1gMJ/G6jHsN+KrNA/aD/UNvZP1dTfp
	bIRrcFp6FLCRQBjhIatAhcd3rQphj4yk31z4ZP0IQliEtL4CiF271EUFUcIYNqQFYesenvU7wcQ
	V4KG0mvbRI2s3VdVK2gIeO9sSz2PlosqibcAOhgOLJ10KmVYNfVySqchu+5RPoV+7WA=
X-Received: by 2002:a05:6102:5108:b0:7a6:85d6:84c3 with SMTP id ada2fe7eead31-7d72b362396mr937610137.3.1795164328218;
        Fri, 20 Nov 2026 00:45:28 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a29csm2347762241.5.2026.11.20.00.45.27
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 00:45:28 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9950a7530d9so373303241.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 00:45:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEQ+3PRtc2GF42k+M7OPiNs5c3Qd141Pl3jYbBS/bhETM/sUG6WCXxuRmHYgYngX2/ukKW4u9NAAg==@vger.kernel.org
X-Received: by 2002:a05:6102:6a83:b0:7cc:2c52:47aa with SMTP id
 ada2fe7eead31-7d71e35b5demr961144137.0.1795164327788; Fri, 20 Nov 2026
 00:45:27 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795095742.git.geert+renesas@glider.be> <CAPVz0n1+qXrO5P+rOBKOSOE86+WcmjNF0taWDZoWqerKrjVgJQ@mail.gmail.com>
In-Reply-To: <CAPVz0n1+qXrO5P+rOBKOSOE86+WcmjNF0taWDZoWqerKrjVgJQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 09:45:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWPvKop0KAg_nff29ZeAELKprfmDtp8hDU2KPvJH5VVMQ@mail.gmail.com>
X-Gm-Features: Aa3M54rOiSTOIwRhd7pOhxBlMhXD66QjrOqwvbGtlwpHt8JjwbFg6d-mZpwSDxY
Message-ID: <CAMuHMdWPvKop0KAg_nff29ZeAELKprfmDtp8hDU2KPvJH5VVMQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Improve MFD_ASUS_TRANSFORMER_EC dependencies
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Svyastoslav,

On Thu, 19 Nov 2026 at 15:51, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> =D1=87=D1=82, 19 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 15=
:52 Geert Uytterhoeven <geert+renesas@glider.be> =D0=BF=D0=B8=D1=88=D0=B5:
> > This patch series improves dependencies for the MFD_ASUS_TRANSFORMER_EC
> > MFD driver and its various subdrivers:
> >   - The first patch adds a missing dependency for the MFD driver,
> >   - The other patches enable compile-testing for the input, serio, and
> >     battery subdrivers.
> >
> > Note that compile-testing cannot be enabled for the LED and charger
> > subdrivers, as they have a hard dependency on the MFD driver.
> >
> > Thanks for your comments!
> >
> > Geert Uytterhoeven (4):
> >   mfd: MFD_ASUS_TRANSFORMER_EC should depend on ARCH_TEGRA
>
> Though this EC is designed for Tegra based devices, it does not have
> any Tegra specific parts. It can be used by any other SoC.

Sure, the dependency can be extended once the hardware appears in
devices with other SoCs.  The question to ask is: does it make sense to
ask about this driver when configuring a kernel for e.g PA-RISC or S390?

> >   input: keyboard: Enable compile-testing for
> >     KEYBOARD_ASUS_TRANSFORMER_EC
> >   input: serio: Enable compile-testing for SERIO_ASUS_TRANSFORMER_EC
> >   power: supply: Enable compile-testing for BATTERY_ASUS_TRANSFORMER_EC

As pointed out by Sashiko, I forgot to take into account the transitive
dependency on I2C, so there will be a v2.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
