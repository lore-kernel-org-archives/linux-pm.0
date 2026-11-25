Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640199;
	b=AhZ41rorQfQFqfY7CIMHaMzGGeVl2sumi31TCIFQjXmvQGBn1pDJu5GyAtRlbxKbpY4O
	 MeVZGFzp1qjm1vxhVlKo0OJAgCgDy5mq6O2l6tAkVCmRVSgrmcLuf5voFhJxhfypJ+T4T
	 Rv2kF54Ot7ClwvnjtRYCAnf05oz1XOQxEUsaDSkPl9olWiZjxRjDb1UJy8utJebUYdTSf
	 kgr4ZRa97YYxGcx5xAvYv2R8OasoIGMvUc1HBdOQm6h+VvABNXruBZ5nFbHFKdGPeDI8X
	 hby9V+GAADdXWtcIJX4mRz/gCcqm3Xnto6Q656DbCFTWmJOjKoM31N1Bi6PN0LrUvRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640199;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1kRROKKosl/yXIFPGvtByySBNrtF9KbT7CipojNr2Ac=;
	b=y5PU+Wnf9Nj381PaDrbP51+xZk7mHLdjzU5mX2cRvcsTJr3roVfE8oyFEl4RuJdbP9wo
	 3sMJSkKZzvrCIbz8QELybogWRBLQUPO9Gv3yoAfipc0b8A/frGcWKgpQusUIcFL44kh4w
	 EoRNN4vy44DbXPB5ktvirnbSIPUpu+3Byor7RrsUG2F+OTQ1pvTK1C9WrcJ/1/tcNNAmS
	 onMwwAuBPXbUw9I6XlNvCsZAWYXytsQNzIzK/a3YQhbbiWMy2nsmaQYSIib0q8m1eYijR
	 PK+XTcNZcLCh6O/C89rrmZqAKzjtYvzVdSTAZPhizAQh6k46/Vus8Q0mry9QE8D/8ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=IC5AH4wH;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19849606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 20:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19849606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=IC5AH4wH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=1kRR
	OKKosl/yXIFPGvtByySBNrtF9KbT7CipojNr2Ac=; b=IC5AH4wH8ctwgU1Tad8s
	xxEe94U8RhC8pxG9PqWsbXeD8GVt2Y+5Mvs31bENX9y38nSyIDNndU9Y1PG0a7NN
	W+BuKm74LzsdGg6JApTSoC+1xeN6L07eXNsFtuL+Sij08GFgJ8UJumuydRlNXvxu
	jM3vqfO2wWK8nSQKrAUPz730IdfB47eT8S8imuHjYRXMHCIItemfb0v/lCesvMz7
	LJZSN3QJrAXQqhy1pqUb6z/kHft2RKTw7xem2GTTITZu3xnp8TApeA/ATHOUGM53
	MbBSbQhwqERI4NeMSCtkHF8ddkv/OFIAFw+dYxneDk3fgbvDvYfaWtwnCdpMjPiV
	uA==
Received: (qmail 1132956 invoked from network); 25 Nov 2026 21:56:32 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Nov 2026 21:56:32 +0100
X-UD-Smtp-Session: l3s3148p1@ZOnQDyBhXuAujnvc
Date: Wed, 25 Nov 2026 21:56:32 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>,
	linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/6] clk: renesas: Convert to dev_clk_get_from_provider()
Message-ID: <awdLgHC8WvGsgQAk@ninjato>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <55d67b95c675924fb67d13ecbab47bb45c8af372.1795094688.git.geert+renesas@glider.be>
 <awQ6PXdLz88kI9wQ@ninjato>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awQ6PXdLz88kI9wQ@ninjato>

On Mon, Nov 23, 2026 at 02:06:05PM +0100, Wolfram Sang wrote:
> On Thu, Nov 19, 2026 at 02:40:36PM +0100, Geert Uytterhoeven wrote:
> > Renesas clock domain callbacks use of_clk_get_from_provider() to obtain
> > clocks used for power management, so the latter show up as "deviceless"
> > in the consumer column of the clk_summary file in debugfs.
> > 
> > Fix this by using dev_clk_get_from_provider() instead, letting us pass
> > the consumer device, too.
> > 
> > Sample clk_summary change snippet on R-Car H1 Marzen:
> >     - sata 1 1 0 62500000 0 0 50000 Y deviceless    of_clk_get_from_provider
> >     + sata 1 1 0 62500000 0 0 50000 Y fc600000.sata dev_clk_get_from_provider
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Tested on R-Car H1 and H3.
> 
> Tested on RZ/A1 (Genmai) and RZ/N1D (demo board).
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

And now also on RZ/G3S (G3S SMARC) using the rzg2l driver.

