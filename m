Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706F3EBF1C;
	Mon, 26 Jan 2026 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458559; cv=none; b=dUMhAPhskc2bIzGy5Gl9SWwPSF9tPMHrhrQQSBAuGgrAhmAUGaTxPvelOGefXNpfzb/3KCAuUfUqSuIteZN/wmEJUodEMbAhWwGMMTv24iVadykK5d/j9AHU0NyTxXUvn5GwXHFYZE0n855CzkCI+JdtiaaSOEscS9Dezyu3UYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458559; c=relaxed/simple;
	bh=UM95fvK6A1BkKGqlC4HPDGXlJP2IsnWed/FuApSBzo4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=luCmwnZtyPFFItv7cxFI1L3dhfiVTZsU0OLjZjUPbGFM4BXXxl2nk3A8rQnDKigZknzWE61rFB6qnZDWGmghMdZeNIIdLDiJvAY2WfBFwI4Wm1Ox+mPIFbA5pqpSxmDreBW+V1//aKBRs5WzGjkw2gZSVKA2QnyFKyvFriMTURw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Jyd1j1eD; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Jyd1j1eD"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C97F926107;
	Mon, 26 Jan 2026 21:15:47 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uESUxJKg_CGL; Mon, 26 Jan 2026 21:15:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769458546; bh=UM95fvK6A1BkKGqlC4HPDGXlJP2IsnWed/FuApSBzo4=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To;
	b=Jyd1j1eDrgL2v7g2g7f2J/8/d3+j8TVNMPIXIxNd16flG6pCLCN2Tgw3+r5GdNmeJ
	 zd5izRmr+yX51iJbwlLRnhS/Yfh9NVxAz1ST+NC0/J+DyyLUYuu27g7Lvw0lXCNcOF
	 /4BjYnUT+kJqjz2jwJtQNqG3UAWvH3bKhtNYAGRyTlaJ9zYcypvy8MjnpqrZXNWayV
	 /DwYUIPhQkbAfMfb48DuCBbxuTjDj4IpnEj3AOCabfc9xb1zn8ofX3U5OWH0+kALQl
	 xP+F0iONy21q3HidOCYEKp7603Td+KaP5tTpgCzbKANHEE5F6djKCVRIEZM7v+hrfU
	 1NHTDMfQ1CRoQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 01:45:35 +0530
Message-Id: <DFYSP9E4NKZY.2Q5YX7RUOXUD5@disroot.org>
To: "Conor Dooley" <conor@kernel.org>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
Cc: "Yassine Oudjana" <y.oudjana@protonmail.com>, "Sebastian Reichel"
 <sre@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: document Samsung
 S2MU005 battery fuel gauge
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
References: <20260126-s2mu005-fuelgauge-v1-0-68a146ed0819@disroot.org>
 <20260126-s2mu005-fuelgauge-v1-1-68a146ed0819@disroot.org>
 <20260126-goal-wasp-fa3f20d2a06a@spud>
In-Reply-To: <20260126-goal-wasp-fa3f20d2a06a@spud>

On 2026-01-26 20:06 +00:00, Conor Dooley wrote:
> On Mon, Jan 26, 2026 at 09:09:48PM +0530, Kaustabh Chakraborty wrote:
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    i2c {
>> +      #address-cells =3D <1>;
>> +      #size-cells =3D <0>;
>> +
>> +      fuelgauge@3b {
>
> Should be "fuel-gauge" iirc (at least, that's what all the bindings do).

There are a few which use "fuelgauge", but majority use "fuel-gauge".
Will change in the next revision.

> Seems fine to me though otherwise,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable
>
>> +        compatible =3D "samsung,s2mu005-fuel-gauge";
>> +        reg =3D <0x3b>;
>> +
>> +        interrupt-parent =3D <&gpa0>;
>> +        interrupts =3D <3 IRQ_TYPE_EDGE_BOTH>;
>> +
>> +        monitored-battery =3D <&battery>;
>> +      };
>> +    };
>>=20
>> --=20
>> 2.52.0
>>=20

