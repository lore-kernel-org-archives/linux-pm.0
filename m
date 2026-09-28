Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45324BD7B4;
	Mon, 28 Sep 2026 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602132; cv=none; b=PudAvNhIiitOzSMSzImtdrmUaYLjIHysU7pLJ15QDmQMAlps/LTZqLcmnZ4ZFNEcV2S19ShVHj23obpjekJayvkGYt+cGyWcv8+0iKxkteDHCwK5qp2lXmULo+rdPIHJdjANOkeMR+t2ZTYgcWaiY5QVM6n8lBIpvdh02AccpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602132; c=relaxed/simple;
	bh=A12mMxs1KlWbHi4NGZ0aS3+TGDJ6Wsu/Wxx1xvAnGFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Te65td1PwiDLFrK6TggA/PTQwOjuagyGKsZBWB6QeuTi01M0LcdV8VJR7CCDkMmIftv9Jsif2zW/I2bIdUHuVcumBzW1eVZnOfEza6iTL4Fkhhu7Zs1AY//qnEA8WX0beTwKVQb+prGMNFvBgrW7O9n5o7nsyrUQ7GULaFLuMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmtMFO5J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmtMFO5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CEE1F000FF;
	Mon, 28 Sep 2026 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790602131;
	bh=MepXiiR8/SiK3rXnagkZ9Ru4v4HspQlVme1kNSfS+C4=;
	h=From:To:Cc:Subject:Date;
	b=bmtMFO5J8/MUgYpauuHV2Hr+4l0iW0YnQY/DjDznJHZYaPcCrpEt68H0Akta8pl4a
	 lSMKCdloi4vKG2JpOxJv2/WeTLd80qjywe1uD1NLLxga94CqPVshVJU8vmIC7lXLTm
	 0hgtzkEKJBi4Q0ISp1c/ouVcsOwCW+a4cE1tFbXCYdJT6EgAoP2dXhFUv0zrmcwbfB
	 bqyZfYJOBoZWlhe3G8XR/LvMvFosonhO7pH1Sld6TcA4PMpRxEolG0OYg9gJxOGS+/
	 tZS3MztiJuIIWQpwSyK7lzpkYwGX8RB1BMixnLoLThxdK1FVjOZ7olywidyADRawxn
	 y8njFVuwLyzwA==
From: djakov@kernel.org
To: amitk@kernel.org,
	thara.gopinath@gmail.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	anjelique.melendez@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com
Cc: linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Georgi Djakov <djakov@kernel.org>
Subject: [PATCH] thermal/drivers/qcom-spmi-temp-alarm: Fix temp_map indexing
Date: Mon, 28 Sep 2026 16:28:23 +0300
Message-Id: <20260928132823.1426513-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Georgi Djakov <djakov@kernel.org>

Fix the following issue noticed when booting on the db845c-dragonboard:

BUG: KASAN: global-out-of-bounds in qpnp_tm_sync_thresholds+0x11c/0x180 [qcom_spmi_temp_alarm]
Read of size 24 at addr ffffdd2495f01200 by task (udev-worker)/371

CPU: 3 UID: 0 PID: 371 Comm: (udev-worker) Not tainted 7.3.0-rc3 #116 PREEMPT
Hardware name: Thundercomm Dragonboard 845c (DT)
Call trace:
 show_stack+0x18/0x24 (C)
 dump_stack_lvl+0xa4/0xf4
 print_report+0x1f4/0x5ac
 kasan_report+0x84/0xcc
 kasan_check_range+0xf0/0x1a4
 memcpy+0x3c/0xa4
 qpnp_tm_sync_thresholds+0x11c/0x180 [qcom_spmi_temp_alarm]
 qpnp_tm_probe+0x3dc/0xae8 [qcom_spmi_temp_alarm]
 platform_probe+0xc4/0x18c
 really_probe+0x17c/0x4fc
 ...

The buggy address belongs to the variable:
 temp_map_gen1+0x60/0xc4 [qcom_spmi_temp_alarm]

It looks like temp_map is a pointer to the complete temperature map.
Indexing it directly advances the entire map, rather than selecting a
threshold row.

Fix this by dereferencing the temp_map before indexing it to select the
requested threshold row.

Fixes: 703f13285a6c ("thermal/drivers/qcom-spmi-temp-alarm: Add temp alarm data struct based on HW subtype")
Fixes: 1f835c6a4c84 ("thermal/drivers/qcom-spmi-temp-alarm: Prepare to support additional Temp Alarm subtypes")
Signed-off-by: Georgi Djakov <djakov@kernel.org>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index fb003ca96454..911ebfd0cdeb 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -345,8 +345,8 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 	}
 
 skip:
-	memcpy(chip->temp_thresh_map, chip->data->temp_map[threshold],
-		sizeof(chip->temp_thresh_map));
+	memcpy(chip->temp_thresh_map, (*chip->data->temp_map)[threshold],
+	       sizeof(chip->temp_thresh_map));
 	reg |= threshold;
 	if (disable_stage2_shutdown && !chip->require_stage2_shutdown)
 		reg |= SHUTDOWN_CTRL1_OVERRIDE_STAGE2;
@@ -535,8 +535,8 @@ static int qpnp_tm_sync_thresholds(struct qpnp_tm_chip *chip)
 		return ret;
 
 	threshold = reg & SHUTDOWN_CTRL1_THRESHOLD_MASK;
-	memcpy(chip->temp_thresh_map, chip->data->temp_map[threshold],
-		sizeof(chip->temp_thresh_map));
+	memcpy(chip->temp_thresh_map, (*chip->data->temp_map)[threshold],
+	       sizeof(chip->temp_thresh_map));
 
 	return ret;
 }
