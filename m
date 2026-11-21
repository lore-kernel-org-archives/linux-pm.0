Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295457;
	b=yKUp0AoTJJNbJ6pVeMzuutIDLA26fk2CmccRXGrZrs0QWdsJNryjR25LCNgbFbW4+qU7
	 x4PMKEQvKBogRgARJin8ubtaLlW6effAeb2/Y8iQ8cqiupOM6iMe5/JKrAq3uMQg7yjU1
	 2WlOg3dENjuB9P0NC7xK15hANkI/gvS5diUbe/HgEYwVsy7Y7w079BRpFcPk0A5ufnH92
	 eDQyJRU4EW5fTi3ZQ+ICgDa95I3s13vU1k9jwCqmhD06nYB6TkkQ5UALbum50F/THn6AJ
	 BAhDDu/SX6JB6maHZ7pAaxfnA16XRh3R8XoBJjE5fr1nlICrcuk+g03X2OpZZilN8Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295457;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KKfogKoccKbSmi27EKzQDLWPjgZehkgSMNv3TPjFRRY=;
	b=b5txVtrF3r5K5Caw7gV7GskvLLA0g0Nd80YRfpNRmEgDmL5dgreH3bDoGgWgxseRJbZe
	 3Re8AGT2iEYWAsVS+6zefH9EHwW9w3tFKYw78gmAHgWhSxSSH0FtDxTXGQoF4JrlV48zx
	 8tzcM0Rd37r0MyxZmEpGmJ0PLL1IzudwbnpveqR8dccPfVxYuBtfYPZpesJF/CDujk5pv
	 f9G1kq/v4iwxDKR775ZdDIcQOTlNW7Doh9yV8dQJNwDRR+sUQpR0z7tSDNy9qF0oKRZTI
	 QDqxTDoI6XngP7mEmpE+szWRNBcypXTjPLyvaAYL0Uun2DrYeB7wtWmYFU/JbOxmPIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JkiRsLtF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D7D606A682;
	Sat, 21 Nov 2026 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JkiRsLtF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396811F000C6;
	Sat, 21 Nov 2026 21:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795295457;
	bh=KKfogKoccKbSmi27EKzQDLWPjgZehkgSMNv3TPjFRRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JkiRsLtFytEz7iVkJbtMjbjlgxiLgL5CcmuvZROW19g8kEgEMs2tk9p9bZUyyF3ci
	 GnYEMG5TzsMegpOBq6v5mp398z76CEXWL+hRfxJ2nTBP1MJebP/Bw1y7/NIBbvbJyA
	 R6kyVVePabmrMtaACvVpKZBBAUsguvzr2VCvUhp/teKmaobt6+1Yz9GR8ubRb7FOfP
	 5/dCTvHjlMnDmRyFLI5X1rQovUIYs+J60DzRGPhz27TX4xy3iMML3uN2/A8u0aUwUj
	 ki6diO5Rn5VVsdF9V+vEFIYq9ub2HYCT2oNOmzfKb65zU9LsE0jarjYFcZy75vpF/W
	 30hv41QDtT7SQ==
Date: Sat, 21 Nov 2026 21:10:51 +0000
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
Subject: Re: [PATCH v2 6/7] dt-bindings: iio: adc: Add support for QCOM
 PMIC5 Gen4 ADC
Message-ID: <20261121211051.7b9b337c@jic23-hlaptop>
In-Reply-To: <20261120-pmic5_gen4_adc-v2-6-94d0e1fd6847@oss.qualcomm.com>
References: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
	<20261120-pmic5_gen4_adc-v2-6-94d0e1fd6847@oss.qualcomm.com>
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

On Fri, 20 Nov 2026 14:49:46 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> At present, support is present for Gen4 ADC channels under a master PMIC
> with Gen3 ADC. Add a compatible string "qcom,spmi-adc5-gen4" to support a
> master PMIC with Gen4 ADC. ADC channels under such a device can be
> considered to be of type Gen4 ADC by default.
> 
> To support any exceptions (Gen3 ADC channels under a Gen4 master), add the
> "qcom,adc5-gen3" ADC channel property, analogous to "qcom,adc5-gen4", to
> indicate that a channel is of type Gen3 ADC.
> 
> Add constraints to ensure that "qcom,adc5-gen4" and "qcom,adc5-gen3"
> channel properties are only valid if the top-level compatible string is
> of the opposite type. A channel without either of these properties can be
> assumed to be of the same type indicated by the master PMIC's compatible
> string.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Just a note to carry through feedback from the earlier patch.

> ---
>  .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml      | 39 +++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> index 065b82c41e86..e79ddc2acca0 100644
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
> @@ -91,6 +96,38 @@ patternProperties:
>            need to be marked as Gen4 to ensure their conversions are handled correctly.
>          type: boolean
>  
> +      qcom,adc5-gen3:
> +        description:
> +          Indicates channel is of type ADC5 Gen3. This may be needed in cases where the

Similar long line and language comments to the earlier dt patch.
Make sure to update this one as well if you agree with that feedback.

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

