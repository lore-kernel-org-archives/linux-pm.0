Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009342;
	b=QQ2COyJq/J7UHXxTG5cccWSroSKDO14fAFlaAPOdTNllXS3Zez7V8URc5YZcn4UDMmkk
	 VwGGiI1risAzTQByuPB7ioeTJ6GUMXsjiSaBrw+AAtKtp+rdq5g02FPWbUUDffXmxsDHq
	 tmDOMG/KWT9TZM1KVPLCtMEYQGHx0bdOyzIEC2UwN5DObu5ujEOijoj3NnLF1BSM4V0er
	 zGQN1Ki+RjljGaf7iepswFa6LCrtvUwiM7GaQaaaf73xAe6x0gUoHiOwNS5Xiyo2Or+iv
	 1aOaiawEfLOIBZMWkBqVAI8IvhFf7GJF/Sv2mSDjBjcXBDgTf+iY2hcePROJiwxf/Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009342;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CLYMN7shHS7NLVY5dkfeAO8ipJLvlWnPXRfUIP8Dwts=;
	b=J0VPRTgof28bkOzQbQcVl0X+yVrKbZu0VUJmgsgeoSHVIPZwbIRQiraV7xYTaAwxt87S
	 LAO0suqAMlSz57pazKLc6tlOxGPvbAH/GiDtDRCkVtQ2NCA9m0CAtJ1yPbsX64FnVuoOP
	 Ss8P1AaHOXx9xMkH5MXa5LFmpLuYD5lQ3125bc/c4KBoZNe6IqJ5vL0OhExSP4aj25FcK
	 QPM1d/H3h7r2fPju0PFDtvYLnt+cF0DbZDvR7EHtx34Jrs7gEDADFR/eGCOj0TsyommFO
	 L8SiZHFmtVn+CyK064an0Cv1boYhmw1oyY9bVnlQURdPCbCKTf1LSzZZvpITL0hgc6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jx/2faGB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DC4606A31A;
	Mon, 26 Oct 2026 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jx/2faGB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1961F01282;
	Mon, 26 Oct 2026 10:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793009341;
	bh=CLYMN7shHS7NLVY5dkfeAO8ipJLvlWnPXRfUIP8Dwts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jx/2faGBqIs6zqSn0EVeyAgK4/gRaSM7KzbJ30OBYvSv+qRxfyN1YazDoNZMYG1Uf
	 iQc5kVtTriWuDSXhgdkCVPph2cfjD3egv5bRXZMpZIz1WyfOJXYwGBT0G7M7jlLZuj
	 zn0sJQ61CrpEXezlZ1VTPh44l+YkzFsJ3OsM97tSFFe+w59Hd5o3g3hk5KhMNMg/ea
	 hIpmjOt6sTiiCJQgOcLPzLXHhW2iV3qa8mYP5xpG/9SOBSg6QTuB7tbueLfSKpAKTr
	 gll041yQ7XmkAWU/XvTKMgjO40k5ueyJqn779c5CpolUIICctyqEPR2oWl9twohVPf
	 tPuMGRBgeU8Cg==
Date: Mon, 26 Oct 2026 11:08:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: clock: renesas,r8a78000-cpg: Add GPIO
 clocks
Message-ID: <20261026-spirited-pumpkin-elephant-43dd3d@quoll>
References: <cover.1792776697.git.geert+renesas@glider.be>
 <624a9fb09e4ec74b1995797e5121b86e7206f5f2.1792776697.git.geert+renesas@glider.be>
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
In-Reply-To: <624a9fb09e4ec74b1995797e5121b86e7206f5f2.1792776697.git.geert+renesas@glider.be>

On Fri, Oct 23, 2026 at 07:50:40PM +0200, Geert Uytterhoeven wrote:
> Add definitions for the clocks used by the GPIO modules on R-Car X5H:
>   - R8A78000_CPG_SCPBUSD16_SCP_MAIN,
>   - R8A78000_CPG_S0D24_PERE_MAIN,
>   - R8A78000_CPG_SGD32_PERW_BUS,
>   - R8A78000_CPG_S0D24_HSCN_OTHER.
> Include a few more clocks from the same groups for ordering consistency.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/dt-bindings/clock/renesas,r8a78000-cpg.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

