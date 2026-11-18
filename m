Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794988020;
	b=1YiceTLk2p+ajxhpAPddN76H1RDnOiwaLeyBQ6GJQYZnfCGcAngja3ZVvaW6bmVgZvhn
	 4JPAuDm1GDhZgOlb+Uj/2BM7sxllzS4OJX/ndD99M8qkxYO0qA7EkTa/Lo5SuWAJaMjaW
	 XYDE0VhzRR8sMMm8QMbLyAb5yF2CqZ8BCKnU0fc2hmJiE+6b366tF0/EsvtrvNAO2LuiS
	 R4P/ptiYlSNXvzPtvg0XeCbeNkgj6vqEjeRKfzEK571GReVAy44Rf8slKQSSz/z3X/xAs
	 aO09H+nH290aZoTXZ5UXTo9QogPRUFKwTJHx8wiGnuldflHwMBdaeu27p/3LUWutYIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Pnx/XKeGh94aieoFZrCY2NwwXx3i4N4YVNZK0i3sHOs=;
	b=5Iwyt0ES7XC2P3sXfI1PMckNH9qwqPzb1JfDG9XIy4kJQF4b/zV19GeYPbc5se/6fXdB
	 NtAgYh7fTle1jScUJ6u+0sBTbdF+v5/QzWFeGNwFdSXMaOJvazarRQLEJuRyEyY4mppht
	 tdhWQeNwLTdhFSl/Qrfr2naA6+4VaYX2wG5g+R7pduiCdQY1QYy/mC9ctQgMGCwc9P71u
	 wM5y9VopFGTc4sVdm9iAtz5iBfwB29cRH636ymjkr+uS0qWHxj+aZdsSRAYpJgQ3Z6YxU
	 xantWyYkkMpRLABw1DTZugjRTku8KlY9icHGufBGNIqovuqikPlU8zrQprCftznLvLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=KwxIBuS9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A134606A32F
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 07:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A134606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=KwxIBuS9
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c50cc8e0f84so85169466b.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 23:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794988017; cv=none;
        d=google.com; s=arc-20260327;
        b=O/aEIw+tyQhqEAFy2LEFhEVzIBqKmhUIHW4di2QuNIF5sBgCKtYL3uEP3WKh0DXb7X
         g21lFRZlsRwVrWysX+5VmRVJTZ/fXaUuftZJdQ1mwIYXkbgtCa1Nwf8b2ctN2jk2tjeX
         heSyd0KgY0pdT57l77b992BlutuXqBDVE6N36uKCD9q+SDWZQwSoemD8+Es7Bgq2Uh9c
         SMPDbtDt3U1onU1ucTRnOAvpnWYo69OFn710TZmSgZQC+zy0Z5gS58yLa0rBA3IPLK/b
         3ZDYSncPvywMwsnU2VKwgGQsuaFAm+dCeHt35Z2Pvb+B8Hy00k+XW11IlMqTMSFcetB4
         ULjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pnx/XKeGh94aieoFZrCY2NwwXx3i4N4YVNZK0i3sHOs=;
        fh=NsQVrDiE26gh1hGWZNGrxmtWl/Kny/TICpQZsCS24/4=;
        b=lthcu5TPC9SHUxXhWAJrkMIPiWbwUZ5PhlkdwRNxjjqS2oCPUFXekBk7WpPDdMw1c+
         uDvaGcuKQtujh3EheUVFd+dvCercFSZ9mwwELpWefPMZbh2xNCnRS0xBJKTf3NVtPViC
         vTB88UDjdes9hPhe/DTA7lzebzpkyhXb3n8fm+UjgpHBs1oMzosTPcF88/VZa+ZGEN3/
         hwA4+laUM3z92AZDJhs6VB02GyrAvM8NFt+xO/L5PTYUMb6MYiX6jAKht8BkieHv4zvN
         u7/SpJ6oUZXJPm8HtZbTxXIqfgSSc9jTU/rphb3MAgHjcntoBb5Gtmt9sleu/oQBIh5N
         +Zlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794988017; x=1795592817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pnx/XKeGh94aieoFZrCY2NwwXx3i4N4YVNZK0i3sHOs=;
        b=KwxIBuS92KiVES7EPspJTIkt+Vyfny/uZgiUrllnoPC8h5ws2iqgOx6IGqU3bdxpJF
         dTh+jwl6pe/Mg2vFUsOi2NsXr//POfNQZwoZGHxLw8YE2AypIZN05YQ++EvnjV5+l1NT
         +NATB2riwpwfALaIqHaZQcMqilv4NY7h7Kd93KIg1VEqkvhv9rwn/bFvmZomybfh0gk0
         dxSxiw2IovXsuFbv+f5Qhxzv2Q5O4vL3W/pYQc9KJe02/JYqpLW7h7bxxzji6Z2SsDLR
         Ul+uqGPAIPJHrYy7FkTC4ddPTvtIgQQ6nMTZCUHj0DGq1S9fjp9CUECwLscDn+TXP/oJ
         8b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794988017; x=1795592817;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pnx/XKeGh94aieoFZrCY2NwwXx3i4N4YVNZK0i3sHOs=;
        b=f3594cj9sYNK1HTu8Z2hZF7M2uc4YfHAxq6nW0JhFbLypVD1afgTXo30FGkipCKkgV
         SDgJMaMpccK/5QIjawsHZpC62zX9aMhDK2T91B9nNks9yoVkd7Y9lCfut8aNjKZo2tiz
         GCe9fosp0a0xeUmNowa/0mxo/A5Z0Z5Y7LHLv0roJABnxyb7M359OzStRvv7aU/R8ula
         i2393hGfBuvMhtNH1488LPkdw0Oh+p+zmidnOib4hXAxP6vlfV+ggkvCO7DgFJA/6P1p
         3h1QD38/NYWM/4gJ9UpE48ULaPcHCLfGw6lx5RPjSGbq1xt2YdvR/G1cHSotwlKbB2hn
         8ndg==
