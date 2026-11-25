Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618427;
	b=tYoOtixwAduH/5ImCD4oEz6IOcGCM3OP3rj5tSs5bJgkv33VQ6WCWU8V1H52Lus1tIfP
	 zYvF0SFueyuo5+HwalFM8MJTBqDliqkAXJMnFpa7Q3DgSCV4zUF/opZbria9AxwQ092H0
	 UClwpxUQFBmeygl3ZZu6jtxf5LZIkE7gRb60ZWZPhsAo79nnKHWa9S6Y51yVyyoMkl8Ko
	 r9d3wBoDv+ayGJ0hyRyFZoP/oeMtWhErNEq9qku/0Int2g5WSp3vXBBUX0x+t0+tQg2ji
	 x8MUBSFq20P1yhR5eC5jVxjGp1mI7S7cBB4RykC2vNZMmC3obFd5ZXQihKZZYylhPLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618427;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qhCwXvAyXM1RHsJVCIWLLXEAUGswl0Dh6+s1SkrTVk0=;
	b=kBrHVIaigUNbf5lZDdc7cIGBH5UCbv6E+wKuwgKB/kcQftRimxhKd3bNts5p4txRTwfT
	 PSGfx9L5xXbJYA32s9cuqz+fd+1ZEJwYmEezi4PwrSS8znqOLxkPd1G4UAa/nMW9G8ntc
	 MQXKJSgl39+W7E5ndAqCMeWukWdxEkfuSJ/3GKCgGyBwVmeTdXINYtdOtiRgk9loDsceE
	 PMpQbq4FZ5gEh5UND/UwV1eefJL3z242qt5Hjnp3vsHvNzS/EsY01sBsBBgMiRZOLriDZ
	 6dgm6XHomJpeX+B13mmLGIdw2vjwtx+pYO7jal6YnTL/1jM/zOoAS51tpHWm3NPv83g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6CE606A331
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 14:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D6CE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b4dd5cb4f6so40561007b3.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 06:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618426; x=1796223226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qhCwXvAyXM1RHsJVCIWLLXEAUGswl0Dh6+s1SkrTVk0=;
        b=NRlO+KQpZmj89oFFo43gd5LSk2jYXn989BSbfW2H1sB3ZeL0SMF9byax0762xfS2De
         g+rvBaIegp/p8fwD97wziIxb1E1K0jglrRqfyDu4i3Tubvn8Yj+H+H+vdhwp2iFeJo7d
         pLZxWaMuZpgx9EG2QZYv7Sv/UYUbW6jdHejSr8WBhYCGlqx6RI9JxNYUAnKk2N/stVHf
         PCcxoEYuWx/DzEMNEIsdE/7rxm/Ya5bPz+EjuYq0AeCuzSpxmQrIWdMitv4MtSYRwBFm
         u+RSHuU3IEMw3QSGunYnBbplVf3wBjSdSDhBlKApJjBcYTKdK0f4hJYpukhAhpPUIFOO
         reaA==
X-Forwarded-Encrypted: i=1; AL+hErGjXAPea/m3PdCVKfvbSckr73/1avI0VmPIHQuPykj+TWlQ60VnCSIwJiFy1qqEUlBgoxj9eOKs0Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/6JWTcFtlPhfpss14d3iwqRDWgXy4DacyFgpfX7TaVXg8Rn5OC
	rfl4LS5N2h3x7ix0iEAuJQCALcATn2zSIxAvsIFl/ZATTWOHQytaEmuqq9jXwbWJ
