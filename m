Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984603;
	b=DVUp+eNqYPn5Z7zwXK0cWRW+I61um3LxVp/N+tglmr9MFsRvn9aTjzC5IX22lZqQk4wt
	 jeFy5j/Ssh6vzjoXpZKRa+3TIvagiIGZFucORMlkTxLlDYb2Oi5BLKgirtYeEg8VLyyay
	 DHxs6I9Ld7b5AlgITIeyWe79z1pWu7p58mJ+o2mzrsXbRGEnYAanWSG9ShJrcoRi75f/F
	 MA+XRr7FeV4Qo4vGzKm1Z/MlDKaBA/TlsKoNEhQq0AqB0ds1C2JlyH1t2MnhAsX20R+P3
	 2KEGqVOyCbqixmgV9CDqsoWb5O4e+NCxSfLP1DGjoIrWK5EiZ5jadcyLHsLeUCNCS1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984603;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=wWZ7suLMwYRE3YxTvWg207PJnLuQey0dcBGqETyKiIw=;
	b=ilsvBKooyWxMWFDDU/PUmV2lhLlGEiguPi48sNhrNW/TGM4WSl4oA6gc8CkznAlbcYMk
	 685Y0xdLtTMApLVuuJ/0ncGmq8QOgLgBxd6v6Fbnz/Xg5O803/53s53//j9hLxmeqsT4e
	 MHy121ecgz4PRXKjOJADitCPe1DoPP8yrMSN9oDo2bGKOMK1bkvXdYiSXRzjIZV+MeMaJ
	 /KivxcAjOVva3Ds+IdUkxFSrHQwkttvBnqU5VKpidtpvrL5OkrtaKFSHeZRMpAyz3DOgK
	 VMmk9GszGW/UgR9KqV5xVFBcopOMR+N+UeABNPGTutAw3fZFKl9qr0uxWQwNln/4v/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ezwN9+Zj;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD1A606A32E
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 17:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AD1A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ezwN9+Zj
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so739916a91.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 09:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793984602; x=1794589402;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wWZ7suLMwYRE3YxTvWg207PJnLuQey0dcBGqETyKiIw=;
        b=W6qHFULuYoMjke/iMD4uuWNA9K0e/9Xz2Xjg7EYMKfqIVwQhAZ5zEsyNG8T1eT+mir
         1zStCiRdhj16Pd+3em2b+8/Gn34j6WR8gAAWrxaRCil0yt1csCThv+d/1MRwtL6W0cgE
         etevzKv3fxUPhLXF5XQ9la6sXNepyu1wMwyT3UtB44h+PwwIBCmdlqo2MNhG0PV0fI0b
         iFfG9JTokJci1vuus8QIfhn8lnQzpSelvt7ZzUKZUYb8ve9fkD5AgyprQU0zt5h4b2T/
         xaE5niBtn1uW4BvQTghQyG/a9pP46fSKOuL3tcuE8sVqSRkGq2dOpUV5o6Yk8ZB6baGL
         8oSA==
X-Forwarded-Encrypted: i=1; AL+hErG6Sh9JCdJWDwDo3VSHOXQZGy4n4M+heYHS3Cn1qtaZVEiagfh/t1TRd0cVW1JLLk1euBgtctELEg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/utWZWRBIYajCZ/eh/3rpDk5PSkLHCXvCTjhhl8p3TZDKBbTN2
	NgRms1qLoS4OIPJBlARqN51Rk1WsQ3JhDP9xbpL3ziI6Szmjres27FfENwd+9cTDorM96eU5NjO
	UATvqb0UEY+Lcb3wW8BY4YUN1eMhG/gO/sDCDnePQT4ysoj9aaYQGBagxD/wOfTo5VH7VZvFnPm
	6Ae5k+Sm0aM1JzAOrS2KYzAmre0OzNyPbU98Mm/RwOtdd9dE8C6fX+tZtmyH3ACTGdrweVJu5NL
	VOlLW9d21UXyus=
