Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031171;
	b=LCBI/54YGtZ5/jv1zqUZN5dwAZBsUWTMEG0/ErPoARMMsgVq9BclKwFK32fnguKuwGoa
	 3+k7KEnFMdt9vM1gHkOZ9B7Nn8DixSKGn55EMK27BWGT+Gr7LYe1tUdqBvJIL3fTKsYTy
	 En9Qoqq0Es8ct8YPFKdVpUtJJMw1C6usoAM+TD8A1cu7bKCWa1iSSsFUpAwcAyMeKEOID
	 kyuuIT9szdVkqspPrDT0pX2QoJ92GvWMNTfbqoByGrZ3qiul/peN6iv/4d3c7X2yrFDyY
	 ryBCzn+PiQLeYeEAT0jmVPkJjdxi/i3A7v+1RxbIiuFoyqy6Unny+9xdYm/pTdqeIrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031171;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=I3r+NdM5uUH4ruZeogpPo+YPl73KMZ2YlnshALoJtN8=;
	b=KftQE6VXpEW+/w30TwES4PCspjT8rQuWQzBzkHLIJX/pDPhcG6YYjKu3hbmWOX16bfr+
	 OltasPJ070tXfWiHyCTeFtL/nMkSBsDnGF2Oz+3uaFtBUnRUA9O4E7adQtsEH4buNYCX7
	 6TB9sJoauvZ4VbigZQIvM4tCGbCT5YSB+6zPtj99XX0XXI4YO0/g+tmxWqtYCjsEu7O09
	 gfW3RuSQ3Dzq2fno8K2cAfGAFWjSM5SxKblyPQvmv04Ph4aAN4CD+O5hXDg04JXStmKu2
	 YzhJBk97RGVf8hWnFSMo0h8ZfiWp124xibjnw9AeNzDPS7XC6fNY+JtyeH2Nxjfv5lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A42606A32F;
	Wed, 18 Nov 2026 19:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A1A1F000CA;
	Wed, 18 Nov 2026 19:46:05 +0000 (UTC)
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
Subject: [PATCH v5 09/15] pmdomain: Make genpd_get_from_provider() return -EPROBE_DEFER
Date: Wed, 18 Nov 2026 20:44:57 +0100
Message-ID: <16bd6b25711f0e5a4a8ff7484ad3acba83a2a2fb.1795029012.git.geert+renesas@glider.be>
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

Unlike provider-based look-up functions in other subsystems[1],
genpd_get_from_provider() returns -ENOENT instead of -EPROBE_DEFER when
the provider is not found, thus not supporting probe deferral.
Currently this is worked around in of_genpd_add_subdomain() by remapping
-ENOENT[2]; other callsites don't care about the actual error code.

Fix this for all current and future callers by returning -EPROBE_DEFER
instead, and drop the no longer needed remapping code.

[1] of_clk_get_hw_from_clkspec(), __fwnode_reset_control_get()),
[2] Commit 18027d6f392ee8d8 ("PM: domains: Make of_genpd_add_subdomain()
    return -EPROBE_DEFER").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5:
  - Add Tested-by,
  - Clarify that all other callsites should be fine.

v4:
  - New.
---
 drivers/pmdomain/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index ee8075e90852e738..c242807f62579e5b 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3021,7 +3021,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
 static struct generic_pm_domain *genpd_get_from_provider(
 					const struct of_phandle_args *genpdspec)
 {
-	struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
+	struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);
 	struct of_genpd_provider *provider;
 
 	if (!genpdspec)
@@ -3276,7 +3276,7 @@ int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
 out:
 	mutex_unlock(&gpd_list_lock);
 
-	return ret == -ENOENT ? -EPROBE_DEFER : ret;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
 
-- 
2.43.0

