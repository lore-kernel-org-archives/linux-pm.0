Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7128638E5F9;
	Fri, 28 Aug 2026 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908895; cv=none; b=KQYdosWcVQxREmJ3QlA6Titz+dWMbkzf38njVbi0i8uhHc4CcHtkzu6NtNb27ulHGCJZzpbyAYpuIrHfZAPObZBJaIn9aa/bmHOgCpMqCUgB11hCT8C7xZKFllD1PShR2ihWbdC1SoG5ALKXlAs4ngjmMsaS4ErfOlNNRnEQtuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908895; c=relaxed/simple;
	bh=j6YQgf6FwIVaMMxB4QIQAm887k/7zlpmVlYw4bqoXi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNFbXQ6k7rxlTjj2v/4sUU+wTJArFJ+/+mBqtzsrhJA/+/yAHszKkiwIOrhEc5AJPkjS1VoROkd7TbLhBhZ7R00fzLU17TiwVHJ08dvAX9wNvwZFapJgMciCK0Q03pLuFg1caIv7Xe6lnvx9gqfr0nxGrUio3b/yIsjw5GKWDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowAD3+zkVU5FqI1F1Bg--.10685S2;
	Fri, 28 Aug 2026 17:21:25 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] thermal: rzg3e: Propagate reset assertion failure from suspend
Date: Fri, 28 Aug 2026 17:21:23 +0800
Message-ID: <20260828092123.9707-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3+zkVU5FqI1F1Bg--.10685S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryrurykZr1UWF17CFWDCFg_yoW8WFy5pF
	4kGF4UCr4DWF18Aa12yr4kZF9YkFWSkFW3XryrKwn5Za13A34ftFyYvFWaq3y8Jry8tFyr
	CF47tw4UCF4DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbtxhJ
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

rzg3e_thermal_suspend() powers off an active sensor and then ignores
failure to assert its reset.  System sleep can therefore continue
without the clean reset state expected by resume.

Return the reset error and, when the sensor had been active, try to
restore power before failing suspend.  This remains an RFC because a
reset assertion failure can represent partial hardware state and the
preferred recovery policy needs platform confirmation.

The issue was identified via static analysis and manually reviewed.

Assisted-by: LLM
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index c44f5b8858d0..7686a45341b3 100644
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
-- 
2.43.0

