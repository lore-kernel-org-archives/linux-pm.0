Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600413B7A3;
	Wed, 22 Apr 2026 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843063; cv=none; b=Zz8rD+fRKfBHp4R01ZLw4CzTneoJVopvj5FRkkNp7AW2wZx6g8gURxYl+x0LH9mxtp/azaHYAeJAc8fRl0jFH1FKKdnizmtlRwXGCtRqPyAwX6fYx3zXxvSDRMNLd/xyJMJXycILCuavu9iD15x0Gv+auoGJv+Hg1w8fbYnmnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843063; c=relaxed/simple;
	bh=XDaFV0u6gJo9HpJsXHSQOVbCycMjk91FXKfLUWErfqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAPWnj0eMNDFn6KE4Brk4D4J6tW77D8VhVfb15LtgCh6C2IjXdzKz/XvvDK444H8BgGiB2U0XoatfnXkmipxVcl6Ep3/zmg5OA5sXBzgtc+YcwsCbAdlqX7ZpiMRMdfIcLuV4s7TSoLmb13ARLBEuRI5FoTiL3iQ2VOymr4xaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMgZ/YiZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMgZ/YiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3808FC2BCB3;
	Wed, 22 Apr 2026 07:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776843062;
	bh=XDaFV0u6gJo9HpJsXHSQOVbCycMjk91FXKfLUWErfqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QMgZ/YiZ+7acoIfzHVLUPVxP1tq9X+A3MD4HItYJqISpi1ngosxJDa7U+qAxzkj02
	 0bB+27eQnxsdZJTYj2AKhkHJU3RSW0mQUIDQXCd7nEcaY2202jMXStgCC6hS1nwepM
	 BYwzmlruzArOMqzXy0ggqL6hdI6OPBhJONSR34+N9GjcM+ryA2nI3kYrm1j3sY7v5P
	 l9zn58Rw/oZ7CzQq241qDOtG/DL9yaOGJxRuNJnOkVMSXuI3d0BQYhAIwcXbjG23NN
	 tRZiWWXASuOYNvt2HdaJKQQ0Gku3tLly8Sj0gmVlBgAdMq+94+DRhhnN7gqJOXJi7u
	 WMZlpaUC12yTw==
Date: Wed, 22 Apr 2026 09:31:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, gaurav.kohli@oss.qualcomm.com, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Benson Leung <bleung@chromium.org>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] dt-bindings: thermal: cooling-devices: Update
 support for 3 cells cooling device
Message-ID: <20260422-calm-badger-of-courtesy-809761@quoll>
References: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
 <20260419182203.4083985-15-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260419182203.4083985-15-daniel.lezcano@oss.qualcomm.com>

On Sun, Apr 19, 2026 at 08:21:58PM +0200, Daniel Lezcano wrote:
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> index b9022f1613d8..28f5818f1e60 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> @@ -44,10 +44,14 @@ select: true
>  properties:
>    "#cooling-cells":
>      description:
> -      Must be 2, in order to specify minimum and maximum cooling state used in
> +      Must be 2 or 3. If 2, specifies minimum and maximum cooling state used in
>        the cooling-maps reference. The first cell is the minimum cooling state
>        and the second cell is the maximum cooling state requested.
> -    const: 2
> +      If 3, the first cell specifies the thermal mitigation device specifier
> +      index for devices that support multiple thermal mitigation mechanisms.
> +      The two other cells are respectively the minimum cooling state and the
> +      maximum cooling state.
> +    enum: [2, 3]

In the same commit you need to narrow
Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
so it will keep value of '2' (const: 2, like all other bindings).

Best regards,
Krzysztof

