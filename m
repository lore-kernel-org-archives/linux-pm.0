Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82A48381C
	for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792235878; cv=none; b=UHk4g9+sJuQpmxS/pC0bLbsI8OvwPuf+ZROuF+6SVX+YIYlVbCL9PcRBrJFHGL5DloOpqi2FIEMGfEOHobdiUKvyQuD3THLEZlluUheC+xLcsMh7BwkmhqGGhfvuDBrzr9ieMRl6mdi11RAYXz7HcjwjQ2OQMbXk+ViU4407yNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792235878; c=relaxed/simple;
	bh=qnaU4A9xveettmpS+vopSNolBG6QJGbtDjGNYstTtWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtYW8l2KpVbjMZn7vZlF/iVuPLoAX2fVZZYT/Lr9N4DigYh9FdMVqsINsTnh7r6rdazDK7Vmamq+NrDriGlE0hUlOtEFnVeHdO2vweDGNs+Ynt4A6pgD4SkB4WfgoTvOySDknl5jzzvO6jKreMJ68IMp/ZicT6ifL6QIrKTJ9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=c/d1+QMq; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="c/d1+QMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=wxuk
	6IDriLl7MXn594d/LjgaXzjR4puXOU8/hIVUu9c=; b=c/d1+QMqtQyDgaUoeZH6
	ERLHM6l26dA0mOpWZEIpoRWkLzN0XWkgma+AeD36oEsGg5o3EfdzYX5Cp5/eNCqE
	ZGY2axdqXfL48EsScQ63GecPZRcY7sZ6nUlB2Ylr+CW2IR6OMwsXSXGgTNRJT6i6
	v52jeP409R6LS0ERvQhF/AyWBv3jip8SDH3HXI7EHBbo73+SA7EPdLrAnkKd/4OI
	2tk5DWbM+4MdAIO2pKaKElHilapT8folp/DDiZ+nSbrNrg9um27iF3PT18TrOrkd
	Goa+tyLk8oU1lkUEPPKeBlEYpwLrTxeJn8LfXnneWZvqJuroxZ71FbAstfVgUiPd
	ZA==
Received: (qmail 984 invoked from network); 17 Oct 2026 13:17:42 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Oct 2026 13:17:42 +0200
X-UD-Smtp-Session: l3s3148p1@5eDrbQdeOsMujnuO
Date: Sat, 17 Oct 2026 13:17:41 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 0/8] R-Car X5H Ironhide CPG/MDLC SCMI remapping support
Message-ID: <atNZVWSjJV8GiK9n@shikoro>
References: <cover.1792163045.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792163045.git.geert+renesas@glider.be>

Hi Geert,

thank you very much for this update!

> During last OSSJ/LPC, Marek Vasut pondered if we could keep our own ID

Well, it is not the last LPC anymore ;) Time flies...

> This series consists of four parts:
>   A. Patches 1-2 prepare and add SCMI remapping support to the R-Car X5H
>      CPG clock driver,
>   B. Patches 3-6 fix and add new interfaces needed for remapping in the
>      R-Car X5H MDLC pmdomain driver,
>   C. Patch 7 adds SCMI remapping support to the R-Car X5H MDLC pmdomain
>      driver,
>   D. Patch 8 enables more SCMI protocols on R-Car X5H Ironhide.

I rebased my I2C branch to it, enabled the debug output and can confirm
that the clocks and resets are now mapped and I2C still works fine. So,
for the whole series:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

The branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/x5h/i2c-experimental

All the best,

   Wolfram

