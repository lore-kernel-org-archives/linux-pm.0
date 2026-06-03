Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593133D3322;
	Wed,  3 Jun 2026 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499928; cv=none; b=iSdf5IB8xNHTgSnc0JarNe9v4F1SkXYZHApgxwNQ0n02jOazWvQMmk43O1nk4p6PlSKZoGaL934u1SMI3BKMNfNdAx4YHMjbl9bAnGtmmLtUUUEt9CsQteDTu0JOK6reMySRzgrHirlykjfhOT//sCxP9GjLKMt8E6FyObXtDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499928; c=relaxed/simple;
	bh=8rP0A6QiQP4KIv/9rf6AXQPC8KF4MfJZQPyvCLEQcUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8fvcnFRxoql7RIluDORFax2qr3KaI80q0hJge8Lxd/tGdyhWB26dSIQhSR8S0ylnHUip5Qx7ea0NRhjcZx7w2CGWelUvZ4ItC0W2vqOvnwghPZB4tanxo2z30KSb5JNk/FTMrT/sRT1fyTuOTtbVUPDkGK7fHruVxfFGUIGNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9AB1F00899;
	Wed,  3 Jun 2026 15:18:45 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pmdomain: arm: Grammar s/may needed/may be needed/
Date: Wed,  3 Jun 2026 17:18:43 +0200
Message-ID: <a9a082c25e4bda4d73b261eee951efecab20612d.1780499882.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix grammar in the help text for the ARM_SCMI_POWER_DOMAIN symbol.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/arm/Kconfig b/drivers/pmdomain/arm/Kconfig
index afed10d382ad7f66..ba0b190a63d6bb18 100644
--- a/drivers/pmdomain/arm/Kconfig
+++ b/drivers/pmdomain/arm/Kconfig
@@ -21,7 +21,7 @@ config ARM_SCMI_POWER_DOMAIN
 	  enabled or disabled via the SCP firmware
 
 	  This driver can also be built as a module. If so, the module
-	  will be called scmi_pm_domain. Note this may needed early in boot
+	  will be called scmi_pm_domain. Note this may be needed early in boot
 	  before rootfs may be available.
 
 config ARM_SCPI_POWER_DOMAIN
-- 
2.43.0

