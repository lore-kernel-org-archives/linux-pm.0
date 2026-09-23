Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780A516144;
	Wed, 23 Sep 2026 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165928; cv=none; b=nbAOpi5r2rNw0RjnX714WSp3frdd/l2XQ7mozsHsr9yDGrffreYAXdALrwwKP+AH+moTk87L11v9in6eWgq7y9REvk0i1BmcqVgpsagfR9S5ACuBkXrMEfaiOUsbGP0VwTXTqGDBJYWz5GEBNc3i9UqA5cR7VaGvvFESrzPHc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165928; c=relaxed/simple;
	bh=71Nr0txiRyDXQQjTVLnQKIL8h5ohanJ0ghTsopnMfII=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rSzyzRuheNTohLBnmF9kcRZ2bELb2D7GCUeHf643BSdxwbCPgnR5rkcd+wVnkqgQNICNlh6aha2k3cFZstKhR/HvdhUamHZg7xu0fngBtTcaNcJgLStov3BWUG878nHC3vTiWmsZkO38GV4Kdkwn42Jpdj5xhSL6SYV3iYnyErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=gHNWPBKu; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="gHNWPBKu"
Message-ID: <3930d120-c412-4c04-afb0-3aee0f162d13@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1790165916;
	bh=71Nr0txiRyDXQQjTVLnQKIL8h5ohanJ0ghTsopnMfII=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=gHNWPBKu5gDiNCJyxS9Ae9UoXA6ZoZFyw/XuUZEHJUth9KeoCscWlIQL5k43kjilW
	 voLUoMYvMswZk2mx/6pvMxW0uOtw9I8SuYlIj7u5rwM9Wvzcv5t0VV4YyIeTc+w+HA
	 8piqH0/iNEbnle+NyMkw8VDYzf9oni4a0ax944KY=
Date: Wed, 23 Sep 2026 14:17:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH 1/2] dt-bindings: thermal: amlogic: describe bus clock for
 t7-thermal
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-pm@vger.kernel.org,
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260923-fix-t7-thermal-clock-v1-0-7d4c4682f182@aliel.fr>
 <20260923-fix-t7-thermal-clock-v1-1-7d4c4682f182@aliel.fr>
 <8c93d281-981f-40ea-839e-6dd24964fbce@kernel.org>
Content-Language: en-US
In-Reply-To: <8c93d281-981f-40ea-839e-6dd24964fbce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/26 2:02 PM, Krzysztof Kozlowski wrote:
> On 23/09/2026 13:51, Ronald Claveau via B4 Relay wrote:
>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>
>> The t7 thermal sensor needs a bus clock, in addition to the existing
>> functional clock, to gate register access to the sensor. This bus
>> clock is specific to each sensor, unlike the functional clock which
>> is shared between sensors. The current binding only describes a
>> single unnamed clock and therefore cannot represent this hardware
>> requirement, so add clock-names to disambiguate "bus" from "core" and
> 
> Index distinguishes, not the clock-names because items have strict
> order. That part of sentence is redundant and more important - if I ack
> this patch, people will use it as an argument in the future review
> discussions.
> 
> Drop this part of sentence. clock-names are fine if you need them, but
> still the disambiguation is provided by indices.
> 

Thanks for your feedback.
I will replace `so add clock-names to disambiguate "bus" from "core"` by
`so add a second clock entry and clock-names for clarity` in next version.

>> make the second clock mandatory for the t7-thermal compatible only
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> 
> Best regards,
> Krzysztof


-- 
Best regards,
Ronald
