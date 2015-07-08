From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCHv2 1/3] mfd: vexpress: Add parentheses around bridge->ops->regmap_init call
Date: Wed,  8 Jul 2015 14:30:16 +0800
Message-ID: <1436337018-32464-2-git-send-email-drinkcat@chromium.org>
References: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36300 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932387AbbGHGbD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 02:31:03 -0400
Received: by pddu5 with SMTP id u5so52433783pdd.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2015 23:31:02 -0700 (PDT)
In-Reply-To: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Boichat <drinkcat@chromium.org>, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lee Jones <lee.jones@linaro.org>, Maxime Coquelin <maxime.coquelin@st.com>, Ajit

regmap_init(...) is a macro since commit
"regmap: Use different lockdep class for each regmap init call".
That same name is used as a function pointer: prevent its expansion
by adding parentheses around the function pointer.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/bus/vexpress-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index a64763b..6575c0f 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -107,7 +107,7 @@ struct regmap *devm_regmap_init_vexpress_config(struct device *dev)
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
-	regmap = bridge->ops->regmap_init(dev, bridge->context);
+	regmap = (bridge->ops->regmap_init)(dev, bridge->context);
 	if (IS_ERR(regmap)) {
 		devres_free(res);
 		return regmap;
-- 
2.4.3.573.g4eafbef

