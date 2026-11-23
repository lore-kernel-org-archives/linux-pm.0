Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449960;
	b=tMpGlDNdyWxDf9vOKIk2VdHNunOAYfzshKHywgD2mg9cjuPjE/8BeoHyBZbM0+8wm6El
	 eiHZ/j7/w4HTikqQfxNqkmCNNArYpIDAiqo5yiqt5LoipkXYrRE/wtYe6pZD14x2VUXOP
	 wfybxyG9LHBFzQvDAGMc6VnsmEy1zY2dfYF0xGMg6NU9jF+ttcEbFa9JmIin939XzPMar
	 xYn5rFCjF48dybbHaJroma6U4EeTjgYJUWXl0/EcvIkKlKGq92s4vSeyncnv6oUlLw6up
	 3hUebYSHamjZaxq1OFEUlSlFTkLWonqCy9OijIpKgeqt3OdZM5EUVHU0xgHGUn3eR4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449960;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=WFaZs5yZ2TaZla+3aHjGks0CtdazRULWW7qGO/cJj/M=;
	b=2vE9F+CkA+ITvU+esW+5WnFTFW+UBs9si76NhYAipCDsv6ppjt9q/Ra3aBBvdLBMekLt
	 A0fSIAoNlbhURQQdJeTEWEtPR4XsZ9hwPWrpBxOCfqxtiwu9ucKBcwJ906LSg2sBpME6D
	 5E1nC4F15amWu8UzmtBRrF10oxUZIDyrJAcjGHzXFDYdGInwofHR1DMau5Z6L2LiczEX0
	 udMUs92RcWoVwJcb34oCGzGOYZHx0mZdl2krXTRP+rRjRCXsHXmiLrv8c+MdH3V2SqTYM
	 2z/ASZH/qlnbTZv03fMdrWEfkijb5Gj8HwPk6ngGZEnDoMnA47IK2vdV8+jPX4uAA/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=KFdgICcx;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D861B606A31A;
	Mon, 23 Nov 2026 16:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D861B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=KFdgICcx
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 35FFD524;
	Mon, 23 Nov 2026 17:03:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795449799;
	bh=9pK6J6oL7XAG9XZBoQELiXRbBhkc76Tz47n6q6kkJAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFdgICcxqgkA3zwfE9GsbuyXLe7fSbl/+MVxyWxmnfzBxlItzM+xhHGfU+7lGVLPR
	 iCJDRBNnTy1W3fGeYji3o+1IR613Jhy3HmMWP3HYW7S9LXSz5ajCmjM/LiOWM5fx4B
	 hLr+BngZaAUkte/VYUwVgTWCSpjhnzWMhZuTiPl4=
Date: Mon, 23 Nov 2026 18:05:50 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: =?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clegoffic@baylibre.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 00/15] R-Car X5H Ironhide CPG/MDLC SCMI remapping
 support
Message-ID: <20261123160550.GA3050935@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>
 <20261119234759.GB2324725@killaraus.ideasonboard.com>
 <19c3745a-6308-46ff-bb37-3acc88fe22e2@baylibre.com>
 <awAqqg6F2Z1t55x2@ninjato>
 <d94ad9ca-afdd-4301-a69c-0bbad5b334fa@baylibre.com>
 <20261123103633.GB2959742@killaraus.ideasonboard.com>
 <fc13a7a8-b825-400c-9ea0-ceb2670dc478@baylibre.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc13a7a8-b825-400c-9ea0-ceb2670dc478@baylibre.com>

On Mon, Nov 23, 2026 at 04:46:49PM +0100, Clément Le Goffic wrote:
> On 11/23/26 11:36 AM, Laurent Pinchart wrote:
> >> I know several SDK versions exist, and supporting several of them is work for a vendor tree.
> >> As Geert's cover says, "While upstream Linux must only support sufficiently mature firmware versions, vendor trees (e.g. renesas-lts) may still want to support development firmware versions".
> >> Each SDK version can then have its own DT there.
> > 
> > That's not how DT works. Please be gentle with Krzysztof and avoid
> > increasing his blood pressure :-)
> 
> These DTs would stay in the vendor tree, so they would not reach Krzysztof :-)
> Upstream would have one SCMI DT, as v5 has one table.
> 
> >> If a release that changes ids is already out, it needs a new DT, or a quirk for that one release when the DT cannot be updated.
> > 
> > So you're proposing that, with any new firmware that introduces an ABI
> > breakage, every single DTB on all boards in the wild get updated ? That
> > just doesn't scale, sorry. Let's forget about that bad idea, and focus
> > on finding a good solution.
> 
> I think the v5 tables have the same problem.

v5 supports one firmware version at the moment, and the driver would get
support for new firmware versions when/if needed.

> As Wolfram said, "the driver is then tied to a specific firmware version", so the same ABI breakage needs a new kernel on every board in the wild.
> Either way every board needs an update, so I think the fix belong in the firmware.

It's much easier to update one kernel than thousands of different DTBs.

> I also see technical weaknesses in the remapping:
> It adds a second layer of ids on top of the SCMI ids, so each new device needs entries in the kernel tables as well as its DT node.
> And Zephyr already uses the SCMI ids in its DT for this chip, without such a layer.
> 
> With the SDK DTs only in the vendor tree, what technical weakness do you see in the solution I proposed?

I have yet to see any vendor who can provide 100% stability guarantees
for SCMI firmware interfaces. In theory, sure. In real life, I just
don't buy it.

And even if that were to be the case, the situation we see today with
vendors shipping BSPs that require different DTs for different SCMI
firmware versions (I'm thinking about ST in particular) is absolutely
horrible. There are SoCs I don't want to touch with a 10-foot pole
because of that. It's a model we need to push back *against*.

> I still think it is a good one ^^

We can agree to disagree on this, no issue.

-- 
Regards,

Laurent Pinchart
