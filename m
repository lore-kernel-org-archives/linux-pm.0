From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v7 1/7] qcom: spm: Add Subsystem Power Manager driver
Date: Tue, 30 Sep 2014 10:26:35 -0700
Message-ID: <7hiok510l0.fsf@deeprootsystems.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
	<1411779495-39724-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1411779495-39724-2-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Fri, 26 Sep 2014 18:58:09 -0600")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Based on work by many authors, available at codeaurora.org
>
> SPM is a hardware block that controls the peripheral logic surrounding
> the application cores (cpu/l$). When the core executes WFI instruction,
> the SPM takes over the putting the core in low power state as
> configured. The wake up for the SPM is an interrupt at the GIC, which
> then completes the rest of low power mode sequence and brings the core
> out of low power mode.
>
> The SPM has a set of control registers that configure the SPMs
> individually based on the type of the core and the runtime conditions.
> SPM is a finite state machine block to which a sequence is provided and
> it interprets the bytes  and executes them in sequence. Each low power
> mode that the core can enter into is provided to the SPM as a sequence.
>
> Configure the SPM to set the core (cpu or L2) into its low power mode,
> the index of the first command in the sequence is set in the SPM_CTL
> register. When the core executes ARM wfi instruction, it triggers the
> SPM state machine to start executing from that index. The SPM state
> machine waits until the interrupt occurs and starts executing the rest
> of the sequence until it hits the end of the sequence. The end of the
> sequence jumps the core out of its low power mode.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

[...]

> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
> index 1505fb8..9a9cc99 100644
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
> @@ -14,10 +14,9 @@ PROPERTIES
>  	Value type: <string>
>  	Definition: shall contain "qcom,saw2". A more specific value should be
>  		    one of:
> -			 "qcom,saw2-v1"
> -			 "qcom,saw2-v1.1"
> -			 "qcom,saw2-v2"
> -			 "qcom,saw2-v2.1"
> +			 "qcom,apq8064-saw2-v1.1-cpu"
> +			 "qcom,msm8974-saw2-v2.1-cpu"
> +			 "qcom,apq8084-saw2-v2.1-cpu"

This looks odd (to me.)  Why are the SoC name and the SAW2 version both
needed?

Kevin
