Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9685B3B27D4;
	Fri, 18 Sep 2026 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696237; cv=none; b=NWAEPzDxJRf7bchVKl4zJ7hz16hcTAm3RacGIdoPYa3+grcM56EXgMmYooeK3bsclWy3xTGXJ3BzmWaHITXtJMPgGAherpHoRj1Ad/enP5pj3Wvq4gpDgiDuLNQqEv9ogbUw9CEZ5u47d7tGkQRAx6mCCS5Ff39AcCw2dRq71Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696237; c=relaxed/simple;
	bh=h2rnnvU1cABd1Qm85kshfAoTaocBNolJoMMn0SOrP2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7TrRS70NTmvX88sZQWbcD5nG+OLRQDS166szayJAfxbD1iR3qmjN02++ZVPrSofPmCQkAh0w0RmQoeysFpxr5RZIdnVzVOr85Sia54m8E8uVBHX8yfd/fxsO+1WZ5LAehxAbTrIn0FN5qwWf6gu0e5HKasWygI2AO7GA65yq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WK+s33XW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WK+s33XW"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8585B4DC;
	Fri, 18 Sep 2026 03:48:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789696118;
	bh=h2rnnvU1cABd1Qm85kshfAoTaocBNolJoMMn0SOrP2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WK+s33XWYcpStYU868v7Jk2/7Ndecv2D71Ut07mRDZxnQnTkoO9IOzSXmEGGMeYye
	 LXon4+ic+fxFC14w2LXuTacNjGh8IL2L91e/lFlXKbArSTShVemTWEZYAAWKi0xbVs
	 aYN/RqZ8kMkC25Boz/HugRF6ty2zHyEgX8hO/E8M=
Date: Fri, 18 Sep 2026 04:50:19 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Paul Elder <paul.elder+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 00/10] media: rcar-fcp, vsp1: Enable on R-Car X5H
Message-ID: <20260918015019.GA736264@killaraus.ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>

On Thu, Sep 17, 2026 at 09:04:39PM +0900, Paul Elder wrote:
> This series is based on Geert's
> "topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v3" branch [0]. A
> branch including this series is available here [1].

The series contains a mix of patches ready for upstream and patches that
are not. The cover letter should explain this better to avoid wasting
reviewers' time. Please organize the patches better in v2, mark the ones
not ready for uptreaming with '[DNI]' or a similar prefix, and explain
the rationale in the cover letter.

> This series enables the FCPV[BI] and the VSP[BI] blocks on the Renesas
> R-Car X5H SoC.
> 
> This has been tested on an Ironhide with the vsp-tests test suite [2]:
> 148 tests: 142 passed, 0 failed, 6 skipped
> 
> There was some odd behavior with the clocks, where from what I
> understood was that the clocks for the FCPV[BI] and VSP[BI] are
> always-on, but the tests would hang unless I explicitly enabled...  the
> always-on clock (or fsleep). Then after I removed the patch that
> explicitly enabled the always-on clock everything ran fine. Just
> reporting that this happened just in case it's relevant.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v3
> [1] https://git.ideasonboard.com/epaul/linux/src/branch/epaul/v7.3-rc1/x5h/vsp/fcp
> [2] https://git.ideasonboard.com/renesas/vsp-tests/commit/900168f58c9d96be0592c2593f4d8f34edc9c69e
> 
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> ---
> Paul Elder (10):
>       dt-bindings: clock: renesas,r8a78000-cpg: Add CPG_SGD4_VIO_DP_{TX,OTHER}
>       clk: renesas: r8a78000: Add clock for FCPV and VSP for SCP FW SDKv4.36
>       pmdomain: renesas: r8a78000: Add maps for VIO for SCP FW SDKv4.36
>       arm64: renesas: r8a78000: Add FCPV[BI] nodes
>       arm64: renesas: r8a78000: Add VSP[BI] nodes
>       media: rcar-fcp: Check device revision at probe time
>       media: rcar-fcp: Handle resets
>       media: vsp1: Support full VSPB on R-Car M3-W, M3-N and E3
>       media: vsp1: Document X5H SoC ID
>       media: rcar-fcp: Add R-Car X5H support
> 
>  arch/arm64/boot/dts/renesas/r8a78000.dtsi        | 171 +++++++++++++++++++++++
>  drivers/clk/renesas/r8a78000-cpg.c               |   2 +
>  drivers/media/platform/renesas/rcar-fcp.c        | 162 +++++++++++++++++++--
>  drivers/media/platform/renesas/vsp1/vsp1_drv.c   |  13 +-
>  drivers/media/platform/renesas/vsp1/vsp1_regs.h  |   3 +-
>  drivers/pmdomain/renesas/r8a78000-mdlc.c         |  34 ++++-
>  include/dt-bindings/clock/renesas,r8a78000-cpg.h |   2 +
>  7 files changed, 372 insertions(+), 15 deletions(-)
> ---
> base-commit: 02c5d61866607bce0b3271e7c1b838c53dbedc55
> change-id: 20260917-epaul-v7-3-rc1-x5h-vsp-fcp-8afdeb2740f7

-- 
Regards,

Laurent Pinchart
