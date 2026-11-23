Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795428283;
	b=ZekZFq1C1KMSuT1fXVovG8AfkeB7VvfFTtgdPSQTxZlRSx/yr4+Kd157NQRagNd1EsIr
	 S3KgJaRyoL2mK7YBAE9+m3KJgSrThdhgwCI7UsrpyUsLyFV3gF/1RNiQzQihlRML1sbTg
	 AeX4bWUxzgqkoyDGDhx9Ucw/CFuu5osOELWZP3N2pSaReIkcBwiuCyYEpVXEEV+holRKg
	 1L2/F+VS/kiti/+GskPSDTHuroa7M28H/SWiGnUktkwZgG6Zv4y86Z5bfSVPtO9QdsAb2
	 r4I87Shyy3woWL0nsV0YXV/yc9TLJillXEyMc1JQIXyDv+T8Pc8vHnDkKebRwV11ztQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6UD6d4OR7O5/YFJwC3m/R5TqgdXj9WG+ZTBm269rAHk=;
	b=uvTYqIEN2XfozMVtme7XHiXFrMPhYM+Lai3q0LrXahIIS5HK5mIVWdZoSYSsLsJ/K823
	 oYDD166kWKiY5WiiaPa99KQmUr15BhfHZGI84La0Z87f+unH8fFwd42Mn9Z9OgthQ6m4j
	 BNCLbRPf9GnAyWeXb1EndcVnz6JJT1tCL6JybbN9U/VgvFHrjgXzjjVKan5ZrPTIVrmIx
	 2CC4ggeK450CSCLLkcrs4Ydd6xhThzvIRthfEdVSE8syRMFie5IUPPEB92tOoaKNCRtDR
	 UnMrmj9HmWCz+5fVJFBrdXP2DewO1GPJ6OZ0tkgFVg44XfglyCKGQpad55axzgZIUJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=fEskxHSQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200A606A32A
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F200A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=fEskxHSQ
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so502675066b.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 02:04:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795428281; cv=none;
        d=google.com; s=arc-20260327;
        b=hfcSfGWL7kArpMXVNRaEnjn91fdUnieCa/P2Kqk18iZmAsSWUzLD8xWAlw0z8140rR
         UUY12+49Qiih5KyyFZmihDw+/DiK1SF4uRnW0VVsUo9gcceWkhqd3lRNkVk7etqC+s56
         yjvdfQU3zvaKzR1RV2nUuwixakWDUe1wbT8r8nsdhhc1JMJlSm5r/vbugMsrLIRJkGOd
         rUiwt9I8tcq0AGEg/+uzjjey7VM7sobLGpjH8eEVD7br1/IPfpRwQdOOqNrr11hJpaF2
         5RCQJq+ocN/XAjPvVBNoYqRIkYJ4GsV4TeMF703WBTt/fgVaO9TbVsQztW87mlhv6x4F
         4w4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6UD6d4OR7O5/YFJwC3m/R5TqgdXj9WG+ZTBm269rAHk=;
        fh=4m92T4ypUYa06Q1V6ohSfgRvQ/s/qK9uoAuuGxyuGHo=;
        b=dNt53SyZNabmjk7RdDz8ss7Ft0Jyb7D3Pp0JVkqG4ZugJvE/k+NRECIbQd5CQ87thq
         90C818REwzipvk7LyYKRKaOVAenf5mGozYkDYjGs7Tg/bYK3/8dO/LVnNGreybglh2Te
         HCajEwnc+9KAWkRvxlCe4bgaluUylavnKDihNvum+glKUpD+lvCghFjiBiiUgshA84M7
         Bm5qHyIac/KYTXunyZt6rWry4Xv6WeNDu+OPaEXDQiE66MwFj5JOG6ORgek+mc8FrTFO
         RxslyQFo0f2OyxPLHGKbJ1gW7fsJoBIZ1Q6OH/B4RLpUnX2vEpcf32oKC4y8+k5QMMUA
         yNAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1795428281; x=1796033081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6UD6d4OR7O5/YFJwC3m/R5TqgdXj9WG+ZTBm269rAHk=;
        b=fEskxHSQrfKjI66o/PpuzFTiLwe24il6dEoMqkWtkIvNllSUSzSOYCuqDTFWkeE2d3
         bL6W4hf36LVvsVTm0XR+yrXS0JcEqlIaSGiOwRNQpBSfcu1t6xcrV1Z3/pb+x5cwcDuJ
         zV1kKB/cAfkRSBWWnWPskdwMMxk+5lOuJI8zr+e81cgEv2YjKCI3WfdDWaieCXTmGwfd
         Dcx4N7LoRSxFEbT4l8ZAwr9XshIOLKpD5yKD6Og/sDqP0N6sgC+0xZz9cHSyjSI8+UuC
         bOcujU9jTNteuQLRkBak7LasmMi7fRyU2L7ZThR7SVzYnSW067bEEcaWZyxoD5PSpjfk
         3OHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795428281; x=1796033081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6UD6d4OR7O5/YFJwC3m/R5TqgdXj9WG+ZTBm269rAHk=;
        b=0VYLPZP9UmMmY0+iXkAHEKPSk40y8C0yobSpAqSooWN0BhmSiudtQ5/d5DGjcq0EaX
         AJofz7GfUtg/wSGT3CMpROtWwZ5NNooQ7kXlkyUsXpx9cTqbPk3aw7Om3m0/50JqmmPO
         IGMTg0sGIEJ15FpI9afSHXg7xBsk+S7MFejdrUJZeXbnziVZmgTO5oZ/p2Q4JgVYn9R5
         FHc+UxfaGCDOTMpdcvHND4KOfKOPHuHSTByVz7KOGOx4vplVJxhRSqGXFY/rod+JbzDu
         2bxkDjEQJCHwMlmaMykVy8TMhNjhsdtK3v7+pL9vHJuTOIo5S7eF/5SLfuzxif7QCm9A
         UQKQ==
