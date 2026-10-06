Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1206C383C92;
	Tue,  6 Oct 2026 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791277903; cv=none; b=DfMX4k8AxOmspUCpSAampMnYzMOEY7Pj96tmMiSDlTwPCVHfZSr44fWsvLibXxtGBU8yFPCtOgr73IQJlkR1rlL4roWRFRqb/HXmR9TeFej0Y1BXixaYDhMAc71Ee14S8fBN83EKYtHRHw8alFuJejAcjLwVl6pj10SKTWTqstw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791277903; c=relaxed/simple;
	bh=cbmqXZc5eMw2f9iPbake+nwkrFkaYniZpHY6pZTni3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVGk1D7syh5RTuLKCrZyMjzyMkei+eqcnANzY0fV7eAad3rpifKtTt4NDUDgC1CV2r2kFHIZWqoicIBOxBBdUSxCoHsL7P/LTDhDDojWZwaY2Bdcky5iRYmDVYXNB7BIHyvaygWtvHGr5yoj6xm4jqGCgXijswHW0Bam3Ybsw+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSajS507; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSajS507"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949F31F000FF;
	Tue,  6 Oct 2026 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791277901;
	bh=Og2rvTNwnBto8lUtTepzVbjqu8HwH5iPSkQnv6s94g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MSajS507MvWZO3VztPOPMhxqDEUFJT8F7vZgEdHKjm5nw6v+yMdP00cBlzvCDRhmf
	 fcTXu+zL6JcuEsSecRyelKpQmaxuBDSNtWAUiemYwCkAzJKH6/AKQevIWjFzQsqZ35
	 fSzt2Ze3Jsmef+m6LE/2N1HFblc3sGa7tey4xPZ+XurPnOhMBLN1UXxVCGPKtK+8nD
	 y3BFJGJivsHuyXj3wguG4ZgVjRFuSxK7+QEL8oYLYjgjrQB8pyhJWY3jatFViM+ES7
	 +k14fIwoTigal3B4JBAPGCUnBRrVMf6+PoE74I2x0DtHKKlac6R8h5aO71hpI7q2VS
	 fDWabn2yBzb8Q==
Date: Tue, 6 Oct 2026 10:11:36 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: power: domain-idle-state: Add
 system-state
Message-ID: <20261006-elfish-aloof-tuatara-5ccc5b@sudeepholla>
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
 <20261005-s2idle_state-v1-1-3c402c66f388@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005-s2idle_state-v1-1-3c402c66f388@oss.qualcomm.com>

On Mon, Oct 05, 2026 at 08:59:42PM +0530, Maulik Shah wrote:
> Some domain idle states require system-wide coordination and are not
> applicable while the platform is up and running.
> 
> Add a boolean system-state property to describe these states.
> 
> Assisted-by: Codex:GPT-6
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/power/domain-idle-state.yaml       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.yaml b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> index 4dd4f59bbbec..35dab3cd6aed 100644
> --- a/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> +++ b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> @@ -45,6 +45,12 @@ patternProperties:
>            state will yield power benefits, after overcoming the overhead while
>            entering the idle state.
>  
> +      system-state:
> +        description:
> +          When present, this state requires system-wide coordination and is
> +          not applicable while the platform is up and running.
> +        type: boolean
> +

I would rather have a system wide QoS latency setting either h/w specific
or it can be purely software policy that tells all these states to be off
for normal CPU idle path.

>        arm,psci-suspend-param:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          description: |
> @@ -77,5 +83,13 @@ examples:
>          exit-latency-us = <40>;
>          min-residency-us = <80>;
>        };
> +
> +      domain_power_off: domain-power-off {
> +        compatible = "domain-idle-state";
> +        entry-latency-us = <100>;
> +        exit-latency-us = <200>;
> +        min-residency-us = <1000>;

Please provide some realistic values. I understand this is just example
but way-off for a system level state. See your own platform values for
reference.

-- 
Regards,
Sudeep
