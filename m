Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD743CE40;
	Wed, 22 Jul 2026 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740275; cv=none; b=VbvDSY0fMQpSUTv5Dgub3kiolPw8DaRmT0qcN7GhUsiOU191OLppMONSDC3953ffXkD2APu+OBgZfzFbGjX6dDmVppXv1vw8THkB4rbByEfxwEuw+K21lNnBtLeF380v7G2bxn+WbH6XjyD5MTgGyYELYGPbaHGc9ErIQaKfj+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740275; c=relaxed/simple;
	bh=7Y45uPglg7iPqVphYTzQdr9XvOjm5WsJCXkvZ34cbCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOnOa8GFBhdrc8yWLDAtx7Kj4e5NJd7UdmTnEOdGnyKg05U8fHfEovt5otjbP+hwvt68TmAJogMMfiHLPLweSvvE01J1xu11wQlN1R7wtqK65UazxkmOrpUx9ZZ07ObtavtbfWOaDyskWhZtDnPPygUR/sQefqvz9cqtx2wZ3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK7sXvlW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK7sXvlW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC551F00A3D;
	Wed, 22 Jul 2026 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784740271;
	bh=5IBnNKjFpX4h0Bw883YP13wsIeX4UwbQCYYcGQL98/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CK7sXvlW6Hxdlu4AfJEbAArnsSEg0XC99sMwPdapxkzWS6lfQHVEjLbKVchA28HiQ
	 ev2d1c0zafdn/Pce8r5I/eIUlZRKRArl/sRA9dFmDMk2UkDhNaxggska+6+yPUbIql
	 Tl8/r36qTileL2G1SVsvkMuomWakSZkIQ6royDGKfHpQ4308acSMZdPcSHAdmXwS35
	 L1gstCY5lDivDwSRSB8UvGhF4Or/NAXg/4Hceh65ba6Ho35zY6tvRBdMa5kF9iJNCF
	 kYNaEnThvDyxQ083o89Pg4doOLatISY8KslxYSzSlkFHWEO4QymY2C0Jiiw+XeXV5S
	 b+RGFAZaLDo5Q==
Date: Wed, 22 Jul 2026 12:11:08 -0500
From: Rob Herring <robh@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	John Stultz <john.stultz@linaro.org>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Andre Draszik <andre.draszik@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v23 06/13] dt-bindings: arm: Document reboot mode magic
Message-ID: <20260722171108.GA1097879-robh@kernel.org>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-6-e7453c548c21@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-arm-psci-system_reset2-vendor-reboots-v23-6-e7453c548c21@oss.qualcomm.com>

On Tue, Jul 14, 2026 at 10:46:34PM +0530, Shivendra Pratap wrote:
> Add bindings to describe vendor-specific reboot modes. Values here
> correspond to valid parameters to vendor-specific reset types in PSCI
> SYSTEM_RESET2 call.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 54 +++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> index 6e2e0c551841..11b90e8affb3 100644
> --- a/Documentation/devicetree/bindings/arm/psci.yaml
> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> @@ -98,6 +98,37 @@ properties:
>        [1] Kernel documentation - ARM idle states bindings
>          Documentation/devicetree/bindings/cpu/idle-states.yaml
>  
> +  reboot-mode:
> +    type: object
> +    $ref: /schemas/power/reset/reboot-mode.yaml#
> +    additionalProperties: false
> +    properties:
> +      # "mode-normal" is just SYSTEM_RESET
> +      mode-normal: false
> +    patternProperties:
> +      "^mode-.*$":

Since your example violates naming rules:

"^mode-[a-z0-9]+$"

> +        minItems: 1
> +        maxItems: 3
> +        items:
> +          - description: arg1 (vendor-specific SYSTEM_RESET2 reset_type)
> +            minimum: 0x80000000
> +          - description: arg2 (cookie_lo in 2-cell form, cookie_hi in 3-cell form)
> +          - description: arg3 (cookie_lo in 3-cell form)
> +        description: |
> +          Describes a PSCI SYSTEM_RESET2 vendor-specific reset type. The string
> +          after "mode-" maps a reboot mode to a vendor-specific reset.
> +          A vendor-specific reset takes two arguments, a 32-bit reset_type and a
> +          64-bit cookie. The arguments are encoded as up to three 32-bit cells.
> +          Each mode property is encoded as mode-xxx = <arg1[, arg2[, arg3]]>,
> +          where:
> +          - arg1 is reset_type and must be >= 0x80000000.
> +          - In 2-cell form, arg2 is lower 32 bits of cookie.
> +          - In 3-cell form, arg2 is high 32 bits of cookie
> +            and arg3 is low 32 bits of cookie.
> +
> +          All values should be provided as per the PSCI SYSTEM_RESET2
> +          specification.
> +
>  patternProperties:
>    "^power-domain-":
>      $ref: /schemas/power/power-domain.yaml#
> @@ -137,6 +168,15 @@ allOf:
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
> @@ -260,4 +300,18 @@ examples:
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
> +        mode-needscookie_64 = <0x80000000 0x00000001 0x00000002>;

Don't use '_' in property names. This is a W=2 warning.

Rob
