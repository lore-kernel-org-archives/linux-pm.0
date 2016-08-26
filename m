From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC/PATCH] dt: bindings: Define bindings for device idle states
Date: Fri, 26 Aug 2016 12:24:33 +0200
Message-ID: <1472207073-4901-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34838 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753003AbcHZKYu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2016 06:24:50 -0400
Received: by mail-lf0-f44.google.com with SMTP id f93so53567967lfi.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2016 03:24:49 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Brendan Jackman <Brendan.Jackman@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Axel Haslam <ahaslam@baylibre.com>, linux-pm@vger.kernel.org

A device may be capable of entering a low power state when it becomes
idle, which should avoid the device from wasting power.

Unfortunate entering a such low power state for a device may often also
come with a cost. This because when a new request is about to be served,
the device must first to be woken up from its low power state. As that may
take a while, the request may suffer from an initial latency.

These so called device idle states are characteristics of the hardware, so
let's define some DT bindings to enable us to describe them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Similar DT bindings has been suggested earlier [1], although Rob raised
primarily two conserns in that approach.

*) The bindings was probably not future proof, some more flexibility was needed.

**) As the bindings also relates to idles states for PM domains, it seemed
reasonable to discuss them at the same time. As there is an ongoing discussion
for that right now [2], I took the opportunity to bring up the discussion for
device idles states again.

[1]
http://www.spinics.net/lists/devicetree/msg120515.html

[2]
http://www.spinics.net/lists/arm-kernel/msg522023.html

---
 .../bindings/power/device-idle-states.txt          | 102 +++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/device-idle-states.txt

diff --git a/Documentation/devicetree/bindings/power/device-idle-states.txt b/Documentation/devicetree/bindings/power/device-idle-states.txt
new file mode 100644
index 0000000..222fafb
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/device-idle-states.txt
@@ -0,0 +1,102 @@
+Device idle states
+========================
+
+A device are often capable of entering a low power state(s) when it becomes
+idle, hence the terminology of device idle states. Entering an idle state for a
+device helps it to avoid wasting power and reduces the leakage of current.
+
+However, entering an idle state for a device may unfortunate often also come
+with a cost, as it could introduce a wakeup latency when a new request needs to
+be served using the device.
+
+Devices may support more than one idle state, where each state could have its
+own specific characteristic on how it impacts power saving, wakeup latency etc.
+
+These DT bindings can be used to describe these device idle states, but also to
+assign the supported idle states to devices.
+
+
+== Device idle states container node ==
+
+The device idle states are defined within a device-idle-states node, which
+provides a container where the device idle states must be listed as device tree
+nodes.
+
+
+== Device idle states nodes ==
+
+To be able to distinguish between different types of device idle states, a
+compatible string is assigned to each type. Currently one type is described,
+but this can be extended to more types if needed.
+
+Each device idle state node represents a device idle state description and must
+be defined as a child of the device idle states container node.
+
+
+== The simple device idle state type ==
+
+For most of the simple devices this type of device idle state, is sufficient to
+be able to describe the device's idle states. The supported properties can be
+extended if needed, although a more complex idle state is probably better
+described by using another type/compatible.
+
+Required properties:
+- compatible:		Must contain "simple-dev, idle-state".
+- entry-latency-ns:	An u32 value in nano-seconds representing the worst case
+			latency required for the device to enter the idle state.
+- exit-latency-ns:	An u32 value in nano-seconds representing the worst case
+			wakeup latency of the device, after entry-latency-ns has
+			passed.
+
+Optional properties:
+- idle-state-name: A string used as a descriptive name for the idle state.
+
+
+== Assigning idle states to devices ==
+
+Required properties:
+ - dev-idle-states:	A list of phandles pointing to the supported
+			device idle states nodes. The list must be ordered as
+			the shallower state - the earlier in the list.
+
+
+== Examples ==
+
+	device-idle-states {
+		RETENTION_0: dev-retention-0 {
+			compatible = "simple-dev,idle-state";
+			entry-latency-ns = <300>;
+			exit-latency-ns = <1000>;
+		};
+
+		SLEEP_0: dev-sleep-0 {
+			compatible = "simple-dev,idle-state";
+			entry-latency-us = <3000>;
+			exit-latency-us = <10000>;
+		};
+
+		SLEEP_1: dev-sleep-1 {
+			compatible = "simple-dev,idle-state";
+			entry-latency-us = <50000>;
+			exit-latency-us = <100000>;
+		};
+	};
+
+	leaky-device@12340000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12340000 0x1000>;
+		dev-idle-states = <&SLEEP_0>;
+	};
+
+	leaky-device@23450000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x23450000 0x1000>;
+		dev-idle-states = <&RETENTION_0>, <&SLEEP_0>;
+	};
+
+	leaky-device@34560000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x34560000 0x1000>;
+		dev-idle-states = <&SLEEP_1>;
+	};
+
-- 
1.9.1