X-Forwarded-Encrypted: i=1; AL+hErF5LAjHvNpDLPNHbKxJAl7HC3Xf3bEZMepzaI6+phE3gYsU8lM/+F/sUtyVVY0D5w85l4I3iNBqSw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8It1eCS4TrtYXvYc4PoO4+RGUyCPCmmMKIyOkuAK5kmVgGiF+B
	MRRHmpI+zao4HRyqgQEogFN/KUhOWWoo7zsAZ2Hciqwj4DG6CwBdmG8RGwTSCHLospDXbYrpA5Q
	KChNZhKJXKlUBuqya605Crb5oaD+co4GZ+DusoqXaHQ==
X-Gm-Gg: AZFdTZeKUcWA4Y9y7yNKTfrmLnCLJpHRE8BseXVEzeTRWsjG3Y3149XjxWIhQWTPlOb
	0TxoHvY/R7x2E80J97TKlBUH1RLG/SjYi8pZQ4PXmZuSc1w/6QzJ9i2hQVEhMU/BAN4j0NOG8a6
	cs2V8chuWJsltrn4yg5ejANL/BMrZ1RHKwynnCn8emweWJXiYseFGPz/xWkF1ocpu0utJPk+yxU
	WqFkZ3V1XFrjsSQn9UDuIIdOHG3zxPt06Azs7E3IozcgZ00Z5bfZOr4PInBFAp/zvZwGIrhuho/
	tzZojtohRjGf+HVbEMVuQVOm2xj4QrZmsHN34yoIEcAcOZ5Q+tp4vpwaMHSw3lrxpZGFq9uX73o
	+tsy12i3xph7mutY2MBVe6Zl01t2vOZ6uU2hr407rIhbYgtLUjF3yt48=
X-Received: by 2002:a17:906:2707:b0:c51:2064:1958 with SMTP id
 a640c23a62f3a-c513a39efe6mr814320766b.2.1795428281172; Mon, 23 Nov 2026
 02:04:41 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com> <20261122-pcie6_fix-v2-1-2e0fe615d90b@oss.qualcomm.com>
In-Reply-To: <20261122-pcie6_fix-v2-1-2e0fe615d90b@oss.qualcomm.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 23 Nov 2026 14:04:29 +0400
X-Gm-Features: Aa3M54pOZMnCeWnbYXgIXixZWgeLWc5StKGtiBVYf4ZIEkVQkWFUunq1ArlQkOQ
Message-ID: <CAKTNdwEFSDn4K_15pVK7=ZEWwanHQ284R4=spWWLCB0UspEMow@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key B connector
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

