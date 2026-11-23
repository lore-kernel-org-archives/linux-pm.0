Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429883;
	b=GQhtkGuC51XDEwzEp/KBU0jjJ3VTMD2ULRV0mRbCWDZp0PZCDQFe7C3eBTtG9e4nVujf
	 gKSCMvyNrNgJgLlcBpHxNQIW8LjlbdD6DnqqS1aU3wiZPqlRJjY86keaS9Fx93GdGQfxK
	 7WOtdh3IqIFKbTSTyk1I696OGbxxCnV+zYAAZnKecu/w6t+0VLtgBmvS3o+D4uvaUQJPl
	 d9pkeL+vLApQEWHA+AQDMkA3MpvLrb9vcMZ+ilQLufPhT3LC5zz64gFUr5TE8eob8Yyqt
	 OtNG5YSDmMVqHamIPLAG4lsfdv8uFMVxgiQ7bx/Q4s8Hleeb7vosPobaLIDYpRCCylA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429883;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=dtJzmPmb6Nwh3H1c2+/p4meqTnrmRahlnsNzxrgnr4E=;
	b=TLY+GjRHlxagUNJ7BIaODLYSL5mKW1WYvW14E7qNHZsJmTn3uWDUurh6BUds6pDoKghq
	 X6xHggbshoivvq3G/1Vkf8ib0CsGctlrXDrNuk8ou1R8jY3UeuaWVagNqAejy9/bsPPA2
	 DynBm38t9K3EFDsBsrN5teePb5HiK+xdtMKgUz9zYEEk8sXxc7i2J5mdFXziCWb4yK+NI
	 ab4dzQjFz3oB1/VWTni7XRdV5H30iNhIZj4bXcvbtXgBIfklgus91JD9rhUUgEpVltcj7
	 Y20+DXwyqEmqL+LruTiKHBQSCBu2nKnDLRnnC9pas31zRwCiD8hSRQMOQhl1lHdDDcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=lPaSgucv;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA463606A31E;
	Mon, 23 Nov 2026 10:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA463606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=lPaSgucv
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D9147177;
	Mon, 23 Nov 2026 11:28:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795429728;
	bh=cMRfZSn1zOLQm5L80O6XfrH/7riZ1+RqoSDv1oE/c8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPaSgucvraqmS/cC71JC3Ei53cGHPN+HUyDvxXoWVy+QFFN/qnYfeBjmabPu3bOet
	 QMNcf4YJ1Tf276JlGoprDDcTe8bAObS/wlFYBZxJo3ZDn6BlYtdMiT552G5QnGEj0v
	 0JySljw1GwHG8kxpwwUWMPpol7frkG3tOtVWkbVo=
Date: Mon, 23 Nov 2026 12:31:18 +0200
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
Message-ID: <20261123103118.GA2959742@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>
 <20261119234759.GB2324725@killaraus.ideasonboard.com>
 <19c3745a-6308-46ff-bb37-3acc88fe22e2@baylibre.com>
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
In-Reply-To: <19c3745a-6308-46ff-bb37-3acc88fe22e2@baylibre.com>

On Fri, Nov 20, 2026 at 11:29:49AM +0100, Clément Le Goffic wrote:
> Hi Laurent,
> 
> Thanks for your feedback !
> 
> On 11/20/26 12:47 AM, Laurent Pinchart wrote:
> > As far as I understand, the assumption impacts the mdlc and cpg drivers
> > only, not their DT bindings. If (or rather, let's face it, when) a
> > firmware revision later breaks the assumption, we will be able to handle
> > it in those drivers without affecting DT.
> > 
> > I don't like this remapping driver much, in the sense that I wish it
> > wouldn't be needed, but it seems to me to be the best possible
> > compromise given the instability introduced by SCMI.
> 
> I don't think SCMI itself introduce instability.
> It only defines the protocol, and each firmware choose its ids.
> Could you tell me what you mean by instability?

That's nitpicking. The protocol is useless without an implementation,
and the protocol design leads to instability in the implementations.

> For development firmware, Geert's cover leaves it to vendor trees:
> 
> > This list deliberately ignores ID instability and the need for SCMI
> > quirks during development of the SCMI firmware.  While upstream Linux
> > must only support sufficiently mature firmware versions, vendor trees
> > (e.g. renesas-lts) may still want to support development firmware
> > versions.
> 
> For a resource that hangs the platform when Linux uses it, the SCMI server should deny Linux access to it.
> Until the firmware is fixed, a quirk can cover it.

-- 
Regards,

Laurent Pinchart
