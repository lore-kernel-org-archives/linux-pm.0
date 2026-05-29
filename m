Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50DA3F928E;
	Fri, 29 May 2026 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068402; cv=none; b=Fi1fpTAttYwbsHdOQY/Xj9/hU4kqvPiiivH5UhfsI5H/ZPRPs1PkkOUrkvt48NDISDqyrK1NPHRsOAEPtfW5qlzBkrCy66ZGks1yr0Y7LjwHXlw/06jpP9xxiLn7E0VSJABVItY+FYArhHN8NrhCGY653N3faL9AX1Zr4F97mCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068402; c=relaxed/simple;
	bh=l2h6L9+8xpQj76sKZcSHGf0inZVWrk3HOuwkI1cwSSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpJVkJCWu8mdPQJOkhYR0TJJAb34mp9BqWLTNFW03ygGBggRzEN3+Ql/VYzd+gaGqDtFuZ2gQ5JxF/fu+CweAAiq2T/jI0C9jjxk9idCWOBxkZhb8umyktkgGrwG5EUETkoWZXAv70zuOJqKOA5xnPYPQdXONasTb4L7K4N0O4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jctJe062; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jctJe062"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 137F633EA;
	Fri, 29 May 2026 08:26:35 -0700 (PDT)
Received: from [10.57.26.238] (unknown [10.57.26.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B2D23FAF5;
	Fri, 29 May 2026 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780068400; bh=l2h6L9+8xpQj76sKZcSHGf0inZVWrk3HOuwkI1cwSSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jctJe062Ocsi72FLYnrMsAlas8KPbHkbhS2ysefQ8uKAVvWVrEBCOe82UFr8Nqd+y
	 HDMcz3y5oUHF+9BvmCRmJPiLhp0BSLPWMrAkLHhGbgIR/LA+YxZyjFl5cFfc5lxaDL
	 LJiG9Fq7JgD7VQjnYzs2gt0Cqlpb5as8PSrPIjyA=
Message-ID: <bfcfd7c9-8185-4ac5-83ab-3bc3a1a94990@arm.com>
Date: Fri, 29 May 2026 16:26:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] dt-bindings: thermal: cooling-devices: Update
 support for 3 cells cooling device
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, rafael@kernel.org,
 daniel.lezcano@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Avi Fishman <avifishman70@gmail.com>,
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
 Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
 Benjamin Fair <benjaminfair@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Amit Daniel Kachhap <amit.kachhap@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Amit Kucheria
 <amitk@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
 <20260526140802.1059293-22-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260526140802.1059293-22-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/26/26 15:08, Daniel Lezcano wrote:
> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> Extend the thermal cooling device binding to support a 3 cells specifier
> along with the 2 cells format.
> 
> Update #cooling-cells property to enum to support both 2 and 3 arguments.
> 
> Fix pwm-fan.yaml to restrict the number of cells to 'const: 2'
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/hwmon/pwm-fan.yaml      | 3 ++-
>   .../bindings/thermal/thermal-cooling-devices.yaml         | 8 ++++++--
>   .../devicetree/bindings/thermal/thermal-zones.yaml        | 3 ++-
>   3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> index a84cc3a4cfdc..6a24851fd80d 100644
> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> @@ -63,7 +63,8 @@ properties:
>       description: The PWM that is used to control the fan.
>       maxItems: 1
>   
> -  "#cooling-cells": true
> +  "#cooling-cells":
> +    const: 2
>   
>   required:
>     - compatible
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> index b9022f1613d8..28f5818f1e60 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> @@ -44,10 +44,14 @@ select: true
>   properties:
>     "#cooling-cells":
>       description:
> -      Must be 2, in order to specify minimum and maximum cooling state used in
> +      Must be 2 or 3. If 2, specifies minimum and maximum cooling state used in
>         the cooling-maps reference. The first cell is the minimum cooling state
>         and the second cell is the maximum cooling state requested.
> -    const: 2
> +      If 3, the first cell specifies the thermal mitigation device specifier
> +      index for devices that support multiple thermal mitigation mechanisms.
> +      The two other cells are respectively the minimum cooling state and the
> +      maximum cooling state.
> +    enum: [2, 3]
>   
>   additionalProperties: true
>   
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index 07d9f576ffe7..999ad40a20d5 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -211,7 +211,8 @@ patternProperties:
>                     device. Using the THERMAL_NO_LIMIT (-1UL) constant in the
>                     cooling-device phandle limit specifier lets the framework
>                     use the minimum and maximum cooling state for that cooling
> -                  device automatically.
> +                  device automatically. If three arguments are specified,
> +                  the first argument is the cooling device specifier.
>   
>                 contribution:
>                   $ref: /schemas/types.yaml#/definitions/uint32


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