On Sun, Nov 22, 2026 at 10:46=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> Add the devicetree binding for PCIe M.2 Mechanical Key B connector
> defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
> connector is used to attach WWAN Adapters to the host machine over
> interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0. The slot also
> accepts SATA and PCIe SSD Adapters, which use the same pins.
>
> Interfaces that share connector pins are described as one graph port
> per pin group, with the endpoint number selecting between the mutually
> exclusive interfaces.
>
> The connector provides a primary power supply of 3.3V/VBAT, along with
> optional GPIO signals: FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1# and DPR
> for WWAN Adapters, and DEVSLP, PLN# and SMBus ALERT# for SSD Adapters,
> plus an I2C parent for the SSD SMBus.
>
> The function of the GPIO_0..GPIO_11 pins depends on the Port
> Configuration, so they are described by gpioN-gpios properties with the
> function of each pin per configuration documented in the binding. The
> Adapter configuration is either sensed through config-gpios
> (CONFIG_0..3) or fixed with config-state, which defaults to WWAN PCIe.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> ---
>  .../bindings/connector/pcie-m2-b-connector.yaml    | 332 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 333 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-connec=
tor.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.=
yaml
> new file mode 100644
> index 000000000000..4760863ff4f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yam=
l
> @@ -0,0 +1,332 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key B Connector
> +
> +maintainers:
> +  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechanical =
Key B
> +  connector. Mechanical Key B connectors are used to connect WWAN device=
s to
> +  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or USB =
2.0,
> +  selected by the Adapter's configuration pins. The slot also accepts SA=
TA and
> +  PCIe SSD Adapters, which use the same pins as the WWAN interfaces.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-b-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for the 3.3v/VBAT supply.

The node name doesn't match what the spec calls it ("pcie" seems
redundant). Also, can a module have separate supplies for its 3.3v and
VBAT?

> +  full-card-power-off-gpios:
> +    description: GPIO output to FULL_CARD_POWER_OFF# signal. This signal=
 is
> +      used by the host system to turn off the entire Adapter. Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.2.13.1 for more details.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO output to RESET# signal. This signal is used by th=
e
> +      host system to place the WWAN Adapter into a power-on reset condit=
ion.
> +      Refer, PCI Express M.2 Specification r4.0, sec 3.2.13.2 for more
> +      details.
> +    maxItems: 1
> +
> +  w-disable1-gpios:
> +    description: GPIO output to W_DISABLE1# signal. This signal is used =
by
> +      the host system to disable the WWAN radio on the Adapter. Refer, P=
CI
> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
> +    maxItems: 1

Shouldn't we also have w-disable2-gpios? The first one typically
controls the WWAN radio, and the second one controls GNSS.

> +  dpr-gpios:
> +    description: GPIO output to the Dynamic Power Reduction (DPR) signal=
.
> +      This signal is provided by a host system proximity sensor to the
> +      Adapter to trigger a reduction in the radio transmit output power =
to
> +      meet regulatory SAR requirements. Refer, PCI Express M.2 Specifica=
tion
> +      r4.0, sec 3.2.13.4 for more details.
> +    maxItems: 1
> +
> +  alert-gpios:
> +    description: GPIO input to the SMBus ALERT# signal (pin 44, shared w=
ith
> +      GPIO_2). SSD Adapters assert this signal to indicate to the host t=
hat
> +      the SMBus device requires attention. It is not present on WWAN
> +      Adapters. Refer, PCI Express M.2 Specification r4.2, sec 3.2.14.2.=
1
> +      for more details.
> +    maxItems: 1

It's also GNSS_IRQ in Port Config_0 and Port Config_1, so that should
probably be reflected in the description. Or maybe treat all
multi-function GPIOs (GPIO_0..GPIO_11) uniformly, and either define
all alt functions for each of them, or none? Otherwise, this one looks
out of line with the rest.

> +  i2c-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the host I2C controller connected to the SMB=
us
> +      pins SMB_CLK and SMB_DATA (pins 40 and 42, shared with GPIO_0 and
> +      GPIO_1). The SMBus is only present on SSD Adapters. Refer, PCI Exp=
ress
> +      M.2 Specification r4.2, sec 3.2.14.2 for more details.

