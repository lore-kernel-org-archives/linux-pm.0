Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793875493;
	b=VnooTsDlpA5jf33WvopyZaAGgI16So7KxgX9akqjjrpApjOAiCr3ymJtvKwUP3ueiqDm
	 GSRS7in7nB8hDPUQDI4PYsEJtWrHf2V7U3GHagwodQMeV7bNzxxXQi34Ykkb/faWwiJLW
	 3cXYSFK1dqECdUPJd1M2pvayh4N4b4dPH3ObMVv3ZNknNWgsHgxG/QlHGpyRb64qYSn0D
	 o3pgpGsB75fxrBskxrVRAbeeBf0ERyyubX47a2dzdwEgxsJ5UJ5PAHYuNyaFFYr+5yl2Q
	 jw+2O2qV/mm8C8nAzN8NNgZaV+Mv81/dIeCMe8YVdbZjlhBsfRlYv9FxP4G/yth0B3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793875493;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/361YtGqsPyOKwIWksN+u2NxEOEqDW3UHp20AyisReU=;
	b=vrZptwRejWqIw7+Wbz7BXU0jIwDp5yr4hzIjEyC8eQg54IvPXG3Vu7n5CQBM0i3xAd1S
	 eo9OuJUD/C9YVRq9bHQkkv0Uf95w0Go7JMYhDyw2Js98moH3TeqhQZUmi+4f++86jHk+6
	 E6twz2u97DvMjXx6QABrrsR7mK/ZoQrBvDSJtgqGdx/mnxGKMqUyvHVeUg72hPyIFgrWY
	 UyH9OeThpIYWug2GM8Q3tP54+Nye5hbterqqu2z1hwSqwYXUBmcgUbWby0rEVO+RaySO4
	 BIXH7sw1DEf9qt0AKY0fq+O1lHtkoUoPGgm18259CDHKJvG8r7GgpPIo3CWQ4YS9Kzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=e0CgSm1Y;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0E5606A31B;
	Thu,  5 Nov 2026 10:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A0E5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=e0CgSm1Y
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44D93143D;
	Thu,  5 Nov 2026 02:44:47 -0800 (PST)
Received: from [10.57.10.82] (unknown [10.57.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A2343F673;
	Thu,  5 Nov 2026 02:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793875490; bh=IxjGppRiLkVgod0WaDW7XzKw99H8Qwfc7vGKAcV6TO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e0CgSm1Y7bxhpm4MerUzAFUUrD55l3h82sWS6NGbFBxG8DDhG3HDQ78PywiKVWGws
	 4xaDwbQgOppazMyK7e8WBrTj8pACWEZ3VMWzPeYrKbWkOfN2alW663BHxhV3xM0Ff2
	 lJdwJXgvf0NISzZpt9X6K60L1aLzU4D18LArDc3U=
Message-ID: <a53ebde3-ca2b-46dc-b4bc-93379b05a1a8@arm.com>
Date: Thu, 5 Nov 2026 10:45:20 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: Use signed integers for
 coefficients
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20261103214357.2700244-1-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20261103214357.2700244-1-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 11/3/26 21:43, Daniel Lezcano wrote:
> The coefficients property describes the coefficients of a linear
> equation used to derive a thermal zone temperature. Both the slope
> and the constant offset can be negative, and the thermal core stores
> them as signed integers.
> 
> Existing Device Trees already rely on signed values. OMAP4460 uses
> an offset of -9301, while OMAP5 uses offsets of -1791 and -2992.
> Broadcom platforms also use negative slopes. Declaring the property
> as uint32-array does not represent these values correctly.

This looks like a good argument which was missed back then (that
the negative values are possible).

> 
> Change the property type to int32-array so schema validation decodes
> the cells as signed 32-bit integers, matching their intended meaning
> and the thermal implementation. The cell width and binary encoding
> remain unchanged, preserving compatibility with existing Device
> Trees.
> 
> Fixes: 1202a442a31f ("dt-bindings: thermal: Add yaml bindings for thermal zones")
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index 999ad40a20d5..72e419124f98 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -101,7 +101,7 @@ patternProperties:
>             thermal zone.
>   
>         coefficients:
> -        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        $ref: /schemas/types.yaml#/definitions/int32-array
>           description:
>             An array of integers containing the coefficients of a linear equation
>             that binds all the sensors listed in this thermal zone.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
