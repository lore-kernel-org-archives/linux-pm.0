Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842A3D3339;
	Wed, 15 Apr 2026 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261842; cv=none; b=RFaejnPRagqd5s4Nryxl8F+6Maaz712Kgr4ZuBpyUznNuy7WpOr4tH4ZVJT9QKk9pfdyjtVlx8CKT994YyHW8LoZ1RgkMbAlY1PAKSxzCuJfdPu8SMRkvLfdD1DA36hL7Dr6uDKz/D/mqFVp3/6H+dNt3/+q4xf59ETq5/fUJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261842; c=relaxed/simple;
	bh=aWGSn3CN9S+IbpjM6b+2zZExgq1YLo7wgpfx+ae9Qt4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=m6Tp5fk1XNbS/kWJbDjmEpfxf4dSzs2F8QW1zZEHTv/7QRob83Qi5Ys4vrWAZgwMBLWsL6sGkCYthSsiPk0lkXcn40U1EAjKnWKMaYwt0gBnLLU52l6VedeFDdPnFn+S6XU53ajexEG/8984EYAbvsPhSEB8xxe0Bw6fPxDiQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=UGOeCFuc; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="UGOeCFuc"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id EBFAB2715F;
	Wed, 15 Apr 2026 16:03:49 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mkeiFiIQuqGz; Wed, 15 Apr 2026 16:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1776261829; bh=aWGSn3CN9S+IbpjM6b+2zZExgq1YLo7wgpfx+ae9Qt4=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To;
	b=UGOeCFucyHI3hsMEzq+/IOCQghT92u4U5lbNFTK7yaZM5Im1gRhbEPt5K6bf0xFq5
	 B8oPsO5I4T1lNZiKuJ2NK6wyUMsVX8ALWlE0kZJdXL3R1wPHHNesUNnXQT2oVBuzuG
	 WHw1hajTx4dB+Gbq69JItu5tz52Thsy74H8wIA/BOha9CYlcKQgtdhZST6ruKMkfBN
	 s14aBNvndqe48+vxH1M6+Fl4kH8bZWkFzIWweIaEHvNBUECZfgoTTfcf3JkVbPo6C4
	 k9nexMRmR7+fb2PK7QHQPZNdYfgeqo3AEA/VDl9rFGks1SSMyJdRSqPUTrcqUYhmsf
	 bmRI5V3O5YWWg==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 19:33:35 +0530
Message-Id: <DHTS9H2EIM2D.2TC17F9WBOOR1@disroot.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
Cc: "Lee Jones" <lee@kernel.org>, "Pavel Machek" <pavel@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "MyungJoo Ham"
 <myungjoo.ham@samsung.com>, "Chanwoo Choi" <cw00.choi@samsung.com>,
 "Sebastian Reichel" <sre@kernel.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Nam Tran" <trannamatk@gmail.com>,
 =?utf-8?q?=C5=81ukasz_Lebiedzi=C5=84ski?= <kernel@lvkasz.us>,
 <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 04/13] dt-bindings: power: supply: document Samsung
 S2M series PMIC charger device
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
References: <20260414-s2mu005-pmic-v4-0-7fe7480577e6@disroot.org>
 <20260414-s2mu005-pmic-v4-4-7fe7480577e6@disroot.org>
 <20260415-swinging-radical-junglefowl-85dcf7@quoll>
In-Reply-To: <20260415-swinging-radical-junglefowl-85dcf7@quoll>

On 2026-04-15 09:18 +02:00, Krzysztof Kozlowski wrote:
> On Tue, Apr 14, 2026 at 12:02:56PM +0530, Kaustabh Chakraborty wrote:
>> +description: |
>> +  The Samsung S2M series PMIC battery charger manages power interfacing
>> +  of the USB port. It may supply power, as done in USB OTG operation
>> +  mode, or it may accept power and redirect it to the battery fuelgauge
>> +  for charging.
>> +
>> +  This is a part of device tree bindings for S2M and S5M family of Powe=
r
>> +  Management IC (PMIC).
>> +
>> +  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml f=
or
>> +  additional information and example.
>> +
>> +allOf:
>> +  - $ref: power-supply.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - samsung,s2mu005-charger
>> +
>> +  port:
>> +    $ref: /schemas/graph.yaml#/properties/port
>
> That port is internal part of the device, thus should be dropped which
> leaves you with only one property - monitored battery - and therefore
> fold the node into the parent node.

And that monitored-battery belongs to power-supply.yaml. Do I then
include the allOf block in the mfd/samsung,s2mps11.yaml under the
s2mu005 compatible?

>
> Best regards,
> Krzysztof

