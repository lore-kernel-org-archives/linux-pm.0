Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426866;
	b=f32tM2ruQ8R2lsrK8ucBLDB3fLWLUEYtZKgTX16ICbsmYE7vrNcrUjwm8ouHPKdpvFMK
	 J8rtwwsEATO2UZsj94TJf2xI+5/H0JlHSCWcUMW9r+UWCFfNN0jhnrOUwZJfuXyBrsHeZ
	 lAEprmKTenFnfgU4OWAP9sJ4exHXmLsimX0cR7ZFcR+73uF2L4K79M/TTuKugmO7XJhum
	 yXZQnrAh0ya8MaCsZsmgHQQQZXoNyLYhjbb1zzFDsDIsTAewUViL8mOs90SpZF8q5vJZR
	 5sX/E/dyuWEiuqG1s9lFlWXjOLeYZJ4e6ypzA5fGvKre3c9Nfri4cI2wtMpHpwgj6xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426866;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=VNVvlFmAYqdL7e0NbR8n4mhG40CW5PlDGJg9XCAnokY=;
	b=hWB636QmLBKyMa9xNF9NaHV6fSnCpTKWxiqHzr9VG3k/xEHYvQECwSDRnBzVJt+LF01A
	 hDxWYlGL7HvqIpX8buMii66vUwwQcnUx5mqgFA5xB64vDEoWO1KoXD/d0Xd2DBDAfST6h
	 KN33RAhVR3utB1Iyj4E0ic8Ws3ug8HA/gg4e2xFKY20tjaJbyFLx5ujQ1oqKUqIiFE4TI
	 tDXNP8IHHuKHnO0+RA8rs64iRJ0oatNo0VLbQbCi+g1vag8ZiGORWq8r+p5v4gV3cat8E
	 1Mm5shKZf19Kgr0WB/3Rr36qISSKqHk9R8O1+oTtbtggVygF5QbRHMBJ/ZEDbRvFphg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4960A2613
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4C4960A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso993986e87.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792426864; x=1793031664;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VNVvlFmAYqdL7e0NbR8n4mhG40CW5PlDGJg9XCAnokY=;
        b=Q0jHvHW4QJ/PWyqPDqNRmdpzOY9BdxErmJJ8WpXGzrVWq7BkXWTduyMCOyqIrWGenM
         F70sB7p+cpWTexVM6GWp+FbBSCEwACMD+rPk83uO2D+hYaLZ1OR5INT097PvRxPG/cp3
         T2dl6q6laz3R0p3m1StbDuoMaSQ9qXpnvPT1uySlZgxjfbS3Yuq5ryNi8/NZZ5HRG09P
         oq26JtgK8LW0ZL8gr/5h9DFU5JUHbQKWIZMp6JQTdsJWsA73Pj92iQdUNxkbe4wbKhjP
         HpL0dBvPfnU2eSUFp9PoTDOO12p56VidRpwVA8ifLQJc42W2Ig1P7tF1L9oX2PTuwzkY
         7zhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzntiZ0Ya/+iv+7t+JvQUpYebTTTF5UbKsEcfq1BKuphh7Fei47aTqjlmLx7cGeOtLgqKJ4pTEqg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKt5emhS0p00bHm9Wr2uvMJqrxQ/M29P+dcrIGduBzHepP+EPjv
	iVfs5b9B6v+3MdQuNHfOJIKxJKxHtPWfUtGiC5rrdZEJ2PxhNKanWJkSYgvE9xD8sSs=
X-Gm-Gg: AYBFou3AASvmIfbH9WUSelvrEoLThllxYdTq8R7ZdiIHuvwICsr4iHjhmMc+9QYwSlV
	nRLteR9fS4JN5XJpM4sEuGANQck7Rf2r8cz96yr0xkAVfh/PU5lGavsUKxVI4P+9O5BV2mQAWRx
	UlJ4//3FpWT3YJTECxMR6+Xp/QK1v84xJqC3l7J9Km8x2vzAxYqD8vDbUjQOYOwr1kxh2H8eMwc
	N5xupdZRVvHpgwxCI6GX6GogzSM3XlQQuiyfkbM3eGLeYusWbeNMjwE5ANSsTO4HjFbHHNgQSzr
	W+lbnokSquU8scbDLSht30W7Lmo2X0APasizdfrIyzNSv5EKpLBYTXfY/kk5W9KTl65SlnooKtr
	FQ6L7OShyqWKJJaE38Gb8v9F0Ze7ghbmZp1cKcWnDKTiNa1iiQD96Z+1U+jX8HosKT6JZzyumcz
	ddoHq73VBPCS5msMasO8j+dCsG9ZyZtNj9wmUNDx/p6q88/M1KYJOJoxej1gJL/80RNt8LgoyrJ
	xqxkI6vi7lteiouHWsDeHKwqH4mMQPTEvJieWqx9oPEKROL
X-Received: by 2002:a05:6512:39c7:b0:5be:4386:8076 with SMTP id 2adb3069b0e04-5be47919a71mr3312425e87.28.1792426863443;
        Mon, 19 Oct 2026 09:21:03 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a3fcf91sm2205200e87.7.2026.10.19.09.21.03
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 09:21:03 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bce4e278baso1177998e87.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:21:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzBPBhTqUfK2qzmLL6EmXXCQShJ86N5MIsAhB2+COD51rgWBwhHlsTGIJVoC5cfzFKjkNoeonkfqw==@vger.kernel.org
X-Received: by 2002:a17:906:99c2:b0:c41:825d:ed8c with SMTP id
 a640c23a62f3a-c41825dfa20mr602336266b.26.1792426550419; Mon, 19 Oct 2026
 09:15:50 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792163045.git.geert+renesas@glider.be> <c38d744c09dffff550a9b882051c211b572b8daf.1792163045.git.geert+renesas@glider.be>
 <20261019155619.GB3705@killaraus.ideasonboard.com>
