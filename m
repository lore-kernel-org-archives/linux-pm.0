From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
Date: Wed, 23 May 2018 16:13:43 +0100
Message-ID: <34b510f5-fd0b-2e28-45b0-f200f9f8d2c5@arm.com>
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
 <1526751291-17873-2-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526751291-17873-2-git-send-email-tdas@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, robh@kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Rajendra Nayak <rnayak@codeaurora.org>, Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org, skannan@codeaurora.org, amit.kucheria@linaro.org
List-Id: linux-pm@vger.kernel.org



On 19/05/18 18:34, Taniya Das wrote:
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by firmware.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-fw.txt           | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
> new file mode 100644
> index 0000000..bc912f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
> @@ -0,0 +1,68 @@
> +Qualcomm Technologies, Inc. CPUFREQ Bindings
> +
> +CPUFREQ FW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> +SoCs to manage frequency in hardware. It is capable of controlling frequency
> +for multiple clusters.
> +
> +Properties:
> +- compatible
> +	Usage:		required
> +	Value type:	<string>
> +	Definition:	must be "qcom,cpufreq-fw".
> +

If the firmware is referred with some other name, better to use that
than cpufreq
> +Note that #address-cells, #size-cells, and ranges shall be present to ensure
> +the cpufreq can address a freq-domain registers.
> +
> +A freq-domain sub-node would be defined for the cpus with the following
> +properties:
> +
> +- compatible:
> +	Usage:		required
> +	Value type:	<string>
> +	Definition:	must be "cpufreq".
> +
> +- reg
> +	Usage:		required
> +	Value type:	<prop-encoded-array>
> +	Definition:	Addresses and sizes for the memory of the perf_base
> +			, lut_base and en_base.

Can you explicitly define each one of them ? Either here or in reg-names.

> +- reg-names
> +	Usage:		required
> +	Value type:	<stringlist>
> +	Definition:	Address names. Must be "perf_base", "lut_base",
> +			"en_base".
> +			Must be specified in the same order as the
> +			corresponding addresses are specified in the reg
> +			property.
> +
> +- qcom,cpulist
> +	Usage:		required
> +	Value type:	<phandles of CPU>
> +	Definition:	List of related cpu handles which are under a cluster.
> +

As already mentioned by Rob and Viresh, better to align with OPP style
to avoid phandle list of CPUs.

Also I see similar bindings for devfreq, can't they be aligned ?
E.g. lut_base here while it's ftbl_base in devfreq.

-- 
Regards,
Sudeep

[1] https://lkml.org/lkml/2018/5/18/136
