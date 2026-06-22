Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F000363C6C;
	Mon, 22 Jun 2026 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127084; cv=none; b=aGEKBIbt5Mb9+BUsq18HUH3cC329VVqlwhHAuhMAXYg/YbnhLjPb/HE8k1w6MzBkfwodXZNBHKKvfQdjA5fZFiAonog8ak5tIq3Gz7+5il3NWDMSu5lLu55z8U4wQNKDZhtJXc2RqzJfrfUfEPSs9P7SVuuGFpKv55Ai15o5jwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127084; c=relaxed/simple;
	bh=HdtF2G1DsaD29ZHA5Zc/J92hjynpjVG3JfparU9m/WE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZvZPl0Al85uhfstR1JYdBlttirEkoG9XXEGOo4KDqCeyGp6PpPFhu/G073wKNaZ8ylYfkcDD3i9h75DVfTpMSlWYvqb6jsX0DTMhjaPJbQ4LVzQpttALPFuP6SZpD9F59a3SOCq5luuE5/YLNrTW1EedX0cXsw0wjOgKlcT5Uqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=fg+m3CxD; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="fg+m3CxD"
Message-ID: <dc285387-b0f9-4f48-a0ba-c544c5af11fb@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1782127072;
	bh=HdtF2G1DsaD29ZHA5Zc/J92hjynpjVG3JfparU9m/WE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=fg+m3CxDeoTsbMdqm2wMyM+Wbgj9ubSfZ8BENBPT4sEkGL0IJQbisZ+QP2SKFzzpq
	 3zjM5GUOik+0hVIXsy/39O4ttmgoeIaIqOkVOi4vze+ZBQ+ym/NssY2JStDRxu6bro
	 8kya+zJceqbC+keEof7DdOjBn1R+fApT2BGfb354=
Date: Mon, 22 Jun 2026 13:17:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH v5 1/8] dt-bindings: thermal: amlogic: Add support for T7
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor.dooley@microchip.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20260424-add-thermal-t7-vim4-v5-0-9040ca36afe2@aliel.fr>
 <20260424-add-thermal-t7-vim4-v5-1-9040ca36afe2@aliel.fr>
 <2e2a93c7-6bf9-49f2-95ed-f44cf767e9fd@kernel.org>
Content-Language: en-US
In-Reply-To: <2e2a93c7-6bf9-49f2-95ed-f44cf767e9fd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 12:02 PM, Krzysztof Kozlowski wrote:
> On 24/04/2026 17:45, Ronald Claveau via B4 Relay wrote:
>> +  - |
>> +    temperature-sensor@20000 {
>> +        compatible = "amlogic,t7-thermal";
>> +        reg = <0x0 0x20000 0x0 0x50>;
>> +        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> 
> 
> This wasn't ever even built! Really, it fails immediately. I will send
> fixes, but quite disappointing that contributor does not test its own code.-
> 

My bad, I thought that `CHECK_DTBS=y` was enough to test
`dt_binding_check` as well. I add it again to my build tests.


-- 
Best regards,
Ronald
