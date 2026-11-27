Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796899;
	b=3mS4x5oBUPZAe1yrBFE253+3gLrIuV8NS1Km2WdMg1ieN2SUPn9gtxA+ditDkKaZdbJj
	 LlASSoKAWwpUnRyeH3Uko1xql3aEKR8zTKp+A8OiJ64RAxJUBKeeQ3QhfUbNHDAg8cwjW
	 TgG0NLkzd7Gd0vXbiqshuDB2zQTqpI5Bne5JLY4jNoItndW0FegfCA65i60iatWJBTLQH
	 sdKT+Agrcb26S93sZRwQ/Gwn1zLSYPehUtPhJANujYC1mSZM5ie7ahtQd64cj5ATAq2hY
	 Tg6HboUimZLO4Uyp/WVDN7Roc3+1/hr+QU5blV3z2m+YuOSmtnsDZuKSksWLHwS8+ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796899;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xQMqdDi/1HnL38YfnZfa/d1qtg2+JgVOWSxcOtwiK6c=;
	b=mirt3tzTpcKn02rUqkOE9My9IxhjDMpKYUkaL7OTSgWLMjipz25ljtU7PsPJmFLiIsDi
	 vEop1lurRoNhOm4Lq4/+8sKMHMhvZMRUyOFEcHR48dYCSTTQXRereUmHvPrsM7SeXnQ59
	 RGO90kxB8Hvz3KVeyZIAcpTJ+adGwMuZUM6wsh7YlXmQg1chNUARke+aeFJAt+rH6rBx3
	 5AQ9kWsjVxzEjwHT1zJfAWS0F4GVi3iZbeyIUgICbo/V18Ur0B22WNjU7BuSDIj2OV2qA
	 ApKkMha9RAzKKxI/cTh/S/tCnIPQiW6h7nma1wtrVJKOKPvg2q6s/qUbueeAZnJdgMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIGILbww;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527B606A31E;
	Fri, 27 Nov 2026 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIGILbww
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FE61F00A15;
	Fri, 27 Nov 2026 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796899;
	bh=xQMqdDi/1HnL38YfnZfa/d1qtg2+JgVOWSxcOtwiK6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TIGILbwwDY2eKbhgObRheh3ogVEVwCCaKlN7U0uG3FxSRdI2KRNfS2z8u0PZguT/1
	 iN7MFJjGFih2zsuUZjT0JPSLYdvH0JqMAsaDd6tS27YtC9PtjsJK8mmC9d1BrRzbX/
	 MiZpgmSZiYXO7jDz0a4FC23KTA2PDe59yy/3wXGEmYOPoieHGZ8QO4HPninPJKn8L/
	 5Xv4Au8B5nxGqfpJ9KwMnYFqjZ/loDSIZuZ8o6sjsD8CZxxwnW4QPC93jE80Fi1Sf0
	 4vRtctBvN5tcOSgsMK0DVYzwJtOJ+6QEB4xaMjz4OIRMS0OPbya6lmrqA5TxZTkv+v
	 Ic6+y2aP4ek+g==
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
Subject: [PATCH v6 12/14] pmdomain: renesas: r8a78000: Shrink IDs to 16 bits
Date: Fri, 27 Nov 2026 17:26:57 +0100
Message-ID: <4f8af5cb14603d3323be9b84bc746ef0c53fc392.1795796064.git.geert+renesas@glider.be>
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

Reduce table size by shrinking hardware module IDs from 32 to 16 bits,
which is still plenty.

While at it, use u32 to store of_phandle_args.args[1] in
r8a78000_mdlc_attach_dev().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v6:
  - Add Reviewed-by,

v5:
  - New.
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index 6477abe64511e880..733bf68dab2ce6dc 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -17,7 +17,7 @@
 #include <dt-bindings/power/renesas,r8a78000-mdlc.h>
 
 struct mod_id_map_entry {
-	u32 hw_id;		/* Hardware module ID */
+	u16 hw_id;		/* Hardware module ID */
 };
 
 struct mod_id_map {
@@ -148,8 +148,8 @@ static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
 	struct device_node *np = dev->of_node;
 	struct r8a78000_mdlc_priv *priv;
 	struct of_phandle_args pd_spec;
-	unsigned int id;
 	int ret, idx;
+	u32 id;
 
 	ret = of_parse_phandle_with_args(np, "power-domains",
 					 "#power-domain-cells", 0, &pd_spec);
-- 
2.43.0