X-Forwarded-Encrypted: i=1; AL+hErGdecRLrCF8fNcv8wmWCWaQBCcMNTXZIze03camEt6Jj+94l1uvbhWbVzPNLac2FcvFz+6xjZYgDg==@vger.kernel.org
X-Gm-Message-State: APuU4Z84ogOiLQgVBF1WDiS73Ak4CTc0YNVSEiv6SqiMeTzhtAR3srss
	twp1mRMjB79xTQCJGrk+T/YfOUxatbPqDqrGydVDYKe2MOdS5QYBIoQEIa4bpRbpVWTlkbsA9w2
	2TBLrNX7S4ZTQiFsx3guHNBv9wKYDOHYTsni/fdBjvw==
X-Gm-Gg: AYBFou2/YzIJp8UXE1MMiTpNNtu25NcKYhmLIkkXXBpjEs9vRyQ4kw6KbIrajsdHJCu
	iEpXMSWpdwSBCCQj19BcM9h52dwDe8aFzOHw6lQnMmqhXiLno+yfr0WdkfWOETUcJb6FbFfV7vu
	6dZBBbEBRUGfLe5vDPJu/LR/PUBk2sJcAlK9dEeTGXEdWVwYF1f3n53/Pux9ZE5WeuaGnS5Oktl
	BecZxVovSN+i29FknKGGnKQWMJZCZr0VyjwyGEQa8VejLgwG28M6Wplbf9HZvktmxyN/66GsshX
	zC8q9fw+N9EfdzvJVQbSadumfNPMg0aRI3eonP6mB6tGiLtoxVEfFipfneKa2zyGjr/yBSpxdRe
	MxY+vDm7FROwaIwgfP8AodLK57tujd6C/AYiypqm/tkIuepXANCwzQPHgpVM8/lgFZpa/Rw==
X-Received: by 2002:a17:907:9446:b0:c4d:456c:4a29 with SMTP id
 a640c23a62f3a-c510e16a720mr128985866b.14.1794988017524; Tue, 17 Nov 2026
 23:46:57 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
 <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com> <CAKTNdwG5XA_chr2ZM9qTnr2RaDMzOjdb85bRdCr4aJCr1EGy7Q@mail.gmail.com>
 <398a1d12-c28b-418c-bbcc-170d781223d6@oss.qualcomm.com> <CAKTNdwEzbYAqM5ABxU+tfh4juU=wgYp=QXyjvdA1haanU0e8tQ@mail.gmail.com>
 <861b48b3-32e2-459a-a6e1-75d93f10e1c9@oss.qualcomm.com>
