Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BFF3DFC9A;
	Fri, 10 Apr 2026 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839747; cv=none; b=jmkXpTlo/QM2BZiF888bJ72IAqJ8puwNuE/ENaEivR079o1SNnKAXwcPUV+DBRMah9kjrQVTtcVDElt7U5rDge5h54WbaMY3n5uzqOrhQotfec42cST8+QhQ0q+2wRr2pnlpbR4emExoLo9ztZOAo5x1VB5C6sw2tuPh3v9QgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839747; c=relaxed/simple;
	bh=gEByb17aWEuS+y3knfgxZufJ5uAM0e8FrkZagNP6esI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NE6vzmAcPRvDbeauGoE6bPjhXsQhBwYolKxr46TfjjoeMpUsEbxmQuzStuiSxmUgk9MP2MTLCgiFNXs0cCF4Pvr4g2Q99OH3KCd0aMKa5Gi1uC87KnO5901izJiCdi4EEEhhVPKyreY4+Ehj9pC9cNdOBWKtr8qIQ6u7BokFhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=PGX2gsl1; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="PGX2gsl1"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1775839735;
	bh=gEByb17aWEuS+y3knfgxZufJ5uAM0e8FrkZagNP6esI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PGX2gsl1yyc+ElHo9FsLIsNLdz0wCQ4AqJ1oVIagtF+w/VRPb2fJUfeFwtApN/lLT
	 KRzWyKBNiZNnqsfcaEB5V+x9VA08l0z3E8bxPZ/UT5jXnpu3KzWmW85Xqo0bzwuWBK
	 9JUQsqnU8Y/8WR1RHhlWiSp/efZ8eULlcwPmZebc=
Date: Fri, 10 Apr 2026 18:48:04 +0200
Subject: [PATCH 3/8] firmware: meson: sm: Add thermal calibration SMC call
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-add-thermal-t7-vim4-v1-3-19f2b8da74d7@aliel.fr>
References: <20260410-add-thermal-t7-vim4-v1-0-19f2b8da74d7@aliel.fr>
In-Reply-To: <20260410-add-thermal-t7-vim4-v1-0-19f2b8da74d7@aliel.fr>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1775839730; l=1805;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=gEByb17aWEuS+y3knfgxZufJ5uAM0e8FrkZagNP6esI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCZXPWgNcIzEeEI7sgiKyGvolQvqu+W2iXUpuLgewQ+KT9tqCB33rJpAiFgCiRuOXeroJaJ+ZpJ
 TlX2RqgZqmw4=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs

Add SM_THERMAL_CALIB_READ at SMC ID 0x82000047 in the command
table and implement meson_sm_get_thermal_calib(), which forwards the
tsensor_id argument to the secure monitor and returns the calibration data.

Also realign the CMD() column to improve readability.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/firmware/meson/meson_sm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 3ab67aaa9e5da..da0dbcd8a2ff2 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -41,12 +41,13 @@ static const struct meson_sm_chip gxbb_chip = {
 	.cmd_shmem_in_base	= 0x82000020,
 	.cmd_shmem_out_base	= 0x82000021,
 	.cmd = {
-		CMD(SM_EFUSE_READ,	0x82000030),
-		CMD(SM_EFUSE_WRITE,	0x82000031),
+		CMD(SM_EFUSE_READ,		0x82000030),
+		CMD(SM_EFUSE_WRITE,		0x82000031),
 		CMD(SM_EFUSE_USER_MAX,	0x82000033),
-		CMD(SM_GET_CHIP_ID,	0x82000044),
-		CMD(SM_A1_PWRC_SET,	0x82000093),
-		CMD(SM_A1_PWRC_GET,	0x82000095),
+		CMD(SM_GET_CHIP_ID,		0x82000044),
+		CMD(SM_THERMAL_CALIB_READ,	0x82000047),
+		CMD(SM_A1_PWRC_SET,		0x82000093),
+		CMD(SM_A1_PWRC_GET,		0x82000095),
 		{ /* sentinel */ },
 	},
 };
@@ -245,6 +246,14 @@ struct meson_sm_firmware *meson_sm_get(struct device_node *sm_node)
 }
 EXPORT_SYMBOL_GPL(meson_sm_get);
 
+int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32 *trim_info,
+			       u32 tsensor_id)
+{
+	return meson_sm_call(fw, SM_THERMAL_CALIB_READ, trim_info, tsensor_id,
+			     0, 0, 0, 0);
+}
+EXPORT_SYMBOL_GPL(meson_sm_get_thermal_calib);
+
 #define SM_CHIP_ID_LENGTH	119
 #define SM_CHIP_ID_OFFSET	4
 #define SM_CHIP_ID_SIZE		12

-- 
2.49.0