X-Gm-Gg: AYBFou2gNapNgaBJzf+lKY9urAwEb9UL1W8gIFk2dfEW+ePAHnmNuJyAIB/isLd6epv
	UvHP/NjvSc03bzGQZd3FAKLMlqqxWvgSaDw0JMzmpS6snemFzVzI8wcjVUd9bgxBkng6YNbcUvD
	FfXr1kxgiM/liO0kDxaqZWGueSbcv73NJSrPvcnpAhcnMTDDrqPRFuMzwnhkGf3L57Tk3MTmFTb
	E+kqCwsv4L5uj9E7AszGNkoTy4AG+WXgxhLuGBhJb9LtdZ2f4gDS531huxZETg8ixPMT27X6uvY
	EudhIDNdwLoa0aUBwfhQxjCbkIENtif/IOIjhZqKlPlJGfj2tBITbz3ioE6Uw8sfI7uLAB8Bi0O
	R6HmLbfcQVKNvOzmlVq0Chne94l4DAnu5hJ5AK32T1cul2bqCmIY4RfmHEFIVqDbRjhWxlEZ4V8
	FLMPvcije1YVkVbrnzWP3Sa26X0p82uBQaQAh3
X-Received: by 2002:a17:90b:2801:b0:3a8:5cab:1009 with SMTP id 98e67ed59e1d1-3b0db6e4fd4mr2806321a91.46.1793984601689;
        Fri, 06 Nov 2026 09:03:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0fc21cec1sm103932a91.0.2026.11.06.09.03.20
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2026 09:03:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-83edc5c5ae9so566829a34.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 09:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793984600; x=1794589400; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWZ7suLMwYRE3YxTvWg207PJnLuQey0dcBGqETyKiIw=;
        b=ezwN9+ZjSD0uCtO1mSbNwyWpNzji5527z7Y8aUusAhLMeNwAV+Xhq0MnMKPCeg8a56
         npRSNxZvU62AgQhWADLbjILvH+Euji09wAoT93h7ixmrxmitbXcXZzwpOUcUaHpX8t6P
         rzszXdauoHgt3yEdvifgx4sphrpyFfgyzB/1A=
X-Forwarded-Encrypted: i=1; AKwUvBwzsYD2iyIPAUIxGDZwky52WRaCYe8wUUNnhLVi4cqXzE3vzS8jb6DNbXzx59THV6cEadQgZ5ymvg==@vger.kernel.org
X-Received: by 2002:a05:6808:509f:b0:504:5fe1:c8d4 with SMTP id 5614622812f47-567e1848b93mr2236524b6e.59.1793984599603;
        Fri, 06 Nov 2026 09:03:19 -0800 (PST)
X-Received: by 2002:a05:6808:509f:b0:504:5fe1:c8d4 with SMTP id
 5614622812f47-567e1848b93mr2236457b6e.59.1793984599023; Fri, 06 Nov 2026
 09:03:19 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-xg6846b-bcmbca-xrdp-reset-v3-0-d6adeb71afc9@kernel.org> <20261106-xg6846b-bcmbca-xrdp-reset-v3-2-d6adeb71afc9@kernel.org>
In-Reply-To: <20261106-xg6846b-bcmbca-xrdp-reset-v3-2-d6adeb71afc9@kernel.org>
From: William Zhang <william.zhang@broadcom.com>
Date: Fri, 6 Nov 2026 09:03:06 -0800
X-Gm-Features: AclHuK9KamAO3QPKzJP168ypI7DJfpGe4hh3kd82BD64aNtSumXkCrA5JKntFqU
Message-ID: <CAHi4H7E+064hC+Jk25gDz7qRgkDe=VHeLuHQ705A1h9Tei8etg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: soc: Describe the BCM6846 Processor
 Monitor Bus
