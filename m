From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC v1 5/8] dt-bindings: introduce cpu power domain
 bindings for Qualcomm SoCs
Date: Thu, 11 Oct 2018 12:08:49 +0100
Message-ID: <20181011110849.GA32752@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-6-git-send-email-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539206455-29342-6-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 11, 2018 at 02:50:52AM +0530, Raju P.L.S.S.S.N wrote:
> Add device binding documentation for Qualcomm Technology Inc's cpu
> domain driver. The driver is used for managing system sleep activities
> that are required when application processor is going to deepest low
> power mode.
>

So either we are not using PSCI or the binding is not so clear on
how this co-exist with PSCI power domains. Could you provide details ?

> Cc: devicetree@vger.kernel.org
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
>  .../bindings/soc/qcom/cpu_power_domain.txt         | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt b/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
> new file mode 100644
> index 0000000..1c8fe69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
> @@ -0,0 +1,39 @@
> +Qualcomm Technologies cpu power domain
> +-----------------------------------------
> +
> +CPU power domain handles the tasks that need to be performed during
> +application processor deeper low power mode entry for QCOM SoCs which
> +have hardened IP blocks combinedly called as RPMH (Resource Power Manager
> +Hardened) for shared resource management. Flushing the buffered requests
> +to TCS (Triggered Command Set) in RSC (Resource State Coordinator) and
> +programming the wakeup timer in PDC (Power Domain Controller) for timer
> +based wakeup are handled as part of domain power down.
> +

And which is this not hidden as part of PSCI CPU_SUSPEND ?

> +The bindings for cpu power domain is specified in the RSC section in
> +devicetree.
> +
> +Properties:
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be "qcom,cpu-pm-domain".
> +

NACK until details on how this can co-exist with PSCI is provided.

--
Regards,
Sudeep
