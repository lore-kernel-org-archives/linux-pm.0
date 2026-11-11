Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794381369;
	b=iKm5rwwagBkCHpoKVRXm/TlYEoBf0kAqCIJyp4msNOGYIuc2/At/c51AkVq67RKbtrHd
	 B5bukuxWn/ZsRRfzjkUYETX5sRAY1bM76Vv9FZdfimXAeE7TAaDeGflxFtNj9m3SQJQ5W
	 vfr6QuzNzg+TiPMk1Lg25HHq627IH3FowwE0ri61xBX2ZKYHoukzWRo61lwKhWQAoUbSL
	 Xuj/Cfbos/kFYeeu4OyBm7ID80JU1UfXrDa2dNgFNyjTmEvG8zEToPYhz07hWcgvehmll
	 YgI6HBNjUm//HfGX6CrHbN+Q33BoHhMQtnaNlFN0ZVbAYSjc8UfgkynBB6ryuCHJwNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PS5LMiKFzIUnURDmLwbpwh2C/rUlEP4/H22PiA88mjc=;
	b=kZQQjtOCIp95UvudaAJC6TpcresKJn+ePNvtl4aqTcHV9FyJi+Lck4Mt1lwFvaqOC2jZ
	 ky9SyRLOC05LJAbsHWWnXhjuNA+UGktzahp29Ylhq/VN2SPkH9jnI+lfqmNM3t/inAfxt
	 p+8nUFpMDy+RFfLo/UF/cb98K3mLeNObOgC1dkgXWoKv58f2TIyTTw1Y0v/YPK5GNjom5
	 8wTZzCrbPs/dnzyD7XVw3iWjHttkehgcBJT/SQ3iH1IkTIkhx0nzOBoMRnvLTEzXzVCn8
	 NdQA2a5QHO+ZeriCx5rZ98RRqIx+7Xwj78IMiMF+P29S5A2e8fj0YNfEFTZTCb+gVyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=pAiwqPtb;
	arc=fail smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4F606A31C
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 07:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14D4F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=pAiwqPtb
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b336de3d38so22366967b3.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 23:16:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794381368; cv=none;
        d=google.com; s=arc-20260327;
        b=P+pj5BUSN5HMdRaHtQrXal8E4KSmET5C8KrQTRgqyq7y/JwUb1SABKkYdxZO4nJR45
         UtpfZQgOjO9+p8/NeHnjVlOqirDRedPgk7KElqx/GeFzRvrdAE5YCA91DXal4+Ur6HfS
         lUpYjVH7bnak1XbXs2TTMvjihsp6fe/1kh/VWx+4vTPZ9/yxq0JPuZyNsQE2bB/741w+
         TDLbvvEfeuDxeIhoVQ5roNP5zaLW+apbzNF2hCYR+xq2WSQRajpdFfeluk5W3f7tHISP
         PhkvcLz0r/vtLpILcdwbmWd4w9+F+NnG+nJHcfQXgmgiY2sQFRUZ6NaAKgvqyxSQaYqB
         oG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PS5LMiKFzIUnURDmLwbpwh2C/rUlEP4/H22PiA88mjc=;
        fh=KxOYe2yNesV39t6/vzi+wjgrlP/oM0/7CmzLfzfBTqo=;
        b=Awdl9sv1STeIo8yUjSx/q7RbljDq/hVf1O9AByi90aShBeW8MMWiqR1gMh2XULi98G
         dAI8oIYQhUs1a3tl6HYUkW1RXdXRL1+OThVls751hLNIbth5GEsGTmUs7N+MW6GSVLYF
         uq+FbY/p/kUW6+QvZ+Czpx1qO7KEtajZwXSj47TI+YAoA5Ixo9Fqdy4JpEFDZiXBSGbh
         ZSMBHhM+B8S4jAhDCBiIV8ciVW28hGzrolXfyehPNuou6w0FnTIFNYvcaWd4BmCgDC7+
         y0vK1aWoBi0+cIrXn3lahCKwNyxq+068gHf1lo3lJoteYlzSWa3+q7tEI7htAPtw+OtJ
         F7qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1794381368; x=1794986168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PS5LMiKFzIUnURDmLwbpwh2C/rUlEP4/H22PiA88mjc=;
        b=pAiwqPtbWeaRH/ZqGVLMtQHwvrxsDdIZe9E35wf1oi/7nOx7xeahW0IAJRLJYHR7ia
         Wx1Wg3BuG1Ku46S+uDvtGxCs22uEQs8H/6bzvaGSMBwHf+dOq6ybmI1eUEU1YgfqN3ad
         /j6cBxti7HsCNg9WA5QfxwHUvXCnlQTCf20NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794381368; x=1794986168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PS5LMiKFzIUnURDmLwbpwh2C/rUlEP4/H22PiA88mjc=;
        b=VrVfQl901a8gsGYVmFMKksFBJblV2FrV1b+lYB0f2gqqWiYssv+t/iHuqfnfW6jw35
         x8Dj2itsnecuUlUfXbVgCY+ZMUjvibqqIL4XzCj24FVKQ2WEbffzvVVBMINfBZdlG/et
         /r7hygMaH6bjh7EMg8nHYQJGDDN3Ex4jh9FejZYqxNi/Bwbht0AnV0s5Sd0FHs4DHMOH
         /lCbxNL0GE2l+N14tiCMa2MTfJ4jsJ5MgVDaKsi1HLP9gE+K/ipzF4DVU70Y7cnIa1aL
         +HlIKmAiuMBg0BZNenbLHE8VCnpHoFlJWH6OjtoEDfItGxMUyPMhBBbHGtp/g1Ev/1E9
         +88Q==
