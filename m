From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH v2] arm64: dts: sdm845: Add PSCI cpuidle low power states
Date: Fri, 30 Nov 2018 08:41:45 -0700
Message-ID: <20181130154145.GK18262@codeaurora.org>
References: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 30 2018 at 11:23 -0600, Raju P.L.S.S.S.N wrote:
>Add device bindings for cpuidle states for cpu devices.
>
>Cc: <devicetree@vger.kernel.org>
>Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>---
>Changes in v2
> - Address comments from Doug
>---
>---
> arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 62 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>index 0c9a2aa..3a8381e 100644
>--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>@@ -96,6 +96,7 @@
> 			reg = <0x0 0x0>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_0>;
>+			cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
I think it might be better to use 
<&C0_CPU_PD>, <&C0_CPU_RPD>, <&CLUSTER_PD>
> 			L2_0: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -111,6 +112,7 @@
> 			reg = <0x0 0x100>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_100>;
>+			cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
> 			L2_100: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -123,6 +125,7 @@
> 			reg = <0x0 0x200>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_200>;
>+			cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
> 			L2_200: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -135,6 +138,7 @@
> 			reg = <0x0 0x300>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_300>;
>+			cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
> 			L2_300: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -147,6 +151,7 @@
> 			reg = <0x0 0x400>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_400>;
>+			cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
> 			L2_400: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -159,6 +164,7 @@
> 			reg = <0x0 0x500>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_500>;
>+			cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
> 			L2_500: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -171,6 +177,7 @@
> 			reg = <0x0 0x600>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_600>;
>+			cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
> 			L2_600: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
>@@ -183,11 +190,66 @@
> 			reg = <0x0 0x700>;
> 			enable-method = "psci";
> 			next-level-cache = <&L2_700>;
>+			cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
> 			L2_700: l2-cache {
> 				compatible = "cache";
> 				next-level-cache = <&L3_0>;
> 			};
> 		};
>+
>+		idle-states {
>+			entry-method = "psci";
>+
>+			C0_CPU_PD: c0-power-down {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x40000003>;
>+				entry-latency-us = <350>;
>+				exit-latency-us = <461>;
>+				min-residency-us = <1890>;
>+				local-timer-stop;
>+				idle-state-name = "power-down";
>+			};
>+
>+			C0_CPU_RPD: c0-rail-power-down {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x40000004>;
>+				entry-latency-us = <360>;
>+				exit-latency-us = <531>;
>+				min-residency-us = <3934>;
>+				local-timer-stop;
>+				idle-state-name = "rail-power-down";
>+			};
>+
>+			C4_CPU_PD: c4-power-down {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x40000003>;
>+				entry-latency-us = <264>;
>+				exit-latency-us = <621>;
>+				min-residency-us = <952>;
>+				local-timer-stop;
>+				idle-state-name = "power-down";
>+			};
>+
>+			C4_CPU_RPD: c4-rail-power-down {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x40000004>;
>+				entry-latency-us = <702>;
>+				exit-latency-us = <1061>;
>+				min-residency-us = <4488>;
>+				local-timer-stop;
>+				idle-state-name = "rail-power-down";
>+			};
>+
>+			CLUSTER_PD: cluster-power-down {
>+				compatible = "arm,idle-state";
>+				arm,psci-suspend-param = <0x400000F4>;
>+				entry-latency-us = <3263>;
>+				exit-latency-us = <6562>;
>+				min-residency-us = <9987>;
>+				local-timer-stop;
>+				idle-state-name = "cluster-power-down";
>+			};
>+		};
> 	};
>
> 	pmu {
>-- 
>QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>of the Code Aurora Forum, hosted by The Linux Foundation.
>