To: Linus Walleij <linusw@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Anand Gore <anand.gore@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Ulf Hansson <ulfh@kernel.org>, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, mfd@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-pm@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d3a2a5065f9e9699"

--000000000000d3a2a5065f9e9699
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 12:27=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
>
> The third generation Power Management Controller (PMC3) accesses SoC
> block control and reset registers through the Processor Monitor Bus
Power Management Bus.   Need to update all the instances in this patch seri=
es.

> (PMB). Describe the BCM6846 PMC and PMB.
>
> Describe the power controller child and all supported power domain IDs,
> including the combined XRDP, Runner and WAN domain.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> I considered even just using the PMB but the PMC has more stuff and
> it seems natural to let it live in a simple-mfd node.
> ---
>  .../bindings/clock/brcm,bcm6846-pmb-clock.yaml     | 39 ++++++++++
>  .../bindings/hwmon/brcm,bcm6846-pmb-pvtmon.yaml    | 42 ++++++++++
>  .../devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml  |  5 ++
>  .../bindings/power/brcm,bcm6846-pmb-power.yaml     | 44 +++++++++++
>  .../bindings/reset/brcm,bcm6846-pmb-reset.yaml     | 31 ++++++++
>  .../bindings/soc/bcm/brcm,bcm6846-pmb.yaml         | 90 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  8 ++
>  include/dt-bindings/clock/brcm,bcm6846-pmb.h       | 42 ++++++++++
>  include/dt-bindings/power/brcm,bcm6846-pmb.h       | 12 +++
>  include/dt-bindings/reset/brcm,bcm6846-pmb.h       | 11 +++
>  10 files changed, 324 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm6846-pmb-clo=
ck.yaml b/Documentation/devicetree/bindings/clock/brcm,bcm6846-pmb-clock.ya=
ml
> new file mode 100644
> index 000000000000..519606522c8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/brcm,bcm6846-pmb-clock.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/brcm,bcm6846-pmb-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM6846 PMB clocks
> +
> +maintainers:
> +  - Linus Walleij <linusw@kernel.org>
> +
> +description:
> +  The Processor Monitor Bus (PMB) provides access to the RDP and BIU PLL
> +  outputs, the Runner clock, the crystal output, the PVTMON acquisition
> +  clock and the clock gates in block power-control zones. Clock indices
> +  are defined in dt-bindings/clock/brcm,bcm6846-pmb.h.
> +  The PLLs and crystal output use a 50 MHz reference clock.
> +  Zone clocks require their associated blocks to be powered.
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm6846-pmb-clock
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ref
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/hwmon/brcm,bcm6846-pmb-pvt=
mon.yaml b/Documentation/devicetree/bindings/hwmon/brcm,bcm6846-pmb-pvtmon.=
yaml
> new file mode 100644
> index 000000000000..9bf52cf097a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/brcm,bcm6846-pmb-pvtmon.yam=
l
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/brcm,bcm6846-pmb-pvtmon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM6846 PMB process, voltage and temperature monitor
> +
> +maintainers:
> +  - Linus Walleij <linusw@kernel.org>
> +
> +description:
> +  The process, voltage and temperature monitor (PVTMON) is a child of
> +  the Processor Monitor Bus (PMB) controller and uses its indirect
> +  register interface. It measures die temperature and seven voltages,
> +  including a diagnostic test input.
> +
> +allOf:
> +  - $ref: /schemas/thermal/thermal-sensor.yaml#
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm6846-pmb-pvtmon
> +
> +  clocks:
> +    maxItems: 1
> +    description: PVTMON acquisition clock
> +
> +  resets:
> +    maxItems: 1
> +    description: PVTMON analog-acquisition reset
> +
> +  '#thermal-sensor-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - clocks
> +  - resets
> +  - '#thermal-sensor-cells'
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml =
b/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
> index d4c927cabb3f..77fbf92926ab 100644
> --- a/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
> @@ -60,6 +60,11 @@ examples:
>              compatible =3D "brcm,bcm6846-pmb";
>              reg =3D <0x20100 0x200>;
>
> +            pmb_power: power-controller {
> +                compatible =3D "brcm,bcm6846-pmb-power";
> +                #power-domain-cells =3D <1>;
> +            };
> +
>              pmb_clk: clock-controller {
>                  compatible =3D "brcm,bcm6846-pmb-clock";
>                  clocks =3D <&osc50m>;
> diff --git a/Documentation/devicetree/bindings/power/brcm,bcm6846-pmb-pow=
er.yaml b/Documentation/devicetree/bindings/power/brcm,bcm6846-pmb-power.ya=
ml
> new file mode 100644
> index 000000000000..891eb0f347e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/brcm,bcm6846-pmb-power.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/brcm,bcm6846-pmb-power.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM6846 Processor Monitor Bus power controller
> +
> +maintainers:
> +  - Linus Walleij <linusw@kernel.org>
> +
> +description: |
> +  The power controller is a child of the Processor Monitor Bus (PMB)
> +  controller and accesses BPCM power zones through the parent regmap.
> +  A domain includes all power zones of a block. The XRDP domain groups
> +  XRDP, its three Runner cores and WAN, matching the vendor power sequen=
ce.
> +
> +  Domain IDs are defined in dt-bindings/power/brcm,bcm6846-pmb.h:
> +    BCM6846_PD_PERIPH: peripheral block (bus 0, device 0, four zones)
> +    BCM6846_PD_MEMC: memory controller (bus 1, device 8, one zone)
> +    BCM6846_PD_USB20: USB 2.0 (bus 1, device 10, four zones)
> +    BCM6846_PD_XRDP: XRDP (bus 1, device 12, three zones), Runner cores
> +      (bus 1, devices 14, 15 and 16, one zone each) and WAN
> +      (bus 1, device 11, three zones)
> +    BCM6846_PD_PCIE0: PCIe 0 (bus 0, device 18, one zone)
> +    BCM6846_PD_PCIE1: PCIe 1 (bus 0, device 19, one zone)
> +
> +  Peripheral and memory domains remain powered because they provide
> +  resources required for system operation. CPU and PLL blocks use differ=
ent
> +  register layouts and are outside the scope of this provider.
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm6846-pmb-power
> +
> +  '#power-domain-cells':
> +    const: 1
> +    description: Power domain ID from dt-bindings/power/brcm,bcm6846-pmb=
.h
> +
> +required:
> +  - compatible
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm6846-pmb-res=
et.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm6846-pmb-reset.ya=
ml
> new file mode 100644
> index 000000000000..d2a85266e36a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/brcm,bcm6846-pmb-reset.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/brcm,bcm6846-pmb-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM6846 Processor Monitor Bus reset controller
> +
> +maintainers:
> +  - Linus Walleij <linusw@kernel.org>
> +
> +description:
> +  The reset controller is a child of the Processor Monitor Bus (PMB)
> +  controller and uses its indirect register interface.
> +
> +  Each reset specifier identifies a logical reset group, which may span
> +  several blocks that must be reset together.
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm6846-pmb-reset
> +
> +  '#reset-cells':
> +    const: 1
> +    description: Reset group ID from dt-bindings/reset/brcm,bcm6846-pmb.=
h
> +
> +required:
> +  - compatible
> +  - '#reset-cells'
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm6846-pmb.y=
aml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm6846-pmb.yaml
> new file mode 100644
> index 000000000000..134a8a676dbd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm6846-pmb.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/bcm/brcm,bcm6846-pmb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM6846 Processor Monitor Bus
> +
> +maintainers:
> +  - Linus Walleij <linusw@kernel.org>
> +
> +description:
> +  The Processor Monitor Bus (PMB) connects the third generation Power
> +  Management Controller (PMC3) to the control registers of miscellaneous
> +  independent hardware blocks.
> +
> +  The controller provides configuration, arbitration and four keyhole
> +  interfaces for indirect register access.
> +
> +  Child nodes describe independent hardware blocks accessed over the PMB=
.
> +  These provide global resources and even resources for each other.
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm6846-pmb
> +
> +  reg:
> +    maxItems: 1
> +    description: PMB configuration, keyhole and address mapping register=
s
> +
> +  power-controller:
> +    type: object
> +    $ref: /schemas/power/brcm,bcm6846-pmb-power.yaml#
> +
> +  clock-controller:
> +    type: object
> +    $ref: /schemas/clock/brcm,bcm6846-pmb-clock.yaml#
> +
> +  reset-controller:
> +    type: object
> +    $ref: /schemas/reset/brcm,bcm6846-pmb-reset.yaml#
> +
> +  hwmon:
> +    type: object
> +    $ref: /schemas/hwmon/brcm,bcm6846-pmb-pvtmon.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-controller
> +  - clock-controller
> +  - reset-controller
> +  - hwmon
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/brcm,bcm6846-pmb.h>
> +    #include <dt-bindings/reset/brcm,bcm6846-pmb.h>
> +
> +    /* Processor Monitor Bus */
> +    bus@ffb20100 {
> +        compatible =3D "brcm,bcm6846-pmb";
> +        reg =3D <0xffb20100 0x200>;
> +
> +        pmb_power: power-controller {
> +            compatible =3D "brcm,bcm6846-pmb-power";
> +            #power-domain-cells =3D <1>;
> +        };
> +
> +        pmb_clk: clock-controller {
> +            compatible =3D "brcm,bcm6846-pmb-clock";
> +            clocks =3D <&osc50m>;
> +            clock-names =3D "ref";
> +            #clock-cells =3D <1>;
> +        };
> +
> +        pmb_reset: reset-controller {
> +            compatible =3D "brcm,bcm6846-pmb-reset";
> +            #reset-cells =3D <1>;
> +        };
> +
> +        hwmon {
> +            compatible =3D "brcm,bcm6846-pmb-pvtmon";
> +            clocks =3D <&pmb_clk BCM6846_CLK_PVTMON>;
> +            resets =3D <&pmb_reset BCM6846_RESET_PVTMON>;
> +            #thermal-sensor-cells =3D <0>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f14f9910911c..e11fc5064dc5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5447,7 +5447,15 @@ N:       bcm[9]?6878
>  BROADCOM BCMBCA PMC3 PMB DRIVER
>  M:     Linus Walleij <linusw@kernel.org>
>  S:     Maintained
> +F:     Documentation/devicetree/bindings/clock/brcm,bcm6846-pmb-clock.ya=
ml
> +F:     Documentation/devicetree/bindings/hwmon/brcm,bcm6846-pmb-pvtmon.y=
aml
>  F:     Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
> +F:     Documentation/devicetree/bindings/power/brcm,bcm6846-pmb-power.ya=
ml
> +F:     Documentation/devicetree/bindings/reset/brcm,bcm6846-pmb-reset.ya=
ml
> +F:     Documentation/devicetree/bindings/soc/bcm/brcm,bcm6846-pmb.yaml
> +F:     include/dt-bindings/clock/brcm,bcm6846-pmb.h
> +F:     include/dt-bindings/power/brcm,bcm6846-pmb.h
> +F:     include/dt-bindings/reset/brcm,bcm6846-pmb.h
>
>  BROADCOM BDC DRIVER
>  M:     Justin Chen <justin.chen@broadcom.com>
> diff --git a/include/dt-bindings/clock/brcm,bcm6846-pmb.h b/include/dt-bi=
ndings/clock/brcm,bcm6846-pmb.h
> new file mode 100644
> index 000000000000..548a18ed7959
> --- /dev/null
> +++ b/include/dt-bindings/clock/brcm,bcm6846-pmb.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +#ifndef _DT_BINDINGS_CLOCK_BRCM_BCM6846_PMB_H
> +#define _DT_BINDINGS_CLOCK_BRCM_BCM6846_PMB_H
> +
> +#define BCM6846_CLK_RDPPLL_CH0 0
> +#define BCM6846_CLK_RDPPLL_CH1 1
> +#define BCM6846_CLK_RDPPLL_CH2 2
> +#define BCM6846_CLK_RDPPLL_CH3 3
> +#define BCM6846_CLK_RDPPLL_CH4 4
> +#define BCM6846_CLK_RDPPLL_CH5 5
> +#define BCM6846_CLK_BIUPLL_CH0 6
> +#define BCM6846_CLK_BIUPLL_CH1 7
> +#define BCM6846_CLK_BIUPLL_CH2 8
> +#define BCM6846_CLK_BIUPLL_CH3 9
> +#define BCM6846_CLK_BIUPLL_CH4 10
> +#define BCM6846_CLK_BIUPLL_CH5 11
> +#define BCM6846_CLK_RUNNER     12
> +#define BCM6846_CLK_XTAL_OUT   13
> +#define BCM6846_CLK_PVTMON     14
> +#define BCM6846_CLK_PERIPH_ZONE0       15
> +#define BCM6846_CLK_PERIPH_ZONE1       16
> +#define BCM6846_CLK_PERIPH_ZONE2       17
> +#define BCM6846_CLK_PERIPH_ZONE3       18
> +#define BCM6846_CLK_MEMC               19
> +#define BCM6846_CLK_USB_ZONE0  20
> +#define BCM6846_CLK_USB_ZONE1  21
> +#define BCM6846_CLK_USB_ZONE2  22
> +#define BCM6846_CLK_USB_ZONE3  23
> +#define BCM6846_CLK_WAN_ZONE0  24
> +#define BCM6846_CLK_WAN_ZONE1  25
> +#define BCM6846_CLK_WAN_ZONE2  26
> +#define BCM6846_CLK_XRDP_ZONE0 27
> +#define BCM6846_CLK_XRDP_ZONE1 28
> +#define BCM6846_CLK_XRDP_ZONE2 29
> +#define BCM6846_CLK_RUNNER0    30
> +#define BCM6846_CLK_RUNNER1    31
> +#define BCM6846_CLK_RUNNER2    32
> +#define BCM6846_CLK_PCIE0              33
> +#define BCM6846_CLK_PCIE1              34
> +#define BCM6846_CLK_BIU                35
> +
> +#endif
> diff --git a/include/dt-bindings/power/brcm,bcm6846-pmb.h b/include/dt-bi=
ndings/power/brcm,bcm6846-pmb.h
> new file mode 100644
> index 000000000000..abdd01c94bc5
> --- /dev/null
> +++ b/include/dt-bindings/power/brcm,bcm6846-pmb.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +#ifndef _DT_BINDINGS_POWER_BCM6846_PMB_H
> +#define _DT_BINDINGS_POWER_BCM6846_PMB_H
> +
> +#define BCM6846_PD_PERIPH      0
> +#define BCM6846_PD_MEMC                1
> +#define BCM6846_PD_USB20               2
> +#define BCM6846_PD_XRDP                3
> +#define BCM6846_PD_PCIE0               4
> +#define BCM6846_PD_PCIE1               5
> +
> +#endif
> diff --git a/include/dt-bindings/reset/brcm,bcm6846-pmb.h b/include/dt-bi=
ndings/reset/brcm,bcm6846-pmb.h
> new file mode 100644
> index 000000000000..ce68adb10108
> --- /dev/null
> +++ b/include/dt-bindings/reset/brcm,bcm6846-pmb.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +#ifndef _DT_BINDINGS_RESET_BRCM_BCM6846_PMB_H
> +#define _DT_BINDINGS_RESET_BRCM_BCM6846_PMB_H
> +
> +/* XRDP packet engine and its three Runner cores. */
> +#define BCM6846_RESET_XRDP     0
> +
> +/* Process, voltage and temperature monitor analog acquisition reset. */
> +#define BCM6846_RESET_PVTMON   1
> +
> +#endif
>
> --
> 2.56.0
>

--000000000000d3a2a5065f9e9699
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
PRi27wH/XHTDMdyL0Org+kxniXue6MSNJvcQwaLO/UQrmgTygBlVGa+Qg9ZFfS00xvuqeYH7tImO
48WiXeu9rgn5KTH0IWP1+R74KIgxJQ+65la+caZvxwC9V3ik5p/LOGA2qS4GEjGuaYF8QKhRTR4h
/QBSktqZLbzVxpjJXrqFTA2BLlYRp9hPhqNxbn46WuLufpMWhFtjUoQi/8fRRWRsMAY0o1J0f+kB
6EI8FoxPTOpvuLRonqHIWMHk5YRnDdqJ3G5Oc8zmV+UCAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEad2lsbGlhbS56aGFuZ0Bicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFHjI7pbQZurVKsSRE/a9
7gUEyVCkMA0GCSqGSIb3DQEBCwUAA4ICAQCFA4fU1GnG8sY7kyUXp5tle+VeWveoWb272jPauU5R
w+udkhVXmnR0Kg7RgkCD00PLTKHNRyegXXDMArs3N9NhO3s9eSp9KjDh+h3WuQWCJH3QBHLGW0qE
fyV87wUtBIy/QsHwO4S8OlOZiXECR7V1EGIF6t3s0W+3UzgYeHL+Ttuhda+2wIVY0EbS0eNH9Vob
4YG17VTBBe7hyobXFpd9d1JGENFzIWncPUshOE0Wv7KlkrRc6aBOpL4p5xO1pHi9h9w8utyHkMoV
nefXixkn5YVHnuV/jbSF/IM4Mlqt0E+n/TRp2c0eR+1AauZKENV2syNBo4aMa0BkmikBjLSnDjt/
TYQdwHNWdV495n71idvueWwTFUhUsnudYcnh42eZENopBOYjVu2WhsffyrNz0hsuR85LriqSuBbf
drd9DMo3DgtfJ7hh4sEAhSw/x/Br86rfLBftZMU02htlnkOI9Tp1QuDsr9+MsqY6AjKeXAy67m7H
TVAZ9uyO9N20yU0p7igESOWKR1ccL1TPA1jrSHK18Y75ot5199FNWeE/UKoDKSML39iPZho9XPh/
/RlsfRFiVOPrI5Gwi4YfIfi0jjEWf310/CYEmA5jrp5gUQSdo/+FgfXLKDFiEHCf5b3B1l70r6bR
WkDCNNacYJWZtSp87i6jmw+l5xx7OkEJ9DGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDD2ooFIye/WiO3KgZTANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
BRebSBOrs+WPDt3JIYNTjfaIHomXCpQ20eXn61sLoTswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYxMTA2MTcwMzIwWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEApILCgNdJjmAE2kwULCh0+qwjcAo2UJaMSYGq
xW3+2wpr/IrRIZcGndoGizLWbB4ioDTMZ0Eodd9PY9aAjSiY88DBg3NCXsjKs1qeYxNMMtpIOJ1R
CYl5oQgcRVTrTZGhtoyOsObAdqRaFeZFZPHoLOOo35+sggHq63eIiug1Bg/UIzYmkDFJFNkc3fsu
L2/ZBXPy02LeLMlRlVgKX4nPK9Y3+iojE+ON6jd19sIi2jVeFVCIXuZbAE7o0k2RSqBivHjZNpFT
nhkwNNBxFy6e5Wdt01oRW8GU8otnckJTheBA76BPIwFmewF+M3pjkkVpybTozbHHfXxQnW0OtHz5
zg==
--000000000000d3a2a5065f9e9699--
