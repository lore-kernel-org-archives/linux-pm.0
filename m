Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882727144B;
	Wed, 14 Oct 2026 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791947939; cv=none; b=F2TZGqeIXkyCfKvumsPIiT9xyyfNYJ6cjSPYxxD+JtiJcXhsqlXNq+csP0bcm1FarKYC/F352oIngAjRONtUref69JJnJellQqIsbSZtq0/TqW9mgT2rcvLUQEBHUusdwnIzlkBleT3fmXQ5DdPPywnr01srJAxaIw4hzMA2F2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791947939; c=relaxed/simple;
	bh=zHSUzkNjToUp8uTEjmar6xN8IxpNlXiXqkogfTNjOQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ggas6e7Kj7p0F43R3GkZAKlHZYMpV4Ms6+UxxLDv0ygbXOPYXUCnuZEEhSWq4DZtXeukGe5EL1Tu2+cxPKRxoTAQcC1YkFLINjHC/QgRzaCPG49i4o3Y1COejx5Gyx6ZsEtzzsqK9u9G8mmJS05nLdTwWKZv8JiFpsoHiraYdT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Jy8S9Ih1; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Jy8S9Ih1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/w
	b5x9YJdon9KKr9z8ynJWG16vj2SwCyxobw86ApWOQ=; b=Jy8S9Ih1ULVyA1mtbs
	LA5ySToPsTMqrgyNaZOh/JURkQ6EZgpPAU4AgZ9KYQtE2SXzDhKHd7G0i771uqoq
	35qKlH9yo77uIzSz5O4wSMe0VUcvceALIC5/+HigHQ6eYvAE11tD2eMBTS/+iq+v
	8ieeIV/LnX6OO3maGywBnKRW8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3Hqt49M5qklMYEg--.56197S2;
	Wed, 14 Oct 2026 11:18:17 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Pengpeng Hou <hppiscas@163.com>,
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v2] thermal: rzg3e: Propagate reset assertion failure from suspend
Date: Wed, 14 Oct 2026 11:18:14 +0800
Message-ID: <20261014031814.7230-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA3Hqt49M5qklMYEg--.56197S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AryrurykZr1UAF1UWFyrCrg_yoW8tw4kpa
	n5Gr4UCr4kWF18Ja17AF1kZF9YkaySkFW3XrZ5Gwn5ZF43Z3y3tFyYgFWYv348Gr18tFy0
	kF4jyw15CF4DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi2Nt7UUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7hupcmrO9HtbhQAA3b

rzg3e_thermal_suspend() powers off an active sensor and then ignores
failure to assert its reset. System sleep can therefore continue without
the clean reset state expected by resume.

Return the reset error and, when the sensor had been active, try to
restore power before failing suspend. This is best-effort recovery:
reset assertion failure may leave partial hardware state, so restoring
power is not guaranteed to succeed. Preserve the original reset error.

The issue was found by our static-analysis tool and manually reviewed.

Fixes: dc67521c20b7 ("thermal/drivers/renesas/rzg3e: Fix add thermal driver for the Renesas RZ/G3E SoC")
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since the RFC:
- resend without RFC and add Claudiu's Reviewed-by, as Daniel requested
- add the introducing Fixes tag and clarify the best-effort recovery
- rebase on current mainline; retain the reviewed code

Previous version:
https://lore.kernel.org/all/20260828092123.9707-1-pengpeng@iscas.ac.cn/

 drivers/thermal/renesas/rzg3e_thermal.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index c44f5b8858d02a7d4d6a5fbe8a8b189ab22568ba..7686a45341b3dcddccbfee11a7f832f9e1d76a15 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -499,15 +499,19 @@ static int rzg3e_thermal_runtime_resume(struct device *dev)
 static int rzg3e_thermal_suspend(struct device *dev)
 {
 	struct rzg3e_thermal_priv *priv = dev_get_drvdata(dev);
+	bool active = pm_runtime_active(dev);
+	int ret;
 
 	/* If device is active, power it off */
-	if (pm_runtime_active(dev))
+	if (active)
 		rzg3e_thermal_power_off(priv);
 
 	/* Assert reset to ensure clean state after resume */
-	reset_control_assert(priv->rstc);
+	ret = reset_control_assert(priv->rstc);
+	if (ret && active)
+		rzg3e_thermal_power_on(priv);
 
-	return 0;
+	return ret;
 }
 
 static int rzg3e_thermal_resume(struct device *dev)

base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef

