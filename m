From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v5 02/16] dt/bindings: Update binding for PM domain idle
 states
Date: Fri, 2 Sep 2016 13:16:05 -0700
Message-ID: <20160902201605.GA1705@linaro.org>
References: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
 <1472242678-33700-3-git-send-email-lina.iyer@linaro.org>
 <0b233802-f459-c6bb-ff42-70745a225cfb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0b233802-f459-c6bb-ff42-70745a225cfb@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, khilman@kernel.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 02 2016 at 07:21 -0700, Sudeep Holla wrote:
>
>
>On 26/08/16 21:17, Lina Iyer wrote:
>>From: Axel Haslam <ahaslam+renesas@baylibre.com>
>>
>>Update DT bindings to describe idle states of PM domains.
>>
>>Cc: <devicetree@vger.kernel.org>
>>Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
>>Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>[Lina: Added state properties, removed state names, wakeup-latency,
>>added of_pm_genpd_init() API, pruned commit text]
>>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>[Ulf: Moved around code to make it compile properly, rebased on top of multiple state support]
>>---
>> .../devicetree/bindings/power/power_domain.txt     | 57 ++++++++++++++++++++++
>> 1 file changed, 57 insertions(+)
>>
>>diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>>index 025b5e7..4960486 100644
>>--- a/Documentation/devicetree/bindings/power/power_domain.txt
>>+++ b/Documentation/devicetree/bindings/power/power_domain.txt
>>@@ -29,6 +29,10 @@ Optional properties:
>>    specified by this binding. More details about power domain specifier are
>>    available in the next section.
>>
>>+- domain-idle-states : A phandle of an idle-state that shall be soaked into a
>>+                generic domain power state. The idle state definitions are
>>+                compatible with arm,idle-state specified in [1].
>>+
>> Example:
>>
>> 	power: power-controller@12340000 {
>>@@ -59,6 +63,57 @@ The nodes above define two power controllers: 'parent' and 'child'.
>> Domains created by the 'child' power controller are subdomains of '0' power
>> domain provided by the 'parent' power controller.
>>
>>+Example 3: ARM v7 style CPU PM domains (Linux domain controller)
>>+
>>+	cpus {
>>+		#address-cells = <1>;
>>+		#size-cells = <0>;
>>+
>>+		CPU0: cpu@0 {
>>+			device_type = "cpu";
>>+			compatible = "arm,cortex-a7", "arm,armv7";
>>+			reg = <0x0>;
>>+			power-domains = <&a7_pd>;
>>+		};
>>+
>>+		CPU1: cpu@1 {
>>+			device_type = "cpu";
>>+			compatible = "arm,cortex-a15", "arm,armv7";
>>+			reg = <0x0>;
>>+			power-domains = <&a15_pd>;
>>+		};
>>+	};
>>+
>>+	pm-domains {
>>+		a15_pd: a15_pd {
>>+			/* will have A15 platform ARM_PD_METHOD_OF_DECLARE*/
>>+			compatible = "arm,cortex-a15";
>>+			#power-domain-cells = <0>;
>>+			domain-idle-states = <&CLUSTER_SLEEP_0>;
>>+		};
>>+
>>+		a7_pd: a7_pd {
>>+			/* will have a A7 platform ARM_PD_METHOD_OF_DECLARE*/
>>+			compatible = "arm,cortex-a7";
>>+			#power-domain-cells = <0>;
>>+			domain-idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
>>+		};
>>+
>>+		CLUSTER_SLEEP_0: state0 {
>>+			compatible = "arm,idle-state";
>>+			entry-latency-us = <1000>;
>>+			exit-latency-us = <2000>;
>>+			min-residency-us = <10000>;
>>+		};
>>+
>>+		CLUSTER_SLEEP_1: state1 {
>>+			compatible = "arm,idle-state";
>>+			entry-latency-us = <5000>;
>>+			exit-latency-us = <5000>;
>>+			min-residency-us = <100000>;
>>+		};
>>+	};
>>+
>
>This version is *not very descriptive*. Also the discussion we had on v3
>version has not yet concluded IMO. So can I take that we agreed on what
>was proposed there or not ?
>
Sorry, this example is not very descriptive. Pls. check the 8916 dtsi
for the new changes in the following patches. Let me know if that makes
sense.

Thanks,
Lina

>We could have better example above *really* based on the discussions we
>had so far. This example always makes me think it's well crafted to
>avoid any sort of discussions. We need to consider different use-cases
>e.g. what about CPU level states ?
>
>IMO, we need to discuss this DT binding in detail and arrive at some
>conclusion before you take all the troubles to respin the series.
>Also it's better to keep the DT binding separate until we have some
>conclusion instead of posting the implementation for each version.
>That's just my opinion(I would be least bothered about implementation
>until I know it will be accepted before I can peek into the code, others
>may differ.
>
>-- 
>Regards,
>Sudeep
