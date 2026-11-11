Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395386;
	b=K5otvsRmbRC1bMpDTBuXXKQlZ+Ft2RXe+Tp5EagRcXdu7N0ur6SjgwMW3Wv+AFa1hjUf
	 4hGEWdgxL+FW2RLE4itWPdtZWsYfTn7OKYpCHkJpCWVo39yKmpFGLtwIJttULSrSGBxZZ
	 pyARaOOobIE8iuZsHuK1GRhWBdiPjjI/j6R9AhO3KxLc4nv/92A/jToxDwiT3yH+cgyGS
	 r2XeBu/zrth1Xha5I1AmxeexkqhsxEoKmpnTtCuaPrpDMmbzMYrvIqFSEEoyYFJrI9D9D
	 13QskmJ5dDSR0pP80ajQWkXtb1PY5kI5pgeZwydulhcgu90CMeYRFwE63DWCoTJjQsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395386;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yn5y2q3JJulnHdFFu2RjD/z39f48yWR7C6Zxb/M775M=;
	b=WKhWQwKxI5VZtzELkVPQX52xoVWMbvpi3qaHGEHu3yGYrw1n+PCPZn0QHrw5MHvz2S5C
	 MMww6BxHCXIpKh+e7cBQTbG9czkia1JHJjPbcKamrddfl6/kaVhhr8gzGdLIbXhTrUH1u
	 kt933R6/wtSL8sd6/mKY10kXwAG6nCHi4carcZLE6n1HX6kaFp6XagJPwQgSDwf67KqEZ
	 ltl9LdgN/EyiZC3gu9tx+QYNSgL986AN8aUVvUcpviBzhFgFsw5HUCB0asef+KAAW59uJ
	 xRCohDlG7DYvyCouZ9jag2poBp5joDj9uyEUudchDYHYy7TD9Lmbe5dPPKd0yfP/0YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFEB606A8AA
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 11:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BFEB606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so804895241.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 03:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395385; x=1795000185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yn5y2q3JJulnHdFFu2RjD/z39f48yWR7C6Zxb/M775M=;
        b=jMbpgZRaGd6EE3q2IEj7gy1c25vl0d/t/9UNgnZG9dzb1kpddwF4haCK7enn+1O98J
         +KojW2qPhoGFJ1xRgVBoo1+UA9CeRfVoqNJYIUFK7ii0NDFpbPQOZE16NzOkgInnWMLs
         nNEdQB38ODi3VMh0JmYdKO3bEvtaLQlWsBdrAziDKSXwZfOyClVIckjBVtIhypf6qhBT
         ikkQ0t8WhSOyV4MX/rfCUHWJpywv7vIPvkKovRjYSDSF8Aq+YMPHhrTowaP3jEvo5Swn
         c2KMeW7mJVZLy4NFp2xhU1axLrF7H5ne6xApmaFVM4nFTKA4IgsvpraaOUvOZaxkhsoq
         icfg==
X-Forwarded-Encrypted: i=1; AL+hErHwvTPMN9t9jek3sGsg3sWUJmv27L6XWihk78QCFNoHl5Ik3QWZ6twbrdXiO7dCO7Cwdm+K+u82RA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8kTFPSCgUKPonX6xv61QrlZGHDL1qLI69cyL43n0xHzn3lo+6Y
	VQPlNhiRFIpmwqf7wBOmIqDp8rTYivYHeZWqZx1+WpC8ulQbbzalf7b7xDE/c0lzlrw=
X-Gm-Gg: AYBFou3c8pRml1BkjtrILMi5CLOFr1ng1bIULUKTUg6hK6kuiFex2sMrb9hnK+JNvVa
	e7hllfZDqZaazSw3NNU+Og/8NOdfcZjWKoVUild2ZmdR3TMvt5ljmFz9yHdl/QdmLA7KeFpgWv6
	zRnbmWXCzTeW69tLLt7Txr0wVcaLj2wG986m6KKqMUROijSfFCKj4q2Ig9u07Sak8C8FzSv0kyC
	L9yFNaVMnwMI7CLg0VFb2Ddo/AqJNKkQnNpmiQQgSo6gOQ+irkcPEULZdz3nhKnHAVZLETahBDB
	fQZ1X+vI5NzzDQI2LND/L9NhumsCKOW+AdAQq747xK6rKX11LChECFlsOdY7lDg/Rs/qwmCfH9X
	zhkWSXdyh1/tApmZguP+G3gQ7+m6C2kdVTDKkGqmslEPhsGtI0sqJLgegpTB92lmDkqKrnGnfuC
	I2J7lM8jiFrHTFujXSx8LXD6eIGmlLDuFRlNyxXAUJAoX+Ih2OEbA72bQDObpTDbZGFMHhJMgjr
	kPyUCsjJY0M55Ls0xQ8NJL8gfM/FQXIzmAut41hlFRJC2Tw6vjSQYk2dNmI5Dt1uycRW2D8G/Nq
	2oIdEGuv4J7zDGzpS0M+jXUJoa+m52gImaJOUwGN9NsVKB5QMxOy3Fsl+2PLAy+vmtE=
