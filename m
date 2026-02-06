Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85017736;
	Fri,  6 Feb 2026 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770386617; cv=none; b=U7RkXs0l4ttoutjcqFO4a+M6l56acfs4skJ1KOKIqntKFpl041fq95B/w6isM4kVRCv0+ROAiGwMjYyShKAiBoFYk8moahBM624F91Ifj8/CNqELJ289e8f6BI4UVvsb0WUO4s3uI1fvfTnOH6u4ax8TlKdvC7kh+zAm61NHRjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770386617; c=relaxed/simple;
	bh=pkBlRcZDg35pLCdafh0SnKa2v20xt5AJZlxoB437QSM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=JFCmrrleDI4K5qncpdUEtwopzbw3Al8V670DLm+MXBknToMxBeQmy9pIcRqfySXhEc18eNLJ90PujGgF5kEwnQfvszaIs9zHsy/YXO5vbzOhr/JY5CXGcjQ54+dJysUk1NK35a8mPIPTTk0Ou4VMvs7VmnNKattdXjA3RIx7Qbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fRJJ3L5r; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fRJJ3L5r"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E43D726F31;
	Fri,  6 Feb 2026 15:03:35 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id niDGZJYQso_o; Fri,  6 Feb 2026 15:03:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1770386608; bh=pkBlRcZDg35pLCdafh0SnKa2v20xt5AJZlxoB437QSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fRJJ3L5rsKk+doMNzH7Dj0xaCIM2ycpgTeBLv306h4ERH6CMz3hniAwJP/K4H3XZN
	 nmU/FuLzCeK4PPGsuKhLDEnpnKk13bXsjP1Ja0RoQGgP8P88mm4sHUnLtso0Af7FMo
	 UBZw08hX1HvwVYMzVqnHSLjkS7VGMHZGrDENq1Q3Rwkyn/PXVHLBGnfhVg0ZgeVbRm
	 c3O6EbLYxZuXJAjDxipAyXwGzwvsixlbishcAmKawnGFexuhLBiZOvFX2DYPq0/Oxt
	 kLMnXhH1UU+ljRlSd5Swdgb6Aho64kUnxqoXrYwoW628ZlfqFDYd/kGiZW6ZKPR0zv
	 UlK9wULJ+ATUw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 19:33:12 +0530
Message-Id: <DG7XO4R0QY9W.13JQE6RFCSY5N@disroot.org>
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>, "Rob Herring"
 <robh@kernel.org>
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
Subject: Re: [PATCH v2 02/12] dt-bindings: leds: document Samsung S2M series
 PMIC RGB LED device
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
 <20260126-s2mu005-pmic-v2-2-78f1a75f547a@disroot.org>
 <20260206133837.GA157817-robh@kernel.org>
 <DG7XJ6T9I7HU.1UVHH2QWX31O1@disroot.org>
In-Reply-To: <DG7XJ6T9I7HU.1UVHH2QWX31O1@disroot.org>

On 2026-02-06 19:26 +05:30, Kaustabh Chakraborty wrote:
> On 2026-02-06 07:38 -06:00, Rob Herring wrote:
>> On Mon, Jan 26, 2026 at 12:37:09AM +0530, Kaustabh Chakraborty wrote:
>>> Certain Samsung S2M series PMICs have a three-channel LED device with
>>> independent brightness control for each channel, typically used as
>>> status indicators in mobile phones. Document the devicetree schema from
>>> this device.
>>>=20
>>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>>> ---
>>>  .../bindings/leds/samsung,s2mu005-rgb.yaml         | 34 ++++++++++++++=
++++++++
>>>  1 file changed, 34 insertions(+)
>>>=20
>>> diff --git a/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb=
.yaml b/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml
>>> new file mode 100644
>>> index 0000000000000..6806b6d869ff7
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml
>>> @@ -0,0 +1,34 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/leds/samsung,s2mu005-rgb.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: RGB LED Controller for Samsung S2M series PMICs
>>> +
>>> +maintainers:
>>> +  - Kaustabh Chakraborty <kauschluss@disroot.org>
>>> +
>>> +description: |
>>> +  The Samsung S2M series PMIC RGB LED is a three-channel LED device wi=
th
>>> +  8-bit brightness control for each channel, typically used as status
>>> +  indicators in mobile phones.
>>> +
>>> +  This is a part of device tree bindings for S2M and S5M family of Pow=
er
>>> +  Management IC (PMIC).
>>> +
>>> +  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml =
for
>>> +  additional information and example.
>>> +
>>> +allOf:
>>> +  - $ref: common.yaml#
>>
>> This looks a bit lacking. Don't you need 3 child nodes for each or=20
>> reference to the multi-color schema?
>
> 	rgb {
> 		compatible =3D "samsung,s2mu005-rgb";
> 		label =3D "notification:rgb:indicator";
> 		color =3D <LED_COLOR_ID_RGB>;
> 		function =3D LED_FUNCTION_INDICATOR;
> 		linux,default-trigger =3D "pattern";
> 	};
>

Message got deleted somehow? Anyways, the device has three channels but
a single LED, but is controlled by a single driver interface only. The
channels are not independent.

>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - samsung,s2mu005-rgb
>>> +
>>> +required:
>>> +  - compatible
>>> +
>>> +unevaluatedProperties: false
>>>=20
>>> --=20
>>> 2.52.0
>>>=20

