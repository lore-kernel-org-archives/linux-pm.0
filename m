Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643AC2E229F;
	Fri, 18 Sep 2026 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789769197; cv=none; b=ugttG3mRhnCTSrLZWSX2uraHFE6FMXO+sEt8kKXim+BWzIy9V23ODWFy7/WYTJfUVRMNJZnPvhMNx2Z5lyTJoiKoUqn22ls3ycSHgaP5yVeeleEpNKyMDyLGAgoeMyANuwtQr0vkL5USYuetCaQV3K4b7Rm6sNeo9BmGmZyQDEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789769197; c=relaxed/simple;
	bh=xnLsNoSw5HMqOCWdSt6MKGnhKvFUd5872n1Ks2lzvi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh5ehb/KT5+kVJN0g3EmcLN9BJpF8rUgyBRnHh0hJ5/zm8kQl0g+5XmQ/qPArGkoNw9Q4hepsB4cldmLsAynPn/86GqTtMyJn4iHBBUnw+z0hV6xJLQFNnAD7btEgxUPQPHNMgf0YQl1Oksgjb3yxtN2OXBy8h2tIUcit8BK7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlVldnl7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlVldnl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D6B1F000FF;
	Fri, 18 Sep 2026 22:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789769196;
	bh=sdkH+9Eyo8lwBnyWL3D0AXJdYxWgcTzyUyAN9ex0Fds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dlVldnl793sIzCA+QOGOpldMSTPn+NoZMEZeCGm5bhJCO8q2JcX7ccwfRYmlVBKT/
	 +8uQjid3nEOdVeZrg8T5nlETCUAVjTreiu0IP2BEz+aYFlKOS6J14Tu24PWqd2Gh2w
	 KxEvQJwf1TV+FrjB16PbBRzFK/5rauXPTzc7e5dOMd+/XxY2AYQaz3N5EwkHd/mjix
	 /UN4o5DDWRVqQ2yj06BKUXrTriaZx2AVekXsV1SsEuNrUW6EvP/ru3omAjVf3HS8fk
	 7PFRofebNSd1Q4ovkxbWzaFZ5d4QgSEx1uKhRjh74tVxEZURcKNXlqI+DPPOduAmVz
	 n9xCx7E6n4WrA==
Date: Fri, 18 Sep 2026 17:06:34 -0500
From: Rob Herring <robh@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Andre Draszik <andre.draszik@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, mfd@lists.linux.dev,
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v25 05/10] dt-bindings: arm: Document reboot mode magic
Message-ID: <20260918220634.GA2441717-robh@kernel.org>
References: <20260914-arm-psci-system_reset2-vendor-reboots-v25-0-4aaf5c09b5c2@oss.qualcomm.com>
 <20260914-arm-psci-system_reset2-vendor-reboots-v25-5-4aaf5c09b5c2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-arm-psci-system_reset2-vendor-reboots-v25-5-4aaf5c09b5c2@oss.qualcomm.com>

On Mon, Sep 14, 2026 at 08:29:09PM +0530, Shivendra Pratap wrote:
> Add bindings to describe vendor-specific reboot modes. Values here
> correspond to valid parameters to vendor-specific reset types in PSCI
> SYSTEM_RESET2 call.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 60 +++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> index 0d04389c81fa..8b6a28b81ed7 100644
> --- a/Documentation/devicetree/bindings/arm/psci.yaml
> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> @@ -98,6 +98,43 @@ properties:
>        [1] Kernel documentation - ARM idle states bindings
>          Documentation/devicetree/bindings/cpu/idle-states.yaml
>  
> +  reboot-mode:
> +    type: object
> +    $ref: /schemas/power/reset/reboot-mode.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      # "mode-normal" is just SYSTEM_RESET
> +      mode-normal: false
> +    patternProperties:
> +      "^mode-.*$":
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 2
> +        items:
> +          - description: arg1 (vendor-specific SYSTEM_RESET2 reset_type)
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0x80000000
> +          - description:
> +              arg2 (cookie_lo in 2-cell form, cookie_hi in 3-cell form)
> +            $ref: /schemas/types.yaml#/definitions/uint32

Drop. Types are per property, not per item.

> +          - description: arg3 (cookie_lo in 3-cell form)
> +            $ref: /schemas/types.yaml#/definitions/uint32

Drop.

> +        description: |
> +          Describes a PSCI SYSTEM_RESET2 vendor-specific reset type. The string
> +          after "mode-" maps a reboot mode to a vendor-specific reset.
> +
> +          A vendor-specific reset takes two arguments, a 32-bit reset_type and a
> +          64-bit cookie. The arguments are encoded as up to three 32-bit cells.
> +          Each mode property is encoded as mode-xxx = <arg1 arg2[, arg3]>,
> +          where:
> +
> +            - arg1 is reset_type and must be >= 0x80000000.
> +            - In 2-cell form, arg2 is lower 32 bits of cookie.
> +            - In 3-cell form, arg2 is high 32 bits of cookie
> +              and arg3 is low 32 bits of cookie.
> +
> +          All values should be provided as per the PSCI SYSTEM_RESET2
> +          specification.
> +
>  patternProperties:
>    "^power-domain-":
>      $ref: /schemas/power/power-domain.yaml#
> @@ -137,6 +174,15 @@ allOf:
>        required:
>          - cpu_off
>          - cpu_on
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: arm,psci-1.0
> +    then:
> +      properties:
> +        reboot-mode: false
>  
>  additionalProperties: false
>  
> @@ -260,4 +306,18 @@ examples:
>          domain-idle-states = <&cluster_ret>, <&cluster_pwrdn>;
>        };
>      };
> +
> +  - |+
> +
> +    // Case 5: SYSTEM_RESET2 vendor resets
> +    psci {
> +      compatible = "arm,psci-1.0";
> +      method = "smc";
> +
> +      reboot-mode {
> +        mode-edl = <0x80000000 0x00000001>;
> +        mode-bootloader = <0x80010001 0x00000002>;
> +        mode-vendor = <0x80000000 0x00000001 0x00000002>;
> +      };
> +    };
>  ...
> 
> -- 
> 2.34.1
> 
