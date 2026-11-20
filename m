Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160993;
	b=a9By+Q6AksobOJxmDoIHGRvqmZkkHwXiq8eKU9VDUvB6wzLkBmmReoDJ0DI2Ck4PN9Lm
	 xMfVrGA4zpzEn1BPB9NBgxBD4ZIrpFb3BIsFQbYJa5kBWwDxcYhvAqI59n5IKu2yoD/vi
	 IP+8X92iwTwG7XrSO46HFVcJWdH8U6Qls/WVdW4CqeWGIgMTxbVLwFMzSdTUjckrmA+yb
	 73npAcjZmgUj9tNdWnlV8tzBRFnZZJ/CKxURfMp/B6m3yboXsqhXtCYnJtDB2Gf5NRl06
	 F88qV5o+ZILO0ZGNDDM+bbPFfaewKb2CKQSKxk/qQqylTgUSyXs5HWfEX8yHSwMhRvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160993;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Vu6IMQbhyMpXX+yWtY4enAtEpk8kj3N3fFV230nsSvs=;
	b=bF07/LIEa7t3cPmQdSrUcjcgvmKreYczwqPf6FtRkbOaXECWMbGxWRVRHueAp/rXjpww
	 VpISV25WM2uzmw6MOqzG3oecc5PY/he9NR0XHmeyuCvzlWWwxhSi+QuR1G8kNTXllXAqQ
	 I89+LsKjWQ0ZTAXlTclyxwWFPgJe4Zb5yrHVWFgTQTi2xiBfAmtitstwRIiimyLK1wEIo
	 gCz75qUFeXQaHlYNGMb7ZvkdczVuP9WCsbPxVI51bUuPUTkMOFFNjNIfeUpR8d5x4Bb9R
	 tZfgzMswEak8x4jmlZXHSa1MGfKGvPXR1ooelsXDTJGdRKSLBk5o1r5Sm4/25YyJM5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC58606A325
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 07:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDC58606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-94965745d92so65040085a.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 23:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160992; x=1795765792;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vu6IMQbhyMpXX+yWtY4enAtEpk8kj3N3fFV230nsSvs=;
        b=23gEaE2ZVFGBw6l0T9ZJU9O0y3SApPMWyLRWlEsnnV++89REcvzaKdKOSEqXOzi7Wu
         n1kG37SipGV/VpUIaDp47S7afkx4xNCHL/UGUCtso4uJzmj92Qx3KO0LdYLIjuGP/4/e
         yaHFpaMjAj1kD9FX6ZuI4OFWFKOQHGPaKglLLdeGkhCFOUHRbrxsuwjfdpVD3YFduYi5
         wlnZ0meLn8XV11aACgR3bN4Cojo7Ru9wJoswjNQ3dzaL/CB26jZfPrTu3ixaBgiJtpQ2
         rNKDKln9pJlKsF9ncAcwXLfEC/RhC2ypujQ5Sd1p3xx1zI/7oCeWDfwZzYFqQkhd4tWK
         1WTQ==
X-Forwarded-Encrypted: i=1; AL+hErFFIwISyvDQJ00oiBkJJ1ADgSNTZEqc14K41xI9hamGtOCnTQHObDRiH1tNKaFVV11bIjUfXT9+6Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8boTilKm8RWBRkroWLWX9xq06Q1VeO6hu0VPfMhvoDrw3z2P85
	sFgKb1ye+70dpjwz46Rv9EKgvoX/oBMDO000ZisKAPSUU/hTCnmjYEhmYUNI2YnL
X-Gm-Gg: AYBFou2JwajPIMTQJ8faYX1p83q+N+TUGncrviiiOEo5UN1+h+9vr0P6rJfY8ODcwxk
	E/yDeuf3guTOyqKmkx02ZoKkMOMNMoCJrLFQWDCEzdY8exsZ+JXgymqL2sYPA4wa7EMxdacPsvp
	4cOMeg+rYQIIs9VDJKBGIG0hEQNrLLPzMnO9ZBzlTC+CVXNIfSm7PZBy11WL+mF3Ntj30ir08Df
	JoAs417vfLJzZp002n/pdjwB9GlrFugwfszL1B4pvuvrDwEOXClCK/I8vtGFn7Z/2djm+84GqDt
	v8FDJCjaRdxqzlAkYK5erQ9r9gzCO6gIjrNZmvQfgLBpH6luWvTaAaBeNYgc19sGwljeNccKUTC
	PVx+DOxTLRsFWoN4nbh2VcTtIkeyXMpMjX/ELvmonngolClsSVSPLN74PnEMWfY3h59t9WuhfLP
	q0j3slj8Rz9s8WER4neUQevE8t+4w5R+Ie/eZpXqSw1imwcs9euAjtDX5rU1i1OXIZoN4Bwx2vR
	jqf45FELXkFVUYP0Y6vo017drhJ7wkg7HeUscit4LttOfEJ394jTfEpq5TK451wpigWqkX6jaVp
	fTmkjkhmw+pOqxYFUs6H6oAAe/uUTyJ5AqdZqd2ZTzuKRa/VD369ZHmJt3+jutwhatw=
X-Received: by 2002:a05:620a:600e:b0:949:569a:a3ed with SMTP id af79cd13be357-949ba7e422amr345265485a.1.1795160991883;
        Thu, 19 Nov 2026 23:49:51 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb41a341sm137798185a.37.2026.11.19.23.49.51
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 23:49:51 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-92104b67a9aso7190766d6.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 23:49:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGsvA3vzuvPBsy6PuCiyza0e6DzFV0TDfij+/R3HR/H/l69pj/rNqrKvH4OOQIE6pLisY/19DV+vQ==@vger.kernel.org
X-Received: by 2002:a05:6102:441e:b0:7cb:bda3:27ab with SMTP id
 ada2fe7eead31-7d7393925f5mr941037137.13.1795160681386; Thu, 19 Nov 2026
 23:44:41 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795094688.git.geert+renesas@glider.be> <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
 <179513882271.284394.17357508909448455391.b4-review@b4>
In-Reply-To: <179513882271.284394.17357508909448455391.b4-review@b4>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 08:44:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWJ8zK+kzcznM7FJ3JCo1xWzjRZ5MQz9jhSUcYQfO5rBA@mail.gmail.com>
X-Gm-Features: Aa3M54p6yw1Lhc431P_jQfP5g0YMf_od8mct8UUR6SclOJC7dcSgYi-awR9w8qQ
Message-ID: <CAMuHMdWJ8zK+kzcznM7FJ3JCo1xWzjRZ5MQz9jhSUcYQfO5rBA@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: Remove unused clk.dev
To: Brian Masney <masneyb@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-clk@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Brian,

On Fri, 20 Nov 2026 at 02:40, Brian Masney <masneyb@kernel.org> wrote:
> > This basically reverts commit efa850487a6b6742 ("clk: Inform the core
> > about consumer devices").
> >
> > This commit added a struct device pointer member to struct clk and a
> > parameter to clk_hw_create_clk(), but the new member was never used
> > beyond setting.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/clk/clk.h
> > +++ b/drivers/clk/clk.h
> > @@ -5,8 +5,6 @@
> >   */
> >
> >  struct clk_hw;
> > -struct device;
> > -struct of_phandle_args;
>
> Did you mean to remove of_phandle_args?

Yes, it was added by efa850487a6b6742, too (although it was
used in that header file before). Currently it's not used.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
