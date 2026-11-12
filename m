Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511218;
	b=qkU844waEgtn4Dng3fF4OlzYv8yuXP1JAyCyxisOFDYcPsWTfmEB3FVTgo/23tc0jBQv
	 7kxMuqPIvyEhgXDOZLC3DRoCiscLnv43l6ix86rp+VttlrNDPOUPDuyxkOF7Y7miVRT06
	 EKWnwL2Nfg7INtM223J87TUaIYYshkYmvFJnbsguUzkhO8OTw+Yobeo0R7nOYyso3XZ6n
	 /Y8X4uyUQbNic3RdTP2F8GQXqiEJRW9ewGaqSvKV0EyIiM1m4QIV1Uu8oec5mwRtaCaKa
	 yrJPDtFFVrpovzn1+bNCbbW4moIy9zEBMYXCydNNHyMX3S7XySh1y86qnvZGFLoUU3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PVPJ6zKdJ7kgvRyUlRiPX5ovk6pUYsEuwV1lOtnjEfA=;
	b=SfGyYilNPWwfDdkxNlTmX1xqKPzLPUYE5ItAV02KxOKkbgkda7cDpSbJ3rjKSZ2DJIlL
	 0cLLt8vHtcUbxW9BdYXRdKliBh+bU7bBA8djL9JgSR9guBt8VjIquyS9rZ+D64Bhvz19f
	 Lb/+YPji9OFHS31pY8YkzS+/rUeAk3V0YKaYvEdTlk12pIaCRAfQuIBz8l7Q9HlEujUwW
	 z+1CL6BeTc27ZifP5W6Ei/JfoF0+bPPakvvDubw/CYmZgMMpXzgVPAKNK450I5b+zaCmu
	 jQg8d9DfHfPQh1e5ZsUE9Z0eTUwPpaWWitLm7dXRw4GGogxm3JgcE9Z0J2Gf3Z0VwhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BFbfdZRs;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7C606A335
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 19:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0C7C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BFbfdZRs
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3704d30b84fso295175eec.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 11:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794511217; x=1795116017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PVPJ6zKdJ7kgvRyUlRiPX5ovk6pUYsEuwV1lOtnjEfA=;
        b=BFbfdZRsrkf/O6yYdWUn/qjrTGRP1SnCuPyAnUf2g31z+r8f7LYKu4p1+7P9M286HU
         rBcyk3gcIDdHrIYRAqc+TxMKHp87rsNzKzXKXZvJyeukjWLefmDIOk+d3F07qpOrczbF
         l6hPPcQqjo5KuDUR09wdAGQFYzn682P6Udnbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511217; x=1795116017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVPJ6zKdJ7kgvRyUlRiPX5ovk6pUYsEuwV1lOtnjEfA=;
        b=IxAIL1Js7aTs9gYPe6FBLttU5NANg8TG/Po7IVgruUKwA7ESqai/U62fxspv0/2SOQ
         99si/TDHoeyGS5bDEDzZ21wkM9//WdUdnGt6qA9Fw9V0PAinlug6/TCiIavOVxzKAKUp
         nyLwNHg8tew8yOLORUrRiz4VKaJ/0VNE6xyhNyhqxHV8DXbAABg52CT+hVS9OA3SuTZx
         VWcxTMIrvd2kW8ueWt8/CGvX5D9PSrTUw8IeMNY9hmt5jIF5f7YhZkAXZEsDNXiiZPOd
         SHFk7mmvm+3x2W3OxbunMhbHZYghIs89VuqjQQ1LazfT6luX4fmogtlq6a/IHJqFyjdB
         RmLw==
X-Forwarded-Encrypted: i=1; AL+hErE2gAo855uJr2LtEhP1uHemP0aLgh4pTDTB/ZGas40ewTaTRqNY+fBz5ITEV5Myqj7tYYLxl85a4Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Oj266bQ/iy6ZPtcwBG9CAhMgN/SlXbtkWHKS56qyBPIenfzUO
	N526IuS5AfGov3mcZAk8y52tdds8XVLbjq9D2yAeWHoJwS1MBZyw+c+UmmoSZN4+EQ==
X-Gm-Gg: AYBFou2d1EBZlC5ahkvzIHJMzVt6XfzuOPPbmMz6Ba1c2yjKM8GWV+g9re4eeq+FhFH
	JW6vum4UT3O8V31LmbXreDjSoJ4WwnCbc1LvQIxWSuKdMVX276T1jkvQq5kpcyvwrQvTS1NJP+e
	ECH6yXNQq1pNmY7fzi4sc/GeXqJ7rPWSkYLkx0iH/3vTkcFc6c+6sTpWBg/IEl6uYOP+CJQzizE
	HUgLIiwGoBBKxlI7IJhf8DyIaA1Av9itqPEkY85bcxqFHHRA5cDDcBndAi9hnMiXjoCrdTO2Nis
	cIS89Jb4XlVxoy2vO05OP18ZL6XgnvgptFPPvaFVD04jRIN01EXcWyH7zGEBMXpNBJoGHKHJr/I
	oRcqGnrhpsyLUyyT65vwBrH+c0waiwYDZUDPcOjSh7fmqmC2SzdM5m/NiNAjEAEnlCSQulGZzC0
	c2SKne/Y1uhvjoOzAWr8t452fe7TvTcXEqoSaD+b52+0l1AHza3krNRCrdo03k3LcOurSRIlE/C
	N0GQWOwBsGqn5BO2clZXVkkW0clurkHA3l514yHGRxvLuRntINTXydJvK9X3wAEr0nBp1FXTLjy
	bwnOLNYFOHqcHM4wyw50Z8UDNTRB8Gv81Xc7co8o8lQiI0pjGAnVMQmKxN3vOHmaEyve
