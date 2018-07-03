From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 4/6] thermal: tsens: Add support for SDM845
Date: Tue, 3 Jul 2018 10:26:20 -0600
Message-ID: <20180703162619.GA17238@rob-hp-laptop>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <43e3ae530334efab3fa0151430879f03731e9daa.1530533998.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43e3ae530334efab3fa0151430879f03731e9daa.1530533998.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, vivek.gautam@codeaurora.org, andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 02, 2018 at 06:14:07PM +0530, Amit Kucheria wrote:
> SDM845 uses v2.4.0 of the TSENS IP block but the get_temp() function
> appears to be identical across v2.x.y in code seen so far. We use the
> generic get_temp() function.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 2 ++
>  drivers/thermal/qcom/tsens-v2.c                          | 6 +++++-
>  drivers/thermal/qcom/tsens.c                             | 6 ++++++
>  drivers/thermal/qcom/tsens.h                             | 5 ++++-
>  4 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> index 06195e8..075182e 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -5,6 +5,8 @@ Required properties:
>   - "qcom,msm8916-tsens" : For 8916 Family of SoCs
>   - "qcom,msm8974-tsens" : For 8974 Family of SoCs
>   - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> + - "qcom,tsens-v2.4.0"  : For SDM845 Family of SoCs
> + - "qcom,tsens-v2"      : Generic fallback binding for any Soc using 2.x.y version of the tsens IP

You need to show what are valid combinations of compatibles. Does v2 
apply to 8996? One valid combination per line.

Rob
