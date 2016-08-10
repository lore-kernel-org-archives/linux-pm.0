From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
Date: Wed, 10 Aug 2016 16:14:59 +0100
Message-ID: <99e35b6c-6698-6d27-f4d7-fa032796869e@arm.com>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lina Iyer <lina.iyer@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, khilman@kernel.org, rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org, Axel Haslam <ahaslam+renesas@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>, Brendan Jackman <Brendan.Jackman@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, andy.gross@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Lina,

I have few concerns mainly due to the lack of description and not the 
binding per say.

On 05/08/16 00:04, Lina Iyer wrote:
> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>
> Update DT bindings to describe idle states of PM domains.
>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> [Lina: Added state properties, removed state names, wakeup-latency,
> added of_pm_genpd_init() API, pruned commit text]
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> [Ulf: Moved around code to make it compile properly, rebased on top of multiple state support]
> ---
>  .../devicetree/bindings/power/power_domain.txt     | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index 025b5e7..4960486 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -29,6 +29,10 @@ Optional properties:
>     specified by this binding. More details about power domain specifier are
>     available in the next section.
>
> +- domain-idle-states : A phandle of an idle-state that shall be soaked into a
> +                generic domain power state. The idle state definitions are
> +                compatible with arm,idle-state specified in [1].
> +

So I assume these can be used for the genpd states. Either we rename it 
domain-power-states or make it clear that these domain-idle-states can 
also represent the power-states for normal devices.

>  Example:
>
>  	power: power-controller@12340000 {
> @@ -59,6 +63,57 @@ The nodes above define two power controllers: 'parent' and 'child'.
>  Domains created by the 'child' power controller are subdomains of '0' power
>  domain provided by the 'parent' power controller.
>
> +Example 3: ARM v7 style CPU PM domains (Linux domain controller)
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7", "arm,armv7";
> +			reg = <0x0>;
> +			power-domains = <&a7_pd>;

This example doesn't consider how do we deal with the presence off
cpu-idle-states property in CPU nodes.

IMO we need move even the cpu/core level idle states into its own power
domain. It also helps to solve other usecases like PMU, debug/coresight
devices attached to the core power domain(in most of the cases) while
they may be in separate PD like PMUs on OMAP. That will help OS whether
to save/restore the states on idle-entry.

In [PATCH v3 15/15] ARM64: dts: Define CPU power domain for MSM8916, the
idle-states are split across the cpu cpu-idle-states and pd
domain-idle-states property. That looks like a really mess to me.

We need to have all the idle state information at one place and in this
case PD seems more appropriate instead of splitting them across.

We can also keep the code clean and not break compatibility. Whenever
both PD and CPU contains idle-states, PD must take precedence.

Also these needs to be documented clearly in the binding.

> +		};
> +
> +		CPU1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15", "arm,armv7";
> +			reg = <0x0>;
> +			power-domains = <&a15_pd>;
> +		};
> +	};
> +
> +	pm-domains {
> +		a15_pd: a15_pd {
> +			/* will have A15 platform ARM_PD_METHOD_OF_DECLARE*/

the above comment make no sense in the binding document, remove it

-- 
Regards,
Sudeep
