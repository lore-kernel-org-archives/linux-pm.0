From: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v16 03/11] ARM: cpuidle: qcom: Add documentation for qcom cpuidle states
Date: Tue, 17 Mar 2015 16:33:43 -0600
Message-ID: <1426631631-56937-4-git-send-email-lina.iyer@linaro.org>
References: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426631631-56937-1-git-send-email-lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, msivasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add documentation for cpuidle states of QCOM cpus. In addition to
arm-idle-state compatible string, the ARM idle state definition must
define one of the following compatible strings -
	"qcom,idle-state-ret",
	"qcom,idle-state-spc",
	"qcom,idle-state-pc",

The compatibles helps the SPM platform driver to use the correct idle
function when the index to the idle state is passed to the platform
driver.

Signed-off-by: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 .../bindings/arm/msm/qcom,idle-state.txt           | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
new file mode 100644
index 0000000..06df04c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
@@ -0,0 +1,84 @@
+QCOM Idle States for cpuidle driver
+
+ARM provides idle-state node to define the cpuidle states, as defined in [1].
+cpuidle-qcom is the cpuidle driver for Qualcomm SoCs and uses these idle
+states. Idle states have different enter/exit latency and residency values.
+The idle states supported by the QCOM SoC are defined as -
+
+    * Standby
+    * Retention
+    * Standalone Power Collapse (Standalone PC or SPC)
+    * Power Collapse (PC)
+
+Standby: Standby does a little more in addition to architectural clock gating.
+When the WFI instruction is executed the ARM core would gate its internal
+clocks. In addition to gating the clocks, QCOM cpus use this instruction as a
+trigger to execute the SPM state machine. The SPM state machine waits for the
+interrupt to trigger the core back in to active. This triggers the cache
+hierarchy to enter standby states, when all cpus are idle. An interrupt brings
+the SPM state machine out of its wait, the next step is to ensure that the
+cache hierarchy is also out of standby, and then the cpu is allowed to resume
+execution. This state is defined as a generic ARM WFI state by the ARM cpuidle
+driver and is not defined in the DT. The SPM state machine should be
+configured to execute this state by default and after executing every other
+state below.
+
+Retention: Retention is a low power state where the core is clock gated and
+the memory and the registers associated with the core are retained. The
+voltage may be reduced to the minimum value needed to keep the processor
+registers active. The SPM should be configured to execute the retention
+sequence and would wait for interrupt, before restoring the cpu to execution
+state. Retention may have a slightly higher latency than Standby.
+
+Standalone PC: A cpu can power down and warmboot if there is a sufficient time
+between the time it enters idle and the next known wake up. SPC mode is used
+to indicate a core entering a power down state without consulting any other
+cpu or the system resources. This helps save power only on that core.  The SPM
+sequence for this idle state is programmed to power down the supply to the
+core, wait for the interrupt, restore power to the core, and ensure the
+system state including cache hierarchy is ready before allowing core to
+resume. Applying power and resetting the core causes the core to warmboot
+back into Elevation Level (EL) which trampolines the control back to the
+kernel. Entering a power down state for the cpu, needs to be done by trapping
+into a EL. Failing to do so, would result in a crash enforced by the warm boot
+code in the EL for the SoC. On SoCs with write-back L1 cache, the cache has to
+be flushed in s/w, before powering down the core.
+
+Power Collapse: This state is similar to the SPC mode, but distinguishes
+itself in that the cpu acknowledges and permits the SoC to enter deeper sleep
+modes. In a hierarchical power domain SoC, this means L2 and other caches can
+be flushed, system bus, clocks - lowered, and SoC main XO clock gated and
+voltages reduced, provided all cpus enter this state.  Since the span of low
+power modes possible at this state is vast, the exit latency and the residency
+of this low power mode would be considered high even though at a cpu level,
+this essentially is cpu power down. The SPM in this state also may handshake
+with the Resource power manager (RPM) processor in the SoC to indicate a
+complete application processor subsystem shut down.
+
+The idle-state for QCOM SoCs are distinguished by the compatible property of
+the idle-states device node.
+
+The devicetree representation of the idle state should be -
+
+Required properties:
+
+- compatible: Must be one of -
+			"qcom,idle-state-ret",
+			"qcom,idle-state-spc",
+			"qcom,idle-state-pc",
+		and "arm,idle-state".
+
+Other required and optional properties are specified in [1].
+
+Example:
+
+	idle-states {
+		CPU_SPC: spc {
+			compatible = "qcom,idle-state-spc", "arm,idle-state";
+			entry-latency-us = <150>;
+			exit-latency-us = <200>;
+			min-residency-us = <2000>;
+		};
+	};
+
+[1]. Documentation/devicetree/bindings/arm/idle-states.txt
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
