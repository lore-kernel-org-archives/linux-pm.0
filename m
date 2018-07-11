From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 6/7] dt: thermal: tsens: Document the fallback DT
 property for v2 of TSENS IP
Date: Wed, 11 Jul 2018 07:49:39 -0600
Message-ID: <20180711134939.GA10268@rob-hp-laptop>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <bf1147fa417314b2fbf5c0cfb682445587fe39bb.1531136000.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bf1147fa417314b2fbf5c0cfb682445587fe39bb.1531136000.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, vivek.gautam@codeaurora.org, andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 09, 2018 at 05:13:28PM +0530, Amit Kucheria wrote:
> We want to create common code for v2 of the TSENS IP block that is used in
> a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
> most of the common functionality start with a common get_temp() function.
> 
> It is also necessary to split out the memory regions for the TM and SROT
> register banks because their offsets are not constant across SoC families.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt     | 25 +++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