In-Reply-To: <20261019155619.GB3705@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Oct 2026 18:15:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDgc+NMFQ2HgkngsvyhVd1+yEgnk3DQpyVmVUQ_aLvEA@mail.gmail.com>
X-Gm-Features: AclHuK_Wqb_TY8SIlHzico7Y9pGZs0pikimfidJslyUcM_WsFGAezgyxmzAMr2w
Message-ID: <CAMuHMdXDgc+NMFQ2HgkngsvyhVd1+yEgnk3DQpyVmVUQ_aLvEA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] clk: renesas: r8a78000: Add SCMI remapping support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent,

On Mon, 19 Oct 2026 at 17:56, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Fri, Oct 16, 2026 at 05:55:41PM +0200, Geert Uytterhoeven wrote:
> > Extend the Clock Pulse Generator driver for R-Car X5H with SCMI support,
> > to remap DT clock IDs to abstractions (clocks) offered by the SCMI
> > firmware when running on a system with SCMI, and SCMI support is
> > enabled.  Take into account some peculiarities of the current SCMI
> > firmware implementations, and fall-back to fixed-rate clocks as
> > replacements for SCMI clocks that are not available.
> > Support for bus clocks used by serial, I2C, and SPI devices is included.
> >
> > This lets us avoid putting SCMI IDs in DT, and allows us to use the same
> > hardware description in SoC DTS for systems with and without SCMI
> > firmware.
> >
> > For now, it is assumed SCMI clock IDs are stable, and match SCP FW
> > SDKv4.31.0 and later.
> >
> > Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/clk/renesas/r8a78000-cpg.c
> > +++ b/drivers/clk/renesas/r8a78000-cpg.c

> > @@ -94,6 +113,21 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec,
> >       return hw;
> >  }
> >
> > +static struct device_node *scmi_find_proto(struct device_node *scmi, u32 proto)
>
> This is the kind of function name that looks prone to a namespace clash.
> I'd name it r8a78000_clk_scmi_find_proto().

I deliberately picked that name, as a suggestion for a future common
helper ;-)

> > @@ -145,7 +184,46 @@ static const struct clk_map *fill_clk_map(struct r8a78000_cpg_priv *priv,
> >                       break;
> >
> >               map[i].fw_id = map_in[i].fw_id;
> > -             map[i].hw = fixed_hws[map[i].fw_id];
> > +             if (map[i].fw_id >= FIXED_CLK_OFFSET) {
> > +                     enum fixed_clk idx = map[i].fw_id - FIXED_CLK_OFFSET;
> > +
> > +                     map[i].hw = fixed_hws[idx];
> > +                     continue;
> > +             }
> > +
> > +             scmi_spec.np = scmi_clk_np;
>
> This seems to be safe because a NULL scmi_clk_np implies usage of the
> default map, which only contains fixed clock offsets, but that makes the
> code a bit too fragile for my taste.

Fair enough, I can add a check for a non-zero scmi_clk_np...

>
> > +             scmi_spec.args_count = 1;
> > +             scmi_spec.args[0] = map[i].fw_id;
> > +
> > +             clk = of_clk_get_from_provider(&scmi_spec);

... but please note of_clk_get_from_provider() will return -ENOENT
in that case.

> > +             if (IS_ERR(clk))
> > +                     return dev_err_cast_probe(dev, clk,
> > +                             "Failed to get SCMI clock %u\n", map[i].fw_id);
> > +
> > +             hw = __clk_get_hw(clk);
> > +             if (!hw && fallback != map_in) {
>
> And if the above is correct, fallback should always be different from
> map_in when fw_id corresponds to an SCMI clock.

True.

> What issue does this catch ? Should the fw map contain a fixed clock
> entry for clocks not available in SCMI ?

Originally it had entries for fixed clocks, too, as the firmware
restricted access to several bus clocks.
Recent firmware provides access to more bus clocks than before, hence
I figured it would be better to use the SCMI clock when available,
and only use the fixed clock when the SCMI clock is not available.

> > +                     for (unsigned int j = 0; fallback[j].dt_id >= 0; j++) {
> > +                             if (fallback[j].dt_id == map_in[i].dt_id) {
> > +                                     enum fixed_clk idx = fallback[j].fw_id - FIXED_CLK_OFFSET;
> > +
> > +                                     map[i].hw = fixed_hws[idx];
> > +                                     break;
> > +                             }
> > +                     }
> > +                     if (map[i].hw)
> > +                             continue;
> > +             }
> > +
> > +             if (!hw) {
> > +                     /* CLOCK_ATTRIBUTES is not supported */
> > +                     dev_warn(dev, "SCMI clock %u is NULL\n", map[i].fw_id);
> > +                     continue;
> > +             }
> > +
> > +             dev_dbg(priv->dev, "SCMI clock %u is %s at %lu Hz\n",
> > +                     map[i].fw_id, clk_hw_get_name(hw), clk_hw_get_rate(hw));
> > +
> > +             map[i].hw = hw;
> >       }
> >
> >       devm_kfree(dev, fixed_hws);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
