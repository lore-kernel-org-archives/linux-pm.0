From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] thermal: qcom: tsens: Allow number of sensors to come
 from DT
Date: Tue, 22 May 2018 15:14:17 -0500
Message-ID: <20180522201417.GA19576@rob-hp-laptop>
References: <20180507235339.8836-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180507235339.8836-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 07, 2018 at 04:53:39PM -0700, Bjorn Andersson wrote:
> For platforms that has multiple copies of the TSENS hardware block it's
> necessary to be able to specify the number of sensors per block in DeviceTree.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt       |  1 +

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/thermal/qcom/tsens.c                         | 12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
