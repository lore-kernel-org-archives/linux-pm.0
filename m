Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035059;
	b=wUs0f6TanTTctTZLG9jaAiob6QkJfOh4umzuvumZc5hU9mTdpMfYJw7EQPEAxGAhASyo
	 hUWpGSIulByy6I13HIF+xABrtYcruby2jTsYlZS9/bpNEACjQ+yfQlWRhu4fTnOYHpySi
	 gSiZm06xbS4WPmnJV46RdQTT/nGnRLBE9IVHbF8fjSYcw645vj/9fuffrSoW9OK+4Awq9
	 RishGLuuIW0Zhtvnbp87apggvmnWjEYh9X/pmy7ENJ7cxl1F+ZSVILTzGwiV5rub+uCA0
	 H0XBoVWLLcIyUlKwN9kbJXwRddT7TZVDFuLTA5TKJEdcV9CyBOHKgLLzhbYxdt+Agbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035059;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0aMgbQQmw1MPLXYBpDbUKS5IgiG3zEQxMu5gz/miA1Y=;
	b=Pr9VeHX8XlGwvPQFaPrtFjETimeGTIMz16EneEn0IbvxW3upSApEz1/+UloMlAt7y/gk
	 tVKU4HgTB5PfM0WYlB8lNfHe9Ygs+Np2Z2oBOaV+hzW3Ghb1doh4Yzq+aDy29WG1+Mv1h
	 yq7E0r/2htzy3qjGxJoIb7iiLuWsW+yEgbtqXqdri5x4wZAfw7ytqguQzEKXu3AABYNj6
	 7eK8c4nkzNJRR5rEUMuagHBHX2z9l4slr4FS2yHrlyyx5G47sqYvQ5ZyHFFVUnOyRu9eu
	 BM/LImaqCaSFRm6X++zQrt3iH9iyGWHArwkrNZzNLt+B3ifidJeM/9MrJvtR+jPkj5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9H2bQLM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F0606A320;
	Wed, 18 Nov 2026 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9H2bQLM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212241F000C4;
	Wed, 18 Nov 2026 20:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795035059;
	bh=0aMgbQQmw1MPLXYBpDbUKS5IgiG3zEQxMu5gz/miA1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D9H2bQLMpNjY6yIUL4eRNe9xtgDcK4QHGxXWLYzlvB1bmUo8C+4C6H57Z6jg9sUA4
	 KI2MfNZWHMF0hbxVFAJ4MbtoVerLZ8UCGf2jV4yN0WNM83SnHWTl5kcf6+9BmecA9C
	 IR0ruJ0M3TZlseY9cOHVO+iRxj4W52ZhRlcTe1jTuvyyFF4rkiRGxbwbj80laq823k
	 sOcXFUIbefvYS3SiHJo54xS8UrUoQKer4+6ur1h7Ye26LX07X6NmyiPvizyO0GovtJ
	 ElEuzkCk84eFx59EadSVPsP+OrgTdyY+X8s8oUb5aHLo4Pf+umJYh0Ni2alCtb4A1m
	 PeHU9oYDdRbqg==
Date: Wed, 18 Nov 2026 14:50:56 -0600
From: Rob Herring <robh@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: thermal: thermal-zones: add
 hardware-binning trip properties
Message-ID: <20261118205056.GA839455-robh@kernel.org>
References: <20261113-thermal_bin-v3-0-878df6eef8bc@oss.qualcomm.com>
 <20261113-thermal_bin-v3-1-878df6eef8bc@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-thermal_bin-v3-1-878df6eef8bc@oss.qualcomm.com>

On Fri, Nov 13, 2026 at 02:13:44PM +0530, Gaurav Kohli wrote:
> From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> 
> Differences in SoC packaging can be used to provide multiple SoC SKUs at
> different thermal and performance characteristics. The underlying SoC
> remains the same except for how much heat the packaging can dissipate,
> thereby influencing the critical trip point at which an SoC SKU needs to
> be throttled. This SKU-specific data is typically burned into fuses
> during manufacturing and can be read back at runtime.
> 
> Add two optional trip-point properties to describe this:
> 
>   - 'temperature-bin': an array of per-bin trip temperatures, used
>     instead of 'temperature' when the trip depends on the hardware
>     revision encoded in fuses.
> 
>   - 'thermal-hw-bin': one or more bitmask groups describing the hardware
>     revisions for which a trip point is valid, modeled on the
>     'opp-supported-hw' property of the OPP framework.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/thermal/thermal-zones.yaml | 60 +++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index 999ad40a20d5..cb9a8c96d053 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -152,6 +152,58 @@ patternProperties:
>                  situation where the trip gets constantly triggered soon after
>                  cooling action is removed.
>  
> +            temperature-bin:

Use the standard unit suffix. 

> +              $ref: /schemas/types.yaml#/definitions/int32-array
> +              items:
> +                minimum: -273000
> +                maximum: 200000

minItems: 2
maxItems: 32 ?

