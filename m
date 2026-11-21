Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795292842;
	b=IzhIUzxZxHm08XhmYWLyKdN0fzEzsJHTSd9pyLn5FGeN3P8fr4C31iLxARhbfapQ0D0T
	 ipf5t70/UPkZogfaSmIXmC98IEqvkfB9jY2qaNw2aWWoxGQkcQHOV9LtSvrO5pO++16JK
	 e4qF+W5m92KvXROO4BuWAyryLcw/iW+TV6V9LVlaOIE3E965Lr8996lSBIQ0bwXPT/kQa
	 +h3Gx4euAjbQaGdzF39JkJ3Wb0DoY88zDBaXO/DMKl9+0TcXzkK+Ah+jTgg12GJBdrWZu
	 rNU07lgg65zGeC2LBerIQ+D8LYUrXss8gf7UeGTTCuCcOL+KCtNwhB0LbPUgoGUmdhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795292842;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=40tejK4FZl5LRGOXaGeE0E1U7AlddvNA/8gzWd64RMk=;
	b=YLrRfhb5NM9Ez5cs6MYK8RniDAtZBoK6nxwF8YSiY4HbP8bK4lW45zlVVbyUMfcegBOo
	 zxp46uBxAFeKpXfFXFW2B5gU1A0CZhWUMVzbUXugzc2ZyLHzdp80WN0KuZ7eGbwYCy7Q9
	 66jzfFaQyL+qDdgGJdBwRB+9uSlBE6XBEvv318Ji8OnsahDBU/kbjZ2XabyACbzktDPVd
	 Fz56b1uFZoDnXh/BEL5bl+T+GFKrIRPlNovU7jhSniQDrwgiP5Lis/FtjhbahG2nO9HqQ
	 1Y2koTBDRjigE+x1U7xEDqd7LBRjkJXCjf5Lx58H0f1jadvMXhXtx7txlUFWN+7LBUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2NnCgJS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D658606A320;
	Sat, 21 Nov 2026 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2NnCgJS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C271F000C0;
	Sat, 21 Nov 2026 20:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795292841;
	bh=40tejK4FZl5LRGOXaGeE0E1U7AlddvNA/8gzWd64RMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h2NnCgJSxklNKvLXaKEdoAr76GOJ4d5ohriu48SW+L9hjft3I254TdHcWVq6n5Bnj
	 JVGQIHOKR2HaGSr8rvaDrc966smIgn8VusrN0LTH36WvRsh7U98DkEqStRY7piDCfP
	 QVVQoIRlxpsLhZvLKv0RbJmvWyogzdi9y6MF19+JbOjuNsEzG3tneX++J7NwxTkppd
	 Q1M2xN8de8h1EuhN6szN6SEF//EMRwM55Anc+1XCUUdum82069PmHAILBkBmsWk79p
	 cFanWlnwfVG0t8VC8dhFmbO/At/VCotkwtU2he8z9x3HF0rQmSkcRk+qKGOlYmpS64
	 qFH1bvf7OIjpQ==
Date: Sat, 21 Nov 2026 20:27:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Kamal Wadhwa
 <kamal.wadhwa@oss.qualcomm.com>, Anjelique Melendez
 <anjelique.melendez@oss.qualcomm.com>, Manaf Meethalavalappu Pallikunhi
 <manaf.pallikunhi@oss.qualcomm.com>, Priyansh Jain
 <priyansh.jain@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: adc: Add "qcom,adc5-gen4"
 property for ADC channels
Message-ID: <20261121202713.15008e5c@jic23-hlaptop>
In-Reply-To: <20261120-pmic5_gen4_adc-v2-1-94d0e1fd6847@oss.qualcomm.com>
References: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
	<20261120-pmic5_gen4_adc-v2-1-94d0e1fd6847@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Nov 2026 14:49:41 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made for
> improved performance, mostly at the hardware level. The main differences
> are increased ratiometric conversion resolution (from 14 bits to 16 bits)
> and increased bit field width for PMIC SID (to allow communication with an
> increased number of PMICs, supported on latest SoCs).
> 
> In the Gen3 ADC topology, the ADC peripheral on the master PMIC
> communicates with ADCs on other PMICs. It is possible that some of these
> other PMICs have ADCs of a different generation and may need to be handled
> differently (for example, on SM8750, PMK8550 is the master PMIC with Gen3
> ADC peripheral and it communicates with PMIH0108, which has Gen4 ADC).
> Add the "qcom,adc5-gen4" ADC channel property to indicate that a channel
> is of type Gen4 ADC.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Hi Jishnu,


Minor thing.  Other than one long line, this binding currently keeps to 80
chars. Hence the new stuff here looks a little out of place.

One small additional comment below.
> ---
>  .../devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml          | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> index 149f4af8f4b8..065b82c41e86 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> @@ -83,6 +83,14 @@ patternProperties:
>            This property indicates ADC_TM monitoring is done on this channel.
>          type: boolean
>  
> +      qcom,adc5-gen4:
> +        description:
> +          Indicates channel is of type ADC5 Gen4. This may be needed in cases where the

The 'may' seems confusing as implies there is an alternative.

"This is needed in cases where the..." or
"This is needed when the..."

> +          master PMIC has an ADC peripheral of type Gen3, but some of the other PMICs it
Is it too loose to refer to a "GEN3 ADC peripheral" ?
I'm just thinking the text would read better that way.

> +          communicates with have ADC peripherals of type Gen4, so channels of those PMICs
> +          need to be marked as Gen4 to ensure their conversions are handled correctly.
> +        type: boolean
> +
>  required:
>    - compatible
>    - reg
> 

