Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644917;
	b=foZOVasQS2/EZjid8afMG/1NK7aAjkf75o1bctxQVqNq4a+UV3usw1Ks0mwcv3xaecIF
	 qpHpcto/FpWBW/uctEK8tb7uwzMEVPCJqgkv4aveqkM/zKlmpqANbD/OG8FeSc7oXgQaS
	 xO88JO1ErPSlyS07CpBugE40hpFUiK0w563pzBIVipzLVipW+SGX6DPRR/XUUTcf8ZouY
	 0zqJ1fCNCyzpZqp37no1FUF6L+N8vhnEwYtH1dzWAQ18wFuf91O9DMNhhxR8MIyJrxJg4
	 +ikzwmt0M26TDCAVkzXcCHYdB5kYS4ho/DSRBR3G4UFjMEnzwO+Mv4QsFG3gdiw08Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644917;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ni8H7Ap+HCHG0QQIQxl79mCC54GcejU+9kKv4fWZ8x0=;
	b=CVJqi9CZxX+wF2VsaczefIUM43JEP5DEPg7mnDozyg4ppHL6HSQiEGdaDBvNm28LhfV+
	 oh7U1zuTBQNaUr8e1yrZlmT70bY20j56zXAYCyZhq46NYHJW/ucBjDfCowdqQi7gUQBvc
	 dS5FbxFfod0UBusF12FvthfTW5ngTJcSP5nBCgElnJ7PRy426C5xtabdZtktJqZ10pJqk
	 S8MXMrfPHi9SU8DrKlHjGgwaw3NdDRd3bS5IM9forycBzlkUYeZQ/LAZ9tYdclgOZGuBK
	 GrmduWjNCM1dzTe6NcAwDU7/iMBynGd+c/hzu1717H8KwSoVmbp6Ab50BFEKBKyuM7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=iHyirvab;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B673606A31E;
	Wed, 25 Nov 2026 22:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B673606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=iHyirvab
Received: from killaraus.ideasonboard.com (KD106184139166.ec-userreverse.dion.ne.jp [106.184.139.166])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 82515153F;
	Wed, 25 Nov 2026 23:12:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795644753;
	bh=OggzM8lGNFtq1hPtvltuDCL/vSTbieC7jAHyiV1fkmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHyirvabuaE3TVwnRQbirNpfnfPyOZnZmb9URm+Kj2204fNQfd5I1nJcfFpDq7bG6
	 1wcnhQ1L7lx7UpizCZoIZwu7/QEVSvSIGaxE2yuV2OCoc09FPWoYg90DX/yLyNA0Cq
	 ZgYJLo1G4mKY3mHqLlX5dL0VArUlBnJoySGAKuD0=
Date: Thu, 26 Nov 2026 07:15:02 +0900
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
Message-ID: <20261125221502.GD3581@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>
 <20261119234759.GB2324725@killaraus.ideasonboard.com>
 <19c3745a-6308-46ff-bb37-3acc88fe22e2@baylibre.com>
 <awAqqg6F2Z1t55x2@ninjato>
 <d94ad9ca-afdd-4301-a69c-0bbad5b334fa@baylibre.com>
 <20261123103633.GB2959742@killaraus.ideasonboard.com>
 <fc13a7a8-b825-400c-9ea0-ceb2670dc478@baylibre.com>
 <20261123160550.GA3050935@killaraus.ideasonboard.com>
 <27796cff-eef5-46ce-8079-93a0a8d40db5@baylibre.com>
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
In-Reply-To: <27796cff-eef5-46ce-8079-93a0a8d40db5@baylibre.com>

On Mon, Nov 23, 2026 at 08:09:05PM +0100, Clément Le Goffic wrote:
> On 11/23/26 5:05 PM, Laurent Pinchart wrote:
> > v5 supports one firmware version at the moment, and the driver would get
> > support for new firmware versions when/if needed.
> 
> This is where I disagree: I don't think a SoC driver should follow the
> SDK versions.

In theory, I agree. In practice, I don't see how that's avoidable.

We routinely have drivers that follow hardware revisions. There's
nothing controversial there, when hardware behaviour differs between
revisions, drivers have to adapt. It would be great if every single IP
core in every SoC was perfect in its first revision, but bugs happen,
and we have to deal with them.

With SCMI, firmware will also not have a stable interface, and it will
be worse than hardware. A hardware bug is way more costly to fix, so the
QA process is more strict. Firmware are too easy to update, so they're
simply less stable.

We have two options to deal with that: either we handle that instability
in every leaf driver, or we handle it in a central place. The latter
seems a much better solution to me.

> > I have yet to see any vendor who can provide 100% stability guarantees
> > for SCMI firmware interfaces. In theory, sure. In real life, I just
> > don't buy it.
> 
> I agree that while an SCMI firmware is in development, its ids can
> change between versions. To keep the ids of a released firmware
> stable, I see three rules:
> - an id always names the same resource, ids are never swapped,
> - an id is never dropped: when a resource goes away, the firmware
>   keeps its id reserved and denies access to it, as SCMI 4.0 section
>   3.2.1 describes,
> - new ids are only added at the end
> 
> I think upstream should only support a firmware that follows these
> rules, with its ids in the DT.
> 
> For firmware still in development, I agree with what Cristian wrote on
> the RFC[1]: "fix your firmwares AND/OR apply quirks in the meantime".
> 
> Any other view on this is welcome.

It's not a matter of "in development". Software is always in
development. Don't get me wrong, I agree that we should minimize
breaking changes in SCMI firmware, but we can't avoid them, or even
minimize them enough, without a QA cost that nobody seems willing to
pay. Where's the stable SCP firmware for X5H ?

The way to go in my opinion is minimizing firmware breakages *and*
having a remapping driver. Those are not mutually exclusive.

> > We can agree to disagree on this, no issue.
> 
> Sure, I think we both already know we disagree on this :-)
> Thanks for taking the time to discuss it
> 
> [1] https://lore.kernel.org/r/aekXUvIPb8nkhdKu@pluto

-- 
Regards,

Laurent Pinchart