X-Received: by 2002:a05:7301:2a9c:b0:372:79a0:e8a3 with SMTP id 5a478bee46e88-37963374fdemr130138eec.1.1794511216522;
        Thu, 12 Nov 2026 11:20:16 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:5446:563c:ac92:43a8])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-379558231eesm516606eec.12.2026.11.12.11.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:20:15 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-pm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Brian Norris <briannorris@chromium.org>,
	linux-arm-msm@vger.kernel.org
Subject: [RESEND PATCH 1/3] ASoC: codecs: lpass: Discard pm_runtime_put_autosuspend() return values
Date: Thu, 12 Nov 2026 11:19:37 -0800
Message-ID: <20261112111937.RESEND.1.I5cd238b1d4516d4d6980565e0a4e1b83d9abce63@changeid>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
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

Printing warning messages on pm_runtime_put_autosuspend() returning
negative values is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

Accordingly, update the LPASS macro codec drivers to simply discard the
return value of pm_runtime_put_autosuspend().

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch was originally sent as part of a larger series here:
https://lore.kernel.org/all/20261006161337.9.I5cd238b1d4516d4d6980565e0a4e1b83d9abce63@changeid/

I expect it should be merged by subsystem maintainers, and we can make
the return type change later.

 sound/soc/codecs/lpass-rx-macro.c  |  4 +---
 sound/soc/codecs/lpass-tx-macro.c  |  4 +---
 sound/soc/codecs/lpass-va-macro.c  | 17 ++++-------------
 sound/soc/codecs/lpass-wsa-macro.c |  8 ++------
 4 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index ab8a1c2b0489..c703275fc442 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3919,9 +3919,7 @@ static int rx_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_rpm_put;
 
-	ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0)
-		dev_warn(dev, "runtime PM put failed after probe: %d\n", ret);
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index def7dcc2058d..26e8486ce041 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -2370,9 +2370,7 @@ static int tx_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_rpm_put;
 
-	ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0)
-		dev_warn(dev, "runtime PM put failed after probe: %d\n", ret);
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 61b24a1e4dde..a090b3e7b5e1 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1352,7 +1352,7 @@ static int fsgen_gate_enable(struct clk_hw *hw)
 {
 	struct va_macro *va = to_va_macro(hw);
 	struct regmap *regmap = va->regmap;
-	int ret, rpm_ret;
+	int ret;
 
 	ret = pm_runtime_resume_and_get(va->dev);
 	if (ret < 0)
@@ -1360,11 +1360,7 @@ static int fsgen_gate_enable(struct clk_hw *hw)
 
 	ret = va_macro_mclk_enable(va, true);
 	if (ret) {
-		rpm_ret = pm_runtime_put_autosuspend(va->dev);
-		if (rpm_ret < 0)
-			dev_warn(va->dev,
-				 "runtime PM put failed in fsgen enable unwind: %d\n",
-				 rpm_ret);
+		pm_runtime_put_autosuspend(va->dev);
 		return ret;
 	}
 	if (va->has_swr_master)
@@ -1378,7 +1374,6 @@ static void fsgen_gate_disable(struct clk_hw *hw)
 {
 	struct va_macro *va = to_va_macro(hw);
 	struct regmap *regmap = va->regmap;
-	int ret;
 
 	if (va->has_swr_master)
 		regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
@@ -1386,9 +1381,7 @@ static void fsgen_gate_disable(struct clk_hw *hw)
 
 	va_macro_mclk_enable(va, false);
 
-	ret = pm_runtime_put_autosuspend(va->dev);
-	if (ret < 0)
-		dev_warn(va->dev, "runtime PM put failed in fsgen disable: %d\n", ret);
+	pm_runtime_put_autosuspend(va->dev);
 }
 
 static int fsgen_gate_is_enabled(struct clk_hw *hw)
@@ -1693,9 +1686,7 @@ static int va_macro_probe(struct platform_device *pdev)
 		goto err_rpm_put;
 	}
 
-	rpm_ret = pm_runtime_put_autosuspend(dev);
-	if (rpm_ret < 0)
-		dev_warn(dev, "runtime PM put failed after probe: %d\n", rpm_ret);
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index e3fe8d0af8be..6d330bd4eddb 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2559,9 +2559,7 @@ static int wsa_swrm_clock(struct wsa_macro *wsa, bool enable)
 				   CDC_WSA_SWR_CLK_EN_MASK, 0);
 		wsa_macro_mclk_enable(wsa, false);
 
-		ret = pm_runtime_put_autosuspend(wsa->dev);
-		if (ret < 0)
-			dev_warn(wsa->dev, "runtime PM put failed: %d\n", ret);
+		pm_runtime_put_autosuspend(wsa->dev);
 	}
 
 	return 0;
@@ -2833,9 +2831,7 @@ static int wsa_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_rpm_put;
 
-	ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0)
-		dev_warn(dev, "runtime PM put failed after probe: %d\n", ret);
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 err_rpm_put:
-- 
2.56.0.611.g1030f0b940-goog

