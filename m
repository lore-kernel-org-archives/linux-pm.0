Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795132091;
	b=gtL3SP9bTdGliv3Lhx37IddCAk0NY5I+EMuqnkpgekNQd8ccEqim5cHUFxo6LkMXU3Wd
	 //AiON8IV1wc7s4NoKGvXRF8wayCshQ3/E+BJlVjbm/9Qv4KSY6Kyqxh86lLON9141+Rj
	 t1Ra9dKJEhgNwWZw+pgs7YKoJ5c48wb6bN7EUmYoDmCStIu0NCLGBbxPJCC2tfzzZa0lQ
	 eP6bbH0c2BP75incGWi4M9soAOSclVeeS8H87VDUOEGRsDK/Cix9BD/zRp1WPZQAYwQkU
	 6Ehf6nVqxM0lzgek86afiP0duRhMfhPuEyuhwjycQ1UdByUPwqo/YBZpNRty2Hrs/2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132091;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=+ijbtSK0fBZ6ownvGj02cHskN9Djna0WvtK/k37lNQ8=;
	b=McH/PNe7u3YghfauTg1It6U4WjKSCJM61zW0zbgZy0uZ5dJQnIKZGolx01vS0EAaceXG
	 cVf4vIta5w9aayl62r1S4DqSUo2payi7eerWfUhglCkZWIUdcukR/A8GAZOpmeoXk6EAa
	 kpt9gpfSDkrXMqGCudPJTjQXMT5qjtAIRCJeKimDv3gAkjkRZ5WZXUqHzKuJi4c1BSOcK
	 ZoJO/Zd2jCWjUTPY4MwuhR1x7kmMYXPZ0o9/UoXR3rJ3gIgpGWlBvKmt5jc1RBXaWWECp
	 LIkgFei9xGXKEtYm0rVAlJdbD6jVPTzhZt1ZJ/6qXr5NSmHmd22CeNcvnjaegrbv5AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=NcISFCtC;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A07A606A320;
	Thu, 19 Nov 2026 23:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A07A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=NcISFCtC
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC82A6AF;
	Fri, 20 Nov 2026 00:45:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795131932;
	bh=EZwvQCbn6puXRaR/jIu1ad9YLeXmu2tjVf0hS1LGbjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcISFCtC5Xg1GEKU99n//zV0rhPkR5PRrt6WisLdwe6SwAb9p/WCxEUiEiBfgG2fT
	 Rnpzq+GOOlztVp88d33vyp6XUpVa/L77iC0tum6ZLf4aiWr26kd0THZmA812SHkFlO
	 cwcwWjPeI9XKnw4+785lXybLQPrjxZjjA9AcwDVk=
Date: Fri, 20 Nov 2026 01:47:59 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: =?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clegoffic@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 00/15] R-Car X5H Ironhide CPG/MDLC SCMI remapping
 support
Message-ID: <20261119234759.GB2324725@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>
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
In-Reply-To: <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>

On Thu, Nov 19, 2026 at 03:47:15PM +0100, Clément Le Goffic wrote:
> On 11/18/26 8:44 PM, Geert Uytterhoeven wrote:
> > 	Hi all,
> > 
> > TL;DR:
> > 
> >     Describe hardware in DT, and perform mapping to abstractions offered
> >     by SCMI in Linux.
> 
> A question on the approach
> An SCMI variant DT could mark the CPG and MDLC status = "reserved" and point the consumers at arm,scmi, while the U-Boot IPL keeps the hardware DT.
> Since v4, the series assumes the SCMI ids are stable:
> 
> >   - Remove dependencies by making assumptions and dropping disputed
> >     items, to move this series forward:
> >       - Assume all SCMI IDs are stable.
> 
> If they are, why not using them in the DT directly?

As far as I understand, the assumption impacts the mdlc and cpg drivers
only, not their DT bindings. If (or rather, let's face it, when) a
firmware revision later breaks the assumption, we will be able to handle
it in those drivers without affecting DT.

I don't like this remapping driver much, in the sense that I wish it
wouldn't be needed, but it seems to me to be the best possible
compromise given the instability introduced by SCMI.

> On partitioning, the cover letter says:
> 
> >   - The clock, reset, and power domain IDs are not stable by design,
> >     causing DT incompatibilities.
> >     SCMI requires that the ID space exposed to an agent (i.e. Linux)
> >     starts at zero and is contiguous.  Hence any change in system
> >     partitioning (Application CPU core vs. Realtime CPU core,
> >     virtualization, ...) may mean a renumbering of all SCMI IDs,
> >     implying a massive change to the DT.
> 
> SCMI do not mandate that renumbering. The ids start at zero and are sequential, but nothing requires them to cover only the resources of one agent.
> The firmware can keep a single id space for all agents and restrict per agent what each one may use, the rest returning DENIED (SCMI 4.0, section 3.2.1).
> For virtualization, the spec has the hypervisor grant each VM its resources this way. A new VM then changes permissions, not ids.
> 
> With a single id space, a software configuration only changes which nodes are enabled, so one DT per software configuration, a base DT plus an overlay, is enough.
> If managing many configurations ever becomes a nightmare, tools exist for it, such as Lopper from devicetree-org [1], which generate one DT per execution domain from a single system DT.
> 
> That leaves the missing clock domain, which is a gap in SCMI itself.
> 
> [1] https://github.com/devicetree-org/lopper

-- 
Regards,

Laurent Pinchart
