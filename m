Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279512;
	b=QT/b/RXW11bBt0TWeRIihGbhdv1d/qkmS/zQb0MIqtv5A1mE+6UlALrWyo+PziaLOIY0
	 t/QOsZLVQVa0l2xFR3aezjUxyNVEWtAiPb1pWcyom5nbrWrGTfck/c9lApD1U0vTkNKiK
	 ctECYY5r0imsOjNDLSzmRX52IxeMoH/qBTNg3y+WLzvC6piMTMZo0gvRoROG4HqK1L0Nd
	 TnoHNtHri2PViPVOAF+lUPjuxD2r6d1oUxrIX/M2xFFzT0am7uFlzGN+bXbgyp+4a5jy/
	 MosXchVYLQFki85Jt0fMdpU0VyXENYn1x9zbmDQCUEmdrhoi/BT24PRqxb3DmbZQCBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279512;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=HyvBjqF9YQuWo179ksR30H3PsEw5+ooJnwlk82YJV4I=;
	b=rfFyh/0sCvntOh1kCajom1VV3kW+7CSeTLc6+H0NY4ynEslN/fFnUpHusmU6RrO5i5PV
	 4UAhPqFzIfpn46HF0bJR8dmPtqW7j/ceqxetEN/wH2VIACCKuU/e65waQvwrf02tLIywg
	 mQxXn/2uqsEQVdQ96jILdAHOEZ3xRF0drpZsy5bzTUWjIDH9XKBljph+KzW18kMETOJ1o
	 AIq6T+asx4zjc44qMuADToVbcn3aJTubu8HWWIviDUgSFvPcCe8bVPCGGHNOFBuF28L8G
	 BkV0vaUqpK+ZXIyDnXMueHlOdqgnK1lHbFip36jrHpXb23BAPKof+5Q390hfvFwYRZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99211606A320;
	Thu, 29 Oct 2026 13:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD62D1F031E6;
	Thu, 29 Oct 2026 13:11:48 +0000 (UTC)
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
Subject: [PATCH/DNI 8/9] pmdomain: renesas: r8a78000: Add CAN-FD support
Date: Thu, 29 Oct 2026 14:11:09 +0100
Message-ID: <ed6aec084413da6a2c634a6f98f7dbf4ec3377f3.1793278754.git.geert+renesas@glider.be>
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

Add support for the Controller Area Network Flexible Data Rate (CAN-FD)
modules on R-Car X5H.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH v4 7/8] pmdomain: renesas: r8a78000: Add SCMI
remapping support"
https://lore.kernel.org/2895c8f3cbe718dc597ad25e16c2461f0d681ab6.1792163045.git.geert+renesas@glider.be/
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index 62156bfb8080e6e4..02699952f5c2d83f 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -691,6 +691,8 @@ static const struct mod_map_in r8a78000_mdlc_scp_mod_fw[] = {
 	{ 0x51, 777, 1459 },	/* MSI1 / MSO_SCP_MAIN */
 	{ 0x52, 778, 1459 },	/* MSI2 / MSO_SCP_MAIN */
 	{ 0x53, 779, 1459 },	/* MSI3 / MSO_SCP_MAIN */
+	{ 0x72, 799, -1 },	/* CANFD0 */
+	{ 0x73, 800, -1 },	/* CANFD1 */
 	{ -1 }
 };
 
-- 
2.43.0

