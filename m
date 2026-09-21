Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A844E046;
	Mon, 21 Sep 2026 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977107; cv=none; b=Wr38JXUy3G+/1ij7BTH399vX6Uh8YXImOg8Zd+h4sXgrzxxhLsK8OGsY7EldTfVyNLUtLETfduDPTp1l1iE0YErilZBmv5DyOQn7qoOEu1SthiGesf+PEpo69lVyF1tb8HWan6WPfgYu9YFzLwS0njYfUDGuMZqR6va1boPy3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977107; c=relaxed/simple;
	bh=sZlS+5hBTeYamg0dI6hO+fZLWCFBhpnY6tKiaHd8tMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btNTEfa0o4ujZ2I/i7iRwJo8wjvmCq4PQqKkNCPStd+wDYljxJTXYB++uaRm5MZpSG22QKMUqaARDjJlnXIHz/kWamAL1qpY2e8+EolOBv6PFJA5AKJYyk4DVwD5J581j1uFSO/UuL76b3tbltk4im2wx/wKyqFyde8MPG78HCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=L+sK7M1R; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="L+sK7M1R"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 282A7153F;
	Mon, 21 Sep 2026 09:49:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789976998;
	bh=sZlS+5hBTeYamg0dI6hO+fZLWCFBhpnY6tKiaHd8tMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+sK7M1R0d3rjmIkUs23v4Y91mzJ9bHr8jjSxwK4aS2qXXoFtQHYCrGWRjnz0Byzx
	 vNNimR4pBTHeG7SeHma/holVeUOWYrcU/oa6HMGMPLxwPNoAXKe5uYt2P4THeDt+p7
	 QcgTtPmdb0AhxJaj4n835+aHRKYh3D1CTLc0YuqE=
Date: Mon, 21 Sep 2026 10:51:41 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Elder <paul.elder+renesas@ideasonboard.com>,
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
Subject: Re: [PATCH DNI v2 00/11] media: rcar-fcp, vsp1: Enable on R-Car X5H
Message-ID: <20260921075141.GF24505@killaraus.ideasonboard.com>
References: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
 <CAMuHMdVC2vNp2nTHUi3saTZ8UD4ggeB_aBEvN9XP+EToOr7G2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdVC2vNp2nTHUi3saTZ8UD4ggeB_aBEvN9XP+EToOr7G2w@mail.gmail.com>

Hi Geert,

On Mon, Sep 21, 2026 at 09:41:10AM +0200, Geert Uytterhoeven wrote:
> On Fri, 18 Sept 2026 at 19:07, Paul Elder wrote:
> > This series is based on Geert's
> > "topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v3" branch [0]. A
> > branch including this series is available here [1].
> >
> > This series enables the FCPV{B,I,D} and the VSP{B,I,D} blocks on the Renesas
> > R-Car X5H SoC.
> >
> > This has been tested on an Ironhide with the vsp-tests test suite [2].
> > VSPI:
> > 145 tests: 138 passed, 0 failed, 7 skipped
> > VSPB:
> > 115 tests: 104 passed, 0 failed, 11 skipped
> > VSPD (a):
> > 114 tests: 99 passed, 0 failed, 15 skipped
> >
> > VSPD (b) hangs on the tests, so that needs some investigation.
> >
> > The first couple patches add clocks that are used by the FCP and VSP,
> > but as the upstream X5H CPG driver is barebones at the moment and we
> > don't yet ensure that the parents are enabled, these are marked as DNI
> > for the moment.
> 
> The DTS patches use DNI definitions of clocks, so they should be DNI, too.

Can we add non-DNI clock definitions in v3, or is that too early in the
grand scheme of MDLC and SCMI development ?

-- 
Regards,

Laurent Pinchart
