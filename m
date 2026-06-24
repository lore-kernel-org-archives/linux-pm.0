Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4356199EAD;
	Wed, 24 Jun 2026 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305598; cv=none; b=XyD9qEEvJ85bN1k6yeTOhNc+vXN9tjuXEd20Ktsw2Mgw5LAHIP2Kd3PO58qe6ScqzqwJ28cHpo222HSTrhiHBhASuGFIiwNmXS51hxBltCnScXfKoAL7ATuNnkJMzhxpnHX7N1jwPcEEPpUMEqA2tBzAwKPnmF1K19DlZQG57Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305598; c=relaxed/simple;
	bh=KahWTfQ6QzHVNxKce8Q1/jzulRXDPsDhkVoGTbwS14I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsRKLrPk6I5yrEoeOM6hgl8p13BnXHuVftkLc+WHTwJCiONIFrFAEs9dI3uBbvAdADWL9WNNtpElt/DPSnPtwNklrQnA3/hIfUixLlbdam/a7N6VQXBuS+IQYrkjxn69gzb8eVZcB2wzK1NKpOStQTXX2gTSkhRyJfSY2g/U2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqZe9GhH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqZe9GhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B211F000E9;
	Wed, 24 Jun 2026 12:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782305597;
	bh=HJKPKyjooasBtuw7pvPpV0lDfiXrWt987kFsIu3bzBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FqZe9GhHzOTTWP54ShlMDrtjxg67FtUO8+DOBweU09ATTsnzg65sr+eaybs1z8tZr
	 VGCHRpOaqd4kdSw3pNVpRUD2M8HyW/A0FQCcNYdp8C2avSfPntdSGU2igZ2Bj43QZR
	 DzbTwUm4IkI7jJNbzNuPwerbyVEJ4NS9j3k70OjqVq3dD8Bu7TAqKA/5hNztaLUrkh
	 fUrZ3at5KyDSTFAEhhSLHkS+mzmtNp1jxvLO5HehPR22q9bp8fWLtMzF3TFc24oREA
	 kvpaHvQxg/ZRPXIVGOXUi+VXKn/J0IuKxJ6V3Lzu6RiPctu4sp6MftN5mTT0ERUOSq
	 706522OnAGF8A==
Date: Wed, 24 Jun 2026 07:53:16 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: amlogic: Fix missing header in
 the example
Message-ID: <20260624125316.GA4032772-robh@kernel.org>
References: <20260622100231.438435-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622100231.438435-3-krzysztof.kozlowski@oss.qualcomm.com>

On Mon, Jun 22, 2026 at 12:02:32PM +0200, Krzysztof Kozlowski wrote:
> Usage of defines from headers requires including relevant header,
> otherwise dt_binding_check fails:
> 
>   Lexical error: Documentation/devicetree/bindings/thermal/amlogic,thermal.example.dts:59.27-34 Unexpected 'GIC_SPI'
>   Lexical error: Documentation/devicetree/bindings/thermal/amlogic,thermal.example.dts:59.38-57 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
>   Lexical error: Documentation/devicetree/bindings/thermal/amlogic,thermal.example.dts:60.37-45 Unexpected 'CLKID_TS'
> 
> Fixes: b1c8ccdbd4e9 ("dt-bindings: thermal: amlogic: Add support for T7")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Fix for current RC - commit already pulled in merge window.
> 
> This should be applied fast to fix current RC, thus maybe Rob?

Both applied.

Rob