In-Reply-To: <861b48b3-32e2-459a-a6e1-75d93f10e1c9@oss.qualcomm.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 18 Nov 2026 11:46:46 +0400
X-Gm-Features: AclHuK-mzUUyPR_nvHlWIkQreDiwLH9wtGyUE6yWiokuHebhGdjJ_j61S1Ijpdw
Message-ID: <CAKTNdwEOiPzvziW5VsNrHcFXEr1E7YjbabMfC3fsG6q+5-TnzA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: connector: Add PCIe M.2 Mechanical Key B connector
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

On Sat, Nov 14, 2026 at 5:45=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
> On 10/22/2026 2:56 PM, Alexey Charkov wrote:
> > On Thu, Oct 22, 2026 at 8:27=E2=80=AFAM Krishna Chaitanya Chundru
> > <krishna.chundru@oss.qualcomm.com> wrote:
> >>
> >>
> >> On 10/21/2026 9:14 PM, Alexey Charkov wrote:
> >>> Hi Krishna,
> >> Hi Alexey,
> >>
> >> Thanks for the thorough review, this is helpful.
> >>> On Wed, Oct 21, 2026 at 5:51=E2=80=AFPM Krishna Chaitanya Chundru
> >>> <krishna.chundru@oss.qualcomm.com> wrote:
> >>>> Add the devicetree binding for PCIe M.2 Mechanical Key B connector
> >>>> defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. Th=
is
> >>>> connector is used to attach WWAN Adapters to the host machine over
> >>>> interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0, selected by =
the
> >>>> Adapter's configuration pins.
> >>>>
> >>>> The connector provides a primary power supply of 3.3V/VBAT, along wi=
th
> >>>> optional GPIO signals for WWAN-specific power/radio control:
> >>>> FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1#/2#, WAKE_OQN_WWAN#, and DP=
R.
> >>>>
> >>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualco=
mm.com>
> >>>> ---
> >>>>  .../bindings/connector/pcie-m2-b-connector.yaml    | 146 ++++++++++=
+++++++++++
> >>>>  MAINTAINERS                                        |   1 +
> >>>>  2 files changed, 147 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-c=
onnector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-conne=
ctor.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..a7f4bcbc5119
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connecto=
r.yaml
> >>>> @@ -0,0 +1,146 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.ya=
ml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: PCIe M.2 Mechanical Key B Connector
> >>>> +
> >>>> +maintainers:
> >>>> +  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >>>> +
> >>>> +description:
> >>>> +  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechan=
ical Key B
> >>>> +  connector. Mechanical Key B connectors are used to connect WWAN d=
evices to
> >>>> +  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or=
 USB 2.0,
> >>>> +  selected by the Adapter's configuration pins.
> >>>> +
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    const: pcie-m2-b-connector
> >>>> +
> >>>> +  vpcie3v3-supply:
> >>>> +    description: A phandle to the regulator for the 3.3v/VBAT suppl=
y.
> >>>> +
> >>>> +  full-card-power-off-gpios:
> >>>> +    description: GPIO output to FULL_CARD_POWER_OFF# signal. This s=
ignal is
> >>>> +      used by the host system to turn off the entire Adapter. Refer=
, PCI
> >>>> +      Express M.2 Specification r4.0, sec 3.2.13.1 for more details=
.
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  reset-gpios:
> >>>> +    description: GPIO output to RESET# signal. This signal is used =
by the
> >>>> +      host system to place the WWAN Adapter into a power-on reset c=
ondition.
> >>>> +      Refer, PCI Express M.2 Specification r4.0, sec 3.2.13.2 for m=
ore
> >>>> +      details.
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  w-disable1-gpios:
> >>>> +    description: GPIO output to W_DISABLE1# signal. This signal is =
used by
> >>>> +      the host system to disable the WWAN radio on the Adapter. Ref=
er, PCI
> >>>> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details=
.
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  w-disable2-gpios:
> >>>> +    description: GPIO output to W_DISABLE2# signal (default functio=
n of
> >>>> +      GPIO_10). This signal is used by the host system to disable a=
 second
