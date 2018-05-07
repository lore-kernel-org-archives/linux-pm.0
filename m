From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 10/14] dt-bindings: qcom_spmi: Add support for SAW
 documentation
Date: Mon, 7 May 2018 11:07:37 -0500
Message-ID: <20180507160737.GA16495@rob-hp-laptop>
References: <1525348355-25471-1-git-send-email-ilialin@codeaurora.org>
 <1525348355-25471-11-git-send-email-ilialin@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1525348355-25471-11-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org, amit.kucheria@linaro.org, nicolas.dechesne@linaro.org, celster@codeaurora.org, tfinkel@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 03, 2018 at 02:52:31PM +0300, Ilia Lin wrote:
> Add support for SAW controlled regulators.
> The regulators defined as SAW controlled in the device tree
> will be controlled through special CPU registers instead of direct
> SPMI accesses.
> This is required especially for CPU supply regulators to synchronize
> with clock scaling and for Automatic Voltage Switching.
> Document it.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  .../bindings/regulator/qcom,spmi-regulator.txt     | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
