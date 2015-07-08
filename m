From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCHv2 2/3] thermal: sti: Add parentheses around bridge->ops->regmap_init call
Date: Wed,  8 Jul 2015 14:30:17 +0800
Message-ID: <1436337018-32464-3-git-send-email-drinkcat@chromium.org>
References: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Boichat <drinkcat@chromium.org>, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lee Jones <lee.jones@linaro.org>, Maxime Coquelin <maxime.coquelin@st.com>, Ajit
List-Id: linux-pm@vger.kernel.org

regmap_init(...) is a macro since commit
"regmap: Use different lockdep class for each regmap init call".
That same name is used as a function pointer: prevent its expansion
by adding parentheses around the function pointer.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/thermal/st/st_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 76c515d..88c759d 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -214,7 +214,7 @@ int st_thermal_register(struct platform_device *pdev,
 
 	sensor->ops = sensor->cdata->ops;
 
-	ret = sensor->ops->regmap_init(sensor);
+	ret = (sensor->ops->regmap_init)(sensor);
 	if (ret)
 		return ret;
 
-- 
2.4.3.573.g4eafbef