X-Forwarded-Encrypted: i=1; AL+hErElaW5OXW2HEHW+YFmfX6RmVELNJCV7zPnvsH2bxDtDaI5p9f1dwYI0ZUkE6AhHxz3+MrhPSGvBCA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+VqrqCwkqMRANedvT82YuE1YKhh0lgvV+y8/ThqGFZ2rvS3tuy
	TzQCxrfZsCio6RYPxvOR7yf1Kit4/VnZ0ISmG8jv8jIjRJUcKyxfPjA0gcjxXNZeMBekMa735gx
	UzDtmCch2MOtD8lxXZvqpWMlopar1t1W0EsxmOyG42w==
X-Gm-Gg: AYBFou1gJvofUvdc4zsOyJKioKyqaNlOgme5lFImKf9KzaULkovuu59/TYuHAjNZwJ+
	hsgX/vLIEEChec93XHl90RzvmG2jXxoIpSdB+nlumrKpZ/sBpjOUI3KPeMzqmAoWPgUfhv3Dt/t
	xyOEyz5T0H6aBy6TcPpFaKHAQpv9JuZCM8N2rwwNOVn0Rl2LNcaCZ39aSlRyC1zPxAsu6S248fz
	MaO5+8kG1sKqRWotA0e8NiRuzweNh4AakpkWdguJ2Cuprybocm+eZ2B3h0pv19E6BmuxWRM6wTQ
	OH5TYt0ntYQsRqw4s+svFjWKmZctZbAccqgO44s6xwG+JaJr4anLJ5DnJeQ1WdK22/04e5ijfkI
	UMEzSKbtjNSxSu17xDjicgUVZcZrLimChqtp1idw7r3LSn2SEZSxc7UYu3fc6R0uThoE=
X-Received: by 2002:a05:690e:1504:b0:677:cbfc:be28 with SMTP id
 956f58d0204a3-67c67f7bcdemr1039946d50.75.1794381368118; Tue, 10 Nov 2026
 23:16:08 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030171910.2822677-1-dario.binacchi@amarulasolutions.com> <f5ddf27a-9771-4967-a9d0-13c09f588402@leemhuis.info>
In-Reply-To: <f5ddf27a-9771-4967-a9d0-13c09f588402@leemhuis.info>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Wed, 11 Nov 2026 08:15:57 +0100
X-Gm-Features: AclHuK_y6USQFhQ1AriRJr3BWyE_Wi1fKklRA36_ipXu6i6f67Qj9RIWxt--J7M
Message-ID: <CABGWkvor=2AWC06iRvONAAPu6b8SS-JnJYmeALCYg_r4bh3wtQ@mail.gmail.com>
Subject: Re: [REGRESSION] cpuidle: psci: boot stall/hang on i.MX8MP
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Ulf Hansson <ulfh@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sudeep Holla <sudeep.holla@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Russell King <linux@armlinux.org.uk>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, coresight@lists.linaro.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Tue, Nov 10, 2026 at 10:12=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 10/30/26 18:19, Dario Binacchi wrote:
> > Hi Ulf,
> >
> > on an i.MX8M Plus Dual board (Engicam i.Core MX8M Plus), mainline
> > c339f4010dea sometimes stalls for ~0.9 s at boot, or hangs until the
> > watchdog resets the board, right after:
> >
> >   [    0.806123] ledtrig-cpu: registered to indicate activity on CPUs
> >
> > On a good boot the next message comes ~11 ms later.
> >
> > About 1 boot out of 3 stalls or hangs. With cpuidle.off=3D1, or
> > with commit 65705b18162b ("cpuidle: psci: Move initialization a bit
> > earlier in the boot sequence") reverted, 10 out of 10 boots are fine.
>
> Hmmm, nothing happened here. Might have fallen through the cracks, so
> maybe this mail will get thing rolling. If not, I'd suggest you submit a
> revert.
>
> Or was there progress or even a fix and I just missed it?

Sorry for not following up. I can't reproduce it anymore with
current mainline (b3dfbde62cf1, v7.4-rc2+) on my current setup, and
I'm not sure what changed. I'll keep an eye on it in my next tests
and report back if it shows up again.

#regzbot inconclusive: can't reproduce anymore

Grazie e ciao,
Dario

>
> Ciao, Thorsten
>
> > I haven't dug into it much. The stall seems to be in
> > pl330_driver_init(), so my guess is that it is related to the AMBA bus
> > reading the ID registers of the CoreSight ETMs while a CPU is already
> > in cpu_pd_wait, but I may well be wrong.
> >
> > Any idea?
> >
> > #regzbot introduced: 65705b18162b
> >
> > Thanks,
> > Dario
>


--=20
Dario Binacchi
Senior Embedded Software Engineer
M. +39 328 0625246
dario.binacchi@amarulasolutions.com
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
Amarula Solutions SRL
 Via Felice Cavallotti 25D, 41012 Carpi, MO, IT
info@amarulasolutions.com
www.amarulasolutions.com
