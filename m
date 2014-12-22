From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v5 4/7] iio: da9150: Add DT binding documentation for GPADC
Date: Mon, 22 Dec 2014 16:51:20 +0000
Message-ID: <a460e5a2a156b2097167df04a79bb73d450e3557.1419264383.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1419264383.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1419264383.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 .../devicetree/bindings/iio/adc/da9150-gpadc.txt         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
new file mode 100644
index 0000000..c07228d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
@@ -0,0 +1,16 @@
+Dialog Semiconductor DA9150 IIO GPADC bindings
+
+Required properties:
+- compatible: "dlg,da9150-gpadc" for DA9150 IIO GPADC
+- #io-channel-cells: Should be set to <1>
+  (See Documentation/devicetree/bindings/iio/iio-bindings.txt for further info)
+
+For further information on GPADC channels, see device datasheet.
+
+
+Example:
+
+	gpadc: da9150-gpadc {
+		compatible = "dlg,da9150-gpadc";
+		#io-channel-cells = <1>;
+	};
--
1.9.3
