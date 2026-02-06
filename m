Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5D3491C4;
	Fri,  6 Feb 2026 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385991; cv=none; b=Z0uehCZYPbqekne4RNe9vC2URnITh2OR/vyHULnEYVDT27vAsjXO9Zg+Y2nl8pBhvH9zw0NASuRR+6u3fJFFPZsbI5JaRZt2dHpMDn0xPDiPlivw0vHgFxXKTwoEiQZWpGWx1Q8esHwUWtzQ8IpITbQjpL278coTXpjJOOTV1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385991; c=relaxed/simple;
	bh=ESXOg+akGHlLAXErepXCTtxP4uuM83vUetBmFdhu7fU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=kXUgRFCafUQTD+cHyibYtXFCU6apb1/GPlnoF4rhLAAODG4XQNeJyDzrFj5hp9n13BynKva/fQqFttkmO2UScde/HkTBY+Vmfza4T7mGLDN8ALZHttaut2+TWuQyn41bzqK5ysXjWV54YxiFBoP/sMWG4hxdcEOJspOKhxsuPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iXmI8nmF; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iXmI8nmF"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9F1842689B;
	Fri,  6 Feb 2026 14:53:08 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BCTUsrrZYRXQ; Fri,  6 Feb 2026 14:53:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1770385987; bh=ESXOg+akGHlLAXErepXCTtxP4uuM83vUetBmFdhu7fU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=iXmI8nmFtcYbXFsUR3WWhX+jqb2HJZgEqiy16dQcUvk29cEip9GKi4bxSMoQtGVRD
	 oYR4JFj5pA07b45mb1ypTSd4jVS1A4iz/QyuQM22CC7aMej8RgYfruVN9Z7smx3zcr
	 OrWoB3InY3thVaGG77Onoa+lo3HtI1RLTlnDE7+Ube6P75y340ya6AxdDqyCBUILSM
	 /ir/ODfjMLglalV6kvAED1F2V+SbDi06sC1aRvmAfqVuzE3Ld3y8Y2Pz/Tceql4CHT
	 KR9u30TE41C8dSjy9fIeUv+JK2rmTTkBHLreIwPiC4ZeRBZjloMH/uPtmga3FbdwvP
	 VGATOKrUUxKlQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 19:22:54 +0530
Message-Id: <DG7XG932U7G5.2VJWCJRZEERI0@disroot.org>
Subject: Re: [PATCH v2 03/12] dt-bindings: extcon: document Samsung S2M
 series PMIC extcon device
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Rob Herring" <robh@kernel.org>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
Cc: "Lee Jones" <lee@kernel.org>, "Pavel Machek" <pavel@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "MyungJoo Ham" <myungjoo.ham@samsung.com>, "Chanwoo
 Choi" <cw00.choi@samsung.com>, "Sebastian Reichel" <sre@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, <linux-leds@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
 <linux-rtc@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
 <20260126-s2mu005-pmic-v2-3-78f1a75f547a@disroot.org>
 <20260206134915.GA171264-robh@kernel.org>
In-Reply-To: <20260206134915.GA171264-robh@kernel.org>

On 2026-02-06 07:49 -06:00, Rob Herring wrote:
> On Mon, Jan 26, 2026 at 12:37:10AM +0530, Kaustabh Chakraborty wrote:
>> Certain Samsung S2M series PMICs have a MUIC device which reports
>> various cable states by measuring the ID-GND resistance with an internal
>> ADC. Document the devicetree schema for this device.
>>=20
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>>  .../bindings/extcon/samsung,s2mu005-muic.yaml      | 35 +++++++++++++++=
+++++++
>>  1 file changed, 35 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/extcon/samsung,s2mu005-mu=
ic.yaml b/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yam=
l
>> new file mode 100644
>> index 0000000000000..05828b7b5be13
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml
>> @@ -0,0 +1,35 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/extcon/samsung,s2mu005-muic.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Extcon Device for Samsung S2M series PMICs
>> +
>> +maintainers:
>> +  - Kaustabh Chakraborty <kauschluss@disroot.org>
>> +
>> +description: |
>> +  The Samsung S2M series PMIC extcon device is a USB port accessory
>
> extcon is a Linuxism. Use usb-connector binding.
>
>> +  detector. It reports multiple states depending on the ID-GND
>> +  resistance measured by an internal ADC.
>> +
>> +  This is a part of device tree bindings for S2M and S5M family of Powe=
r
>> +  Management IC (PMIC).
>> +
>> +  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml f=
or
>> +  additional information and example.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - samsung,s2mu005-muic
>> +
>> +  port:
>> +    $ref: /schemas/graph.yaml#/properties/port
>
> What does the port connect to?

I have it connected to the USB PHY in device tree.

>
>> +
>> +required:
>> +  - compatible
>> +  - port
>> +
>> +additionalProperties: false
>>=20
>> --=20
>> 2.52.0
>>=20

