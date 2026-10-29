Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279484;
	b=2epPnthaDaT/DVkyR7AsFA384dfC/uUAoy6enr0L8ayy7Kplo4r2H3qBeY+bmWmcCL4r
	 BmD5vDMcRsTxtiCEAhrLU3EcgjuER2uDNbGdv4z0TekWior+5NfChLzmCLtSJnkQAGXNW
	 ZD0B+X32SQw2GRypAV0OLkSDZ+vpm8JcaNqAcrxRfPVC2cywKa+FwN9TzO38yrMN2p/L1
	 cQ3IKkNomYrCOMYYzei1DZbaYnHKO5LoZjZ5NOODZsuon6CfZJ63nBeQ8I3P+HWAkqhTP
	 qw44wa+ZenoQobWduPnUzNHjIbIasqZd36y1+ETVikfgofmnGLgvgFYYb/0Z2AbEthg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279484;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=7D4WWcgpY9Rx/WzLn/080IBar+xdg1pQrFCdgvE70ME=;
	b=GR/CiRy5sRLIZXzy0Ei7yyA+x7Rk4OrDIoiFxl8+PgEE0M3XRZ3fwQ/yG84Z3GrxqEKs
	 p/dxUsjSjqJtmKz/Y9jVYd/dTfP86iZ7NXON8Sgl0kUGDlVUD+tCdo/hmX64BD7IXOQ0C
	 EtcybCBnlSoavTHO8Ff7ROVRmH0o0StkAeOxP7FehVehNlG7zozp4xOxqYepW8CR+cgIW
	 knP2NYEke9oRWygRS1W2MYzD8jF4YWy+TJ19A2gtc7bd0ECnbbL3xc90va743xUqRLk1w
	 z/2TbwBvG/wsJl/GU5ANTTSFxOAsmxVnd6JaIuweTcDsT+p29Gn+iySjgZzrY+6VIxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C22606A31C;
	Thu, 29 Oct 2026 13:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451851F01829;
	Thu, 29 Oct 2026 13:11:20 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Biju Das <biju.das.au@gmail.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 1/9] dt-bindings: can: renesas,rcar-canfd: Document R-Car X5H support
Date: Thu, 29 Oct 2026 14:11:02 +0100
Message-ID: <2b91003767a4089e21d8fdaf9892aa99d0fcd45c.1793278754.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793278754.git.geert+renesas@glider.be>
References: <cover.1793278754.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for the Controller Area Network Flexible Data Rate
(CAN-FD) modules as found on R-Car X5H, which is the first member of the
R-Car Gen5 family.  It is a further evolution of the CAN-FD block found
on R-Car Gen4 SoCs, adding Freedom From Interference and Virtual Machine
support.

Binding-wise, the major difference is the split of global and
per-channel interrupts (like on RZ/G2L), and the addition of Virtual
Machine interrupts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Do we need the VM interrupts, or are they meant for the hypervisor?
If yes, should we add a third option for interrupts and interrupt-names:
  - 2 global interrupts,
  - 8 VM interrupts,
  - 8 (= number of channels) x 3 channel interrupts,
so we can easily restrict the number of interrupts when a variant with
less than 8 channels appears?
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 470d178e5faccf6a..2d36d63b281e30b2 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -40,6 +40,11 @@ properties:
               - renesas,r8a779h0-canfd     # R-Car V4M
           - const: renesas,rcar-gen4-canfd # R-Car Gen4
 
+      - items:
+          - enum:
+              - renesas,r8a78000-canfd     # R-Car X5H
+          - const: renesas,rcar-gen5-canfd # R-Car Gen5
+
       - items:
           - enum:
               - renesas,r9a07g043-canfd    # RZ/G2UL and RZ/Five
@@ -86,6 +91,36 @@ properties:
           - description: CAN5 error interrupt
           - description: CAN5 transmit interrupt
           - description: CAN5 transmit/receive FIFO receive completion interrupt
+          - description: CAN6 error interrupt
+          - description: CAN6 transmit interrupt
+          - description: CAN6 transmit/receive FIFO receive completion interrupt
+          - description: CAN7 error interrupt
+          - description: CAN7 transmit interrupt
+          - description: CAN7 transmit/receive FIFO receive completion interrupt
+          - description: Virtual Machine 0 transmit interrupt
+          - description: Virtual Machine 0 receive interrupt
+          - description: Virtual Machine 0 error interrupt
+          - description: Virtual Machine 1 transmit interrupt
+          - description: Virtual Machine 1 receive interrupt
+          - description: Virtual Machine 1 error interrupt
+          - description: Virtual Machine 2 transmit interrupt
+          - description: Virtual Machine 2 receive interrupt
+          - description: Virtual Machine 2 error interrupt
+          - description: Virtual Machine 3 transmit interrupt
+          - description: Virtual Machine 3 receive interrupt
+          - description: Virtual Machine 3 error interrupt
+          - description: Virtual Machine 4 transmit interrupt
+          - description: Virtual Machine 4 receive interrupt
+          - description: Virtual Machine 4 error interrupt
+          - description: Virtual Machine 5 transmit interrupt
+          - description: Virtual Machine 5 receive interrupt
+          - description: Virtual Machine 5 error interrupt
+          - description: Virtual Machine 6 transmit interrupt
+          - description: Virtual Machine 6 receive interrupt
+          - description: Virtual Machine 6 error interrupt
+          - description: Virtual Machine 7 transmit interrupt
+          - description: Virtual Machine 7 receive interrupt
+          - description: Virtual Machine 7 error interrupt
         minItems: 8
 
   interrupt-names:
@@ -114,6 +149,36 @@ properties:
           - const: ch5_err
           - const: ch5_rec
           - const: ch5_trx
+          - const: ch6_err
+          - const: ch6_rec
+          - const: ch6_trx
+          - const: ch7_err
+          - const: ch7_rec
+          - const: ch7_trx
+          - const: vm0_tx
+          - const: vm0_rx
+          - const: vm0_err
+          - const: vm1_tx
+          - const: vm1_rx
+          - const: vm1_err
+          - const: vm2_tx
+          - const: vm2_rx
+          - const: vm2_err
+          - const: vm3_tx
+          - const: vm3_rx
+          - const: vm3_err
+          - const: vm4_tx
+          - const: vm4_rx
+          - const: vm4_err
+          - const: vm5_tx
+          - const: vm5_rx
+          - const: vm5_err
+          - const: vm6_tx
+          - const: vm6_rx
+          - const: vm6_err
+          - const: vm7_tx
+          - const: vm7_rx
+          - const: vm7_err
         minItems: 8
 
   clocks:
@@ -232,6 +297,22 @@ allOf:
         resets:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rcar-gen5-canfd
+    then:
+      properties:
+        interrupts:
+          minItems: 50
+
+        interrupt-names:
+          minItems: 50
+
+        resets:
+          maxItems: 1
+
   - if:
       properties:
         compatible:
@@ -241,9 +322,11 @@ allOf:
       properties:
         interrupts:
           minItems: 20
+          maxItems: 20
 
         interrupt-names:
           minItems: 20
+          maxItems: 20
 
         resets:
           minItems: 2
@@ -354,6 +437,7 @@ allOf:
             enum:
               - renesas,rcar-gen3-canfd
               - renesas,rcar-gen4-canfd
+              - renesas,rcar-gen5-canfd
     then:
       required:
         - resets
-- 
2.43.0

