Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA63D3D1E;
	Wed, 15 Apr 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262998; cv=none; b=fznBQeBbHs/xqS6OpkRtIDKl9P/K7Ay9g+ywQq8iL/b21TJh4jHviV9sJo5YfEA4hh2zbkAh33dZM4p3qHRRLQu7U6YOP7A8kYaj7PzQQ91GpyzlqxHUrbOiLQ3G3HwXRWB71MFjm+A11YBvHw+QHvT/VtSNuXilm17N1S5uAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262998; c=relaxed/simple;
	bh=6ZLO2AMuAAH+XCdzW7ye5diyybZIn/a4i+Igy0qsURk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AFfaABqbJncRjK0m5KcdfwssNidBn3/xN6rtUsv37QEQbgedUFLXpnU+E/81Q+V2B9OYEhZvD4e+tsCZardY+BhJKuNXlbwjaVhOISNxwl/CUqpS3g+/hfGL6KQxqY7hUVp+JPSVyI+A367CJvcxnJtbGj8H8aW4FGVcj5uuEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=X3VqBch4; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="X3VqBch4"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E95FA262A0;
	Wed, 15 Apr 2026 16:23:15 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rnWEuO4oD7w3; Wed, 15 Apr 2026 16:23:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1776262995; bh=6ZLO2AMuAAH+XCdzW7ye5diyybZIn/a4i+Igy0qsURk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=X3VqBch4/pUMXNri0BSB8m4YbE1iuvdppa+/dCMCXxxrRD1eh30UQu+kTQktKUX7F
	 zEDUpfRjTrC7D3/C6leypbhJTWlFLoDCL5IpHJzPvcJtaafZcf6+gRv4Xaa4wqhGd9
	 sT4JPbPSqOmh2PsZUAYJgmCXBRlluc+MN0lc/OIxjxAUE88QcxiP6dar/ApgNeZD/x
	 dijJhGqjDZNdgN/+0r3voJjTmPVQXc+5W7b9zbpDbLHzgi8wHSpuDKt7Acxo+BgX6y
	 GEkTY/Gy2FgznDCZZ557uhkzH8ZZLK1yJn2WCavQ2acXySVKyKbtLXnCqner8bOMpt
	 4SyQBI3jWAKFA==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 19:52:54 +0530
Message-Id: <DHTSO9L6YZTQ.WYM9ERXBGNGB@disroot.org>
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
Subject: Re: [PATCH v4 05/13] dt-bindings: mfd: s2mps11: add documentation
 for S2MU005 PMIC
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
References: <20260414-s2mu005-pmic-v4-0-7fe7480577e6@disroot.org>
 <20260414-s2mu005-pmic-v4-5-7fe7480577e6@disroot.org>
 <20260415-notorious-dainty-starfish-58a13c@quoll>
In-Reply-To: <20260415-notorious-dainty-starfish-58a13c@quoll>

On 2026-04-15 09:17 +02:00, Krzysztof Kozlowski wrote:
> On Tue, Apr 14, 2026 at 12:02:57PM +0530, Kaustabh Chakraborty wrote:
>> =20
>>    clocks:
>>      $ref: /schemas/clock/samsung,s2mps11.yaml
>>      description:
>>        Child node describing clock provider.
>> =20
>> +  charger:
>> +    $ref: /schemas/power/supply/samsung,s2mu005-charger.yaml
>> +    description:
>> +      Child node describing battery charger device.
>> +
>> +  extcon:
>
> You got comment to drop extcon naming. If this stays, it's muic for
> example.
>
>> +    $ref: /schemas/extcon/samsung,s2mu005-muic.yaml
>> +    description:
>> +      Child node describing extcon device.
>> +
>> +  flash:
>> +    $ref: /schemas/leds/samsung,s2mu005-flash.yaml
>> +    description:
>> +      Child node describing flash LEDs.
>> +
>
> Please make it a separate binding file.

What do you mean by that?

>
>>    interrupts:
>>      maxItems: 1
>> =20
>> @@ -43,6 +59,11 @@ properties:
>>      description:
>>        List of child nodes that specify the regulators.
>> =20
>> +  rgb:
>
> led

Well flash ones are also LEDs. Would you rather have `flash { ... }` and
`rgb { ... }` under `led { ... }` instead?

>
>> +    $ref: /schemas/leds/samsung,s2mu005-rgb.yaml
>> +    description:
>> +      Child node describing RGB LEDs.
>> +
