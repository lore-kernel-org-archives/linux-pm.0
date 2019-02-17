From: Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 3/7] dt-bindings: power: supply: Add voltage-max-design-microvolt property
Date: Sun, 17 Feb 2019 15:29:12 +0100
Message-ID: <20190217142914.17433-3-contact@artur-rojek.eu>
References: <20190217142914.17433-1-contact@artur-rojek.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190217142914.17433-1-contact@artur-rojek.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Artur Rojek <contact@artur-rojek.eu>
List-Id: linux-pm@vger.kernel.org

Add documentation for the "voltage-max-design-microvolt" property.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 Documentation/devicetree/bindings/power/supply/battery.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 89871ab8c704..5c913d4cf36c 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -16,6 +16,7 @@ Required Properties:
 
 Optional Properties:
  - voltage-min-design-microvolt: drained battery voltage
+ - voltage-max-design-microvolt: fully charged battery voltage
  - energy-full-design-microwatt-hours: battery design energy
  - charge-full-design-microamp-hours: battery design capacity
  - precharge-current-microamp: current for pre-charge phase
@@ -48,6 +49,7 @@ Example:
 	bat: battery {
 		compatible = "simple-battery";
 		voltage-min-design-microvolt = <3200000>;
+		voltage-max-design-microvolt = <4200000>;
 		energy-full-design-microwatt-hours = <5290000>;
 		charge-full-design-microamp-hours = <1430000>;
 		precharge-current-microamp = <256000>;
-- 
2.20.1
