Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26A3E00B3;
	Fri, 14 Aug 2026 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694498; cv=none; b=GczvNvYhb5Okh4jqaQzbA9b/WWso7SLQI9Y0XmciiR3opRf0OaKpRN0xEvkj+GLPz5SHvxtqoWEOWcYk1zWTIbo4kPPruvJGGDhqWhVAB/8QlBGUX4e+VEqiPMLpMp4m3uELo7gv3BTGdFJ7PTAvBkJe+SZUfi0sUWF+fVOthyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694498; c=relaxed/simple;
	bh=ulbvecIsBsqefZCDU0O+Ppr1OQKd+WANpXUojGaw7Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J8ZHVsftS/3XPM5q+vcnGIMef1cxaSFHvMJFM0HsFkv3fQsSLn8jPagoTjiIOJoltB10D1wOAU2JRHV8BPEvGo2mblYxTLc80wW5BB7vdX8MmBbbXPJSsHmlQ2ZscXeCnIJ7CJ8z6gpCv0XaFkLj3o0fkinph7GaSRf3SuNlxHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowAAH2+5dy35qQbGeBQ--.63478S2;
	Fri, 14 Aug 2026 16:01:33 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Tobias Schrammm <t.schramm@manjaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] power: supply: cw2015_battery: export the I2C device table
Date: Fri, 14 Aug 2026 16:01:33 +0800
Message-ID: <20260814080133.21358-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAH2+5dy35qQbGeBQ--.63478S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF13CFyxCFWruF1rJw43Wrg_yoW8JFyfpa
	98uF9Iyw15ZFWUJa1jy3W3uFyjganxA34YkrZrK34a9ryayFyvv3ZrKrWY9ryDJF1rAF4I
	qrZIy3yxAF4fA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU2Q6
	JUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The I2C device ID table is used by the driver but is not exported
with MODULE_DEVICE_TABLE(). As a result, I2C module alias information is
not generated for automatic loading.

Export the existing table.

Fixes: b4c7715c10c1 ("power: supply: add CellWise cw2015 fuel gauge driver")
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260704152428.51844-1-pengpeng@iscas.ac.cn/
- rebase on current CW2015 sources
- add the coding-assistant disclosure

The driver-owned I2C table and module alias publication were reviewed
statically; no CW2015 hardware test was performed.

 drivers/power/supply/cw2015_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 7496295d2948..1bcb60cf763d 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -736,6 +736,7 @@ static const struct i2c_device_id cw_bat_id_table[] = {
 	{ .name = "cw2015" },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, cw_bat_id_table);
 
 static const struct of_device_id cw2015_of_match[] = {
 	{ .compatible = "cellwise,cw2015" },
-- 
2.50.1 (Apple Git-155)