It's also GNSS_SCL/GNSS_SDA in Port Config_0 and Port Config_1, so
that should probably be reflected in the description.

On a broader point, I see you've decided to keep the "slow" interfaces
and GPIOs out of the ports schema - is that intentional? I'm afraid
that would make referencing e.g. the audio interface provider more
cumbersome. Maybe we need to define a DAI subnode for it then?

Also, should pinctrl groups corresponding to different interface
configurations be part of the binding?

> +  devslp-gpios:
> +    description: GPIO output to the DEVSLP signal (pin 38). The host ass=
erts
> +      this signal to tell a SATA SSD to enter the Device Sleep power sta=
te.
> +      It is only present on SATA SSD Adapters. Refer, PCI Express M.2
> +      Specification r4.2, sec 3.2.10.1 for more details.
> +    maxItems: 1
> +
> +  pln-gpios:
> +    description: GPIO output to the Power Loss Notification (PLN#) signa=
l
> +      (pin 8, shared with W_DISABLE1#). The host asserts this signal to
> +      notify a PCIe SSD that a power loss event is about to occur. WWAN
> +      boards use w-disable1-gpios for this pin instead. Refer, PCI Expre=
ss
> +      M.2 Specification r4.2, sec 3.2.18.1 for more details.
> +    maxItems: 1
> +
> +  config-gpios:
> +    description: |
> +      GPIO inputs sensing the four CONFIG_0..3 pins (pins 21, 69, 75 and=
 1
> +      respectively, listed in that order in this property). The Adapter
> +      grounds or leaves unconnected (NC) each of these pins to tell the =
host
> +      the Adapter type, the host interface in use and, for WWAN Adapters=
, the
> +      active GPIO_0..11 Port Configuration. Boards that only ever use on=
e
> +      Adapter type should use config-state instead. If both properties a=
re
> +      present, config-gpios takes precedence. Refer, PCI Express M.2
> +      Specification r4.2, sec 3.2.15 and Table 3-18 for more details.

s/only ever use/only support/ ?

Shall we enforce that only one of `config-gpios` or `config-state` is
present via the schema, and remove the precedence description from the
text?

> +      Table 3-18. Socket 2 Add-in Card Configuration:
> +
> +        CONFIG_0 CONFIG_1 CONFIG_2 CONFIG_3  Adapter Type / Host Interfa=
ce   Port Config
> +        GND      GND      GND      GND       SSD - SATA                 =
      N/A
> +        GND      NC       GND      GND       SSD - PCIe                 =
      N/A
> +        GND      GND      NC       GND       WWAN - PCIe                =
      0
> +        GND      NC       NC       GND       WWAN - PCIe                =
      1
> +        GND      GND      GND      NC        WWAN - PCIe, USB3.1 Gen1   =
      0
> +        GND      NC       GND      NC        WWAN - PCIe, USB3.1 Gen1   =
      1
> +        GND      GND      NC       NC        WWAN - PCIe, USB3.1 Gen1   =
      2
> +        GND      NC       NC       NC        WWAN - PCIe, USB3.1 Gen1   =
      3
> +        NC       GND      GND      GND       WWAN - SSIC                =
      0
> +        NC       NC       GND      GND       WWAN - SSIC                =
      1
> +        NC       GND      NC       GND       WWAN - SSIC                =
      2
> +        NC       NC       NC       GND       WWAN - SSIC                =
      3
> +        NC       GND      GND      NC        WWAN - PCIe                =
      2
> +        NC       NC       GND      NC        WWAN - PCIe                =
      3
> +        NC       GND      NC       NC        WWAN - PCIe, USB3.1 Gen1   =
      vendor-defined
> +        NC       NC       NC       NC        No Add-in Card present     =
      N/A
> +    minItems: 4
> +    maxItems: 4
> +
> +  config-state:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Fixed Adapter configuration for boards that do not sense the CONFI=
G_0..3
> +      pins, given as the state number (0-14) of Table 3-18 of the PCI Ex=
press
> +      M.2 Specification r4.2. It selects the Adapter type, the host inte=
rface
> +      and, for WWAN Adapters, the Port Configuration used to interpret t=
he
> +      gpioN-gpios properties. Ignored if config-gpios is present. If nei=
ther
> +      property is present, state 2 (WWAN - PCIe, Port Config_0) is assum=
ed.

Does state 2 follow from the spec? It sounds arbitrary; perhaps
mandating either config-gpios or config-state via "required" would be
clearer.

> +    minimum: 0
> +    maximum: 14
> +    default: 2
> +
> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host s=
ystem to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.1=
2.1 for
> +      more details.
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph bindings modeling the interfaces exposed on th=
e
> +      connector. Several interfaces share the same connector pins and ar=
e
> +      selected by the CONFIG_0..3 pins, so each port describes one group=
 of
> +      pins and its endpoints describe the mutually exclusive interfaces =
that
> +      can be present on that group.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: |
> +          Pins 41, 43, 47 and 49. The endpoint number selects the interf=
ace:
> +            0 - PCIe lane 0
> +            1 - SATA
> +        patternProperties:
> +          '^endpoint(@[0-9a-f]+)?$':
> +            type: object
> +            properties:
> +              reg:
> +                enum: [0, 1]
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: |
> +          Pins 29, 31, 35 and 37. The endpoint number selects the interf=
ace:
> +            0 - USB3.1 Gen1
> +            1 - SSIC
> +            2 - PCIe lane 1
> +        patternProperties:
> +          '^endpoint(@[0-9a-f]+)?$':
> +            type: object
> +            properties:
> +              reg:
> +                enum: [0, 1, 2]
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB 2.0 interface (pins 7 and 9)
> +
> +    anyOf:
> +      - required:
> +          - port@0
> +      - required:
> +          - port@1

Can there be a USB 2.0-only host that provides neither port@0 nor port@1?

> +patternProperties:
> +  '^gpio([0-9]|1[01])-gpios$':
> +    description: |
> +      GPIO connected to the GPIO_<N> pin of the connector, where N is th=
e
> +      number in the property name. The function of these pins depends on=
 the
> +      Port Configuration selected by config-gpios or config-state (Table=
 3-15
> +      of the PCI Express M.2 Specification r4.2, sec 3.2.13.3):
> +
> +        GPIO  Pin  Config_0     Config_1     Config_2     Config_3
> +        0     40   GNSS_SCL     GNSS_SCL     SIM_DETECT2  IPC_0
> +        1     42   GNSS_SDA     GNSS_SDA     UIM_DATA2    IPC_1
> +        2     44   GNSS_IRQ     GNSS_IRQ     UIM_CLK2     IPC_2
> +        3     46   SYSCLK       GNSS_0       UIM_RESET2   IPC_3
> +        4     48   TX_BLANKING  GNSS_1       UIM_PWR2     IPC_4
> +        5     20   AUDIO_0      AUDIO_0      RFU          AUDIO_0
> +        6     22   AUDIO_1      AUDIO_1      RFU          AUDIO_1
> +        7     24   AUDIO_2      AUDIO_2      RFU          IPC_5/AUDIO_2
> +        8     28   AUDIO_3      AUDIO_3      PLA_S2#      IPC_6/AUDIO_3
> +        9     10   LED_1#       LED_1#       LED_1#       DAS/DSS/IPC_7
> +        10    26   W_DISABLE2#  W_DISABLE2#  W_DISABLE2#  HSIC_STROBE
> +        11    23   WoWWAN#      WoWWAN#      WoWWAN#      HSIC_DATA
> +
> +      The IPC_0..7 functions of Port Config_3 are vendor defined, as are=
 all
> +      functions in CONFIG state 14.
> +
> +      On SSD Adapters (CONFIG states 0 and 1) the same pins are SMB_CLK
> +      (GPIO_0), SMB_DATA (GPIO_1), ALERT# (GPIO_2), PLA_S2# (GPIO_8), an=
d
> +      LED_1# or, on SATA, DAS/DSS (GPIO_9).
> +
> +      Only list the pins that are wired to a host GPIO. Pins used as a b=
us
> +      signal in the selected Port Configuration (I2C, I2S/SLIMbus, HSIC)=
 are
> +      not GPIOs and are not described by these properties.

Should those bus signals be reflected in the binding though?

Best regards,
Alexey
