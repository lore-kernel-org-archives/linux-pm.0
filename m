Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430198;
	b=hzekJHrmZns1DjTF/gZN1NbeS/RxcCaayBrpbJMCX4QYDVUHHufN0vVWTfvSkrnAj+do
	 g790KDwXqmbnYRJggZhbaaBNx+u9IqQ8Lz9h0/qMy62382yV8pPJ4xpnFdCmanMIq/qoX
	 8Qt6wzutfKR+Vw11/UA2QZmQgAAQ/kuJJGZ1OYJr93FfCIBAzd3u3ZX9+z1WCmM3aN8+D
	 XmXAe2owCUa39IZ3A1S+W2hd/60XDZPZttEWgNNk3438A21EhunYBZLW93paOZtmyfCeb
	 s2i381orFsuL+A8eWllQbN+0y3zMeDTGkBozy/uznHlsxM6nwxZlGcdT6oW2RX0gCxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430198;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=PcLcbUy9WLbB87302gRwaNmUCRa+6gKrWS43onZVWUM=;
	b=RkvvQun+qFaWR9ow+NTuLY6PohM9Ds5oZi9Mzdlpn984jxuZ3n+n91bUfEalQV1GQAcA
	 bAomRVgFVAvdnux5fEjQjCaxj8AO22kS+j40VcytlzTUbyEw8/KsSMOeaElRB7nQLAb/U
	 UYboyhwOAaDHf9YzzCdNCuJQbidheicLhogAQ/V9RjXHvPfLqVdQ+SQCJ43XCnaV3baSB
	 Zt5ptjcClnnSPA7YGxzXdR9yYfC5R293UJ8gfW/0i2mVvs8ZQ5v77VApLzEt0LZ85Oxkb
	 1sN3NyFYXFDITCFBdJAaiMhtlwSc/2jiCBeRetzMQeWJ6+z/oKr7m0h4ck/oL6GKvjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=mITrGh2T;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58482606A31E;
	Mon, 23 Nov 2026 10:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58482606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=mITrGh2T
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 834BE4B0;
	Mon, 23 Nov 2026 11:34:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795430042;
	bh=ccjAAMHgAJq89pSqUHBH89F3ZPD7R6QW9itkpi2hSf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mITrGh2T1FVa6dXh336gRFij/ePLSfcLwEekVfS1AxwaI7aqZ0bLgYy/lJEqruSUi
	 FObd+PkgFTebQAZS8wBeD2K5FUZEdu7ymMqsxsBxmV4tRsWqYAeyJUQAp8z0+2dNCm
	 P5/jt6wVW1mR4TlGRbHZb1csDC+J4CXxqUIxhxnA=
Date: Mon, 23 Nov 2026 12:36:33 +0200
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
Message-ID: <20261123103633.GB2959742@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>
 <20261119234759.GB2324725@killaraus.ideasonboard.com>
 <19c3745a-6308-46ff-bb37-3acc88fe22e2@baylibre.com>
 <awAqqg6F2Z1t55x2@ninjato>
 <d94ad9ca-afdd-4301-a69c-0bbad5b334fa@baylibre.com>
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
In-Reply-To: <d94ad9ca-afdd-4301-a69c-0bbad5b334fa@baylibre.com>

On Fri, Nov 20, 2026 at 03:33:11PM +0100, Clément Le Goffic wrote:
> Hi Wolfram,
> 
> Thank you for the rewording, it is clear
> 
> On 11/20/26 12:10 PM, Wolfram Sang wrote:
> > In the past, we wanted to support all kinds of firmware. Sadly, each new
> > firmware introduced different IDs here and there. So, we came up with
> > some stable IDs ourselves and mapped them to the IDs per firmware. This
> > is a n:1-mapping of firmware IDs to our stable IDs.
> 
> Sure, that is part of firmware development.
> I know several SDK versions exist, and supporting several of them is work for a vendor tree.
> As Geert's cover says, "While upstream Linux must only support sufficiently mature firmware versions, vendor trees (e.g. renesas-lts) may still want to support development firmware versions".
> Each SDK version can then have its own DT there.

That's not how DT works. Please be gentle with Krzysztof and avoid
increasing his blood pressure :-)

> > The support for <n> firmware versions got serious opposition from
> > upstream. We concluded that supporting only the latest firmware will
> > make most controversial discussion points vanish. So, we now have a
> > 1:1-mapping of (the latest) firmware IDs to our stable IDs.
> 
> Agreed, supporting several numbering upstream for the same chip only brings confusion.
> But then, why can't that one mapping be one DT?
> 
> > I guess this is what Geert means with IDs becoming "stable". <n>
> > firmware versions might return <n> IDs, but supporting only one firmware
> > we get the same "stable" ID from it.
> > 
> > Sadly, of course, with the next firmware update, we still might get a
> > different ID all the time. So, not stable in that regard and we still
> > need the mapping :(
> 
> When the firmware can be updated, I think an id change should be fixed there first.
> That is what I would do in the open-source SCMI server firmware I am writing for this chip.
> 
> > Yes, this means the driver is then tied to a specific firmware version
> > because it only has this mapping. Not nice for a user. But we didn't see
> > another way moving things forward for now.
> I think the DT is that other way.
> With the SCMI ids in DT, only the DT is tied to a firmware version, not the drivers.
> If a release that changes ids is already out, it needs a new DT, or a quirk for that one release when the DT cannot be updated.

So you're proposing that, with any new firmware that introduces an ABI
breakage, every single DTB on all boards in the wild get updated ? That
just doesn't scale, sorry. Let's forget about that bad idea, and focus
on finding a good solution.

> The hardware stays described
> The CPG and MDLC belong to the SCMI server, so the DT should mark them status = "reserved", and the consumers use the SCMI clock, power domain and reset providers.
> 
> The Devicetree Specification v0.4 define "reserved" for this case (section 2.3.4, Table 2.4):
> "Typically this is used for devices that are controlled by another software component, such as platform firmware."
> 
> Zephyr also uses SCMI on this chip, and it already keeps the SCMI ids in its X5H DT
> Juno and STM32MP15 handle their firmware differences the same way, with separate -scmi DT variants that simply include the board DT and an SCMI .dtsi.
> If the number of variants grows, tools such as Lopper, which I mentioned before, can help manage them.

-- 
Regards,

Laurent Pinchart
