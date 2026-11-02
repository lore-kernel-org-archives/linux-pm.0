Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619394;
	b=u8o2iXf4dpXmVncLMTe+oG/kuPIU1uJ67C295uVyWI3M3k8KBCZR0rm+YhmjfsvEcy1C
	 B5BU1Gk66YQWm7hdtxU2WfH9rnJjRG+sPzrF7Xkgu5xF1W1fmsKKr3iOCKwYYqvvzZAtv
	 z/E5SCGPuzC49LQvrzJfbsTX+carpUnTEfA3KRxYe6l9F3Qe4ejC22LsDQAYbR0a14b5v
	 uYcQjEbBavIwGlSO4YLx5nr+2cMZ0l2y1+S8RHYhz/zk8tj8JgATdO1op5EjF+8+gHz+s
	 DxT4X1KpCdCC8ShqPt9efQG16TclBTZ/OG8FEzUI+4QVAezrqPUoCnzIeXDbq4xJ9sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619394;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Q7yr2pjyVHcaYoQn+v7ayfwqL+qFJkC864TRHPRSDZQ=;
	b=w+BHqtLUTvvGUkERPzZD6WxQD+6k2N4f/hMlcUSySTxbfIXapV1flCQ0DMwDVL146fn8
	 ZGpDONbTIGFCbrG4VZ1ziDpADblxG9RPBvmmsgIqsvGIn+Ib6b0LisBIhwDvq7BGq2X0q
	 8lrcwPp4ReBRLFw0vKlV4YLuMaShOVegYU5kWyJF3zJ6xGatm+XsnHf/l1cHTBfvx9KY7
	 +sSBDQd5uyb30LGGkxfVDY9CD4kiW9dxEZ7nLyrZR5aEnLCZNcT3bVbOapu+PMH1zSYoF
	 lLMbV56fVMPiwb+ymclH8EhNPUpsycobjTirKDGJ3eX00G2K5DuW74ZiKg6+vxTmQ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRmcwiY1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072CB606A327;
	Mon,  2 Nov 2026 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRmcwiY1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62EF1F00A16;
	Mon,  2 Nov 2026 11:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793619393;
	bh=Q7yr2pjyVHcaYoQn+v7ayfwqL+qFJkC864TRHPRSDZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hRmcwiY1SLbm4fFTYsqLIuH7sac5tFchyISgNsdlizLMnEkg9/Ih82hOZeeH427yS
	 aww3Hqxd1Gwshsnnue01ZtvH8gG+hQQRUfTTc8LOL4VCsqvFBeJ7nkqWWpdnSi7xQw
	 p7gOnCAfHML3Q3jqZJzbte20c5sA6Vja9EMYWQ+Txa+9LI/O3waL0cUXHjR3mZnPJa
	 Qr/0EHe7CR/fZsAtI6/shNtVn7XV8Qty6q/eUS1x29KPNazoELk4sT3Ek44b8lvbGz
	 p207mESNX7QhLuNy4vw420FQPblfNr2kkyoBFIEe58hHAcgSLLbLxMsFvEmGoALbHO
	 h9pqLz8Lw8utw==
Date: Mon, 2 Nov 2026 12:36:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: daniel.lezcano@kernel.org, rafael@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	ansuelsmth@gmail.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: airoha: Allow sensor indices
 for EN7581
Message-ID: <20261102-beagle-of-optimal-fantasy-a1ebe7@quoll>
References: <20261031141912.1664575-1-sochnev.v.74@gmail.com>
 <20261031141912.1664575-2-sochnev.v.74@gmail.com>
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
In-Reply-To: <20261031141912.1664575-2-sochnev.v.74@gmail.com>

On Sat, Oct 31, 2026 at 04:19:11PM +0200, Vitaliy Sochnev wrote:
> Allow either the existing zero-cell form or a sensor index that
> selects the main or CPU ADC.
> 
> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
> ---
>  .../devicetree/bindings/thermal/airoha,en7581-thermal.yaml  | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

