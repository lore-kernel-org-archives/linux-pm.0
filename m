Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D92264D9;
	Sun,  2 Aug 2026 23:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785714587; cv=none; b=ng3IrY9OHWbl8D7MzfHz3VMUk+wjjkNJ1yGF7rbOno+f5/uPhO2IUYqZdzKusAWsaoxACXDr1LMXncgyDzRfBAAjkHh8KizB2RNYf4IDNQe+5yCdMzA9hHJrcta0AN4bLgeqk8+vQvSjhfsKnllHBQfXa4rvpLf1kDSE04SNzOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785714587; c=relaxed/simple;
	bh=JGscVa3KFAw9z5nZgmk3X6JizoVa+vzmK9tIPxz+GPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiHUK/mhoDdo/huKQS7xc9HOg6RZtlguaknQaT/qO+o1ON2CQpVjeOdO0a0+KzmsRv8c9XBtHn0tR2QtSKXXnn5ERazlyEErnQQ4gBZzE3hR+0UIWqZTlEgqXesa4ivPZtFVUGCZhl+nsmCXlJZTaWMO5HlIpEN4fr/ZtvuE21s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9VeCVOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9VeCVOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BBE1F000E9;
	Sun,  2 Aug 2026 23:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785714585;
	bh=4uQoeWOc9qQjtyG2spie5qB9XYVYpRiMcI+qdnyqlJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i9VeCVOw5oG3kvTQrKUC8a/8E7dS4aqWPFigwZjTUMro7xhAmBWt9yPQCWBKH+fM0
	 Ls5OPJ4MnxWZc4BDLRYKmEGYn+MSqXDnypsi/s8rIkngMfKj/G/Gn+lGwYq8jGlkYR
	 DlU4itQH3MkI29iznJfwcAdgfBvM71O+NurBdlZa95GQRicfDXoRcap8tplPbP0Se4
	 4fnfJDgmrQ31m50g11ntjSynxURo84Df2YYsbkdXn2qXfCoVx7ueZItADK0GB5aUlN
	 lGwMU96k8llre03IeUzygPMtNc/odDbms6x6zShkUZSnAPw+j3MW24Nj1sI8XE3qjP
	 BAWWcaxENfn5Q==
Date: Mon, 3 Aug 2026 00:49:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Kamal Wadhwa
 <kamal.wadhwa@oss.qualcomm.com>, Anjelique Melendez
 <anjelique.melendez@oss.qualcomm.com>, Manaf Meethalavalappu Pallikunhi
 <manaf.pallikunhi@oss.qualcomm.com>, Priyansh Jain
 <priyansh.jain@oss.qualcomm.com>
Subject: Re: [PATCH 1/7] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen4 ADC
Message-ID: <20260803004940.0277c0ac@jic23-huawei>
In-Reply-To: <20260731-pmic5_gen4_adc-v1-1-9c49b2eea6f9@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
	<20260731-pmic5_gen4_adc-v1-1-9c49b2eea6f9@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 23:36:14 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made for
> improved performance, mostly at the hardware level. The main differences are
> increased ratiometric conversion resolution (from 14 bits to 16 bits) and
> increased bit field width for PMIC SID (to allow communication with an
> increased number of PMICs, supported on latest SoCs).

Hi Jishnu,

The mixed case is enough of a surprise (to me least) that I'd expect
there to either be more discussion here or for it to be handled first
as a dt binding patch to allow for v4 channels on v3 hardware.

That would provide a place for a description of why that is necessary and
then the following gen4 dt-bindings patch with gen3 channels would seem
like a natural extension.

Other than that this seems fine to me.

Jonathan

> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
>  .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml      | 47 +++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> index 149f4af8f4b8..e79ddc2acca0 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> @@ -21,9 +21,14 @@ description: |
>    All boards using a particular (SOC + master PMIC) combination will have the
>    same number of ADC SDAMs supported on that PMIC.
>  
> +  PMIC5 Gen4 ADC is similar to Gen3 ADC, with some differences such as
> +  improved ratiometric conversion resolution.
> +
>  properties:
>    compatible:
> -    const: qcom,spmi-adc5-gen3
> +    enum:
> +      - qcom,spmi-adc5-gen3
> +      - qcom,spmi-adc5-gen4
>  
>    reg:
>      items:
> @@ -83,6 +88,46 @@ patternProperties:
>            This property indicates ADC_TM monitoring is done on this channel.
>          type: boolean
>  
> +      qcom,adc5-gen4:
> +        description:
> +          Indicates channel is of type ADC5 Gen4. This may be needed in cases where the
> +          master PMIC has an ADC peripheral of type Gen3, but some of the other PMICs it
> +          communicates with have ADC peripherals of type Gen4, so channels of those PMICs
> +          need to be marked as Gen4 to ensure their conversions are handled correctly.
> +        type: boolean
> +
> +      qcom,adc5-gen3:
> +        description:
> +          Indicates channel is of type ADC5 Gen3. This may be needed in cases where the
> +          master PMIC has an ADC peripheral of type Gen4, but some of the other PMICs
> +          under it have ADC peripherals of type Gen3.
> +        type: boolean
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,spmi-adc5-gen4
> +
> +    then:
> +      patternProperties:
> +        "^channel@[0-9a-f]+$":
> +          properties:
> +            qcom,adc5-gen4: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,spmi-adc5-gen3
> +
> +    then:
> +      patternProperties:
> +        "^channel@[0-9a-f]+$":
> +          properties:
> +            qcom,adc5-gen3: false
> +
>  required:
>    - compatible
>    - reg
> 

