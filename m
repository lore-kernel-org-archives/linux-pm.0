Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EB2EC0A6;
	Mon,  3 Aug 2026 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765744; cv=none; b=LtpLccqw/nDousskOcLyyC4O7/YvfxbcS5Rio9dJ1b/rSj3kXq33DhrhAAuDz1v2E1L0VBl1R1sx85B/r2hEJHXeZ20ngB4mCm/80IV3+SJD7MrunA+3mxS+WgAWRZXZvIUtvOPQgMJizZv11iP05/6BZBqLMFwcJOMPWQpEffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765744; c=relaxed/simple;
	bh=91+5d5w0IBat7XmUafS9OMB0xElt2o9m8PAQSTBabdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImXxbSchIaXhO58PlrD5NwnBI1eGc+MXLSzVRq7IKGNc22c+iRDCLC+QcJ4L0pSnyOqDkFm+wu5r3OvzUbQlocNxfq2tJ1WpUui0JFCtMzs9n9RjvR7sVQkxjfBZvi7FdNpzBSzzGdhvxnJTHvmSLXgRtAZnuEJ31qVSDa4rSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzngFhPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzngFhPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112ED1F000E9;
	Mon,  3 Aug 2026 14:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785765743;
	bh=8MQ8T7NdvAwpzxaCZ1+v7WJCcrO5pFRdCLXlVF1VhRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dzngFhPCD8XmmP7MUsAOv0G7EzXOnMwETJWSUldS5GWOpWZnu5FQ5OBt6Tk1GhkWY
	 sL8QLYACy9jYmtNx+rqZfhjhaec8bqDrTylFd7PAS3cYSj3d0S7LypEYaHuj19/sSz
	 ixpHt7poJV7vHiTmKODx3r2187gK//eJU/RG2WCgXlrbGz966iFHzbz7MmMgkq21nq
	 XQdC7MT3PtEhr9/D8AmBgHD+fUQ6hYwADW+3rFiG+G96meo1RsRGUKwXEoYHFqluFK
	 Z1GSDfEDc0A5fwAHN4VaDzyDUtlophV8GKRctLd2NBNTcg88Nc6gTM+/g3HT9E6Pl9
	 OPLXGzdvVKqmQ==
Date: Mon, 3 Aug 2026 09:02:22 -0500
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
Subject: Re: [PATCH v24 05/12] dt-bindings: arm: Document reboot mode magic
Message-ID: <20260803140222.GA3188037-robh@kernel.org>
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-5-889281373870@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803-arm-psci-system_reset2-vendor-reboots-v24-5-889281373870@oss.qualcomm.com>

On Mon, Aug 03, 2026 at 03:13:36PM +0530, Shivendra Pratap wrote:
> Add bindings to describe vendor-specific reboot modes. Values here
> correspond to valid parameters to vendor-specific reset types in PSCI
> SYSTEM_RESET2 call.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 58 +++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> index 6e2e0c551841..7d6a86690a2e 100644
> --- a/Documentation/devicetree/bindings/arm/psci.yaml
> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> @@ -98,6 +98,41 @@ properties:
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
> +        minItems: 1
> +        maxItems: 3
> +        items:
> +          - description: arg1 (vendor-specific SYSTEM_RESET2 reset_type)
> +            allOf:

Don't need allOf here.

> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +              - minimum: 0x80000000
> +          - description: arg2 (cookie_lo in 2-cell form, cookie_hi in 3-cell form)
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +          - description: arg3 (cookie_lo in 3-cell form)
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Describes a PSCI SYSTEM_RESET2 vendor-specific reset type. The string
> +          after "mode-" maps a reboot mode to a vendor-specific reset.

Blank line if this is a paragraph.

> +          A vendor-specific reset takes two arguments, a 32-bit reset_type and a
> +          64-bit cookie. The arguments are encoded as up to three 32-bit cells.
> +          Each mode property is encoded as mode-xxx = <arg1[, arg2[, arg3]]>,
> +          where:

blank line

> +          - arg1 is reset_type and must be >= 0x80000000.
> +          - In 2-cell form, arg2 is lower 32 bits of cookie.
> +          - In 3-cell form, arg2 is high 32 bits of cookie
> +            and arg3 is low 32 bits of cookie.

Indent the list by 2 more spaces.

> +
> +          All values should be provided as per the PSCI SYSTEM_RESET2
> +          specification.
> +
>  patternProperties:
>    "^power-domain-":
>      $ref: /schemas/power/power-domain.yaml#
> @@ -137,6 +172,15 @@ allOf:
>        required:
>          - cpu_off
>          - cpu_on
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: arm,psci-1.0

SYSTEM_RESET2 was introduced in PSCI 1.1...

> +    then:
> +      properties:
> +        reboot-mode: false
