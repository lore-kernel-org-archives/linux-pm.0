From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 08/11] dt-bindings: PM / OPP: add opp-throttlers property
Date: Thu,  7 Jun 2018 11:12:11 -0700
Message-ID: <20180607181214.30338-9-mka@chromium.org>
References: <20180607181214.30338-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607181214.30338-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

The optional opp-throttlers property is used to configure the throttlers
(see drivers/misc/throttler/*) that use a given OPP to throttle the
corresponding device(s).

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- patch added to series

 Documentation/devicetree/bindings/opp/opp.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 4e4f30288c8b..b10240f07d30 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -167,6 +167,9 @@ Optional properties:
   functioning of the current device at the current OPP (where this property is
   present).
 
+- opp-throttlers: Array with phandles of throttlers that use this OPP to
+  throttle the corresponding device(s).
+
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 / {
-- 
2.18.0.rc1.242.g61856ae69a-goog
