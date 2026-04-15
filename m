Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F563612D8
	for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265672; cv=none; b=Q8oUOvjQ/mNoVDuqKzuzhIxUvn6fz5Q6E2XStLGoGFpeNE2SOIN5w1oiUFrBQgoNTYajT8jAi+UQ5DvACpB+hGDL+o5Kvryoh0bjhaK2Ip1mvUzzbd+JTK4op6nfnnD/Y0Rz2lQq7EMQ79uwf21YH6cAVeBnSyLFYAmK6t00J2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265672; c=relaxed/simple;
	bh=Drt4olyRuT2tALLQ8RuoYoBxrj8siEgxgXFJHNRMNDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=STuHbN+Zm6+vtqvZv64F3bhkC3AwcupHMaTQw/W+LtaWCQf46X6bY8nvcxloFIKWtmJfReQAf0CCfgbwi+F0hGa8AJSY8N9kxdIBg0oSYsNFYkHQgWohQjpqM7xg0WSPdSmtOJMmv5H05T/EnkqK9hmjQ56T4ICPK9MguC5afig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7Cb/5Um; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7Cb/5Um"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad9a9be502so42192305ad.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776265671; x=1776870471; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N1pLRZfOG8G8WCP9cuAbEmSh0QlKpjJAukNE5nT+L34=;
        b=i7Cb/5Umb6WAHf7MqRdCHX2fZ5//G1te8XwqWYfoSjkvpLim2gWPIddLTEWY2dmjqT
         oGRbmzZGkUou112aEqSNz+Na5Yj4mW5vtLEx8Rp8uwXY0dKzkk8M2QlaS6CCv+CnCy/q
         Qe8rAKfEyUijaJvtmfO2+N7xqee02Y1LEQ2/GsdIh7sCr+myZEFCpmfJSy+fcRyUWPTa
         7FTj1xZMB1lloClsgAsFF8DMLK1V3Z4LIKpT/tFdKlMxfek3rFG+ViCGM3Q49ZRAgAyP
         kq74l+HcYlUg7pRLetv3iCgKjJtKHJf36mlmuLxr/dyRBHuS9xo+7L6EBaoBJRXfH/lR
         IF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265671; x=1776870471;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1pLRZfOG8G8WCP9cuAbEmSh0QlKpjJAukNE5nT+L34=;
        b=OlHalVTxJEEncKIHZrkTYELd5Q+SBiZr8SKnJL+gXBWs7qcQ++gSp1hpfmtn7O/MAX
         Br4hDePDq9zw2aKk45X9YypsUNn1PE1rSjBrf0RFi0FaZozPdMzbvAAtJ609gPBNF7wS
         gLGVsqQK8NIQOt+HOo6a2AdrVx/q2k+VoIRg5I9Q5gkNFkvWHborgMEjb3mbvljUVIlt
         UE717AuOXSoQK4N9eyph7o7LiEFhAMQFnudn1X9T+kvX9C9DO5M46UTgBblUNEQUJlDv
         82uihfLB+/+WMubUmWEOx+xGrsQk8co08uUPOsPZk6mJXkIG5/PldtkLv09D9ij4nsec
         iN/w==
X-Gm-Message-State: AOJu0YxP9xIBXtKFZ8uU6y+nbBv28ZYPOZ/ngXLrRcs3lA1dq565OZ7X
	53rPAOUy5S6PmQbEA/vzcEcdae1wedkBy3NCh9jclVjBX2guHDp/EEmQW3R2L3sdguc=
X-Gm-Gg: AeBDietMErkZjBJRWhVmu9Lnz1rnsrvVP1Qwcv0POWztPURhJalU9F/m4nzvN/EY6+H
	effGpUMzpyZLjG1Oi9e7p49PSfIu2+PVNu6OkREWcvZomf2fTzXs77mjVrcJQNzEkS3Few++VZE
	wrPeNkIi07TU/7Jk8NofU/RMVEG6BiNU+Ysv3whd73c9YPt1CZeceHL/Ik/FVAbGxMz7dveshAx
	pPoTkddSfcXR54cPNzRERMjTANJ55GGZUJoXLiwxE3kJG66awLl4YNvcsaojlCjfM4sPcHUOBcw
	0VCZGHpStR6BU5mRdxizqdr0QjHAvVxK8BEB9eTBk94Gb2vlwY3tDUnFOsPLHcE1wjbSUUkIjXZ
	hoGCzTl9z5h7+oqaQqsueYXLqOyKJgl5gPFtScud9RwJMWqf53by+Vk42t3zERNmtTvjmTUWUFY
	jSXrRlQwuZo4JoiyQkuGelTwagx6e0OoVUMmsaXbH01IC0FdyIGFVGKbwVdWlXp3X6yOiy7vfwn
	jdbYvT2S6HafZe+CPVwMtLE+KX5Z5M=
