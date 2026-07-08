Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95933E1231;
	Wed,  8 Jul 2026 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505846; cv=none; b=W/gABqih6mIyi4s0RDCYJx9RAt7sqmHG4Fg1EPdWeavhetWHIeuJnKVhrXbPHpKc7ZKpl44KvuXK3VBP7+yf+GmVeV5yqIaDFX/1xxRksobwAJRGy+rLSkSiR6HEAddDzPNBGGYM7wlkwSOipim1RXBbHSL0xzuyWxKitFocqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505846; c=relaxed/simple;
	bh=k14qa0Ealuf/Y+wH/E+klOEeuZzgrFfDVY3EoFFYPnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMt2/HIpgOrqIi2jsx5lSwqzfozw0W3pZMud0jJpg9FVZk+Hf9qs/phftBGjs+cFoCVEBktGhTa4QfurrNkuDd4MXpA03rBDe+3yWnQUCUzMqkn9keb/gBtQLSD1ozXbswF0Sbx/+9Skpak3rhzGmfQJjZmR/Egte7Hivjj0w90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372341F00A3D;
	Wed,  8 Jul 2026 10:17:20 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 06/10] dt-bindings: power: renesas,r8a78000-mdlc: Add firmware property
Date: Wed,  8 Jul 2026 12:16:24 +0200
Message-ID: <b4d16ddb0c0af56f4103feadb3014e71899edec1.1783505329.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783505329.git.geert+renesas@glider.be>
References: <cover.1783505329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a firmware property, for systems where SCMI must be used instead of
direct hardware access.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Spin off from "dt-bindings: power: Document Renesas R-Car X5H Module
    Controller".
---
 .../devicetree/bindings/power/renesas,r8a78000-mdlc.yaml   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
index 1dba1e1b1c5b52d0..9616f0244415896c 100644
--- a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
@@ -43,6 +43,12 @@ properties:
       and thus identical to the second power domain specifier cell.
     const: 1
 
+  firmware:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Reference to the SCMI firmware device node on systems where SCMI must be
+      used instead of direct hardware access.
+
 required:
   - compatible
   - reg
@@ -58,4 +64,5 @@ examples:
             reg = <0xc3060000 0x1000>;
             #power-domain-cells = <2>;
             #reset-cells = <1>;
+            firmware = <&scmi>;
     };
-- 
2.43.0

