Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026539;
	b=HdglxoDm4wYd/Po7HtHx6KtAIC9VRxyfHD1wxzesL2j40F4K0hT5rOtmLigsDUNoxHst
	 Z4W/pKLzqk5D+Wu5t+BfGGklk8kBDMKbbM7KU4QlVsP3Aqq5M4EgYHvb9KXfvd23UdQeQ
	 nw97qVEy+6sExbCJlp3jyMiKYN3ZG7pqaDTxb+6nyFo3NfqWlAD1p0waaJDvGTPRO4qBt
	 5gWo3QHjuLlB45CfFnLT4YVs05QGKn3VV7bgNmyIOTlimZgU84wAtWvCnG8pa/NaAxjXI
	 bVDrIESwc0AqaOoKzwy5ll6qlrgcmHCzc0Dm8dspDAIR4fGlmoBfvifpw3UkarMRIXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026539;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=MGsjF8yAycNX+1w32e1k8A5z+o58fLHJWlgySWZ9AOo=;
	b=uAC6XOEut/r2cQCdqLakXvyFuR/ilPMgSGqsps2O/7AS4IhoOYjl6lkwfRRzBrHVC0Ov
	 83POPXKxBsopJk1s4hgYx2cfW0ezX3t+t2rw6sA5TYKmRpAkRB+7ZZPMCrJWfQHivaFdJ
	 JUMsqF+tKCuBrtqQgLMyy7SFWPU3N1zjG06ncXDRaJjr3ISecANBIDumSd1YuDcUsUien
	 gnr9IN0QujmBhQnB43ThJkCpIBvIFLzvbZWWGAWySI0dHoQNLIHflw5j7NXFkNcXBTGWm
	 Aka9aF421GZqJVIfghfps7rx7EwCJxb+yCMjTuJRPuRfA80N4U6ONQZJ70QKOExLyYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBAF606A31B;
	Mon, 26 Oct 2026 14:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B670A1F01829;
	Mon, 26 Oct 2026 14:55:35 +0000 (UTC)
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
	Khanh Le <khanh.le.xr@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 01/11] dt-bindings: pwm: renesas,tpu-pwm: Add support for R-Car X5H
Date: Mon, 26 Oct 2026 15:55:17 +0100
Message-ID: <8b2c7719c301a445891fc6c5309456327ec8a94c.1793026273.git.geert+renesas@glider.be>
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

From: Khanh Le <khanh.le.xr@renesas.com>

Document support for the 16-Bit Timer Pulse Unit (TPU) in the Renesas
R-Car X5H (R8A78000) SoC.

Signed-off-by: Khanh Le <khanh.le.xr@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index f85ee5d20ccbb3f9..144a88ff53e5633b 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -33,6 +33,7 @@ properties:
           - renesas,tpu-r8a779a0  # R-Car V3U
           - renesas,tpu-r8a779g0  # R-Car V4H
           - renesas,tpu-r8a779h0  # R-Car V4M
+          - renesas,tpu-r8a78000  # R-Car X5H
       - const: renesas,tpu
 
   reg:
-- 
2.43.0

