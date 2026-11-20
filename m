Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164592;
	b=mhMvTtrNoff3GkigL1yms32HH/4jrUEttse7SObPKd+6vo5ejL8sjTk29RX6Er3Chrco
	 K2z4cWJ9vu7MH+err7POAa3cOo5uTXRW9ZqOp013MA2184cAaSNAYbEXJIseZp02emCgQ
	 HtY5dN8x/rNejSWz3Dj38KO2YApwq/6hfQ57UGV5gmDpd0urc2FyfevXTROTZoR6R+0pF
	 DUOQMikyD2S90U7CB/KSxsa4KUmlQq9DnUNBLevoSyR52Hnh3zz4JdVNSLIxvjTGFSf4e
	 iAGME27OA0Mnarx5hN6QuJYvgFF95792lPYYR+1gyoYmvf7OLS0je9W+lCQPZpLCzmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164592;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=slnLzkdmpwFbnxdOJOf8j6Mw1PiHOu2DMR+OPWGMV3g=;
	b=LDX/cFUKS4ZJn5wabihA6pcWOX8EDO53bTww7Q3jJwiSQN9D004Fvq1vG4t2QEdW7jPB
	 KNhui9gL15Uq+riWXv6HRX7BttDk35IRZe/Z1qApu9bm7UVjKYkNjntIWjBjhljReWhq5
	 SSJFIlMrBzk9nNQ2AlsL3sVMG4XlS/FipApb+bHJH3CSP4pf+tn2MAHAaarjbP+uW7eJ4
	 OYLtDgYVDmeIm9d+7/CthxHzd2UN8lM05G1Y3A9w/2gRc7APeAeMp+Hjr7wRFQ+HgJ8Dp
	 l60Ge9SfqVN8hCAbmjpV3QpKbq497M+1F1F9/CwtpLHUTDXmAyQQpaeenIhUtfDr49w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2F606A32A
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 08:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97C2F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so492562e0c.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 00:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164591; x=1795769391;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=slnLzkdmpwFbnxdOJOf8j6Mw1PiHOu2DMR+OPWGMV3g=;
        b=oDm3c3zXjnzjYGrC7BUMNvUDN+HmdKgXvXh9vOimO7QpLiK8Xr1SkoMR5Uze5szdv3
         Lkof+bFt9peJa7bhKFwOxlnYCg3h9hO9wLQtsIGDVTZe1yxidbgXzUO+U77ScLBn0j/l
         TJitL6dEcWUBlfhA5hXBjPSIG/V2sxPgwG8ExNrfRnEmDoBIULk5Ywa5LD+pSKeIW/lI
         AuZOBph9J2/4aTLl4OAugsPBIDZh8ss+MwE4hh3xdC5yfDfaGqOPI/Ow9AlpR8b3BSz6
         IoxLxF+s+LRoS8lj1r5p7t6RlYbh5Iddkg+aowvL1U892hT8k2SNteK+zCOKOtAb9piF
         0eCA==
X-Forwarded-Encrypted: i=1; AL+hErFdemVBJTHlRRvtBt+vCrFhSwkPqtx4Q6c+uFYBAxQ+ChWXglueZKg14QbcsBUZJYNslabQGQlegw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/QswdM34IZFK4MdIN0WLqM5n/fl0DHGeftvrOYUx+zS3QFidai
	jqbT16IIlSNNvsGmnnhJ+TX1DXbBm1EceWEhE0eHG0IpneZ2gnxhEYkOmQArL9Nc
X-Gm-Gg: AZFdTZcwPYxwRAJ8r5kIu8RKZJwhMyYUVV5OfqujXsbZT4kccqz6F4xLFO0dBOF7Bol
	vNFSOOEQ+AfpnHaeL3UefZEnuMKIM+e1RvC/RKzg5dugLiC1P9Iv6Aygh5Ulr/u/i/zlYS38UpM
	Y2LaWqZo4cWyDmPCozjon0ZtVLWgEsYIyrXu4E87fJOx3yZTdA5ETRtxVhwe00BbhN8UnDsLmeb
	DQwzpFXEGuk4Rx7EE0MZnnnPqMtbd6Od2P2sT1p8S5XKIvNomqaRiUnnHbj3OxDtY9j4w7P53U7
	yi0AtDaB6vsQ48XFPGAPD9O3l/oSf4ToZRqrr5yE4btFPlJQT66YBtReeQmIFGm7q/mWuEv1ZDq
	d0WrM5DcvlFQja8joBtdl/iqRttPJggSu6khXhK/4bYLgRxeaNJPdpfzybGAaengrM+xWHd/s5V
	zpUwTUm6BM+cuTa/8476pMtL3CU+KBGXUQU/id+6FCVFyhzzaMobgKVyILwC2gpnbT4kJ0VgoDp
	o6Lw3zRam8fZ83zVMy8Gbn9VcEVH46wtleQxdYazYlo1RTQ3nml0UB6tKL6TqpKRAtm1UI/8Atb
	tcPAwo4ROM3zxQeqfEEc1/Ulj/66Q9J4VXnoCg/Bp4xqGEVV81VK0eNkyg+mJX2HpBc=
