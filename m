From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 02/10] dt-bindings: thermal: Fix a typo in
 documentation
Date: Mon, 13 Aug 2018 15:49:53 -0600
Message-ID: <20180813214953.GA27382@rob-hp-laptop>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <08b528ddc26adcb57539b1ac9d352850d7d80bfb.1533815718.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <08b528ddc26adcb57539b1ac9d352850d7d80bfb.1533815718.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:34PM +0530, Amit Kucheria wrote:
> c(1) + x(1) was actually meant to be c(1) * x(1).
> 
> While we're at it, add some brackets to make it nicer to read.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
