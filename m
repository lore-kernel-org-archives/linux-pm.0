Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C15054726;
	Thu,  2 Apr 2026 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775096880; cv=none; b=Lc/JsoZQLVggFtpTojDyZ1u+Sk4GLEk9+/lJkREIQ91uW7qsVoi9gTN9yCVnxTUEKDWTiIwmwB88Gl2bepiytUJhjfwOynzxxr+aZ0mV1cfBad3TUxr1D4BYSyEllO/IbOflfYJ3YYrbHseC3ydJMN1//NziNVkVbGVYxofr94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775096880; c=relaxed/simple;
	bh=z6mWm/u9S4vDSY0TVUH6SB/X/u63x4rPSaQD8DlRed8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ez3hInxPs9GDxZsG2ZYgTbxYPinV7tvRXnufHXWOCwur637ANrwnB3EikujpQxZQ5CTMSqVzyO2pZ56j7OzxS58Pvt461vjO4njFC1kvpbA7zK/yjQb7CNnkA66WnK1Hg9bQ3noO1waYiBDGs3rZhSNk8swWuwgwN5kPeDb4qWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8c72d7862e3b11f1aa26b74ffac11d73-20260402
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:68cfd259-ee02-4ad3-b046-ad4f25cf3ab4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:5adf657ceb9b6b905ebb3c6e4f3da857,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|898,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8c72d7862e3b11f1aa26b74ffac11d73-20260402
X-User: liujiajia@kylinos.cn
Received: from iris.lan [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1609488578; Thu, 02 Apr 2026 10:27:51 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiajia Liu <liujiajia@kylinos.cn>
Subject: [PATCH RESEND v1] thermal: core: fix blocking in unregistering zone
Date: Thu,  2 Apr 2026 10:27:42 +0800
Message-ID: <20260402022742.17738-1-liujiajia@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hwmon->tz_list has more than one member,
thermal_remove_hwmon_sysfs does not unregister hwmon->device.
Unregistering the zone which is parent of hwmon->device blocks
at wait_for_completion(&tz->removal). Add check and move hwmon
to other zone in thermal_remove_hwmon_sysfs.

One method of reproducing hung task is to unbind the first
acpitz zone on systems with two acpitz zones.

 $ cd /sys/bus/platform/drivers/acpi-thermal/
 $ ls
 bind  LNXTHERM:00  LNXTHERM:01  uevent  unbind
 $ echo 'LNXTHERM:00' | sudo tee unbind > /dev/null

Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---
 drivers/thermal/thermal_hwmon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index b624892bc6d6..43cde079fef0 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -242,6 +242,15 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 	list_del(&temp->hwmon_node);
 	kfree(temp);
 	if (!list_empty(&hwmon->tz_list)) {
+		if (hwmon->device->parent == &tz->device) {
+			struct thermal_hwmon_temp *first;
+
+			first = list_first_entry(&hwmon->tz_list,
+						 struct thermal_hwmon_temp,
+						 hwmon_node);
+			device_move(hwmon->device, &first->tz->device,
+				    DPM_ORDER_DEV_AFTER_PARENT);
+		}
 		mutex_unlock(&thermal_hwmon_list_lock);
 		return;
 	}
-- 
2.53.0

