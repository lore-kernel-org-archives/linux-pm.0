Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B64536E489;
	Fri, 25 Sep 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790325466; cv=none; b=Mh76FgHQLtHVnGEgF7Pq1x/kIgK4rp0b9aJWSfsaDPZ557/+3I9TuiTr/G04mgm9g4yKHBeKPyfQezOntdmoOI3hcYs2CTNDv0LylSORPxd6sf/IRmjdYbXLSXIUOCr/Pv9F/LeWis6gNhSFxTtjE5sXA4tczznYA/sPoBFqI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790325466; c=relaxed/simple;
	bh=dYkZ1PcbOsm8+hVJ6fyLXzRG6VxBJylZlFh8Z+RKoq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHRhQTyZpy17MOwoQdGPyJi17DX8gkZO6pKNF8EJtBe97tG03COWZueRg2XAdlt1+P2FBvF9CYcEncKt57PI6ZkGntT1KAsrPfe2DlNxXxngJXXOE2A0/5+kSCV9LDU4jMmKw2axB+kThGWQXxXkcvN6U9MBX1dT6HUbup6RoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bqnf7vu5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bqnf7vu5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBC71F000FF;
	Fri, 25 Sep 2026 08:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790325465;
	bh=sfijTU51Vh7or10tSZAJfrDehvDBspnHgWMvZGqhjuQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bqnf7vu5yAU7u35i6Xftde/oz3hh8Mbo/rF4T0QlwpDNYw6HK+98CL+CypSKMX8Eo
	 XU2urOzmFZc+yvqOWB79yWvWE6TdPGo/IGn3W0jUKvYE2j97djahbkIRHqANGJZoIg
	 CYRUTooqZ777cSZ/gUdHXhEbbz9YImxl6Q/hlya/BzKmppI/6IaktV1vISgFa/BYFG
	 ay8cSApy1yQqGeRSZ5lKyH5kxihoygDtF78oD5BjB5l/D0ggVQH9C8ng/7entNzsle
	 Q2yWr1zfaC2zIAskk+MDUjd6pKc6djR0k69WU26lyiw9DVHX4Bhqr6YKX1dokBc9V6
	 y48jde93phpTA==
Message-ID: <158671d2-ec78-4863-b67e-7180e218b758@kernel.org>
Date: Fri, 25 Sep 2026 11:37:40 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] dt-bindings: thermal: r9a08g045-tsu: Document
 RZ/G3L TSU
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Biju Das <biju.das@bp.renesas.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
 <20260925061617.127349-2-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20260925061617.127349-2-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/26 09:15, Biju Das wrote:
> Add the renesas,r9a08g046-tsu compatible string for the RZ/G3L Thermal
> Sensor Unit (a.k.a TSU), which is similar to the RZ/G3S TSU but uses
> different calibration constants. TSU is connected to a dedicated ADC IP
> (a.k.a ADC1) on RZ/G3L.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
