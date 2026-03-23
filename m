Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106C53B19AC;
	Mon, 23 Mar 2026 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289902; cv=none; b=KsyAlV18GaEwLP1oRF/r1TVabgnDkTbaJKU6jtjk37vs+78f4EAZcsRRJhv8nAkocXvmwLGO5lRjpBbWIsR4439MAyEyOInCcczck+7oFaSUFvM+1/me07e5pIjNJ20PqYA3zJQug57T9mZDfH1e5kMaJFCS7TD7ekAGYJsFo0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289902; c=relaxed/simple;
	bh=3Ln9TJW6v970TdxyUfCmzNIsZKkFWpIYcxuM81XamYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTfNCLZ2siTZM/ntbqegwObgyYe9LadHGJJd71G7wVFPx2tfeX/zRyK3dYEYLZd3Qpt0ZhlhL+X9YVWU+8tOJINespFCLONbEuW0giPEYPkId0Q8kVSk0xNdwuYiuo9qW5eJnCZGUBNE73CVOQ29/JvxT3/PL46JQ1xfSveayy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laJPMH7j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laJPMH7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAFCC4CEF7;
	Mon, 23 Mar 2026 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774289901;
	bh=3Ln9TJW6v970TdxyUfCmzNIsZKkFWpIYcxuM81XamYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=laJPMH7j+hzqYBxUfdtIHfbsfTD1hbQ1VyzSPhxXf2selsi9AXV4PXN/l4g5J239h
	 iPX6NjS4yNh2oxnKUer7FjZWSGV5VZ02Ma8aID6qrPxn2T44bYzO4nIoRnF4b7aVmN
	 23YC/w5u7xvbCcFtD0+QSFsbLFnwSOdbrSh9oYfQH2N9AvEblLrio+lA+qd8/NdbwY
	 KHEJAQbp8Eo1YXDpvBYo653dWoTxDexxSKFsFINweCTWWdCJX8PdCWtV0EDYoQ0Dtb
	 bly5AufWXT89G685/oICWFyFKnUDSwQAaUvdmQFMqtZtqX9zZNmIxX2l4ZdRZSz7S+
	 gip0+TfymlULg==
Date: Mon, 23 Mar 2026 13:18:20 -0500
From: Rob Herring <robh@kernel.org>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
Message-ID: <20260323181820.GA888901-robh@kernel.org>
References: <20260323-b4-add_pwrkey_and_resin-v4-0-abef4e4dcc3d@oss.qualcomm.com>
 <20260323-b4-add_pwrkey_and_resin-v4-1-abef4e4dcc3d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-b4-add_pwrkey_and_resin-v4-1-abef4e4dcc3d@oss.qualcomm.com>

On Mon, Mar 23, 2026 at 04:15:15PM +0530, Rakesh Kota wrote:
> PMM8654AU is a different PMIC from PMM8650AU, even though both share
> the same PMIC subtype. Add PON compatible string for PMM8654AU PMIC
> variant.
> 
> The PMM8654AU PON block is compatible with the PMK8350 PON
> implementation, but PMM8654AU also implements additional PON registers
> beyond the baseline. Use the PMM8654AU naming to match the compatible
> string already present in the upstream pinctrl-spmi-gpio driver, keeping
> device tree and kernel driver naming consistent.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> ---
> Changes in v4:
>  - Remove the contain for PMK8350 and new if:then for PMM8654AU as
>    suggested by Krzysztof Kozlowski
> 
> Changes in v3:
>  - Update the commit message.
> 
> Changes in v2:
>  - Introduces PMM8654AU compatible strings as suggested by Konrad Dybcio.
> ---
>  .../devicetree/bindings/power/reset/qcom,pon.yaml  | 32 +++++++++++++++++-----
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index 979a377cb4ffd577bfa51b9a3cd089acc202de0c..2a5d9182b8d5c1a286716ab175c7bb5e39b334e0 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -17,12 +17,16 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,pm8916-pon
> -      - qcom,pm8941-pon
> -      - qcom,pms405-pon
> -      - qcom,pm8998-pon
> -      - qcom,pmk8350-pon
> +    oneOf:
> +      - enum:
> +          - qcom,pm8916-pon
> +          - qcom,pm8941-pon
> +          - qcom,pms405-pon
> +          - qcom,pm8998-pon
> +          - qcom,pmk8350-pon
> +      - items:
> +          - const: qcom,pmm8654au-pon
> +          - const: qcom,pmk8350-pon
>  
>    reg:
>      description: |
> @@ -100,7 +104,6 @@ allOf:
>    - if:
>        properties:
>          compatible:
> -          contains:
>              const: qcom,pmk8350-pon
>      then:
>        properties:
> @@ -113,6 +116,21 @@ allOf:
>              - const: hlos
>              - const: pbs
>  
> +  - if:
> +      properties:
> +        compatible:
> +            const: qcom,pmm8654au-pon
> +    then:
> +      properties:
> +        reg:
> +          minItems: 1
> +          maxItems: 2
> +        reg-names:
> +          minItems: 1
> +          items:
> +            - const: hlos
> +            - const: pbs

I don't understand this. The existing if/then schema did the exact same 
thing until you removed 'contains'. Now we just have the same schema 
duplicated.

What does need changing now that I've looked at it is dropping 'reg' 
in this schema as it just repeats what the top-level schema has.

Rob
