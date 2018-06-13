From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
Date: Wed, 13 Jun 2018 12:26:53 +0100
Message-ID: <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org
List-Id: linux-pm@vger.kernel.org



On 12/06/18 12:02, Taniya Das wrote:
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by firmware.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-fw.txt           | 173 +++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
> new file mode 100644
> index 0000000..e3087ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
> @@ -0,0 +1,173 @@
> +Qualcomm Technologies, Inc. CPUFREQ Bindings
> +
> +CPUFREQ FW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> +SoCs to manage frequency in hardware. It is capable of controlling frequency
> +for multiple clusters.
> +

You are bit inconsistent on the wordings. Some places you refer this as
hardware engine. If so, please drop all references to firmware/FW. If
it's firmware then update accordingly.

> +Properties:
> +- compatible
> +	Usage:		required
> +	Value type:	<string>
> +	Definition:	must be "qcom,cpufreq-fw".
> +
> +* Property qcom,freq-domain
> +Devices supporting freq-domain must set their "qcom,freq-domain" property with
> +phandle to a freq_domain_table in their DT node.
> +
> +* Frequency Domain Table Node
> +
> +This describes the frequency domain belonging to a device.
> +This node can have following properties:
> +
> +- reg
> +	Usage:		required
> +	Value type:	<prop-encoded-array>
> +	Definition:	Addresses and sizes for the memory of the perf
> +			, lut and enable bases.
> +			perf - indicates the base address for the desired
> +			performance state to be set.
> +			lut - indicates the look up table base address for the
> +			cpufreq	driver to read frequencies.
> +			enable - indicates the enable register for firmware.


You still didn't answer my earlier question.

OS might touch one or 2 registers in lots of IP blocks. I am not sure
why those are any different from these. Are you trying to align with any
other bindings or specification. Are you trying to make this binding
generic here ? I understand if it was trying to generalize the firmware
interface, but you also state it's a hardware engine. So I fail to see
the need for such specificity here. Why not define the whole IP block
and the driver knows where to access these specific ones as they are
specific to this hardware block. In that way if you decide to add more
data, it's extensible easily without the need for patching DT.

Eg. Suppose you need some information on power curve for EAS energy
model, I really hate to update DT for that or even do a mix with DT just
because f/w is no longer modifiable.

-- 
Regards,
Sudeep
