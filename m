Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417343;
	b=W7YczGavkjOxBZAzvFWIH2JE2ZeesP2dS0udoFB+3jfoEOEca7kczTHrVn0sqYcgpBt1
	 fIA2mP4tQKgvSV+pQUhm8r8uuSaHvQLpyPHKbloqvtO3icVN7HWnSa8WBjFxIrzMkJPD+
	 sNtvu5n0Gk6+/hYpme0zJHsa/x4XWaFM9gciXX6Rb9lFXp34eS2MAsWPeqyrivZlyyIO+
	 4kwABFofYClSo4rCIcssE1dNbjpnjFSvRI1b7lW3lHfaSTJOO8BBkDXNZbdKhShz35fd3
	 QgqlSzhE99x+Ws4ZdKwqGFjoOhajIJVzsX6GdDdNyIV26ZK9J2K/qYBsiCY2YIpyCMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417343;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=w8vNoC9Nxsw0YxO6Po42QLoQ5/fTPMksdeWkGWXJRYg=;
	b=QHcv/swl4Qg1GIavMNkvHwwmT4slDFl3UfOw0sqpbcCbjptT3k5Ed7zbBjT0PMY6jcwc
	 +ap1QfUkx2PAvJ15KuLlHy0Hf1kdmx0lVtRqZwfQyaZcN2flc/X+Gem5tLIxqXEbiKB6p
	 dN6oqolkD65pEkPZ1u4AZ9L7I38VMdBoG9sXGkzyzblp6tHbY/Wjvy4xcU970w+fwGTY7
	 eAYpKQnLK2pO8cFAmpyiugdaCQItPcURdk4/ZnKludTAll0SGQo5SOB+pYLGYoIafYWjw
	 dad9vnAFupWI3LS9NJSvmCESVtxRVHFhZRukMn+ZLc/SaaXSE2Whu96lniuJUXE4C9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBbd5mtS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58E606A321;
	Wed, 11 Nov 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBbd5mtS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D0A1F00A05;
	Wed, 11 Nov 2026 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417342;
	bh=w8vNoC9Nxsw0YxO6Po42QLoQ5/fTPMksdeWkGWXJRYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YBbd5mtSUp/RiEVHPeFjrL7da0RxMdI9MfB0nbzxVOv7RTGdcgZpyua3TNCwi5Dib
	 +Z3PbFFN4/4ztEmPqd/4p47SQA6+h066iQzBEDxlRtmsZXKhNPjIg+PKpCtC+zyy69
	 8QHRCtTfXQb7GL16zBWUvAn+uI9nQVFSW1bpEa3iQH2DH8wPRt8B1Nuib5QYhWcp7V
	 Y3a4aaXC4HILFVFU0N6GrG1s6+RHSBGsbq3iEH4jrcgB1X2aHe27spSiqRsbxDvQRr
	 v1/0iHch+2nhANOHGJRXmRg67o58Ue8nhnfIDI7lBoa1IE6GIAuxtjDbzTl9agaycG
	 K6p3Sb+ZkDSvw==
Date: Wed, 11 Nov 2026 11:15:40 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>, Ulf Hansson <ulfh@kernel.org>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/7] dt-bindings: mfd: Describe the BCM6846 PMC complex
Message-ID: <20261111171540.GA3718375-robh@kernel.org>
References: <20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org>
 <20261111-xg6846b-bcmbca-xrdp-reset-v4-2-17035a5e8ad2@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-xg6846b-bcmbca-xrdp-reset-v4-2-17035a5e8ad2@kernel.org>

On Wed, Nov 11, 2026 at 12:00:43PM +0100, Linus Walleij wrote:
> The third generation Power Management Controller (PMC3) has
> different subdevices.
> 
> Identify the parent with the BCM6846-specific "brcm,bcm6846-pmc"
> compatible.
> 
> Describe the complex as a simple-mfd with a PMB bus child owning its
> register resource. Include the PMB power, clock and reset controllers and
> PVTMON, with its acquisition clock and reset resources.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  .../devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml  | 87 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 88 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
> new file mode 100644
> index 000000000000..6082e30d37ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/brcm,bcm6846-pmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM6846 Power Management Controller
> +
> +maintainers:
> +  - Linus Walleij <linusw@kernel.org>
> +
> +description:
> +  The third generation Power Management Controller (PMC3) contains several
> +  register banks. This binding describes the Power Management Bus (PMB)
> +  interface within Procmon. The PMB child owns its register bank. The parent
> +  provides address translation and does not own a register bank.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: brcm,bcm6846-pmc
> +      - const: simple-mfd
> +
> +  ranges:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +patternProperties:
> +  '^bus@[0-9a-f]+$':
> +    $ref: /schemas/soc/bcm/brcm,bcm6846-pmb.yaml#
> +    description: PMB configuration, keyhole and address mapping registers

This causes the bus node to be validated twice (once here and once when 
applied by compatible). And then because the pmb schema does the same 
thing with its child nodes, those will be validated 3 times. Twice I can 
live with, 3 times not so much. The fix for all this is either merge the 
schemas to 1 file or do:

'^bus@[0-9a-f]+$':
  type: object
  additionalProperties: true
  properties:
    compatible:
      contains:
        const: brcm,bcm6846-pmb

  required:
    - compatible

That ensures the node contains enough to apply the child schema. 

Since there's 3 levels here, you could also do some combination of both.

Rob