> >>>> +      radio on the Adapter. Refer, PCI Express M.2 Specification r4=
.0,
> >>>> +      sec 3.1.12.3 for more details.
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  wowwan-gpios:
> >>>> +    description: GPIO input to WAKE_ON_WWAN# (WoWWAN#) signal. The =
Adapter
> >>>> +      asserts this signal to wake up the host system. Refer, PCI Ex=
press M.2
> >>>> +      Specification r4.0, sec 3.2.13.3.6 for more details.
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  dpr-gpios:
> >>>> +    description: GPIO output to the Dynamic Power Reduction (DPR) s=
ignal.
> >>>> +      This signal is provided by a host system proximity sensor to =
the
> >>>> +      Adapter to trigger a reduction in the radio transmit output p=
ower to
> >>>> +      meet regulatory SAR requirements. Refer, PCI Express M.2 Spec=
ification
> >>>> +      r4.0, sec 3.2.13.4 for more details.
> >>>> +    maxItems: 1
> >>> This seems to be missing the four CONFIG_* pins, which are quite
> >>> crucial in these connectors, as they define which interfaces the
> >>> module asks the host to provide on the respective pins. Without those
> >>> module type detection is impossible.
> >> Agreed, thanks for catching this. I will add a config-gpios property  =
(4 GPIO
> >> inputs, one per CONFIG_0..3 pin) to v2. It's optional, not required - =
a board
> >> that always has a known, fixed card type in a given socket (e.g. QCOM
> >> glymur-crd's WWAN-only slot) can just describe that fixed wiring via t=
he ports
> >> property and skip CONFIG decode entirely; config-gpios is only needed =
when the
> >> host wants to detect the card type/host-interface at runtime. Kept it =
as plain
> >> sensed GPIOs with no decode semantics imposed by the schema - the prop=
erty
> >> description documents the full Table 3-18 state table inline (all 16 s=
tates)
> >> so the binding is self-contained, but turning the sensed 4-bit pattern=
 into
> >> "this is a WWAN-PCIe Adapter in port config 0" is left to driver code,
> >> consistent with how the rest of the connector's sensed straps (e.g.
> >> viocfg-gpios on the E-connector) are already handled.
> > Agreed that the logic of turning the 4-bit pattern into
> > enabling/disabling interfaces sounds like a driver realm, although we
> > probably need to consider if the connector should accept pinctrl-0
> > through pinctrl-15 to hint the host about which pin muxes should
> > follow from each of the 16 4-bit CONFIG_* pin states. This mapping is
> > hard to recover outside the connector's context.
>  I'd put the pinctrl states on the connector, one per CONFIG_0..3 value (=
Table
> 3-18), selected after the driver reads config-gpios. The CONFIG-to-mux ma=
pping
> can't be recovered from the interface providers, as you said. Providers w=
ould
> keep only their own default pinctrl. What I'm unsure about is how much is
> SoC-muxed in practice. The high-speed pairs are often fixed by PHY or lan=
e
> routing, so the states may mostly matter for GPIO_0..11. Do you know of a=
 case
> where they cover more than that?

Thanks, that makes sense.

Regarding the high-speed pairs, the Rockchip based boards that I know
about route one PCIe lane muxed with SATA to the connector, with the
SoC combo-PHY managing the interface muxing (including the polarity
swap for the SATA-B pair). I don't know how people deal with the
second PCIe lane vs. USB SS muxing though, or if such devices have
been made available at all. Either way, it sounds like those could be
modeled as one port per muxed pin group - i.e., port@0 for SATA+PCIe
lane 0 (as two endpoints), port@1 for PCIe lane 1+USB SS+SSIC (as
three endpoints), etc. A PHY driver for a dual-lane PCIe interface
would then have to figure out whether its OF graph has one or two
links and configure the PHY and the controller accordingly.

Best regards,
Alexey
