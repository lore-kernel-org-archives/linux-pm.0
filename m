Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205584;
	b=FWa0d9wLOcsbHkJ1h6IOVo0TVrhI8SxpS41OVRCMZEOvfCmcIFlib2J/dh3b04f9a4x6
	 3DjmWFcF3/DLgWGh3cu78RfxKUXDXl/lJ600ZWIV+YG3mV4tZFbE61Iy+BZv6vnSnbhhC
	 6tYomj/vR4MLCWnUzz2Ztf4RM+TsBtuUhH4m7gbsRzwtswXks0QOGKUU2Nh2WC8LkJb7x
	 Vu78fwUlCICcMpsBHkm8hue/zKzQvzf2d9vGAaGuUy2fJshKH2qqZtzKx5PI4Ip+IVBWE
	 azMI2ZKRyFKRGCESCPg8+B9e4TzrI8BiMjq3tnQkCUpOkBb5DlYg2Blxy2JmVk9u4lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205584;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=TJlktW/QHwQzWX8KmM3KGgch3rcXax0gFxtt66ySgB4=;
	b=JwTuA5jiAYChuuz7E+qQETw9nwrUw6/6Myo6fm/mXnzcgzzdN1vZy4EPLn1NykW7Znnc
	 IB6f2C+gxCA6XSO9+mEbeLlPCVistl+7wS9AFTy4waKJCBs83br6B53MdItL5ZTCd+AJw
	 9GaPKS5oDvLrjZcVQxzddGgXIst9HjWbyJ7nsrUkDqwesaUg6L/U0PJoMPi9s/qdt13Dd
	 uhaD8IM/nal7pbSK/gJFIWiNWQAeD2sqX6TvmEYoA9b7BjIlEVJKbxYcOKjTKt8kH6Zwu
	 BO7zOnQchLdWmZt1QX3IJ2wVicTMV1qqB1kC19sRQbzJ+Wfb4fpETEYJan2myLLVFqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=aoMmoJYo;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133AF606A335;
	Wed, 28 Oct 2026 16:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 133AF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=aoMmoJYo
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E9BADB07;
	Wed, 28 Oct 2026 17:37:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793205449;
	bh=5oFtXnzBQ98MFaco5zMv+o9V6iN5E4nNphi2zpmABz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aoMmoJYo7EOox5Wv63orgylHjdTEx5VSBwQdf4G54k4lg1X1J25tmZPH/0b21GbOQ
	 KV5hzzcJ6M1/2PbiGQDQVL3xCY5yuEUnAlaD92gnsz1am0ww70WreQbrmGB62HeJ0Y
	 UJdm3Fm4e/02xIBObfm44Grlb8/rDMMSRTHEDMiM=
Date: Wed, 28 Oct 2026 18:39:40 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/11] dt-bindings: clock: renesas,r8a78000-cpg: Add PWM
 clocks
Message-ID: <20261028163940.GA2673734@killaraus.ideasonboard.com>
References: <cover.1793026273.git.geert+renesas@glider.be>
 <e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be>
 <20261028132937.GL15441@killaraus.ideasonboard.com>
 <CAMuHMdXycpJ6COtiAA-2oRRfHSfLK40n2cacStW15QJRN3EfLQ@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdXycpJ6COtiAA-2oRRfHSfLK40n2cacStW15QJRN3EfLQ@mail.gmail.com>

On Wed, Oct 28, 2026 at 03:43:42PM +0100, Geert Uytterhoeven wrote:
> On Wed, 28 Oct 2026 at 14:29, Laurent Pinchart wrote:
> > On Mon, Oct 26, 2026 at 03:55:23PM +0100, Geert Uytterhoeven wrote:
> > > Add definitions for the clocks used by the PWM modules on R-Car X5H:
> > >  - R8A78000_CPG_SGASYNCD16_PERW_MAIN,
> > >  - R8A78000_CPG_S0ASYNCD8_PERW_MAIN.
> > > Include R8A78000_CPG_SGASYNCD8_PERW_MAIN for ordering consistency.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > > --- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > > +++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > > @@ -28,5 +28,8 @@
> > >  #define R8A78000_CPG_SGD8_PERW_BUS           18
> > >  #define R8A78000_CPG_SGD32_PERW_BUS          19
> > >  #define R8A78000_CPG_S0D24_HSCN_OTHER                20
> > > +#define R8A78000_CPG_SGASYNCD8_PERW_MAIN     21
> > > +#define R8A78000_CPG_SGASYNCD16_PERW_MAIN    22
> >
> > Could you also add R8A78000_CPG_SGASYNCD4_PERW_MAIN and
> > R8A78000_CPG_SGASYNCD32_PERW_MAIN for ordering consistency ? The
> > dependency patch should then also include R8A78000_CPG_SGD4_PERW_BUS and
> > R8A78000_CPG_SGD16_PERW_BUS, as well as
> > R8A78000_CPG_S0D{1,2,4,8,12,16}_HSCN_OTHER.
> 
> I could add them, but do you have any need to refer to them from DT?
> So far I only added clocks that are listed as clock supplies of on-SoC
> modules, e.g. R8A78000_CPG_SGASYNCD8_PERW_MAIN is supplied to the
> Timer Unit (TMU)).

So we have two conflicting goals here. One of them is to only add clocks
that we have validated to exist (and ideally work as documented). The
other is to keep renesas,r8a78000-cpg.h readable. We won't be able to
satisfy them both fully.

I think we previously discussed adding whole groups of dividers in one
go, as some sort of middle-ground approach. Those are clocks that are
not directly controllable. There's a risk of adding clocks that don't
exist, or clocks that we won't need to reference from DT (because
they're only used as parents of the MDLC-controlled module clock). Do
you think that's an issue, could it cause ABI problems in the future ?

-- 
Regards,

Laurent Pinchart