X-Gm-Gg: AZFdTZc3koGODFrWrxoT3g6bpHEuNQPu+giLOff3/ynBNF+6lgqHwqUDoJbO6WV+Vy5
	BV476G9WUTLT48ssYxMnQUEYjI1VreDrKQsZfFM0e234m8oIRzdgti1zMkr803GSonS++FHhUOx
	2kpnTjnMCa8T8bH/QVcrjFoSIoUJZMoRMwAUuYZgezaxWsmMN1fB8Zs0kLC++lTuIAdcl/BbsV2
	aKdFNshPdWtkm7q3rdnAy/3we1jj/wS1+8/5/3+nC9WbHrjXEwHxDko7S0V4wHDvIvDcWDfAHk9
	aUVmuOPcnKjpMqZSHTXesIRAxsZDyCVldIZsytrZ8Frlaitz1pYfVjODCZgCSIpe3gqLKyHcxQh
	Lczok/QafLVX6tSlrG98l8KFPzXf3/VZ6P8TDvhuPN3tF6gNVUK24BTkokGpzyfpqi4idFYhPKc
	cLPrJkEELBHhFro8/JpT28TDBkj7fXwTZgwG3GjbsxXpMXpTzsxUSerqQQBEFOSXB10zzPitOA+
	2x2qQreunRUTidxfFUkSBHH3jG4jkPz9gGaNbeTaYchhQqqMebt+zZkJ1+pt7NNzgNXZDWr7BwR
	9bKGLLO4m7eJ9iF4OoispBxmkE+7YbekVbEyEH1XRpocXJ9ArcZrchs+QBBOq7Pzp8B7Bvs0+zc
	iK4CH3IiuHAeY
X-Received: by 2002:a05:690c:998c:b0:8b4:e2dc:3f2e with SMTP id 00721157ae682-8b5203299cdmr82151087b3.8.1795618426430;
        Wed, 25 Nov 2026 06:53:46 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5203325adsm73110627b3.37.2026.11.25.06.53.46
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 06:53:46 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d6a6776719so3575923137.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 06:53:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGjxH/CMxapW3stTDaPVTwM+xXe9WOFXXafPv3ZkULB4s+VS2urpsyAgcymDNafFrsd7yIi9EATuQ==@vger.kernel.org
X-Received: by 2002:a05:6122:2192:b0:5ec:7589:f9e0 with SMTP id
 71dfb90a1353d-5ee8af4a3d9mr11210352e0c.11.1795617963345; Wed, 25 Nov 2026
 06:46:03 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795029012.git.geert+renesas@glider.be> <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>
In-Reply-To: <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Nov 2026 15:45:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX2BEAK27P0Da7Nei=DLaHgTdi=FiC5ZMhVegNuGwM5_Q@mail.gmail.com>
X-Gm-Features: Aa3M54o5mrxb1PGlHbFHaQn6zx-fZm6HZYf4SleH1VTd0nBeXxZvXoTTF6NrZag
Message-ID: <CAMuHMdX2BEAK27P0Da7Nei=DLaHgTdi=FiC5ZMhVegNuGwM5_Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] R-Car X5H Ironhide CPG/MDLC SCMI remapping support
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Paul Elder <paul.elder+renesas@ideasonboard.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cl=C3=A9ment,

On Thu, 19 Nov 2026 at 15:47, Cl=C3=A9ment Le Goffic <clegoffic@baylibre.co=
m> wrote:
> On 11/18/26 8:44 PM, Geert Uytterhoeven wrote:
> > TL;DR:
> >
> >     Describe hardware in DT, and perform mapping to abstractions offere=
d
> >     by SCMI in Linux.
>
> A question on the approach
> An SCMI variant DT could mark the CPG and MDLC status =3D "reserved" and =
point the consumers at arm,scmi, while the U-Boot IPL keeps the hardware DT=
.

In theory, yes.

Status =3D "reserved" would work fine for a leaf device (e.g. a network
interface), without further dependencies.

For core components like the CPG and MDLC its different, as every single
module on the SoCs makes use of them.

> Since v4, the series assumes the SCMI ids are stable:
>
> >   - Remove dependencies by making assumptions and dropping disputed
> >     items, to move this series forward:
> >       - Assume all SCMI IDs are stable.
> If they are, why not using them in the DT directly?

Because:
  1. They are not stable!
     We only _assumed_ they are stable, so we could relax dependencies.
     With that assumption, there is no longer a need for the (contented)
     addition of scmi_get_base_info(), which would be needed to
     distinguish among different firmware using e.g. different ID
     spaces.
     FTR, without scmi_get_base_info() we're at the same playing field
     level as some other SoCs vendors that don't bump their version
     numbers at all when making incompatible changes ;-)

  2. That can't work for now, due to limitations/deficiencies of the
     current SCMI firmware specification and/or firmware implementation.

  3. Last but not least, they are not hardware description.

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
