From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v3 1/5] Documentation: add DT binding for ARM System Control and Power Interface(SCPI) protocol
Date: Wed, 27 May 2015 10:53:14 +0100
Message-ID: <1432720398-5701-2-git-send-email-sudeep.holla@arm.com>
References: <1432720398-5701-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432720398-5701-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds devicetree binding for System Control and Power
Interface (SCPI) Message Protocol used between the Application Cores(AP)
and the System Control Processor(SCP). The MHU peripheral provides a
mechanism for inter-processor communication between SCP's M3 processor
and AP.

SCP offers control and management of the core/cluster power states,
various power domain DVFS including the core/cluster, certain system
clocks configuration, thermal sensors and many others.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/arm/arm,scpi.txt | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,scpi.txt

diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
new file mode 100644
index 000000000000..5db235f69e54
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
@@ -0,0 +1,121 @@
+System Control and Power Interface (SCPI) Message Protocol
+----------------------------------------------------------
+
+Required properties:
+
+- compatible : should be "arm,scpi"
+- mboxes: List of phandle and mailbox channel specifiers
+- shmem : List of phandle pointing to the shared memory(SHM) area between the
+	  processors using these mailboxes for IPC, one for each mailbox
+
+See Documentation/devicetree/bindings/mailbox/mailbox.txt
+for more details about the generic mailbox controller and
+client driver bindings.
+
+Clock bindings for the clocks based on SCPI Message Protocol
+------------------------------------------------------------
+
+This binding uses the common clock binding[1].
+
+Required properties:
+- compatible : shall be one of the following:
+	"arm,scpi-clocks" - for the container node with all the clocks
+		based on the SCPI protocol
+	"arm,scpi-dvfs" - all the clocks that are variable and index based.
+		These clocks don't provide the full range between the limits
+		but only discrete points within the range. The firmware
+		provides the mapping for each such operating frequency and the
+		index associated with it. The firmware also manages the
+		voltage scaling appropriately with the clock scaling.
+	"arm,scpi-clk" - all the clocks that are variable and provide full
+		range within the specified range. The firmware provides the
+		supported range for each clock.
+
+Required properties for all clocks(all from common clock binding):
+- #clock-cells : should be set to 1 as each of the SCPI clocks have multiple
+	outputs. The clock specifier will be the index to an entry in the list
+	of output clocks.
+- clock-output-names : shall be the corresponding names of the outputs.
+- clock-indices: The identifyng number for the clocks(clock_id) in the node as
+	expected by the firmware. It can be non linear and hence provide the
+	mapping	of identifiers into the clock-output-names array.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Example:
+
+sram: sram@50000000 {
+	compatible = "arm,juno-sram-ns", "mmio-sram";
+	reg = <0x0 0x50000000 0x0 0x10000>;
+
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0 0x0 0x50000000 0x10000>;
+
+	cpu_scp_lpri: scp-shmem@0 {
+		compatible = "arm,juno-scp-shmem";
+		reg = <0x0 0x200>;
+	};
+
+	cpu_scp_hpri: scp-shmem@200 {
+		compatible = "arm,juno-scp-shmem";
+		reg = <0x200 0x200>;
+	};
+};
+
+mailbox: mailbox0@40000000 {
+	....
+	#mbox-cells = <1>;
+};
+
+scpi_protocol: scpi@2e000000 {
+	compatible = "arm,scpi";
+	mboxes = <&mailbox 0 &mailbox 1>;
+	shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
+
+	clocks {
+		compatible = "arm,scpi-clocks";
+
+		scpi_dvfs: scpi_clocks@0 {
+			compatible = "arm,scpi-dvfs";
+			#clock-cells = <1>;
+			clock-indices = <0>, <1>, <2>;
+			clock-output-names = "vbig", "vlittle", "vgpu";
+		};
+		scpi_clk: scpi_clocks@3 {
+			compatible = "arm,scpi-clk";
+			#clock-cells = <1>;
+			clock-indices = <3>, <4>;
+			clock-output-names = "pxlclk0", "pxlclk1";
+		};
+	};
+};
+
+cpu@0 {
+	...
+	reg = <0 0>;
+	clocks = <&scpi_dvfs 0>;
+	clock-names = "big";
+};
+
+hdlcd@7ff60000 {
+	...
+	reg = <0 0x7ff60000 0 0x1000>;
+	clocks = <&scpi_clk 1>;
+	clock-names = "pxlclk";
+};
+
+In the above example, the #clock-cells is set to 1 as required.
+scpi_dvfs has 3 output clocks namely: vbig, vlittle and vgpu with 0, 1
+and 2 as clock-indices. scpi_clk has 2 output clocks namely: pxlclk0 and
+pxlclk1 with 3 and 4 as clock-indices.
+
+The first consumer in the example is cpu@0 and it has vbig as input clock.
+The index '0' in the clock specifier here points to the first entry in the
+output clocks of scpi_dvfs for which clock_id asrequired by the firmware
+is 0.
+
+Similarly the second example is hdlcd@7ff60000 and it has pxlclk0 as input
+clock. The index '1' in the clock specifier here points to the second entry
+in the output clocks of scpi_clocks for which clock_id as required by the
+firmware is 4.
-- 
1.9.1
