Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090FB433E7F;
	Sat,  4 Jul 2026 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783178676; cv=none; b=hZGtjI6MheuBgvmeF0z/6larxfuq8EVVHQo+ilFPCxbOAFnLpZWn3UbaeOAN8tBcwcoiaaREIML+L0CyhYTTvXFpTwu4qy+sODIgkGSIcQHT8vnd3w1qfcXiCT6fKZ794p6ItOO/DIJBaR2ySdTvBGqOIFK4FfEToI2TIubwV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783178676; c=relaxed/simple;
	bh=hiHnRQvjSwXWoP4YqCoVl+3ALX/RNoVvuVsJQBQJ3Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2MPYR6zQqzE+Ks8KFVh4FgeWxiwuwoZiUYnsblmzRdzAfZBcB3hO5o6dCy2tdqDMGVDTQRwGmsDb8jfgEMS162lRgCUQ8xfeSAdb7oNXlg2snutJvKyM680iMvYflNGOhG4jBQ9DJodSKQeqlucfB4A37kk2RKODCI3BtZql0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowABXrdCuJUlqFcPbFg--.46948S2;
	Sat, 04 Jul 2026 23:24:30 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Tobias Schrammm <t.schramm@manjaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: cw2015_battery: add missing MODULE_DEVICE_TABLE()
Date: Sat,  4 Jul 2026 23:24:28 +0800
Message-ID: <20260704152428.51844-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXrdCuJUlqFcPbFg--.46948S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFWktrWrZr4UtryUKw4fGrg_yoWkXFgE9r
	W8Z3sagFy3uryjkr9Fyr4fZr9Yka97Wr97W3WvqFnxZ3W7XwnxCFWkWF9Ivw1DJrWxCFZ8
	XFyqgF1rGFW2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUBT5
	dUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The driver has a match table for the i2c bus wired into its driver
structure, but the table is not exported with MODULE_DEVICE_TABLE().

Add the missing MODULE_DEVICE_TABLE() entry so module alias information
is generated for automatic module loading.

This is a source-level fix.  It does not claim dynamic hardware
reproduction; the evidence is the driver-owned match table, its use by
the driver registration structure, and the missing module alias
publication.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/power/supply/cw2015_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index a05dcc4a48f2..ab8298485fab 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -735,6 +735,7 @@ static const struct i2c_device_id cw_bat_id_table[] = {
 	{ "cw2015" },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, cw_bat_id_table);
 
 static const struct of_device_id cw2015_of_match[] = {
 	{ .compatible = "cellwise,cw2015" },
-- 
2.53.0

