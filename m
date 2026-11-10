Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303055;
	b=E6ZrUW+wNNg4OZG1xHAjEFrFlRhs6TOptvT9lOmaDjwnOABgNIrH0ngZzRNvWh2p4X8U
	 cs281Pdpgm4ybW9qP1KvOqt0qlYjvr6qrVGR6qCzvPDo45S1dtlyltod9S5w47N4otDkC
	 o2N8c2A3VkSEqoqjXJ/wnDefhxzLqYLuwwtzb8plssECc///+Ov1wTdBoDMLjb9HU+Q5n
	 n8UwdZw6iJPjI4wq6MGaRVd2PEAnhRSIk+LGvNX6QoYCsehtYEuTp+RVKgNNBoLIJOQ1+
	 l9gO3Pct1i6MnPVTOHtPJ4wWTOKftuiRxvbsv7d3Wip/ZG4EhDFV417qfJcfww18gKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303055;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=3a9+A4cGMpvcWBUNJX+y82H3Lcn9cALPUzIw6af2AfE=;
	b=qw/FyNwV07+HwaDPcrnJORHmWcd8E5mfS0SDMBnAYdTfG/yWKUunoteCditm6xf1au6B
	 d57EIoPH6918Ze3LbB3B8CWRMQ5OUl7+w6kmXviQhIrOV3IjiwI/GjRjjDHibF5qsTOjT
	 gJjicGaYr1cA9uwfQOSqihBOFq7PPD0avrlIzSMp1P9ScDZc/6sOhWmyfG0qNiLtpDlcm
	 gZaDe+Ufl2bQIQMwSVREM20zjks0U1Xoz29JVXP6rh3LQkj5vI7edCc0AeRsyVdL5Tb90
	 qihK0RpnGhFnhH/ShAdMRXk9JWh9KV7mkuF5UmDdLWzNbuEV0PVKuE9C/TkieiONg/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwcwYqjI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF1606B9D7;
	Tue, 10 Nov 2026 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwcwYqjI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F271F0089F;
	Tue, 10 Nov 2026 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303054;
	bh=3a9+A4cGMpvcWBUNJX+y82H3Lcn9cALPUzIw6af2AfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZwcwYqjISG4ryy7jJkuwvwIgQ5W0SqJcYnmERlw5RGVMPqSbCuWUp8V6tGP483IYN
	 tPOf2hREYaBI6yDnB2rYjMpvpLJM6BX6ptZevNWJva69XJRwz7ADywbQA2z4jNSQM8
	 VZ8KyDhtpdoN0U60ZIPXL7NUZBtW9iGZ+FwMIFfUqAgo6BSArftCGWiUt7KZA1JF5A
	 k2j0LcIlJftiAg34+n7FVLWkt/CfcJRaMQruCgI2L4fq3DOXuJJZfFrK/fBt3mlmYM
	 PjW0RQeZCNLk12po38CI03jqx4TS5vcSAS6qn5zGNdX8+Glq3wGBQ5k1bCzPFyYZAv
	 iPPCEiNb/Aqvw==
Date: Tue, 10 Nov 2026 10:30:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Elder <paul.elder+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v4 01/13] dt-bindings: clock: renesas,r8a78000-cpg: Add
 CPG_SGDn_VIO_DP_{TX,OTHER}
Message-ID: <20261110-steady-kangaroo-of-mastery-5fcd7f@quoll>
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
 <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-1-1b2072e8c37e@ideasonboard.com>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-1-1b2072e8c37e@ideasonboard.com>

On Mon, Nov 09, 2026 at 10:34:22PM +0900, Paul Elder wrote:
> Add the CPG_SGDn_VIO_DP_TX and CPG_SGDn_VIO_DP_OTHER clocks that are
> used by FCPV, VSP, VCON, and DPTX cores.
>=20
> It should be noted that there is likely a discrepancy regarding the
> clocks. In practice it ought not to be an issue as all the clocks derive
> from the same SGD1_VIO_MAIN clock and none of them are programmable or
> gateable.
>=20
> According to the datasheet, the FCPV[BID] and VSPD cores use
> SGD*_VIO_DP_TX=CF=86 while the VSP[BI] cores use SGD*_VIO_DP_OTHER=CF=86.
> However, educated guessing suggests that IP cores in the same pipeline
> should be using the same clocks:
> - FCPV[BI] -> VSP[BI]:                  SGD*_VIO_DP_OTHER=CF=86
> - FCPVD -> VSPD -> VCON -> DPTX:        SGD*_VIO_DP_TX=CF=86
>=20
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
>=20
> ---
> Changes in v4:
> - Add all the clocks
> - remove DNI

What is DNI?

What do you expect from us on this patchset?

Best regards,
Krzysztof

