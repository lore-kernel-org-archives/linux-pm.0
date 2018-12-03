From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v11 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Date: Mon, 3 Dec 2018 17:09:07 -0600
Message-ID: <20181203230907.GA17086@bogus>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-2-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543722903-10989-2-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 02, 2018 at 09:25:02AM +0530, Taniya Das wrote:
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by the hardware engine.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 +++++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..2b82965
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,172 @@
> +Qualcomm Technologies, Inc. CPUFREQ Bindings
> +
> +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> +SoCs to manage frequency in hardware. It is capable of controlling frequency
> +for multiple clusters.
> +
> +Properties:
> +- compatible
> +	Usage:		required
> +	Value type:	<string>
> +	Definition:	must be "qcom,cpufreq-hw".
> +
> +- clocks
> +	Usage:		required
> +	Value type:	<phandle> From common clock binding.
> +	Definition:	clock handle for XO clock and GPLL0 clock.
> +
> +- clock-names
> +	Usage:		required
> +	Value type:	<string> From common clock binding.
> +	Definition:	must be "xo", "alternate".
> +
> +- reg
> +	Usage:		required
> +	Value type:	<prop-encoded-array>
> +	Definition:	Addresses and sizes for the memory of the HW bases in
> +			each frequency domain.
> +- reg-names
> +	Usage:		Optional
> +	Value type:	<string>
> +	Definition:	Frequency domain name i.e.
> +			"freq-domain0", "freq-domain1".
> +
> +- freq-domain-cells:

#freq-domain-cells

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