X-Received: by 2002:a05:6122:4690:b0:5ea:bda1:7689 with SMTP id 71dfb90a1353d-5ee8af0b00fmr1444036e0c.4.1795164591512;
        Fri, 20 Nov 2026 00:49:51 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b42f564sm2004537e0c.2.2026.11.20.00.49.51
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 00:49:51 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7d2db6408cfso426315137.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 00:49:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEJcV5qT8ig6dlrQLQxfXplUTIBUQQH2WxyiI5Ing/cbf6hN+dbtX1oEnyp6N8XGMt+OdljVijHyQ==@vger.kernel.org
X-Received: by 2002:a05:6102:a49:b0:7c3:7286:c291 with SMTP id
 ada2fe7eead31-7d739587805mr971622137.19.1795164590827; Fri, 20 Nov 2026
 00:49:50 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795094688.git.geert+renesas@glider.be> <683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
 <20261119225017.15a7b5cc@kemnade.info> <CAMuHMdVbgGV_6yjOip4xT3YhBgaOveHzSRbw9e_cHen9NRZqmw@mail.gmail.com>
 <20261120094320.442d064b@kemnade.info>
In-Reply-To: <20261120094320.442d064b@kemnade.info>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 09:49:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWiCODz6RC9Q9-xMM5_k3grHztiLuR+-ikOZYoBawVvZg@mail.gmail.com>
X-Gm-Features: Aa3M54pnWIgbseGoLAFGMXWb1P8DBLFzk6LU-uNSdaE_BgKhwLT8uPsc_3uFT5k
Message-ID: <CAMuHMdWiCODz6RC9Q9-xMM5_k3grHztiLuR+-ikOZYoBawVvZg@mail.gmail.com>
Subject: Re: [PATCH 5/6] [RFT] ARM: OMAP2+: Convert to dev_clk_get_from_provider()
To: Andreas Kemnade <andreas@kemnade.info>
Cc: ettore.chimenti@linaro.org, Aaro Koskinen <aaro.koskinen@iki.fi>, 
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

Hi Andreas,

On Fri, 20 Nov 2026 at 09:44, Andreas Kemnade <andreas@kemnade.info> wrote:
> On Fri, 20 Nov 2026 08:49:05 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, 19 Nov 2026 at 22:50, Andreas Kemnade <andreas@kemnade.info> wrote:
> > > On Thu, 19 Nov 2026 14:40:38 +0100
> > > Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > >
> > > > OMAP2+ clock handling uses of_clk_get_from_provider() to obtain clocks
> > > > used for power management, so the latter show up as "deviceless" in the
> > > > consumer column of the clk_summary file in debugfs.
> > > >
> > > > Fix this by using dev_clk_get_from_provider() instead, letting us pass
> > > > the consumer device, too.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > > Compile-tested only.
> > > >
> > > > The first change is probably OK.  The second change may fail if anything
> > > > in the oh->od->pdev->dev chain is not available yet at this point.
> > >
> > > Test on OMAP3:
> >
> > Thanks for testing!
> >
> > > --- clk-old     2026-11-19 22:44:59.810807920 +0100
> > > +++ clk-new     2026-11-19 22:26:52.862531880 +0100
> > > @@ -1,17 +1,17 @@
> > >                                   enable  prepare  protect                                duty  hardware                            connection
> > >     clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
> > >  ---------------------------------------------------------------------------------------------------------------------------------------------
> > > - oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      of_clk_get_from_provider
> > > + oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      dev_clk_get_from_provider
> > >                                                                                                             deviceless                      no_connection_id

                                deviceless
mcbsp_clks
> >
> > Hmm, so the passed device is always NULL, and thus there is no point
> > in making the change.
> > Do you know if these come from the first or second change in my patch
> > (I guess the second)?
> >
> From the first change, The second piece is nowadys only used by the dm81*
> devices.

Interesting.  So that means all/some of the existing use of
&od->pdev->dev in _add_clkdev() is futile, as it may be NULL?

> I would prefer to have this tested on dm81* too.

Agreed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
