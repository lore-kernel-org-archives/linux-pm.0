Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE7473C93;
	Wed,  2 Sep 2026 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348589; cv=none; b=FOkxevYuPUHSdnJu0VFTUF6hZTnY6QtOtgSIWXpFATAsoUPpEJ2hTSlY+1IWqwTVBF95ANG1CEAOKXoD5JXLr4ujTOMFjjNC7t8YqBZUQVPRin4xzveYEQPHwuNVr3EOIlZ2DmrUcc92/Z63Pzne2ZSEfYkhCWpIjNB4Bw7EunQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348589; c=relaxed/simple;
	bh=KTuC1vhsPzJF0Hhes+ZFU0fLx7PtNCTVzxJU43emmDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oB5hgt5IVQbeQf+S6HYAKuZ0MBMEX4go/gDj2ngCIy/L3sluVqGlB0UKA9mo3qJG0jlRHHmNS5SWH/ZYCmvZY7JaEOoy/chH6jGGJMYeWs8UHjDxloEAmfrp2TzgXTgVVpzEQSJASJSf5rumJOFo02enVFldBUyqgKTtkrUc47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FAD1F00A3A;
	Wed,  2 Sep 2026 11:29:42 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>
Cc: devicetree@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 01/12] dt-bindings: clock: renesas,r8a78000-cpg: Add renesas,scmi-firmware property
Date: Wed,  2 Sep 2026 13:29:17 +0200
Message-ID: <2cf42d7ef9b452efbab3007ec2c2340cf87adbbf.1788338320.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788338320.git.geert+renesas@glider.be>
References: <cover.1788338320.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems using the ARM System Control and Management Interface (SCMI),
the Clock Pulse Generator hardware registers must not be accessed
directly.  Instead, the SCMI message protocol must be used for inquiry,
configuration, and control of clocks.

Add a "renesas,scmi-firmware" property to distinguish between systems
with and without SCMI, and to indicate which SCMI firmware interface
provider to communicate with.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Add "renesas" vendor prefix to the property (I still think it
    should be dropped, or replaced by "arm"),
  - Add "scmi-" prefix to the property,
  - Elaborate rationale,
  - Move forward in series,

v2:
  - Spin off from "dt-bindings: clock: Document Renesas R-Car X5H Clock
    Pulse Generator".
---
 .../devicetree/bindings/clock/renesas,r8a78000-cpg.yaml  | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
index 4e23bba334382346..d4123b1d1890c624 100644
--- a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
@@ -35,6 +35,14 @@ properties:
       <dt-bindings/clock/renesas,r8a78000-cpg.h>.
     const: 1
 
+  renesas,scmi-firmware:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      On systems where the CPG must not be accessed directly, but only through
+      an SCMI firmware interface provider, this property must be present and
+      reference the device node that describes the SCMI compliant firmware
+      interface provider to use instead.
+
 required:
   - compatible
   - reg
@@ -52,4 +60,5 @@ examples:
             clocks = <&extal_clk>, <&extalr_clk>;
             clock-names = "extal", "extalr";
             #clock-cells = <1>;
+            renesas,scmi-firmware = <&scmi>;
     };
-- 
2.43.0

