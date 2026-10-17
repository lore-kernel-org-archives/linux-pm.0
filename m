Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28336CE19;
	Sat, 17 Oct 2026 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254992; cv=none; b=jxbVuXwwHWlG6wyXUVdp/fH7YeaKRG+xRtrf7IPP8IVzcI5U813dNz7F0tGRFYjpAoF0m+wp6pewfJcKghUjJSm6rtIsIRSb235xiNHU8FZWNeyctfDcHIOgVdQYc9PVAJhxE1NaweqDVnNvHKs94a80f64qV/8VjM4HqUOLuJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254992; c=relaxed/simple;
	bh=RDwOdKaGng+Ic7ym/UeoyGIyJtKZGrHLqAW219g/MMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jlq4I24HpQdBXt6BjADEepT3JA03JWYSJD5iT5Cx/hc2P5w+1Iw063NLsbZeqjc+gS/hsf8tAoQFArycEejabFIdMaJQOsvqxmat5MD7QChZ4RBjgpKUrBpoyymPyJsXkI7Ss/gCPDEM+mxGK6sTN19NZGlQBVX2W/5szFw2DaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEocfRQw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEocfRQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F851F000C4;
	Sat, 17 Oct 2026 16:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792254991;
	bh=Aa7clGUXSZUy7fCX06bj0AW6sS07fpn2z5lJu7qS0vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GEocfRQwtHbpT1Akc+NfXvH5BfzJEgq1TJl0zLR3Ej29JSvbKbHqdja9UJxIVB9Pw
	 CqIzPY4dBNbvCbn3h8Iqynqq4BGiZyhSa9tyLKQf5h970fnKeJMYQWToertzMclWtf
	 LQ+alT9kK5jotKoFR/uno0UN0a5g9LKiSjWuRPOzKTKWIZTQfWinpgKf0EY/dLAx6O
	 983wYAvqOp0GRyrs2r1PQbv41AtfQE17AEpsIILJL5GRMoZxPXCniheQrmLjlCE3Ao
	 a2DnchcWZ455YmE3fX1d2D3DwzDPga6nAMpZLjIJXXXDZHjTJ7HPnQYfaZRxwAsGQc
	 w4PnY3U/eRqRA==
Date: Sat, 17 Oct 2026 18:36:27 +0200
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
Subject: Re: [PATCH v3 13/15] dt-bindings: Increase Renesas X5H MDLC PD
 specifier bit width
Message-ID: <20261017-misty-granite-collie-7c4305@quoll>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-13-e052903a3832@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-13-e052903a3832@ideasonboard.com>

On Thu, Oct 15, 2026 at 04:51:53PM +0900, Paul Elder wrote:
> In the Renesas R-Car X5H, the module controller's power domain specifier
> cell's bit width has been increased. Update the bindings documentation
> to reflect this.
> 
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> 
> ---
> I'm guessing that the maximum number is now 512 but I can't find
> definite proof of this.
> ---
>  Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