X-Received: by 2002:a05:6102:83d9:b0:7c3:2b19:6266 with SMTP id ada2fe7eead31-7d4fb3ddb8emr355668137.22.1794395385024;
        Wed, 11 Nov 2026 03:09:45 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d3023aeac7sm3520676137.9.2026.11.11.03.09.34
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 03:09:37 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7d2ca055399so926134137.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 03:09:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFyfLwv5wcllu+PLp1dc/71CyrkpP63W2iTbsqS7BBo9JgyLbvRfHS0DN3A7yRnoMn2rY5cwg67cA==@vger.kernel.org
X-Received: by 2002:a05:6102:d8e:b0:7c8:1fd5:82b5 with SMTP id
 ada2fe7eead31-7d4fb291ba2mr478980137.14.1794395373576; Wed, 11 Nov 2026
 03:09:33 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
 <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-1-1b2072e8c37e@ideasonboard.com>
 <20261110-steady-kangaroo-of-mastery-5fcd7f@quoll> <179438844820.272237.18262716067322018404@neptunite.rasen.tech>
 <e179b228-3f18-4b99-9c54-93699d13e63b@kernel.org>
In-Reply-To: <e179b228-3f18-4b99-9c54-93699d13e63b@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Nov 2026 12:09:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQOMX2GXnBpH=onofFp1w+TyZPNc3RWjM1pDbpLTG1fA@mail.gmail.com>
X-Gm-Features: AclHuK-p812fgpXzcAZTo074hP5s29t5onlgPposQZBLZQWezlnyhodp5CVCArI
Message-ID: <CAMuHMdXQOMX2GXnBpH=onofFp1w+TyZPNc3RWjM1pDbpLTG1fA@mail.gmail.com>
Subject: Re: [PATCH v4 01/13] dt-bindings: clock: renesas,r8a78000-cpg: Add CPG_SGDn_VIO_DP_{TX,OTHER}
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Paul Elder <paul.elder@ideasonboard.com>, 
	Paul Elder <paul.elder+renesas@ideasonboard.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Nov 2026 at 10:16, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 11/11/2026 10:14, Paul Elder wrote:
> > Quoting Krzysztof Kozlowski (2026-11-10 18:30:50)
> >> On Mon, Nov 09, 2026 at 10:34:22PM +0900, Paul Elder wrote:
> >>> Add the CPG_SGDn_VIO_DP_TX and CPG_SGDn_VIO_DP_OTHER clocks that are
> >>> used by FCPV, VSP, VCON, and DPTX cores.
> >>>
> >>> It should be noted that there is likely a discrepancy regarding the
> >>> clocks. In practice it ought not to be an issue as all the clocks der=
ive
> >>> from the same SGD1_VIO_MAIN clock and none of them are programmable o=
r
> >>> gateable.
> >>>
> >>> According to the datasheet, the FCPV[BID] and VSPD cores use
> >>> SGD*_VIO_DP_TX=CF=86 while the VSP[BI] cores use SGD*_VIO_DP_OTHER=CF=
=86.
> >>> However, educated guessing suggests that IP cores in the same pipelin=
e
> >>> should be using the same clocks:
> >>> - FCPV[BI] -> VSP[BI]:                  SGD*_VIO_DP_OTHER=CF=86
> >>> - FCPVD -> VSPD -> VCON -> DPTX:        SGD*_VIO_DP_TX=CF=86
> >>>
> >>> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> >>>
> >>> ---
> >>> Changes in v4:
> >>> - Add all the clocks
> >>> - remove DNI
> >>
> >> What is DNI?
> >
> > Do not integrate. Most of the patches here were DNI in previous version=
s
> > because they depended on a lot of downstream things, but now those depe=
ndencies
> > are in the process of upstreaming so these can graduate from DNI status=
.
>
> Upstream clock indices ABI does not depend on downstream at all, so
> seeing this unmergeable is just confusing.

In case of the clock indices, "work in progress" would be a better
wording than "downstream": multiple patch series are adding indices
in parallel, so some of them may need to be renumbered. Just like when
adding syscalls.

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
