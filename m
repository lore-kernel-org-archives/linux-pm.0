Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27194DD3B5;
	Fri, 16 Oct 2026 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166191; cv=none; b=XkilVzbR3sO+VlWHguC0Rnzjl7W6dbB5ObbzPRSI0HPC6e0CbpdXeelDuuBYK4kkYgjyMDfZSi56H35JGiEQ3yxfVb0XHpRYmqVSfOTDptUfHANA6vBHteixQ5f37ohS1bUhX2JleGUfdul0XJ7ECfa1i6/1RJHF1cDk5j/6RVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166191; c=relaxed/simple;
	bh=cxuMx+Oqh1KLCdfo6KAi6pN7jrIyyvrHRQDh6+1LhWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDxCtYJe2WwawK4T17tMixpIodgQe4NJjuzU7v5gPJeRFvyiKE8JCkt9MP/pyn0YXlsr4MMAfu3MO8zZJG+oNpn6bQnNGuVUn+yLBb4TaCPowJKexPGXhOCOHGuf2VbEDbK2HgzDRhOf9oSKQavpud15CpPiEWKsYXBOMCkHPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9750B1F000C9;
	Fri, 16 Oct 2026 15:56:25 +0000 (UTC)
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
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 5/8] pmdomain: Make genpd_get_from_provider() return -EPROBE_DEFER
Date: Fri, 16 Oct 2026 17:55:44 +0200
Message-ID: <4524363679c1f2163aca3b3dda2bfbde170d095a.1792163045.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792163045.git.geert+renesas@glider.be>
References: <cover.1792163045.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike provider-based look-up functions in other subsystems[1],
genpd_get_from_provider() returns -ENOENT instead of -EPROBE_DEFER when
the provider is not found, thus not supporting probe deferral.
Currently this is worked around in of_genpd_add_subdomain() by remapping
-ENOENT[2].

Fix this for all current and future callers by returning -EPROBE_DEFER
instead, and drop the no longer needed remapping code.

[1] of_clk_get_hw_from_clkspec(), __fwnode_reset_control_get()),
[2] Commit 18027d6f392ee8d8 ("PM: domains: Make of_genpd_add_subdomain()
    return -EPROBE_DEFER").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.
---
 drivers/pmdomain/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 964e44c2f78f1d55..88c886814a5b9da3 100644
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

