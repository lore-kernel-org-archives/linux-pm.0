From: Kukjin Kim <kgene@kernel.org>
Subject: RE: [PATCH v5] arm64: dts: exynos7: add support for cpuidle core power
 down
Date: Thu, 27 Nov 2014 16:21:19 +0900
Message-ID: <08b101d00a12$bd15dc80$37419580$@kernel.org>
References: <1415683897-983-1-git-send-email-k.chander@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:26335 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaK0HVW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 02:21:22 -0500
In-reply-to: <1415683897-983-1-git-send-email-k.chander@samsung.com>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Chander Kashyap' <k.chander@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com, rjw@rjwysocki.net

Chander Kashyap wrote:
> 
> Exynos7 supports multiple idle states. Core power down is one such
> idle state, where cores can be powered off independently.
> 
> This patch adds support for core power down idle state.
> 
> Entry latency for core power down idle state is calculated as follows:
> 1. Time difference is measured between cpuidle entry and exit.
> 2. WFI is skipped for measuring the time.
> 3. Select the worst case time in a set of 100000 cpuidle transactions,
>    with varying load.
> 
> Exit latency and min residency values are supplied as per HW team.
> 
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Lorenzo, thanks for your ack. Will apply.

- Kukjin

> ---
> This patch has following dependencies:
> 	- [PATCH v5 0/8] arch: arm64: Enable support for Samsung Exynos7 SoC
> 		www.spinics.net/lists/arm-kernel/msg375961.html
> Changes in v2:
> 	- Moved the cpu-idle-state property after reg property
> 	- removed the status property.
> Changes in v3:
> 	- Added the Entry latency calculation in commit message.
> Changes in v4:
> 	- Corrected the commit message.
> 	- Corrected the entry latency value.
> Changes in v5:
> 	- Commit message modified
> 
>  arch/arm64/boot/dts/exynos/exynos7.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> index d7a37c3..891eef4 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -37,6 +37,7 @@
>  			compatible = "arm,cortex-a57", "arm,armv8";
>  			reg = <0x0>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP>;
>  		};
> 
>  		cpu@1 {
> @@ -44,6 +45,7 @@
>  			compatible = "arm,cortex-a57", "arm,armv8";
>  			reg = <0x1>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP>;
>  		};
> 
>  		cpu@2 {
> @@ -51,6 +53,7 @@
>  			compatible = "arm,cortex-a57", "arm,armv8";
>  			reg = <0x2>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP>;
>  		};
> 
>  		cpu@3 {
> @@ -58,6 +61,20 @@
>  			compatible = "arm,cortex-a57", "arm,armv8";
>  			reg = <0x3>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP>;
> +		};
> +
> +		idle-states {
> +			entry-method = "arm,psci";
> +
> +			CPU_SLEEP: cpu-sleep {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x0010000>;
> +				entry-latency-us = <34>;
> +				exit-latency-us = <150>;
> +				min-residency-us = <2100>;
> +			};
>  		};
>  	};
> 
> --
> 1.9.1

