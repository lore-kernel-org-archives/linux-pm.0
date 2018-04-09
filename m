From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 10/14] dt-bindings: Add support for SAW documentation
Date: Mon, 9 Apr 2018 15:21:44 -0500
Message-ID: <20180409202144.76gjmc6kcn2msffl@rob-hp-laptop>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-11-git-send-email-ilialin@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1522358807-10413-11-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org, amit.kucheria@linaro.org, nicolas.dechesne@linaro.org, celster@codeaurora.org, tfinkel@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 30, 2018 at 12:26:43AM +0300, Ilia Lin wrote:
> Add support for SAW controlled regulators in 8x96.
> Document it.

Perhaps some clue in the subject what subsystem and/or device this 
applies to.

> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  .../bindings/regulator/qcom,spmi-regulator.txt     | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> index 57d2c65..406f2e5 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> @@ -110,6 +110,11 @@ Qualcomm SPMI Regulators
>  	Definition: Reference to regulator supplying the input pin, as
>  		    described in the data sheet.
>  
> +- qcom,saw-reg:
> +	Usage: optional
> +	Value type: <phandle>
> +	Description: Reference to syscon node defining the SAW registers.
> +
>  
>  The regulator node houses sub-nodes for each regulator within the device. Each
>  sub-node is identified using the node's name, with valid values listed for each
> @@ -201,6 +206,17 @@ see regulator.txt - with additional custom properties described below:
>  			2 = 0.55 uA
>  			3 = 0.75 uA
>  
> +- qcom,saw-slave:
> +	Usage: optional
> +	Value type: <boo>
> +	Description: SAW controlled gang slave. Will not be configured.
> +
> +- qcom,saw-leader:
> +	Usage: optional
> +	Value type: <boo>
> +	Description: SAW controlled gang leader. Will be configured as
> +		     SAW regulator.

Would the coupled regulator binding work in this case?

Rob
