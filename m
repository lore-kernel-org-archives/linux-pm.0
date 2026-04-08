Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B274A3D1CC5;
	Wed,  8 Apr 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658059; cv=none; b=KvaiY3+s1nu6wMZwXDcVnx7U1mqAr8O8zvfI83EkahosXvR3yOsZXWeZ8nGOXh1Nd7k9U2Xd6rC18Gznq57QAAzt9TnixEwXdjIkzviFN31NvAKWpeHRiOIPZLtVZNmYJTcasWMVtnk7OfcEbZ+JLkdbewKRW0/qPs3yTKBLVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658059; c=relaxed/simple;
	bh=8WmkSpy4Ix8CxX9BBBqn764oSP5OdEq/fxn3SewG84k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAqcRdklr91UJ19f1NZGf2Cxydp9mUl6fzr+/K/zBKk7/NJc4btEWAaIWqGPB9VW3UHTHu0rkvMB3O5AiuQIHMSIk+psPqy+wv5e1Sd7eOwBMDkvRNrud6/5SVsKUGOygPMgCQoiis3dKNyiV52mcUwUoX5bdTdxJPNJFqZTIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: cA0vwFnzRBOs9WlYEoR5Tg==
X-CSE-MsgGUID: lnhWvXw1RiWYLDDrhxKl9A==
X-IronPort-AV: E=Sophos;i="6.23,167,1770566400"; 
   d="scan'208";a="172195258"
From: Tianxiang Chen <nanmu@xiaomi.com>
To: <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <lingyue@xiaomi.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tianxiang Chen
	<nanmu@xiaomi.com>
Subject: [PATCH v2] cpufreq: Fix hotplug-suspend race during reboot
Date: Wed, 8 Apr 2026 22:19:14 +0800
Message-ID: <20260408141914.35281-1-nanmu@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0ie54h2aK05qNZTWNw5bu7GZDgsxM55KSsuF=ReLMkm-w@mail.gmail.com>
References: <CAJZ5v0ie54h2aK05qNZTWNw5bu7GZDgsxM55KSsuF=ReLMkm-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX19.mioffice.cn (10.237.8.139) To YZ-MBX05.mioffice.cn
 (10.237.88.125)

During system reboot, cpufreq_suspend() is called via the
kernel_restart() -> device_shutdown() -> pm_notifier_call_chain()
path. Unlike the normal system suspend path, the reboot path does not
call freeze_processes(), so userspace processes and kernel threads
remain active.

This allows CPU hotplug operations to run concurrently with
cpufreq_suspend(). The original code has no synchronization with CPU
hotplug, leading to a race condition where governor_data can be freed
by the hotplug path while cpufreq_suspend() is still accessing it,
resulting in a null pointer dereference:

  Unable to handle kernel NULL pointer dereference
  Call Trace:
   do_kernel_fault+0x28/0x3c
   cpufreq_suspend+0xdc/0x160
   device_shutdown+0x18/0x200
   kernel_restart+0x40/0x80
   arm64_sys_reboot+0x1b0/0x200

Fix this by adding cpus_read_lock()/cpus_read_unlock() to
cpufreq_suspend() to block CPU hotplug operations while suspend is in
progress.

Signed-off-by: Tianxiang Chen <nanmu@xiaomi.com>
---
v2:
- Update changelog to explicitly mention reboot scenario
- Add observed crash trace
---
 drivers/cpufreq/cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1f794524a1d9..6f1d264c378b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1979,6 +1979,7 @@ void cpufreq_suspend(void)
 	if (!cpufreq_driver)
 		return;
 
+	cpus_read_lock();
 	if (!has_target() && !cpufreq_driver->suspend)
 		goto suspend;
 
@@ -1998,6 +1999,7 @@ void cpufreq_suspend(void)
 
 suspend:
 	cpufreq_suspended = true;
+	cpus_read_unlock();
 }
 
 /**
-- 
2.34.1

