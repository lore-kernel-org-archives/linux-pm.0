Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B640963A
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528961; cv=none; b=QE00ZujNhC4BgalNYkJz2BHeJqjwc90FEbZCT7bX7p67AE8pJTjHxqVSz+dqwbdhvDvm70OT2n7SiUoNFtFY2QmWOnhKtdtpsDqQUO3M3V9A7eMOt4a5/D6yu5oohL7ljbebkkdV0DLik3fVCdSsmiyJwU2vw5uqmBn5g1KQ4Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528961; c=relaxed/simple;
	bh=wokLofWxv7vLrWb75WZJGxZonifi+3z274aDMO/O3SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQTvu0YRMkO2JAUheNHoMcZkB+uV1L6DJrTCiyNlp5t48cvnVXzgRrha70yM8EM1tSAq6r9aRgwQMh7SeKq92I8pMr+YPVJTneaeaJEhA4aOcV9bc3PjcpB0Z+YcAmSng15Z2rG64ndoCxxW8zOkKxLQg5HBaG1r7Qs/siYBRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-97727c2064fso521273241.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 03:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786528958; x=1787133758;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CR60h/fVXoId0NfC1qox1rIsZX7Vdp8o1eA32koeHU0=;
        b=X56FpRiZh6A8Qhs9v/7ohvvnUjBQyMxCH/NE4zshKG6u0LNjpZQz214/WDBpdRlQGH
         P8cSddAF+K2x2VA4THEqFvLSe4v0ogAdUXBT3ES9S7Z7aeZASAbw92qCYEEEdmtFDRsY
         hJoRoZ8uAD3qEYEfJv88026A+uNxD/E8FkcM9CmpIO2Zl4e4eSua4yETJJZmF27Pw1Cz
         D6w12v1zhw8gkjDdIiHn5ZFwBotfYOdeOTVje0vwscJRthNO2LvRqavAKKzA+c+L3rsv
         TDMlLdpMz8kmRU6lbiRaSjG0Oii+tOVsNRSNjMTjFq1Zw39fl7x40+WwNFRz7eOttF1a
         2YeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpv29yznKWtsiKcXl7MQC679duGT/trIRZYPtFH4d97Ju+fcYh+mGoSlYNm+s6Xxag3RFWqQmlzgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5HhoijKcZbCu+5IsXUhMM+7ra0wAVfW9rDVybQB0HjtnaS+X
	wtshh1PKyBqpl2EvarYqsyC5En10KwEgpLNLyT2ZxoyaSSVtg2WQIwUto1IfzXfa
X-Gm-Gg: AR+sD12gP5Ap5YOwrCpmMQUiB0cmMvczp/Bz3csZPOfu7EpjdGeVUIp3Dlp9wbgng+J
	TtlZwMskkfhNq7lqn8HTg2t2svlIONjXa6Vwc4oy98aEF9ztZHKTXH3BXSMolaZfcMRMyAdekt+
	Ty62Wzzbd0xTiwVPNQq+DTn/p/NO7XUC68SSpzKu4X9vhX8YvXXOSz/TUxViF0XCfbYkIQjv388
	v4wMwMBJniT0XbVE6CjqHcfxXXNz++ydGcmxvuJcxuvn5asvcukv70N5/fnneGc5QiIkiLumvnU
	KUful4Z0BZ7Rz5b2R36Ojbiwiu+cx95C7fS3lKjjrTvdN3kYZMst2n0NclWrTyAWKzRMVU2dSVd
	C9bQgbSnyMPtmbTUwrwNGUTq8SLKoMIOXXnEViQZa/rwmdoaHIoPeZ/41XrXSuioq5TlW0UvuqC
	xlK09XAl/zCkbKcPQpvbkVcCZDaoVy/vqiqlZVeEHAfQWyyUE86VgpMYGhazZm3JkMTvyRHvD+q
	WsOwz3v2NyuvFtReY88OzezmQ==
