Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38D346AD5;
	Fri, 15 May 2026 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879274; cv=none; b=Pzh37pc7/+8hbVXfG2rd6UYaRCzsVPESW66i2BWyPnJQ7IUgbAb7XtEo+LmQW7HnXQ9Pu76s6QnfxjT4iX64Xg8DfXCO38JwvSAsQMI1u9O8KeSdStPBC14VOXP1wEAqLjwu7Cltbot4Y5G8vZifujTof2veLDxeiEzEYsb4sFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879274; c=relaxed/simple;
	bh=UZQiu0VH2xAOXUxnfPEgUIj3JzYw5nHJpb6xLgSjZxw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=vDP3SsEgmQ903+JuKrTR3cdIESH9hq2HyoL0l1RZ3Dq3p3GKYSAAzZuiNmxKctyw1qTMNgWK7B70Z7c3S/8PbyrOUt+2fxHKwic5rYjmEjBRPCScYDRWWPmeA4qJJFcaMtoLyPhCJuQ/uofXMjiiu9sgG4TAf067aJeMlLfJ9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=KZxDj9jU; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="KZxDj9jU"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4FCC9271BA;
	Fri, 15 May 2026 23:07:52 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0_mgalvMmZ-c; Fri, 15 May 2026 23:07:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778879271; bh=UZQiu0VH2xAOXUxnfPEgUIj3JzYw5nHJpb6xLgSjZxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KZxDj9jUR9eWY6FtpDOfeAiHdPJhQRayv8CRJF0SCw/5/WwSUZmevrgvw/Fq4mYEC
	 FvgYwNdWeUmcs6Rl+P9VBFdaAhnFR57l18isQVtNY/lx0nzvShZfuxXwg6YrjAO5oO
	 4H7dHFV7DdVdr5ILFO/KJWDmXcVaFjqnI19H8hS9viNfoysLdTYusaC8oprMu1pn3R
	 iYes4MaI9wvWM3s8arTr5vFrjfCa/h0C7z1WxAUKgX2DuphoS+9Fj2zPG619erC0w4
	 E+PsYVzARBAHhJorueok+DNwSS83ke16/sMNQwTSnt1cYWXinUahBOMaT/e+eMrjnK
	 UA41x/RhAlNzA==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 16 May 2026 02:37:34 +0530
Message-Id: <DIJK2FWQOGCK.2WJ9FED9HKGHG@disroot.org>
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Conor Dooley" <conor@kernel.org>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
Cc: "Lee Jones" <lee@kernel.org>, "Pavel Machek" <pavel@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "MyungJoo Ham"
 <myungjoo.ham@samsung.com>, "Chanwoo Choi" <cw00.choi@samsung.com>,
 "Sebastian Reichel" <sre@kernel.org>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Nam Tran" <trannamatk@gmail.com>,
 =?utf-8?q?=C5=81ukasz_Lebiedzi=C5=84ski?= <kernel@lvkasz.us>,
 <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 02/11] dt-bindings: extcon: document Samsung S2M
 series PMIC extcon device
References: <20260515-s2mu005-pmic-v6-0-1979106992d4@disroot.org>
 <20260515-s2mu005-pmic-v6-2-1979106992d4@disroot.org>
 <20260515-mutable-urgency-305fecf3ffc4@spud>
In-Reply-To: <20260515-mutable-urgency-305fecf3ffc4@spud>

On 2026-05-15 18:15 +01:00, Conor Dooley wrote:
> On Fri, May 15, 2026 at 04:08:58PM +0530, Kaustabh Chakraborty wrote:
>> Certain Samsung S2M series PMICs have a MUIC device which reports
>> various cable states by measuring the ID-GND resistance with an internal
>> ADC. Document the devicetree schema for this device.
>>=20
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

Thanks, but this patch has already been reviewed by Krzysztof in v5. I
missed the Reviewed-by tags, sorry! I'd been preparing v7 after the
reviews by Sashiko.
