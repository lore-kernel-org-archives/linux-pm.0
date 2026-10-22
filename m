Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792664667;
	b=KcyVutd6ivhC+Yw6FFIIvrI5GI6C4b9qC2RN31FIHVKqKSWkzgeOln3g+2HqLmXL8CuI
	 Q9aJKl9Lvmx60PTO8I4Zutg3y7tB+tFAUO/KaigYJzFUBpCvK/PojSekbaX/PQD64FA7R
	 XmX5sXBio927ZySQeb5hmsLvPjeKRD9L1dLOWHE3Aok/dyzBcQEbzRfFKyvCX/05ikemV
	 U/6AgME+z8nLMKX7wYfN9n2pO6OUAym8M9MxZhxv8bG/V7xJ3enCapdOr1fASQcBGkt1E
	 2X0QEEYNVQLOh4N1W3+uMCcj9Ue/L+YMYJlvUeH/5ma9fKmSgnSq+m913nMtYiaWpmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664667;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=ugyFSCnTfsLdf9m20uVYRw6UIGWGn+LdXLFTD8Rhr/s=;
	b=ueDRBc9tUHc9JPZBj+ePbFxao+dkUuosoKwuUrnnULheHTLnYWDQLV5YJpZ+GKGqpW3W
	 HGWvLFu+4zPNouSMjIHtwgM61KNv9/MmWj5DJ7B26pR4mdsb38NGtZHF20JnlBNN2gJN5
	 e+JZ1mzQiV4DARqZAJ+zX74XbC3Y9oC/oqVmkspNu6jv0Zyz6b9ZuRY7rfwj+ygs25Lug
	 EnOARrnO2Kjtj8mLLUp2tUj6mDH/ous0lXzwcegrmz2HiUiUZqV6sQr0dbPH0PUrkXIo1
	 acBZqCa6tNGM3W83pe0QB/G6zxy0x35aq+H5p6UaU8LuUiurqSX124iL5Z06Ce+ZM1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="MdjfW2j/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B05606A329;
	Thu, 22 Oct 2026 10:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3B05606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MdjfW2j/
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 014142004FF;
	Thu, 22 Oct 2026 12:24:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792664663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugyFSCnTfsLdf9m20uVYRw6UIGWGn+LdXLFTD8Rhr/s=;
	b=MdjfW2j/k2QDPsZOIHy7PZt5Z2El+wcq2JctgMX74K8hRrhLGybZQrXu3CWicg97R2KP2D
	Ret1yLcSM3lfSjgcNOl/43Jg3TtiJlCUD5tgCP+gv/bocMeYbsUMt/niP2fXy0PGtAjoaz
	tp/HNvckDbBnkJAl+5stHagl+SI9nIntwRgaMhq1kuHrZMY5CYdqWqlwf00dGe8IYqT2xl
	WbGOmj8j3k71dUrFwjS5crsdfXMZtrJ+WoBjIHwhc/+sRJjJx1ebHt2ZbkrGo3sK690aTP
	W9kdkWYztNp2vhDec1ej6sgcurYNiC0yZ06Mp6GnF7gDli6QPdG7P2XKcN0B1Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792664663; a=rsa-sha256;
	cv=none;
	b=edtDA8hUpIe7+mU0hva+zNJQGy6IEOqpNBTRFhWhKoUnjvFzJtFxXZRFh2S99ONFJUZnPu
	Ne8xVqy21RdhXv5Hlige/XMqWFzrOlDDRgakCDeMYCSht9FA1YGr9s0eTnZvoS4zIHpvkx
	OWBWZsdzoECmGCI5NJ76c5SbbrieVMkRmHwPLsy3LSjZlon8RAkMDUHwj39cjLQubV6awE
	M3i0+KmcgNDZ4Bljnlr9XonivOr8CIsNBdbP2nz3cV4a0/J6r+VdnBLLIA6bf9xbhp9YyH
	0/R+aqMNB4SgpEADu3aoE+1rxj+Ujk/F+gTOxYFoA/8G84iXgng+uIs3Ikh3ag==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792664663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugyFSCnTfsLdf9m20uVYRw6UIGWGn+LdXLFTD8Rhr/s=;
	b=O44rc3MUCLXCMepH7FcLNVL4aje3eL/Kxcj8GCWeBb3Pk04DyoUO0DAGrvp3a4QHMtBQuH
	oM3Fi99p1dzV515dvFcH4D85lMfCqJUqjzHPawSQBdDt47otWiFMxoxOX8vNKCOtSApJnN
	QxqEC0QPB55vp5ECREbj5a9u1uHOlKX34o0vNsW3AzIXHylfDaGfvXbZwsZ2y3BP0M98QM
	jkegbpg6wVp8KDVMPLvo87Hv0s7WuQv9pXRy4e31lbew19ZQbN8C7t2U6AjT0z6TAqGiZi
	wxkV4NPED5YymbXEAGOngJ9UdQR7nc5fyzmuhQHyb4kgeFhPX/r8TL5kAzMh2Q==
Message-ID: <2e28581115962ef23af4834ff274ee11de172344.camel@pengutronix.de>
Subject: Re: [PATCH v4 4/8] reset: Add
 reset_control_get_from_provider_exclusive()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd	 <sboyd@kernel.org>, Brian Masney
 <bmasney+clk@redhat.com>, Jerome Brunet	 <jbrunet+clk@baylibre.com>, Ulf
 Hansson <ulfh@kernel.org>, "Rafael J . Wysocki"	 <rafael@kernel.org>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>, Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>,  Kevin Hilman <khilman@baylibre.com>,
 Vinod Koul <vkoul@kernel.org>, Wolfram Sang	
 <wsa+renesas@sang-engineering.com>, Kuninori Morimoto	
 <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart	
 <laurent.pinchart+renesas@ideasonboard.com>, =?ISO-8859-1?Q?Cl=E9ment?= Le
 Goffic <clegoffic@baylibre.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Cristian Marussi	 <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Date: Thu, 22 Oct 2026 12:24:22 +0200
In-Reply-To: <b9e68c8df1e545191e0359dba23fe53de31a4ce5.1792163045.git.geert+renesas@glider.be>
References: <cover.1792163045.git.geert+renesas@glider.be>
	 <b9e68c8df1e545191e0359dba23fe53de31a4ce5.1792163045.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fr, 2026-10-16 at 17:55 +0200, Geert Uytterhoeven wrote:
> When stacking two reset controllers, the upper one should go through the
> proper channels: request exclusive reset controls and use them via the
> reset_control_*() APIs.  However, unlike the clock subsystem, which has
> of_clk_get_from_provider(), the reset subsystem does not offer a way to
> lookup and obtain a reset from a reset provider.
>=20
> Hence add a public helper reset_control_get_from_provider_exclusive()
> to lookup and obtain an exclusive reference to a reset controller, based
> on the recently introduced __reset_control_get_from_provider() helper.
> This will be used by the R-Car X5H Module Controller driver.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