X-Received: by 2002:a05:6102:5086:b0:739:a2d:9621 with SMTP id ada2fe7eead31-76c9071e76emr869036137.13.1786528958413;
        Wed, 12 Aug 2026 03:02:38 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97a3c138a9esm1410373241.3.2026.08.12.03.02.36
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 03:02:37 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-97727c2064fso521249241.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 03:02:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqBgyg5XnKKFSi0zvEOE5IF2TR0eq1tgwQ57HqS9uit+Y4zWrBv8HjKyTMiIK30dnMw+XvyfrTh3g==@vger.kernel.org
X-Received: by 2002:a05:6102:3fa3:b0:738:531e:a43e with SMTP id
 ada2fe7eead31-76c8e62eb86mr823119137.7.1786528956520; Wed, 12 Aug 2026
 03:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505329.git.geert+renesas@glider.be> <49726acff0fee1c3606e83c4f242ef6aad25b4b8.1783505329.git.geert+renesas@glider.be>
 <20260710-adventurous-burgundy-chimera-b2fff9@quoll> <CAMuHMdV=ckONBbTYELPJU8YWoNzdu3PJ95VR8cz+f_7dUeiPUw@mail.gmail.com>
 <20260716214924.GA1477674-robh@kernel.org> <CAMuHMdU0ss6wUEdjC+OYa3iQS439aJ8b_d9M2ws7Ayn4_kOyMQ@mail.gmail.com>
 <20260811163334.GA2354701-robh@kernel.org> <CAMuHMdWbzg-QpFBzzDa2hC3HzAmWUkerESC5O-cSVxmWX3_PkQ@mail.gmail.com>
 <45dfd858-9d59-47e6-91e0-ef9e6e909af6@kernel.org>
In-Reply-To: <45dfd858-9d59-47e6-91e0-ef9e6e909af6@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Aug 2026 12:02:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJFdJQP1GVXrOWRuYO8Si_WF5X+vpzmAgTZY+tQstR1A@mail.gmail.com>
X-Gm-Features: AUfX_myt-2ep2N9UFFpinQmtMeTX8Y6aB554SNFoItehXn5f25ET5eoahbFPK1U
Message-ID: <CAMuHMdXJFdJQP1GVXrOWRuYO8Si_WF5X+vpzmAgTZY+tQstR1A@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] dt-bindings: clock: renesas,r8a78000-cpg: Add
 firmware property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Wed, 12 Aug 2026 at 11:51, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 12/08/2026 11:47, Geert Uytterhoeven wrote:
> >>>>>>> +  firmware:
> >>>>>>
> >>>>>> RPi is doing similar, but I have doubts. It looks way too close to
> >>>>>> generic "syscon" which is disallowed.
> >>>>>>
> >>>>>> I think this should be vendor+purpose specific, e.g.:
> >>>>>> "renesas,scmi-transport" or "renesas,scmi-firmware"
> >>>>
> >>>> If you can tell me the resource that a 'firmware' provider provides then
> >>>> it is fine, but you can't.
> >>>
> >>> It provides a firmware API, which is not available until the firmware
> >>> provider is initialized.
> >>
> >> I don't know what "a firmware API" is. What does it provide? I know what
> >
> > It can provide lots of things (everything we are no longer allowed to
> > touch directly from Linux ;-)
> >
> >> a clock, GPIO, reset, interrupt, etc. provider is.
> >
> > A clock is an object you can access through the clock API.
> > (s/clock/.../ for the other cases).
> > Firmware is a service (virtual object) you can access through a
> > firmware API.
> >
> > In all cases, the consumer of the object or service needs to know
> > which object or service to use (there can be multiple).
> >
> > In all cases you cannot access the object or service until it is
> > available (initialized and registered), for which we have -EPROBE_DEFER,
> > and/or "[PATCH v2 02/10] of: property: fw_devlink: Add support for
> > firmware".
> >
> > Thanks for your understanding ;-)
>
> I think that's the difference here. Clock is not an object, but a signal
> on a wire or within IC coming from one device (provider) to another
> (consumer). Firmware is not a signal, not a wire, not anything which can
> be provided from one to another.

Oh yes, it is a service provided by the secure world or a different
CPU core to the application core running Linux.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
