Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484668;
	b=2ZSujgtxoCewGhwOpHs1UPwJRA1jYZoY3T12drcFC9/Uuf+PiqRjGztKaxIc+ay5MA8N
	 v948g59JwIfNE4Pjnvfi5fIXEJ7bjW2ml+v9QxOoEXoVRgqy3yBVnsC7iUVxjdZZEuB+a
	 TM5bKQRCdO/oJT/I/QK73d0IEXkCdqs4RGkXeRIk5jxSnCiQtJ9GoFZ8WI2KzWOrmRBAn
	 Tzb2cuPj7SY6NwEvl0LkhuUkCcGMXybh0fwP3nVQiPfnwc6tpXnzd/1dEnf/6sWJD2JR6
	 k3R9nT53a3XOtad4681tv451i0j6H70iE4MD0UyCJU2Mo1OLrIQN8zuf57t141tAsNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484668;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BDH66iwqkRgJj4e6eKiX9PI9QDXAkvZBEmj4POr6C3A=;
	b=WlrSJeT/bZJ5qxgtRkpBxVBH5EiYNZb2A3R2QzbWTeBz4kYmg4kqMhTVaF8PIvqCbCFo
	 6NAq9NGy5tQpVxxyp+KlkW/Onf+C6qpSJ8itNczQe854DjPlrtMsGVd8a8yfShz8PrKIA
	 fgs4eEnNaO3nza1t8t2m3VILlBSAwSLvc9t8woQFH+WQfaM+e+/2igav8KwKFPdODji2f
	 Vw1wK852gfxtNKOnXQGOxPpUEMF0JtsYAi/zT//Xl3e9rE39QzR0jQgcyKa/bEpX9NuoH
	 RQVeMeAdyFaJ3fWUgAjDZT0UPhuABu7cSeheXBz7ZvpJQVIy3VkMrfbXps/9n9EbhzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUD3yD46;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D87606A319;
	Tue, 20 Oct 2026 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUD3yD46
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2DA1F000C4;
	Tue, 20 Oct 2026 08:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484667;
	bh=BDH66iwqkRgJj4e6eKiX9PI9QDXAkvZBEmj4POr6C3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JUD3yD46BE6lkiwuLD7Yk5HVWwsxin/8xL49ESTfGpBixMfITVs3BDxjqIK7GLKYx
	 41uHhW6rmVkvDz+cR1pN15TqnOgKBseRYj4gviCWlpMl7DHk+u9z8+97H/D2c1sGmD
	 HNXmODdkDtZOM55q0G/P5CRZoE55NzcUyoN/6Gqn+j+14gY/P6VLca3NsXwXSzMXw+
	 xWZzcWxLx3Db59fOiBxExqva0X3zJS9qbvIeCl2CAstYf3Uk1h5Tf/Ct+KTevUF/H0
	 ivoSfCK/sx9DDavmKJ5ibaaOBNr0u3B1FcjIHH+8e5lG1LA/x2Vz2Q4kFPkJDkl+Ri
	 5u99tVlYBxuEg==
Date: Tue, 20 Oct 2026 10:24:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Del Regno <angelogioacchino.delregno@somainline.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Andy Gross <agross@codeaurora.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Shawn Guo <shawn.guo@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: interconnect: add Qualcomm MSM8998 NoC
Message-ID: <20261020-daft-competent-saluki-a080c7@quoll>
References: <20261019-msm8998-icc-v1-0-c2da3934b6c8@oss.qualcomm.com>
 <20261019-msm8998-icc-v1-1-c2da3934b6c8@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019-msm8998-icc-v1-1-c2da3934b6c8@oss.qualcomm.com>

On Mon, Oct 19, 2026 at 05:12:39PM +0300, Dmitry Baryshkov wrote:
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,msm8998-a1noc
> +      - qcom,msm8998-a2noc
> +      - qcom,msm8998-bimc
> +      - qcom,msm8998-cnoc
> +      - qcom,msm8998-gnoc
> +      - qcom,msm8998-mnoc
> +      - qcom,msm8998-mnoc-ahb
> +      - qcom,msm8998-snoc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4

...


> +  - if:
> +      properties:
> +        compatible:
> +          const: qcom,msm8998-mnoc-ahb
> +
> +    then:
> +      description:
> +        The MMSS AHB NoC shares its register space with the MMSS NoC, so it is
> +        described as a child of the latter and has no register range of its own.
> +
> +      properties:

reg: false

> +        clocks:
> +          items:
> +            - description: MMSS AHB Clock
> +
> +        clock-names:
> +          const: bus
> +
> +      required:
> +        - clocks
> +        - clock-names
> +
> +    else:
> +      required:
> +        - reg
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,msm8998-bimc
> +            - qcom,msm8998-gnoc
> +
> +    then:
> +      properties:
> +        clocks: false
> +        clock-names: false
> +

unevaluatedProperties should go here, just before the example

> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-msm8998.h>
> +    #include <dt-bindings/clock/qcom,mmcc-msm8998.h>
> +
> +    interconnect@1008300 {
> +        compatible = "qcom,msm8998-bimc";
> +        reg = <0x01008300 0x77d00>;
> +        #interconnect-cells = <2>;
> +    };
> +
> +    interconnect@1740000 {
> +        compatible = "qcom,msm8998-mnoc";
> +        reg = <0x01740000 0x10000>;
> +        clocks = <&mmcc MNOC_AHB_CLK>, <&mmcc MNOC_MAXI_CLK>;
> +        clock-names = "iface", "mnoc_bus";
> +        #interconnect-cells = <2>;
> +
> +        interconnect-mnoc-ahb {

I do not see how this can validate. You do not allow any children in
your binding. Your tpo-level properties should define all possible
properties and nodes.

also, name should be just "interconnect"


Best regards,
Krzysztof

