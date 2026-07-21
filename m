Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE2425880;
	Tue, 21 Jul 2026 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616802; cv=none; b=u8rKspjvC6+BQIJahEn9j5jzh3uq7zPHTqTQ+6p96HmMcc/JKw/Xv7Qi/K/ADb1Csn4FCct6lP0yl3405oknijA9auto4XlGgxbazvPn/mLlGGFTseGDBq+74jsXIjKR1K+0QT+srxzOBomGC1wKZhfEpN+kbCOQ14T3QBN/WXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616802; c=relaxed/simple;
	bh=Mr48OJBpqNXF99NUVscw+XS7PPWk1GoY1V8Qc4G1XxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alj2wAqP6+Sqycb6NK6Y74q5O/sWIlcoK5SRQJeOHGxgUPrV1CuWOoadhN3/LrqK045qYQDIM7LryDXn2WJJJoJTkbqP+trFGbyz4Aoifl1AgqnkftQ2q6009q9HFhjVdCQLvwcaarmEBNIjosO/VhLHBUUqqDSZO6UpNQdlDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiEObvFH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiEObvFH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3831F00A3D;
	Tue, 21 Jul 2026 06:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784616800;
	bh=oXWA4aAp+eHwrOCsUG6kaSjtByPSvhC3onuHYmgdsu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GiEObvFHjkkXl57S2uc/tzUe5e7i0tVV221gye3x353rubA3rXrTZhC+X3mIq5R/J
	 4gZ6dSzoxOsRnc7iDzjfTkWp0G2jMoKcbGexjxYIPX39goZlmvlimBJ5QqgTKsCsoC
	 uJ32NL2LM3QcKgdBlXKvDSK+O+oa16G+6PMRHtyzLXZov6/bUK2TYHGPfTQeZhF++p
	 oBRlV6Qd8mu+k6DYZ0MwBxa/1cNyPx31Dtgbb331weFbUUgUlwXkMA8ZLZ317KBrIr
	 EMBNroOFW16LoNTrQDv9/vtOqbWKxfyi8D7IIhUSp0QWQm3NZCSL4eMO12WI3U2HMF
	 TgxvBL+5t2HDA==
Date: Tue, 21 Jul 2026 08:53:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
Message-ID: <20260721-lovely-quick-tarsier-768113@quoll>
References: <20260713-b4-add_pwrkey_and_resin-v5-0-3bea476e1453@oss.qualcomm.com>
 <20260713-b4-add_pwrkey_and_resin-v5-1-3bea476e1453@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713-b4-add_pwrkey_and_resin-v5-1-3bea476e1453@oss.qualcomm.com>

On Mon, Jul 13, 2026 at 05:28:14PM +0530, Rakesh Kota wrote:
> PMM8654AU is a distinct PMIC variant from PMM8650AU despite sharing the
> same PMIC subtype. PMM8654AU implements additional registers added to
> the "hlos" register address spaces, so add qcom,pmm8654au-pon as a
> fallback to qcom,pmk8350-pon to distinguish it from the baseline
> PMK8350 PON implementation.
> 
> The GEN3 PON peripheral requires two register address spaces: "hlos"

What is gen3 pon here? It is the first time this appears in the commit
msg.

> for the primary PON block and "pbs" for the address needs to be
> specified to facilitate software debouncing. Set minItems: 2 for reg
> in the qcom,pmk8350-pon if/then constraint to enforce that both
> address spaces are always present.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> ---
> Changes in v5:
>  - Set minItems: 2 for reg in the PMK8350 if/then block to enforce that
>    both hlos and pbs address spaces are required for GEN3 PON peripherals.
> 
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
>  .../devicetree/bindings/power/reset/qcom,pon.yaml     | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index 979a377cb4ffd577bfa51b9a3cd089acc202de0c..09eea48c709e5e42c45c1949ee1d06298dea1f91 100644
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
> @@ -105,10 +109,9 @@ allOf:
>      then:
>        properties:
>          reg:
> -          minItems: 1
> +          minItems: 2

You wrote that PMM8654AU has additional registers. This implies pmk8350
does not have them, so why are you changing this?

Also, that's an ABI break and I see no relation to the goal of adding
PMM8654AU. Don't combine independent works into one commit.

Best regards,
Krzysztof

