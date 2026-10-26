Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026544;
	b=ekzI8VuLh6x76ezRJuGLxNZkXpVSE7yiOIjcEjpV/2c+4OlZ91kwnNhYx1ZGMqqNkkck
	 VHTQBaxOcjsLRn5gEBtvG5/C25mXgbN6yAv8c0XYmhrY9DRw0Q7PyrUJzmGw/HLqfWb04
	 JtBRErAjYqDCLu/B3gFO7JblhR8sT0+xKMxYwJFhkK7GCiUJj5Uj7BZHV1S8JSlgkd+p6
	 gbEcIrraRXJHuNUHiNhri8TNMTrIrc7lIoYOhAy/8EJUF2rqY1PtzDOukfA0H7rDmKy+w
	 2MWtCLqVp24r6MD9YfJ/KcAUjO4ET7l3/I1dxqQiQutQjK/zNcwOg+iGjU3qOSPADrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026544;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Bkr7NxOTzxC5Z0kfnHtPBn5MNEZeRCbawudmN91sFJM=;
	b=rI2FNh+SwD1Q8y6TP7lDbH2sICuiauRkQhTChRgF0dYRxSLjNxT6VXn2v7BDv9iXlq70
	 6gXiKoftFjQN9O6+x+kpKQaqH/q19yZyxfyN0y9T4242fpCBa/2J/zBZOfNkw0OfD4S3z
	 lNQR8kb5zkHpCfxInUCitn5xOMR3h26ebfin5VJdfY+6XIxi0v660c40QCsKovWk0Ulug
	 3gJ1Im7WkUxQJxe5nxcek0CCxMs8jJ8T4e3QVXhkYY0495OjX/rJxLU/afdFB1UpJExSx
	 yvQTYs370lkgCYvKnKfN53JYf76OweWz1FIM0JGgJARA+ar7aifaDMWj7t5qgR+OTyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D32606A328;
	Mon, 26 Oct 2026 14:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75FA1F01825;
	Mon, 26 Oct 2026 14:55:39 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 02/11] dt-bindings: pwm: renesas,pwm-rcar: Add support for R-Car X5H
Date: Mon, 26 Oct 2026 15:55:18 +0100
Message-ID: <388ee68e120ba73e675ad78fe0b1cbd89b061831.1793026273.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793026273.git.geert+renesas@glider.be>
References: <cover.1793026273.git.geert+renesas@glider.be>
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

Document support for the Pulse Width Modulation (PWM) module in the
Renesas R-Car X5H (R8A78000) SoC.

R-Car Gen5 enlarged the PWM output cycle and high-level period fields
from 10 to 24 bits.  While the added register bits have initial states
of all-zeroes, and thus look compatible with previous generations, the
register bits may have been modified before Linux boots.  Hence no
fallback to renesas,pwm-rcar is included.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/pwm/renesas,pwm-rcar.yaml        | 61 ++++++++++---------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
index 2fe1992e29088c9a..424ca1e2df15354c 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
@@ -11,34 +11,39 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,pwm-r8a7742   # RZ/G1H
-          - renesas,pwm-r8a7743   # RZ/G1M
-          - renesas,pwm-r8a7744   # RZ/G1N
-          - renesas,pwm-r8a7745   # RZ/G1E
-          - renesas,pwm-r8a77470  # RZ/G1C
-          - renesas,pwm-r8a774a1  # RZ/G2M
-          - renesas,pwm-r8a774b1  # RZ/G2N
-          - renesas,pwm-r8a774c0  # RZ/G2E
-          - renesas,pwm-r8a774e1  # RZ/G2H
-          - renesas,pwm-r8a7778   # R-Car M1A
-          - renesas,pwm-r8a7779   # R-Car H1
-          - renesas,pwm-r8a7790   # R-Car H2
-          - renesas,pwm-r8a7791   # R-Car M2-W
-          - renesas,pwm-r8a7794   # R-Car E2
-          - renesas,pwm-r8a7795   # R-Car H3
-          - renesas,pwm-r8a7796   # R-Car M3-W
-          - renesas,pwm-r8a77961  # R-Car M3-W+
-          - renesas,pwm-r8a77965  # R-Car M3-N
-          - renesas,pwm-r8a77970  # R-Car V3M
-          - renesas,pwm-r8a77980  # R-Car V3H
-          - renesas,pwm-r8a77990  # R-Car E3
-          - renesas,pwm-r8a77995  # R-Car D3
-          - renesas,pwm-r8a779a0  # R-Car V3U
-          - renesas,pwm-r8a779g0  # R-Car V4H
-          - renesas,pwm-r8a779h0  # R-Car V4M
-      - const: renesas,pwm-rcar
+    oneOf:
+      - items:
+          - enum:
+              - renesas,pwm-r8a7742   # RZ/G1H
+              - renesas,pwm-r8a7743   # RZ/G1M
+              - renesas,pwm-r8a7744   # RZ/G1N
+              - renesas,pwm-r8a7745   # RZ/G1E
+              - renesas,pwm-r8a77470  # RZ/G1C
+              - renesas,pwm-r8a774a1  # RZ/G2M
+              - renesas,pwm-r8a774b1  # RZ/G2N
+              - renesas,pwm-r8a774c0  # RZ/G2E
+              - renesas,pwm-r8a774e1  # RZ/G2H
+              - renesas,pwm-r8a7778   # R-Car M1A
+              - renesas,pwm-r8a7779   # R-Car H1
+              - renesas,pwm-r8a7790   # R-Car H2
+              - renesas,pwm-r8a7791   # R-Car M2-W
+              - renesas,pwm-r8a7794   # R-Car E2
+              - renesas,pwm-r8a7795   # R-Car H3
+              - renesas,pwm-r8a7796   # R-Car M3-W
+              - renesas,pwm-r8a77961  # R-Car M3-W+
+              - renesas,pwm-r8a77965  # R-Car M3-N
+              - renesas,pwm-r8a77970  # R-Car V3M
+              - renesas,pwm-r8a77980  # R-Car V3H
+              - renesas,pwm-r8a77990  # R-Car E3
+              - renesas,pwm-r8a77995  # R-Car D3
+              - renesas,pwm-r8a779a0  # R-Car V3U
+              - renesas,pwm-r8a779g0  # R-Car V4H
+              - renesas,pwm-r8a779h0  # R-Car V4M
+          - const: renesas,pwm-rcar
+      - items:
+          - enum:
+              - renesas,pwm-r8a78000  # R-Car X5H
+          - const: renesas,rcar-gen5-pwm
 
   reg:
     # base address and length of the registers block for the PWM.
-- 
2.43.0

