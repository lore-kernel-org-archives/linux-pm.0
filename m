Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7C44BC9A;
	Thu, 13 Aug 2026 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614184; cv=none; b=QwYUIX+w+Sg/cGVRchnAKrbq+9K6SLLPhrmIXVmeWhbfl29b6sboZf/RqNZgO+qGT1CK2QbtuZ7XyZUHFBhuJdwqB2UR3IdwEvZYWs3BHQxiRfVAS9xwla3PiJPcyo+IgOIj/H8LcwXgjEqvlYdfuXRZCnc3qqRPyJGqTpyXJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614184; c=relaxed/simple;
	bh=rHOTMfFh+9npJEWL2zJ16RJYD7KDP9JJY2gIefqZ0nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oO38nimyRQGxZZ8rB68FvrvW06pM1mYX1pvdW5ePimWc8q8WyU1tYxThUoIMvhsv9aNZXvpWeuqCV5intv3YOXb4jVrgOMfggSQFbKRz6veGFT8kc3NFDoRF1jxdHorzDBmnx/grNAN9OOh49ziy22DwgElbLnsYR+wNVV1gGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOEIFUac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOEIFUac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC6E1F000E9;
	Thu, 13 Aug 2026 09:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614182;
	bh=+I+TAhajKR2AAUrBGWlnYP4eznV2SRB9pd5JLDfyY4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QOEIFUacTB61Iq9soMf6AcC2um3JCYmEMinmplLeObG0c4cPLITsUfuKfBjYycZna
	 mtCIWOTkyXEvWwtExeHoO1FWydPBjFgtkpTbi+7siy8wjldN4hYIMeqN9ynH+mEADr
	 qGyV5GnbXSRmeBp3D8UsUaWoBs6MQApBGesZA11XXCoHsBtXyq6k/ZSwEuVaEVSQW/
	 uHCs4q3og04Cg6X/3LV/T5g/iLCKtbddtycpX3t7M+GGwCkbajVjoct5BGU1YVQUnZ
	 qdbcL9aTZ7OmwQeBV4tSJxMSbGNwkitxlgjhFrkDDGvXBOdCXmjxq3LZpGEIqqx614
	 fPf9mVZC4/pfA==
Date: Thu, 13 Aug 2026 11:42:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 14/15] dt-bindings: arm: qcom: Document Kuno IDP board
Message-ID: <20260813-audacious-cockatoo-of-brotherhood-098c9d@quoll>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-14-5e0ede4a0c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809-kuno-soc-support-v1-14-5e0ede4a0c72@oss.qualcomm.com>

On Sun, Aug 09, 2026 at 12:57:13PM +0530, Hardeep Sharma wrote:
> Document the Qualcomm Kuno IDP board and allow the legacy qcom,msm-id
> and qcom,board-id properties for the qcom,kuno SoC.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index c7c9a9279684..f87ff5d923f8 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -174,6 +174,11 @@ properties:
>                - qcom,kaanapali-qrd
>            - const: qcom,kaanapali
>  
> +      - items:
> +          - enum:
> +              - qcom,kuno-idp
> +          - const: qcom,kuno
> +
>        - items:
>            - enum:
>                - qcom,mahua-crd
> @@ -1322,6 +1327,7 @@ allOf:
>                - qcom,apq8026
>                - qcom,apq8094
>                - qcom,apq8096
> +              - qcom,kuno

No, this list cannot grow.

What you miss is to update qcom-soc.yaml

Best regards,
Krzysztof

