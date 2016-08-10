From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v3 15/15] ARM64: dts: Define CPU power domain for MSM8916
Date: Wed, 10 Aug 2016 11:35:43 -0600
Message-ID: <20160810173543.GB1401@linaro.org>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-16-git-send-email-lina.iyer@linaro.org>
 <aae203cd-35ee-958f-bc59-b9d53c32aeb2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <aae203cd-35ee-958f-bc59-b9d53c32aeb2@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, khilman@kernel.org, sboyd@codeaurora.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, Brendan Jackman <Brendan.Jackman@arm.com>, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 10 2016 at 09:27 -0600, Sudeep Holla wrote:
>
>
>On 05/08/16 00:05, Lina Iyer wrote:
>>Define power domain and the power states for the domain as defined by
>>the PSCI firmware.
>
>>The 8916 firmware supports OS initiated method of
>>powering off the CPU clusters.
>
>How is that related to the this DTS change, more details below ?
>
>>
>>Cc: <devicetree@vger.kernel.org>
>>Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>---
>> arch/arm64/boot/dts/qcom/msm8916.dtsi | 27 +++++++++++++++++++++++++++
>> 1 file changed, 27 insertions(+)
>>
>>diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>>index 3029773..eb0aaed 100644
>>--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
>>+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>>@@ -64,6 +64,7 @@
>> 			next-level-cache = <&L2_0>;
>> 			enable-method = "psci";
>> 			cpu-idle-states = <&CPU_SPC>;
>>+			power-domains = <&CPU_PD>;
>
>This is really messy. We need to have idle state information at one 
>place. I prefer to have a hierarchal representation of power-domains
>for CPU with idle-states at each level.
>
>> 		};
I see where are going with that. We need to then isolate idle states
from all devices (including CPU) and put them under the umberella of the
domain/parent idle states.

We also need to remember that domain idle states are not just for CPU
domains. There are generic PM domains that also define their idle
states. For some, that hierarchy may not make sense. So forcing it on
all domains is not correct as well.

>>
>> 		CPU1: cpu@1 {
>>@@ -73,6 +74,7 @@
>> 			next-level-cache = <&L2_0>;
>> 			enable-method = "psci";
>> 			cpu-idle-states = <&CPU_SPC>;
>>+			power-domains = <&CPU_PD>;
>> 		};
>>
>> 		CPU2: cpu@2 {
>>@@ -82,6 +84,7 @@
>> 			next-level-cache = <&L2_0>;
>> 			enable-method = "psci";
>> 			cpu-idle-states = <&CPU_SPC>;
>>+			power-domains = <&CPU_PD>;
>> 		};
>>
>> 		CPU3: cpu@3 {
>>@@ -91,6 +94,7 @@
>> 			next-level-cache = <&L2_0>;
>> 			enable-method = "psci";
>> 			cpu-idle-states = <&CPU_SPC>;
>>+			power-domains = <&CPU_PD>;
>> 		};
>>
>> 		L2_0: l2-cache {
>>@@ -113,6 +117,29 @@
>> 	psci {
>> 		compatible = "arm,psci-1.0";
>> 		method = "smc";
>
>Why is it inside PSCI node ? I don't see a need for that.
>If it needs to be here, then amend the binding document.
>
It is described in patch 13/15.

It is inside PSCI node, because PSCI has the domain controller.

>>+
>>+		CPU_PD: cpu-pd@0 {
>>+			#power-domain-cells = <0>;
>>+			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;
>>+		};
>>+
>>+		domain-states {
>>+			CLUSTER_RET: domain_ret {
>>+				compatible = "arm,idle-state";
>>+				arm,psci-suspend-param = <0x1000010>;
>>+				entry-latency-us = <500>;
>>+				exit-latency-us = <500>;
>>+				min-residency-us = <2000>;
>>+			};
>>+
>>+			CLUSTER_PWR_DWN: domain_gdhs {
>>+				compatible = "arm,idle-state";
>>+				arm,psci-suspend-param = <0x1000030>;
>>+				entry-latency-us = <2000>;
>>+				exit-latency-us = <2000>;
>>+				min-residency-us = <6000>;
>>+			};
>>+		};
>
>So how do you collapse these states into the cpu level states ?
Why do you have to collapse?

>We should be able to cope up with platform co-ordinated mode of idle.
>For me, this binding and the representation here is designed only to
>address OS co-ordinated mode of idle support but it should be other way
>around. Design the bindings that can cater any mode (platform and OS
>co-ordinated)
As explained to Brendan on the version2 of the series, OSI and PC are
orthagonal to each other. The idle state definition in the devicetree
exactly matches the unique approaches of these 2 modes.

In platform coordinated, the CPU determines the idle state of the domain
and selects the state, hence it makes sense to extend the
cpu-idle-states to cover those domain states.

In OSI, the CPUs only determine their idle states. When they are done
with their idle state, they bubble up and let the domain choose its idle
state and therefore the domain-idle-states is part of the domain
controller.

With this addition platform coordinated representation is not broken. If
your SoC supports both platform and os modes, then you can specify the
idle states of both of them in the DT. The clause in firmware/psci.c
will however, choose OSI if its available. I am not sure we want to
dynamically switch betweeen OSI and PC at runtime.

Thanks,
Lina
