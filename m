Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D34E2F01;
	Thu, 17 Sep 2026 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647476; cv=none; b=OchPlI7Qxh40EH5ihRzzlBBMTDKxfwi+W5NZaQImG3v448qkxR1P4niFuJ503DljZdq+Mj9dYTThdFQCWQjFjB+n6rsDK4O9mfrnSCWbqZfnc7YBOhCp3TjiLi6dl8yqAkY3tR58JqOtfyC8+eqygPeLL6l+gipX//bv+lkandY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647476; c=relaxed/simple;
	bh=pJhDjtEfI3y/JufdwLLfcoX28rId297lZF6Ojq5idWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNHCJpYPh4vDNoceQ7aF0siP2QhrS2BiYqLciixKBdxw8slUjz3fUZ1GT7bvARSW+joWJomdQMztRM3/hb7CKdbJrKrxrlM8hH56qhPLsydCviZK6IQENRDozx3ttpdGLnJCJF6oh1wzuC4t2vIrZWwAwV49YxlPlS+/w7wpYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nZ6F752Z; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nZ6F752Z"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1959F2C6;
	Thu, 17 Sep 2026 14:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789647357;
	bh=pJhDjtEfI3y/JufdwLLfcoX28rId297lZF6Ojq5idWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZ6F752ZtElaAUm6diuaB4eUGYTulF1GRH97dfMKLfFjIEWMlDW+Jv4ge6Tn2VWH8
	 pBQReX2ZMk0xeqVZQsN73mjKODnJrxyJqMXvp+8H8VxNDOfb/7Sr2y4LQazH+7t3pR
	 v3mGlAlaAciE8asKKJTcyuD3jMLcauYzi0sv4fMo=
Date: Thu, 17 Sep 2026 15:17:37 +0300
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
Message-ID: <20260917121737.GB44274@killaraus.ideasonboard.com>
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
> 
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

Well, it's always worrying, but as you can't reproduce it now it's hard
to debug it. Let's keep an eye on that during further VSP work.

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
