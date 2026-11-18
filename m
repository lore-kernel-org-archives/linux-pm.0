Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031182;
	b=uqcv8RyZnY0zwOa89A3JoDjSPymVPomto/MexxWdQ+VyLGQugRUiF9+vvKXp6vCQRjLJ
	 2zE5SzAvpuUKD6rPkrhpUNit8DnXEDNSPdKJOF3E13Pbumuvow5WCX3SNvbCZfoYCKEvV
	 W+189b3sMaYxy4BMbFMp/qzYf7koj4jmZf1SEMAMWcwnmuyHSArJamhBfgF946x8fPAdS
	 /0RaJVdh5wHGM37Tp7GN19mxtpIcqw9+WEFHHh0sNRKASSS9+iAMA/NT3uidR9zLEYMqh
	 0UbRliDptSo/sImm11QI+8ixSV3Nb9f46ViLRLlvtoAg8g/Ki//ZgK+BBVkkAuXNbvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031182;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=jbw2FjtWb8yft9KaE0ctkHu1Kex0/HcxtFL//rQWWSs=;
	b=I+iHKlucITvasqN9HNPI13Nr05VA9pNXAD1YusPIqa8dJa70gA7WNeEAGAGW0nEWnEMX
	 1TR01my2TAh3ggSAobgQUlNqOJY5YZRar1SG3IKhTIC1QnXW/j9bPVBooiktbQ7l0odDM
	 hRzuWtELxiKMjN8m8qu0sYwGkFa8jrjZsmrRr7cRXFu7lfe5CS0sKj7X7/rTHFIl22Pqn
	 BtgMq3stxHuNuH5+LLWyocR+vwKxVPv9fruRAOEd+hm08XpOF5gaq2CfJvy9TUUfB3gwc
	 lmQe1ySbXGPPytxOUQvmf154KGPXJMZHNtnHr3y7X/p9z56nEAvhUKTHMI0t1Zjk1Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7034A606A331;
	Wed, 18 Nov 2026 19:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064511F000C7;
	Wed, 18 Nov 2026 19:46:16 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
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
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 11/15] pmdomain: renesas: r8a78000: Drop MDLC name comment
Date: Wed, 18 Nov 2026 20:44:59 +0100
Message-ID: <11c375d15b5073212ca79e11330e422539eae4b5.1795029012.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795029012.git.geert+renesas@glider.be>
References: <cover.1795029012.git.geert+renesas@glider.be>
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

There is no need to document Module Controller base addresses in
mdlc_info tables, as a mod_map initializer already contains the Module
Controller's name.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - New.
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index 75de869872de9e82..1ace1fb10870f646 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -299,7 +299,7 @@ static const struct mod_map r8a78000_mdlc_perw_mod_default[] = {
 
 static const struct mdlc_info r8a78000_mdlc_default[] = {
 	{
-		.base = 0xc05d0000 /* mdlc_perw */,
+		.base = 0xc05d0000,
 		.mod_map = r8a78000_mdlc_perw_mod_default,
 	},
 	{ /* sentinel */ }
-- 
2.43.0

