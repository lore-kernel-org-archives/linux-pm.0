Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793887602;
	b=VwxUqElTPkl67mv/WlpcSZY8k/ngY2TI2vxGJaPymcXiEaIg7cm3rzY2fqYRH6skSER1
	 g4L9l+GMFpAtiaFkXHD9vnBIaVDLrvuWVGoajPeBV1eWgGaAEm3b0Fe61DuXxoMU+kmXx
	 ZWZ4GrK2XDYmQfbkL2Fjeja+e2eVgVBs5vV+DkSBSJ5JBJXlvaHsd6G9cbOYAqBIoD7U/
	 FFZfeJ03RvOa29NScRjqxTNABddWjdLrWuv1ZE6nb+MbT4DmwsER0JKn4/3tM2r+sqF+y
	 Q/U7dCoQF4V5Mg/a6ykdQ7tInxR2sjvO/0bwbx70ymm1mXSws4jUVDsdplIHH0zdRkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887602;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=onIgHLIVAs7MX99o13Ov7v+hJtEInFTXwUejUAfUW20=;
	b=IdMLYTAxE6DFd67RkS3WcaKTtYLau/G2KIf+3aB+isRro+eo0TDo53aXVZSuzbNqWHOw
	 gstnkeM8824a318FQuRJrKsiCA1diqxFMZAEJiCPEg1daOjAW5z9gBffZc+pMRfcMe1+4
	 2R5od+biRASh++AhSM++tytBg5feqkIrxBu0UuCk4R6WWe+aHPLL5Lm9d4uk4e9Kq6dAp
	 cA4/C8oNw1XHEU9y33n9icSnMVFRP9NGjR2rplkyYNIgepLNToAD7/k2nwq3xCgFxL8Av
	 yIsVbS+YiLlT5G0e8IisRUkKui7loXIApucxV1pgfjn24heSnkQSpqTy7/GwpXH74QA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KJWksXtv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97016606EEB8;
	Thu,  5 Nov 2026 14:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97016606EEB8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KJWksXtv
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6AB0A2022CC;
	Thu, 05 Nov 2026 15:06:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793887594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onIgHLIVAs7MX99o13Ov7v+hJtEInFTXwUejUAfUW20=;
	b=KJWksXtvrQkeHBB2QG3hlukLeXYtgKGn49r+HNdv+H61dtiBtgukpM1pnBu4xDWcQu7LUF
	AJWVLZcoYavm/lMfN/KCOrvw/23mZfMUqDlpKVnBRsJMPnUajR2FjPRiy0pD2ILKWN46mc
	kT835SAcncSxHpdCi1D5waQ97c169fQ71qG8Fq93S6PvN1LibzLMaGsTk7TwaGWXoMwnaH
	Q6l3vdvoRsAMxChmcPB1Vnu94yJNLMRYIjpF7MfE3jIUUsXZaNnooTIJsVlhfcFnij2TSq
	nBLSSo/gO5Xf50JUofbacG31eIz9oq48d9FO7Cti6sdYamye2tCfELCeBbCmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793887594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onIgHLIVAs7MX99o13Ov7v+hJtEInFTXwUejUAfUW20=;
	b=WY79QNjwoQ2bd8W2IccevfvDFHKxEM5EmG1MFmnVt/njesvffBqiOvSYWbAC0gAV5xaXua
	LGXzm3Y+DIFCDf4Z7jSjRaReFEZdAGopxaebA1iw6VJDJ8J1eM/GI+4tCoOGx00QhKY5F/
	fWG9HIUUE7E/rAWqQkcC/CLLo866ZS5HZBDU20xCQO/c4lIa0k39eywkg8t9Dj5/Wwfc+M
	W2rNzH2bqjfhLAgU/a5TigA5gD+Ih5/IFYicRK4UXpEZVvs07GDQ0qT3RzoI8B3ttrL6k9
	j/U3l/lKuDjmwQWZX5wNhT/vtIS19muPWqU+cL5gWycyhcMZ0PefbApr1HOphQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793887594; a=rsa-sha256;
	cv=none;
	b=SIrXT7f+EFYsrxfLyYrcXmzbUECmt3zbRWvxd9zUpBwt/NnlIu6UvlOe9h+NArWorHBLKg
	LVknmoKvgYZltI53e8XXEeagXRI2jXgvCadcL9Luk/uMPiuOLiaAzyJHP2NRwm7y21vjWp
	tG+fYANNl4kB/o2BFrfnluwN3xtrG7eDBDk5zmMA9W4DSQHkuj86Zoew0/X37f/yAVyz7U
	xHQkusR/fbWNynYH8EtovlOODoiSG8+CxG48PQgqK3jq0f5eFNMxVhRFu46YxAENcsnHVS
	0wYDWMWCj9HbQhbg9QWeuqi4TaOgzquPN4KPxhn/udpYGoLydw8CUexvcU9sbA==
Message-ID: <dfdd4e30f31ebda533c1bc05d4578a5d23e31320.camel@pengutronix.de>
Subject: Re: [PATCH v3 09/15] media: rcar-fcp: Handle resets
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Paul Elder <paul.elder+renesas@ideasonboard.com>, Geert Uytterhoeven	
 <geert+renesas@glider.be>, Stephen Boyd <sboyd@kernel.org>, Brian Masney	
 <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Rob
 Herring	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Ulf
 Hansson	 <ulfh@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>,  Mauro Carvalho Chehab	
 <mchehab@kernel.org>, Kieran Bingham
 <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org, Laurent Pinchart
	 <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 05 Nov 2026 15:06:34 +0100
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-9-e052903a3832@ideasonboard.com>
References: 
	<20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
	 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-9-e052903a3832@ideasonboard.com>
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

On Do, 2026-10-15 at 16:51 +0900, Paul Elder wrote:
> On some versions of the FCP, such as the one on the X5H, reset control
> is required to operate the FCP. Add support for handling resets
> optionally, to continue supporting versions that do not require it.
>=20
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>=20
> ---
> Changes in v2:
> - handle errors
> ---
>  drivers/media/platform/renesas/rcar-fcp.c | 30 +++++++++++++++++++++++++=
+++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/renesas/rcar-fcp.c b/drivers/media/pl=
atform/renesas/rcar-fcp.c
> index dfb0ca93e854dd0bb8aedfb757fd786ef6e45542..76d4c250b30815d9eac58f9b5=
4ad923748df79f6 100644
> --- a/drivers/media/platform/renesas/rcar-fcp.c
> +++ b/drivers/media/platform/renesas/rcar-fcp.c
[...]
> @@ -162,20 +164,25 @@ static int rcar_fcp_probe(struct platform_device *p=
dev)
> =20
>  	fcp->dev =3D &pdev->dev;
> =20
> +	platform_set_drvdata(pdev, fcp);
> +
>  	fcp->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(fcp->base))
>  		return PTR_ERR(fcp->base);
> =20
>  	dma_set_max_seg_size(fcp->dev, UINT_MAX);
> =20
> +	fcp->rstc =3D devm_reset_control_get_optional(&pdev->dev, NULL);

Please use devm_reset_control_get_optional_exclusive() directly.

Otherwise,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
