Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796911;
	b=Vp5ZseKFhhkst0QakqNjYqg2QpHKvGr8h0cBMADOOUdewPOM7H92kEPzfi6VDQkWF/vc
	 ajSSIqZaS0DuWLPWfExwqwDkwzSQKNNd80MUx8GWo8BTOy1s5ynsqN0fRiSHwlUx3/NFW
	 yqVgeq8JdndHiqJqSnckasTk3gePbYbBZ8xLDecJTpSh1xpR212N0dF1Krlh3JmntdOiV
	 vd+vj4TfUP3oVKQKDybFO52dW3HuoyotZzWpVhbc0f6wUg/RC0Pcks+p0s/sapFXvKWMU
	 fEKw+Imza8jMLPE079Fptl+Emk4CVT54lZIN/v/l2u3v6sM6SfM8ErL9RzL1fK8F+Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796911;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x3qSxsN0BB2ADEZtB2vqAGa6KasHvlIycteLaQjp0Gk=;
	b=yMYIdaxR2u9WbxCpaJrRto5e2q1qZYsuGJ8KwexTysa/XPeahOqKtOo9LE0aBZYErrWD
	 Bj6fPNxvIZUZXUIXWWdNWnQ6Y/DCvkgsKfmr4QEyQHVdLI4DZBsqrthiiCzNuZCdivv1K
	 pJMWij1lmaa4QnpeOLs4K7+tv2il6ZVv3KaH821+fxf4FhoUvjsGA0hsYig6IRSU+GGV9
	 8rDzH+LQq7ZEimT9d/bB6l7c2iNgc33y9ALLTBPqjELHKpYsg7anf1MZs3oP5vx+tFlcF
	 UPneNUbYhInXAVazAExd4JGvgBJokLQENjB++LVvSXifn0chxHb2i2802zXaQEV/nbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2Pm7Itk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FED606A321;
	Fri, 27 Nov 2026 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2Pm7Itk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEC51F0089A;
	Fri, 27 Nov 2026 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796910;
	bh=x3qSxsN0BB2ADEZtB2vqAGa6KasHvlIycteLaQjp0Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l2Pm7ItkpIPgm7/RJh1LG9Uldqz63IQNXTQcy/oxc6jEnfQXD6O+UiN0iUDdV9kW4
	 vKCqMR9wbBbC99/JdWhVt1derfvG5gJFKZVLgJeMRgL3fPlzi1JTLuGYDpffFtie4f
	 5cqW4LnGiNeEi1TUYkAzYLf/ivY4KZHecG274eIdm21GS0L/EhUn0fLL+49gdMCRWl
	 8ifB/dWzURMRVvqYyqCXCKP4AUJoeX2vVIhKCGeDWIttROejEwvNCTfFETl+5avQ7l
	 IinHhVi7btRrJKhzLhuLGrm6skO5tx3ATeura8ZtWhS2rbEoC/f3zo59FiGAdbCyAP
	 KeLmtq/rY3ofA==
From: Geert Uytterhoeven <geert@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
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
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 14/14] arm64: dts: renesas: ironhide: Enable SCMI devpd, sys, clock, and reset
Date: Fri, 27 Nov 2026 17:26:59 +0100
Message-ID: <f1dc2ba18aec2b2f7341edf8f7e8c8de95b651c3.1795796064.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795796064.git.geert+renesas@glider.be>
References: <cover.1795796064.git.geert+renesas@glider.be>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

SCP FW SDKv4.28.0 and later for Renesas R-Car X5H Ironhide not only
implement the SCMI base protocol, but also the SCMI power domain, system
power, clock, and reset domain management protocols.

Enable support for the latter by adding the corresponding SCMI protocol
subnodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v6:
  - No changes,

v5:
  - Add Tested-by,

v4:
  - No changes,

v3:
  - No changes,

v2:
  - Fix misindentations,
  - Add scmi_clk node, as it is no longer added in earlier commits.
---
 .../boot/dts/renesas/r8a78000-ironhide.dts    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
index b2d6b06c63881896..ade8bcd3a0e5ee8b 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
+++ b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
@@ -31,6 +31,25 @@ scmi: scmi {
 			arm,no-completion-irq;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			scmi_devpd: protocol@11 {
+				reg = <0x11>;
+				#power-domain-cells = <1>;
+			};
+
+			scmi_sys: protocol@12 {
+				reg = <0x12>;
+			};
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+
+			scmi_reset: protocol@16 {
+				reg = <0x16>;
+				#reset-cells = <1>;
+			};
 		};
 	};
 
-- 
2.43.0

