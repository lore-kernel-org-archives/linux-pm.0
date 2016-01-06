From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 4/4] thermal: power_allocator: document k_pu_ratio/k_po_ratio
Date: Wed,  6 Jan 2016 16:53:48 +0800
Message-ID: <1452070428-2567-5-git-send-email-leo.yan@linaro.org>
References: <1452070428-2567-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452070428-2567-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

Document k_pu_ratio and k_po_ratio's purpose, and refine formula to
demonstrate to use ratio to calculate k_pu/k_po.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/thermal/power_allocator.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/thermal/power_allocator.txt b/Documentation/thermal/power_allocator.txt
index a1ce223..8958dab 100644
--- a/Documentation/thermal/power_allocator.txt
+++ b/Documentation/thermal/power_allocator.txt
@@ -114,13 +114,20 @@ whilst temperature is low, and may lead to temperature overshooting.
 
 The default value for `k_pu` is:
 
-    2 * sustainable_power / (desired_temperature - switch_on_temp)
+    k_pu_ratio * sustainable_power / (desired_temperature - switch_on_temp)
 
 This means that at `switch_on_temp` the output of the controller's
-proportional term will be 2 * `sustainable_power`.  The default value
-for `k_po` is:
+proportional term will be k_pu_ratio * `sustainable_power`.
 
-    sustainable_power / (desired_temperature - switch_on_temp)
+The default value for `k_po` is:
+
+    k_po_ratio * sustainable_power / (desired_temperature - switch_on_temp)
+
+k_pu_ratio's default value is 2 and k_po_ratio's default value is 1.
+These two vairants mean the ratio value compared against sustainable power,
+so smaller ratio will result in thermal slower ramp. User can set these two
+ratio value from sys filesystem nodes, finally k_pu and k_po will be
+calculated by updated ratio value.
 
 Focusing on the proportional and feed forward values of the PID
 controller equation we have:
-- 
1.9.1
