Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297473939B5
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062590; cv=none; b=Mt3aGna1T4kH8GkW7Ph5gvn3cgQHalHql6XLeH200hYwpR1jdNuITYlndlNqSwup8xc3nxllywDSAEDlcPzkfoxVOuUjuUqXuc2+LYgoLCMoxQfLBsuUdGuJLz9G5GraCbAU9Yq1bi6rD5BLwwro2Yx+P/D/paHMy7VAC5k/ZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062590; c=relaxed/simple;
	bh=dZlGgiNJR+pthvIMaRy0AOvoVGUKu3DW6sw/TqMaq0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WL+4qMOgRpTKQIAFXE9Jt1fFRHkDJYGq+wewRaPk6UF0KL+8SqVBgKqE93KtW5lQaWPDacC2z6T5fkymcdxFkrgsGl53/SJTndAAY0QXV/1WiHz2sO90cQ6R9h9NGWFwWE6+V4+tZZNUGn0Ofeke7IPK4/jbKqHg2WFMnfyWQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=mCsBNaGK; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="mCsBNaGK"
X-KPN-MessageId: 911249d4-2deb-11f1-92a9-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 911249d4-2deb-11f1-92a9-005056aba152;
	Wed, 01 Apr 2026 18:55:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=hjIQKQc09Ty4ZuPFqA4sflWylIiFqAt4knIEFLnMnCk=;
	b=mCsBNaGKrcGr9iA2v4Zn4uI3vZW1ONpVRB9wyNNvKdFA1eepmD3eefiVJNIWy788QLhtwitCile2J
	 1WZuK7YYRQ+lU6wVbK7xCQsJPO7vzmycqOdkqZErrSAP7jNP9vInmmEOnYy/VmAowGpYuhjFwdwfU7
	 2Nm6sUoNmfkT1om5agN0exqracUeZr0XNvsavnwQ/q9Bi8zK+7ZRrUwMw2SB5sPIMntX9R7rYJLs2Z
	 vY1RYSLcc2cUMAMvvmkgObQkuh2IKKclZwm4bl353oXeyffPv+9ma+9DrLK808JCFTcPTWsfuDvmYo
	 YjavapehGgh5uuqIkOv7F9A83DNCo/Q==
X-KPN-MID: 33|Z2mlv25z5aXT/aaAwB0yoliKC8HCdW0/BWmawlFHKblaT6SwIeJZPUjeNl5gyix
 /bxFr0peMrRsvj38BBMNeG4eQcPsfBoXYsNWvHkyHOtY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|7xgZbEoVUcxvZHXTz+CJbCJ6J75ncoo9ginBHhZem4cmWMmw7M+QYEIvD57OjUa
 HuLRXPec9j0JRq5l1Cf1S6w==
Received: from daedalus.home (unknown [178.227.141.37])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 8e442dd4-2deb-11f1-bdad-005056ab1411;
	Wed, 01 Apr 2026 18:55:19 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] devfreq: change devfreq_event_class to a const struct
Date: Wed,  1 Apr 2026 18:55:18 +0200
Message-ID: <20260401165519.3842485-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The class_create() call has been deprecated in favor of class_register()
as the driver core now allows for a struct class to be in read-only
memory. Change devfreq_event_class to be a const struct class and drop
the class_create() call. Compile tested.

Link: https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 drivers/devfreq/devfreq-event.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 179de3cf6d6c..9e183cd8818c 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -17,7 +17,13 @@
 #include <linux/list.h>
 #include <linux/of.h>
 
-static struct class *devfreq_event_class;
+static struct attribute *devfreq_event_attrs[];
+ATTRIBUTE_GROUPS(devfreq_event);
+
+static const struct class devfreq_event_class = {
+	.name		= "devfreq-event",
+	.dev_groups	= devfreq_event_groups
+};
 
 /* The list of all devfreq event list */
 static LIST_HEAD(devfreq_event_list);
@@ -321,7 +327,7 @@ struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 	edev->desc = desc;
 	edev->enable_count = 0;
 	edev->dev.parent = dev;
-	edev->dev.class = devfreq_event_class;
+	edev->dev.class = &devfreq_event_class;
 	edev->dev.release = devfreq_event_release_edev;
 
 	dev_set_name(&edev->dev, "event%d", atomic_inc_return(&event_no));
@@ -461,18 +467,15 @@ static struct attribute *devfreq_event_attrs[] = {
 	&dev_attr_enable_count.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(devfreq_event);
 
 static int __init devfreq_event_init(void)
 {
-	devfreq_event_class = class_create("devfreq-event");
-	if (IS_ERR(devfreq_event_class)) {
-		pr_err("%s: couldn't create class\n", __FILE__);
-		return PTR_ERR(devfreq_event_class);
-	}
+	int err;
 
-	devfreq_event_class->dev_groups = devfreq_event_groups;
+	err = class_register(&devfreq_event_class);
+	if (err)
+		pr_err("%s: couldn't create class\n", __FILE__);
 
-	return 0;
+	return err;
 }
 subsys_initcall(devfreq_event_init);

base-commit: d466c332e106fe666d1e2f5a24d08e308bebbfa1
-- 
2.53.0

