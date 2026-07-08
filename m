Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E742189A;
	Wed,  8 Jul 2026 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505841; cv=none; b=urJOaEK11gOXQc+1k81rdguiJIDrFq8hrnEZaOJ6UbqDs2YNE41mawhtvExwKJg3szUU7EdUW8mp0hSXn9QACd3/ujIfeEQRF50QvfJvFFz/7mCLuvNvXswJR6LcNkofLr6Iwt6aLf12bpiAFcWhMKKjes/OfcElimRSZYx6w6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505841; c=relaxed/simple;
	bh=OVfjBCOWwIW+n8Ee4eFBGu00ml5ebjzikt+6tjXE/94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4BNtZcLccWk/7va+pCHRrMYlw/7cHF2zHwPSzqloQNdMnK+8CPqxnpMbV3VsCmPLjA5Ah5+aEBewgXkH6b6P/KUm5ePKNVyADORT0y0bS9ngR67GDj0HkFrCp057RomualvLficgSjkUWSs4TI0FDFlCjyQkInHmFac9ntJcw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12BF1F00A3A;
	Wed,  8 Jul 2026 10:17:14 +0000 (UTC)
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
Subject: [PATCH v2 05/10] dt-bindings: clock: renesas,r8a78000-cpg: Add firmware property
Date: Wed,  8 Jul 2026 12:16:23 +0200
Message-ID: <49726acff0fee1c3606e83c4f242ef6aad25b4b8.1783505329.git.geert+renesas@glider.be>
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
  - Spin off from "dt-bindings: clock: Document Renesas R-Car X5H Clock
    Pulse Generator".
---
 .../devicetree/bindings/clock/renesas,r8a78000-cpg.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
index 4e23bba334382346..fc499e7cf52e4f0c 100644
--- a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
@@ -35,6 +35,12 @@ properties:
       <dt-bindings/clock/renesas,r8a78000-cpg.h>.
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
@@ -52,4 +58,5 @@ examples:
             clocks = <&extal_clk>, <&extalr_clk>;
             clock-names = "extal", "extalr";
             #clock-cells = <1>;
+            firmware = <&scmi>;
     };
-- 
2.43.0

