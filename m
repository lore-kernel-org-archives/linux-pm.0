Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6311E531;
	Sat,  7 Mar 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772887727; cv=none; b=gZv+xKgnMCRIc+wgbSnCM5p9j++Vrb3AYC5FImT2u28q6eFc05XuOMpWWqm0h9+DFpU1u68Q+9uOb7WrCBjhd2ytYZZa4i3hjmKhUsdPMn/hJbXbZdfKZisYTrGNX36VGyQk7B+wT4vhNHibeoAtKpGgSHjchhwCOG0F2ZPXwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772887727; c=relaxed/simple;
	bh=Bsc5vDjhsHepkmaxrBA9X0GZmghTH5YYu0FXiXaJ8F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUEMBRf0TE6WskXjDMdL8O0iiL/r2NFXjJSUGNDBQgrE9y9LPuiAemuwDyvfMEPCV2uIRSK3x2nHePzYegdDJmTAyTFZlnXTd/5IFWrhNfb5lhV2VxWWwBCYycNqzO84Q8zCz+PYn1oJeIonQtsScY7AUtwpTk3xTWmNz9/QgIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qK/Xbsuh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK/Xbsuh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067B0C19422;
	Sat,  7 Mar 2026 12:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772887726;
	bh=Bsc5vDjhsHepkmaxrBA9X0GZmghTH5YYu0FXiXaJ8F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qK/XbsuhCgn/oNsQ8jaU1rY2k01ID5ymGX9XVgBCfdZC8cUmUboJGxUMuiGY8mB5a
	 zIe1e3x+/ibjwwhsk2lKIxEXhpf0NzPHPfnNkGIqg6yUgwEjXZ6glk5xN8XA8Pnv+r
	 SNtRVEL2p2xcH3xXJXX5I66QEl7+djFkkwPcl8nsrduY/UsEiQpJX0KYuH8PI0gGSa
	 LrSCg9WNtSm7Hu5/w2D1PeC2ixxw765GSivMaehMxDbHuPrlq0XKBD5DezBmw5fnS+
	 FazXqD0VxvsKStPmpCMyhqVXDQ9Uy11LutyZT/SzO2PR42nh9HEHkzCSYg47YZtUTp
	 vFkdmjjPPFh/Q==
Date: Sat, 7 Mar 2026 13:48:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-binding: pinctrl: pinctrl-max77620: convert to
 DT schema
Message-ID: <20260307-smiling-coyote-of-economy-317afe@quoll>
References: <20260306133351.31589-1-clamor95@gmail.com>
 <20260306133351.31589-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306133351.31589-3-clamor95@gmail.com>

On Fri, Mar 06, 2026 at 03:33:47PM +0200, Svyatoslav Ryhel wrote:
> Convert pinctrl-max77620 devicetree bindings for the MAX77620 PMIC from
> TXT to YAML format. This patch does not change any functionality; the
> bindings remain the same.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../pinctrl/maxim,max77620-pinctrl.yaml       |  97 +++++++++++++
>  .../bindings/pinctrl/pinctrl-max77620.txt     | 127 ------------------
>  2 files changed, 97 insertions(+), 127 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinctrl.yaml
> new file mode 100644
> index 000000000000..7364a8bdd7d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinctrl.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/maxim,max77620-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Pinmux controller function for Maxim MAX77620 Power management IC
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description:
> +  Device has 8 GPIO pins which can be configured as GPIO as well as the
> +  special IO functions.
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/pincfg-node.yaml
> +  - $ref: /schemas/pinctrl/pinmux-node.yaml
> +
> +patternProperties:
> +  "^(pin_gpio|gpio)[0-7_]+$":

Underscores are not allowed in general, so pattern needs fixes. Does
anything actually rely on this name? Is this ABI? I don't see old
binding and driver using the name, thus this should be just ^pin-[0-7]$
(+ is also not correct if you have max 8 gpios)


Best regards,
Krzysztof

