Received: from mail-m3295.qiye.163.com (mail-m3295.qiye.163.com [220.197.32.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC23DB649;
	Thu, 23 Jul 2026 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794416; cv=none; b=Zl+kBTKIozBdT/P3Nkw0HlSH4dyDdXS7MRE7grlG0JxtY2UdCvRd9TZaUHL+dpOB5JYpePuaMyOGVlWKa05RFcUJGClXZvXNh1q/yXDDY3tdkJGAgx1XlJDv/aJygzH2ZHTa24IcsJ6+T5+pb3p3dzbFbxLpvOJrnnINzgaWrlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794416; c=relaxed/simple;
	bh=MmzUD9kxBZ/p+fKnPO1gv9hauAbmio+h6AEg0rju6Wc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oBuGyPKN4U/DRe3lRrKkUWUo+AL6JLM2Z+TPd9GMYEizOXWiNjyNoJpXRwihBWxcQU9a0mFLLpXhp9Ee3vmLaNce2x0BIROQCtxcSF+M7D7IvTJWXrdXxY/R+kaumy2mZXpHI4lXuEayNKwyuBWWF6efmkVETVKcqenu4VA7VJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Gp2Y/Byi; arc=none smtp.client-ip=220.197.32.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Gp2Y/Byi"
Received: from finley.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 474aa2101;
	Thu, 23 Jul 2026 16:08:08 +0800 (GMT+08:00)
From: Finley Xiao <finley.xiao@rock-chips.com>
To: finley.xiao@rock-chips.com,
	heiko@sntech.de,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] PM / devfreq: governor_userspace: Guard against NULL governor_data during switch
Date: Thu, 23 Jul 2026 16:08:06 +0800
Message-ID: <20260723080806.1451-1-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f8e04843c03a8kunm06cfeb95392759
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUpCVk0eShpOT01MTxlJSlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Gp2Y/ByiGNqDuQTiQEDVj6I5OJtMptscFvBh2bxKQQAbuQo/dijxdWF/zSl0eajT05JrUdwb1gaVQMIBamCnfQE35salZGLRXJ0Ieb2e1y0MScdnZb7AEDeQt6yGZzOW9qcj7lk4iFYxOK5kpdcIGMjFyMgpmTa+A4QIellJ/YU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=z7WD5F3iNVCYup8QrBprb+wSkzvfUuLvDHIwAXjeAxw=;
	h=date:mime-version:subject:message-id:from;

The userspace governor is the only one that uses devfreq->governor_data,
allocated in its DEVFREQ_GOV_START handler (userspace_init()) and freed
in its DEVFREQ_GOV_STOP handler (userspace_exit()).

When switching governors via sysfs (governor_store in devfreq.c), the
sequence is:

STOP(old) -> df->governor = userspace -> START(userspace) -> userspace_init

Between the df->governor assignment and userspace_init() completing,
governor_data is still NULL (the previous governor never touched it,
and the core does not clear or pre-allocate it). During that window,
asynchronous paths that call update_devfreq() outside of the driver's
control -- the OPP notifier (devfreq.c:686) and the pm_qos notifier
(devfreq.c:707) -- run devfreq_update_target() under df->lock and reach
devfreq_userspace_func(), which dereferences governor_data without a
NULL check, causing:

  Unable to handle kernel access to user memory outside uaccess routines
  pc : devfreq_userspace_func+0xc/0x28
  lr : devfreq_update_target+0x58/0x158

Add a NULL check in devfreq_userspace_func() and fall back to
previous_freq, which is the same behaviour as the existing "no user
frequency specified yet" branch. This closes the race for all callers
since every path ultimately goes through get_target_freq.

Additionally, take devfreq->lock around the kfree()/NULL assignment in
userspace_exit(). Without it, a concurrent OPP/pm_qos notifier running
under devfreq->lock could read governor_data after it is freed but
before it is set to NULL, constituting a use-after-free.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 drivers/devfreq/governor_userspace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 3906ebedbae8..f7a485c43fd7 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -24,7 +24,7 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
 {
 	struct userspace_data *data = df->governor_data;
 
-	if (data->valid)
+	if (data && data->valid)
 		*freq = data->user_frequency;
 	else
 		*freq = df->previous_freq; /* No user freq specified yet */
@@ -110,8 +110,10 @@ static void userspace_exit(struct devfreq *devfreq)
 	if (devfreq->dev.kobj.sd)
 		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
 
+	mutex_lock(&devfreq->lock);
 	kfree(devfreq->governor_data);
 	devfreq->governor_data = NULL;
+	mutex_unlock(&devfreq->lock);
 }
 
 static int devfreq_userspace_handler(struct devfreq *devfreq,
-- 
2.43.0

