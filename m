From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: [PATCH RFC v1 2/3] Fix hibernation restore hang in freeze_processes
Date: Tue, 18 Feb 2014 17:52:08 -0800
Message-ID: <1392774729-3235-3-git-send-email-sebastian.capella@linaro.org>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:55070 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbaBSBwW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2014 20:52:22 -0500
Received: by mail-pd0-f178.google.com with SMTP id fp1so8385334pdb.9
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2014 17:52:21 -0800 (PST)
In-Reply-To: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Sebastian Capella <sebastian.capella@linaro.org>, Russ Dill <Russ.Dill@ti.com>, Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

During restore, pm_notifier chain are called with
PM_RESTORE_PREPARE.  The firmware_class driver handler
fw_pm_notify does not have a handler for this.  As a result,
it keeps a reader on the kmod.c umhelper_sem.  During
freeze_processes, the call to __usermodehelper_disable tries to
take a write lock on this semaphore and hangs waiting.

Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Russ Dill <Russ.Dill@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/firmware_class.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index eb8fb94..e2b51f8 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -1541,6 +1541,7 @@ static int fw_pm_notify(struct notifier_block *notify_block,
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
+	case PM_RESTORE_PREPARE:
 		kill_requests_without_uevent();
 		device_cache_fw_images();
 		break;
-- 
1.7.9.5