X-Received: by 2002:a17:902:7c93:b0:2b2:3bb6:fbf8 with SMTP id d9443c01a7336-2b2d599a212mr161470545ad.16.1776265670548;
        Wed, 15 Apr 2026 08:07:50 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780f024csm22870865ad.3.2026.04.15.08.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:07:50 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 15 Apr 2026 23:07:45 +0800
Subject: [PATCH] thermal/drivers/sprd: Use for_each_child_of_node_scoped()
 in probe
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-sprd-v1-1-aec5b32b3094@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMCp32kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0NT3eKCohRdYwNjk2TjxERLMxNLJaDSgqLUtMwKsDHRsbW1AAxK+F5
 WAAAA
X-Change-ID: 20260415-sprd-3034c3aa9649
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776265667; l=2627;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=Drt4olyRuT2tALLQ8RuoYoBxrj8siEgxgXFJHNRMNDQ=;
 b=KfyzGULnOa0OCC/QPWI6zBBfD4MoOZqf71Aj3o1D5/tAOpiQpv6nFOOE55lZh4UMjcKEz/kq4
 m+563VKjNq0BUQnuW+KzAsOAIgiNM34pEM9wO0BDVpU0u7ZmL/w34av
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Use for_each_child_of_node_scoped() to avoid manual cleanup
of_node_put() in early exits from the loop, simplify the code.

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/thermal/sprd_thermal.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index d683fcb0f8ab..069bc13ffc57 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -331,7 +331,6 @@ static void sprd_thm_toggle_sensor(struct sprd_thermal_sensor *sen, bool on)
 static int sprd_thm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *sen_child;
 	struct sprd_thermal_data *thm;
 	struct sprd_thermal_sensor *sen;
 	const struct sprd_thm_variant_data *pdata;
@@ -380,12 +379,10 @@ static int sprd_thm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	for_each_child_of_node(np, sen_child) {
+	for_each_child_of_node_scoped(np, sen_child) {
 		sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
-		if (!sen) {
-			ret = -ENOMEM;
-			goto of_put;
-		}
+		if (!sen)
+			return -ENOMEM;
 
 		sen->data = thm;
 		sen->dev = &pdev->dev;
@@ -393,13 +390,13 @@ static int sprd_thm_probe(struct platform_device *pdev)
 		ret = of_property_read_u32(sen_child, "reg", &sen->id);
 		if (ret) {
 			dev_err(&pdev->dev, "get sensor reg failed");
-			goto of_put;
+			return ret;
 		}
 
 		ret = sprd_thm_sensor_calibration(sen_child, thm, sen);
 		if (ret) {
 			dev_err(&pdev->dev, "efuse cal analysis failed");
-			goto of_put;
+			return ret;
 		}
 
 		sprd_thm_sensor_init(thm, sen);
@@ -411,31 +408,25 @@ static int sprd_thm_probe(struct platform_device *pdev)
 		if (IS_ERR(sen->tzd)) {
 			dev_err(&pdev->dev, "register thermal zone failed %d\n",
 				sen->id);
-			ret = PTR_ERR(sen->tzd);
-			goto of_put;
+			return PTR_ERR(sen->tzd);
 		}
 
 		thm->sensor[sen->id] = sen;
 	}
-	/* sen_child set to NULL at this point */
 
 	ret = sprd_thm_set_ready(thm);
 	if (ret)
-		goto of_put;
+		return ret;
 
 	ret = sprd_thm_wait_temp_ready(thm);
 	if (ret)
-		goto of_put;
+		return ret;
 
 	for (i = 0; i < thm->nr_sensors; i++)
 		sprd_thm_toggle_sensor(thm->sensor[i], true);
 
 	platform_set_drvdata(pdev, thm);
 	return 0;
-
-of_put:
-	of_node_put(sen_child);
-	return ret;
 }
 
 #ifdef CONFIG_PM_SLEEP

---
base-commit: 936c21068d7ade00325e40d82bfd2f3f29d9f659
change-id: 20260415-sprd-3034c3aa9649

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

