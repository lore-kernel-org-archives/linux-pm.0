Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6DE43CE42;
	Wed,  2 Sep 2026 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348594; cv=none; b=gWiFJcVSs/Bk94NDnM8lTZS09kxn/JmwkowLHRzxnklui1S9Cp1ShJEY57gq4bOB08hbOppJpHCe9NI5lHe/lWD//J1knGV5oVgIRCjE3+XdsoZ5/iCMs35eoPYEVoHguJMQ+zjE5G394SCoqej2suh/xx6NrtSIJBPWvp9MuO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348594; c=relaxed/simple;
	bh=IgtgdDt6OCi3Gt/CasZpVP0tIww1DJE6xBwsdJPD7qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bi2zMdD7Iwn84UJyNvzdNaFv+GXEU5pPw40T5mkIaGe1dMA32qA4so5s+tEdg46rhkSFYS3GI/XedOUKJ9WPE2uEeuybO/MIXPdjaOhtfipYQogJDWEPst8IWVDSNSNShHrj4+FD3rIHCow9DDBfuYVIm8Ywi5HhOuULiygzlVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B731F000E9;
	Wed,  2 Sep 2026 11:29:47 +0000 (UTC)
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
Subject: [PATCH v3 02/12] dt-bindings: power: renesas,r8a78000-mdlc: Add firmware property
Date: Wed,  2 Sep 2026 13:29:18 +0200
Message-ID: <f1bb6566f00a06df7c01f43e5329b754a32620e9.1788338320.git.geert+renesas@glider.be>
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
Module Controller hardware registers must not be accessed directly.
Instead, the SCMI message protocol must be used for inquiry,
configuration, and control of power domains, clocks, and resets.

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
  - Spin off from "dt-bindings: power: Document Renesas R-Car X5H Module
    Controller".
---
 .../devicetree/bindings/power/renesas,r8a78000-mdlc.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
index 1dba1e1b1c5b52d0..27d85dd49f954623 100644
--- a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
@@ -43,6 +43,14 @@ properties:
       and thus identical to the second power domain specifier cell.
     const: 1
 
+  renesas,scmi-firmware:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      On systems where the MDLC must not be accessed directly, but only through
+      an SCMI firmware interface provider, this property must be present and
+      reference the device node that describes the SCMI compliant firmware
+      interface provider to use instead.
+
 required:
   - compatible
   - reg
@@ -58,4 +66,5 @@ examples:
             reg = <0xc3060000 0x1000>;
             #power-domain-cells = <2>;
             #reset-cells = <1>;
+            renesas,scmi-firmware = <&scmi>;
     };
-- 
2.43.0

