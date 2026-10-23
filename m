Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778080;
	b=tVweKRT9gGpiKnPO8E9PNbxKidE/u10sTEJGfsRqQSrC3GaWJ8bOlre/AZbBpZ37Capu
	 1MAVINOYnVA5txQOFDcarxhOJn1bQtyNLhF4qQvbMsVALMHBhfCoZjsYCf4ALfcQtvBDR
	 HS01gnZ0Aq4++b75WWKMw6bFxoPujkvxV8Z4CHfV0/yurSrg+mRaRS7ws18WZrAr3Wy+y
	 66gJd+ikjfTIl6pmWajOTAzN//0ohAL5Y78v9N2FSD0BthimD0dhCOmQYTK4BskQWMacY
	 Psqn6TkL4lmXq4ZqJQYVD3/crMU8ZakSVgoEymTTRIp4141YyiBJP44O2/CYketWhCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778080;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=veEtzTzjL8zq0FEnYMOZSeR9nQqTNj9N4Odb5GHoV9A=;
	b=QOqgqNTYht0CXKjHBx5eHEHetDaFfThfdEaWKm8CO8u44jSwxMtF02rQHKA5n6CBNhpJ
	 fQOSFLSegy7haZ5/4Mc2zNFQN8MJv7eAxg9XpYpmyGkurLVBKIbWI3d2nj8B+C4smwe/R
	 3tge008aqloy1MO5Fwlk+NWnQpKbkvk+gQug6r9abhCMIpOaqAlLhLMH8Ospjz1c4JCVj
	 di8GgVYVhUYd+eBzlG0Aw66AMKoh00XUWtWxxSOwaZWjHg6TnhLDSZwgAEV0RObvjcqP+
	 DihrKjBlyoKzJBifCiDka6VSYPf4I9OBmjZNx24w0XoF8gPTmTNIV+jHYDe0i6OZZBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41048606A31A;
	Fri, 23 Oct 2026 17:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C691F01828;
	Fri, 23 Oct 2026 17:54:18 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 5/7] pmdomain: renesas: r8a78000: Add default GPIO support
Date: Fri, 23 Oct 2026 19:50:43 +0200
Message-ID: <c7ceec0d203fb01b3bf7c7923bfee50b7a5e3ac1.1792776697.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792776697.git.geert+renesas@glider.be>
References: <cover.1792776697.git.geert+renesas@glider.be>
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

All GPIO modules seem to be accessible without SCMI, and at least
GP05_15..GP05_20 are known to work.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Do we want this? So far there are no users of GPIO, and future users
might need SCMI for other reasons anyway.
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index af36d8229030f6c0..10089d938f71b27e 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -606,13 +606,38 @@ static int r8a78000_mdlc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mod_map_in r8a78000_mdlc_aon_mod_default[] = {
+	{ 0x20, 0, -1 },	/* GPIODM0 */
+	{ -1 }
+};
+
+static const struct mod_map_in r8a78000_mdlc_hscn_mod_default[] = {
+	{ 0x50, 0, -1 },	/* PFC_HSCN_GPIODM0 */
+	{ -1 }
+};
+
+static const struct mod_map_in r8a78000_mdlc_pere_mod_default[] = {
+	{ 0x30, 0, -1 },	/* PFC_PERE_GPIODM0 */
+	{ -1 }
+};
+
 static const struct mod_map_in r8a78000_mdlc_perw_mod_default[] = {
+	{ 0x30, 0, -1 },	/* PFC_PERW_GPIODM0 */
 	{ 0x54, 0, -1 },	/* HSCIF0 */
 	{ -1 }
 };
 
 static const struct mdlc_info r8a78000_mdlc_default[] = {
 	{
+		.base = 0xc1338000 /* mdlc_aon */,
+		.mod_map = r8a78000_mdlc_aon_mod_default,
+	}, {
+		.base = 0xc9c90000 /* mdlc_hscn */,
+		.mod_map = r8a78000_mdlc_hscn_mod_default,
+	}, {
+		.base = 0xc08f0000 /* mdlc_pere */,
+		.mod_map = r8a78000_mdlc_pere_mod_default,
+	}, {
 		.base = 0xc05d0000 /* mdlc_perw */,
 		.mod_map = r8a78000_mdlc_perw_mod_default,
 	},
-- 
2.43.0

