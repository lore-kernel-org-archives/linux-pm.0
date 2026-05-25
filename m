Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAC13A1DB;
	Mon, 25 May 2026 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722187; cv=none; b=bJKbrhjabsMmRAfGBAMS79SOmoAIMVXwoGn7nMbzNuoTmaSXr8epO1gSYvZIUrbcGx8hR2w3WCr/KSPDdRudxzoLzRF5xD0mC6fKP9zNtulICgPIGWtvrGmwfWxrK7NvKsiwboFn2gXGXTom4yLi1Y4e2wTwvM74ZvbybHr8JHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722187; c=relaxed/simple;
	bh=o5SM7+2ttmpBlzIdPqcCHN6SUVmayLwa2HTCbimM84U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fojISx383BljLwfd9V6gNqs7kdPY7fzCnNgM14/dp4FPyzvO0AxKN+pqD5rFn8NYzOOekiwfhgtpYGIde4ot33NVSo+4VRDOO1VytTTKNCmVkOgwxeYnRRJcOQzriThxHlsK1iH+wVYiI7xeFwDOa+4Cgi25esNATKu1SKSnvag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaJIQGYC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaJIQGYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C6B1F000E9;
	Mon, 25 May 2026 15:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779722186;
	bh=jcbOcUoUhFls73GT8GVM12doLK9adORdLLd2M1U8XuQ=;
	h=From:To:Cc:Subject:Date;
	b=EaJIQGYC0M4rVJNMSmq1JAUNhISfnRA1LKz3gMUZh21HFlbx2msjcW7BbOYYvTbeZ
	 458UeEKxmETuM0YJ7tP5oD2XgKY3O/+4u2VhP3TE5uFxXBBvoyITKjNUO3UW7nHFdF
	 hOYl7at+pacIQ2eB9VILjASlzTFe54yAZz/4Z+/2WdoLnyu+Z2lsrlm9S9IFXtadac
	 38008kgt2N8B5XCmf2Nhzim2IvXSP8VHB5yZDZvuQAwAjuxD7twi80NddQ01oupCqZ
	 Zf2DFi8ai0kfu5eEQkgrcHYj58lrIrH/MjUkI8wjOl57qx7wdzJrIF/Z3X3JVvIbrB
	 N/ZXTZCVsveGw==
From: Daniel Lezcano <daniel.lezcano@kernel.org>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: linux-pm@vger.kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/core: Fix double device initialization
Date: Mon, 25 May 2026 17:16:10 +0200
Message-ID: <20260525151609.2826121-2-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234; i=daniel.lezcano@kernel.org; h=from:subject; bh=o5SM7+2ttmpBlzIdPqcCHN6SUVmayLwa2HTCbimM84U=; b=owEBbQGS/pANAwAIAagyI4oqT+hPAcsmYgBqFGe5K3YQnK7o2+aRO72p840KInnK4Xwa7jZtJ wXr0YuUC+yJATMEAAEIAB0WIQQafc3hhXPRY1XIeySoMiOKKk/oTwUCahRnuQAKCRCoMiOKKk/o T5KvB/41YT4WlDynBhqqfVmwjFIu4SusmbU6kFAx/Nx7WAV7ZNvIWo3VKuUbDZMpvf21udrQ0pT 3CZ7H2sJZjBiIzrMwpdAgn5rcvv0SZcoFUSN+Kfq4hoduoa9NPpFvmQmiD8de21tw/tTQUHMuPE wKBVVZ6ZnnvSKG1mK44AolRVCxfq1ZtWvJ3aCnRrzQi0bcuDK9SraXsrbCFFP97ato8K5qDKtIp BGE+1befaYtwyViHJPNEbS2N4a6kNCvDXmB4dYUERsasZ02pOVsh1GSrRBg8wKMYJkgok5oKBgg M+dOr0lAThrHCkbEWW8VMC3gF4q2C3g1pwUhaXaF9iUaK6Cz
X-Developer-Key: i=daniel.lezcano@kernel.org; a=openpgp; fpr=24D626F253BE9E87E6CE5BF48FF4B8D271675527
Content-Transfer-Encoding: 8bit

In the previous change splitting the cooling device register function,
the device initialization was mistakenly added in the move.

This change is wrong because the device is registered with the
function device_register() which does device_initialize() and then
device_add(). That results in a double initialization and a message in
logs:

[    1.531290] kobject: kobject (0000000053ba73b2): tried to init an initialized object, something is seriously wrong.
[    1.531293] CPU: 9 UID: 0 PID: 420 Comm: kworker/u50:3 Not tainted 7.1.0-rc1+ #48 PREEMPT(lazy)
[    1.531294] Hardware name: LENOVO 21N10007UK/21N10007UK, BIOS N42ET38W (1.12 ) 05/29/2024
[    1.531295] Workqueue: events_unbound deferred_probe_work_func
[    1.531298] Call trace:
[    1.531298]  show_stack+0x24/0x50 (C)
[    1.531301]  dump_stack_lvl+0x80/0xc0
[    1.531303]  kobject_init+0xc0/0xd8
[    1.531305]  device_initialize+0x3c/0x140
[    1.531308]  device_register+0x20/0x48
[    1.531310]  thermal_cooling_device_add+0xe0/0x208
[    1.531311]  thermal_of_cooling_device_register+0x54/0xa0
[    1.531313]  __cpufreq_cooling_register+0x1e0/0x368
[    1.531315]  of_cpufreq_cooling_register+0x64/0xe0
[    1.531316]  cpufreq_online+0xa6c/0xef0
[    1.531317]  cpufreq_add_dev+0x108/0x180
[    1.531318]  subsys_interface_register+0x138/0x168
[    1.531320]  cpufreq_register_driver+0x1b8/0x390

Fix by just removing the added line.

Fixes: 13f4e660a126 ("thermal/core: Split __thermal_cooling_device_register() into two functions")
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/thermal_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9b9fa51067bd..3cf305ceaf41 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1012,7 +1012,6 @@ static int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void
 	cdev->updated = false;
 	cdev->device.class = thermal_class;
 	cdev->device.release = thermal_cdev_release;
-	device_initialize(&cdev->device);
 	cdev->devdata = devdata;
 
 	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
-- 
2.43.0

