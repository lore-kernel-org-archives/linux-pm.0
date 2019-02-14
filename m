From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime
Date: Thu, 14 Feb 2019 23:46:19 +0100
Message-ID: <2281684.8tZHfIXjiu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, =?utf-8?B?0K/RgNC+0YHQu9Cw0LIg0KHQtdC80YfQtdC90LrQvg==?= <ukrkyi@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On HP ProBook 4540s, if PM-runtime is enabled in the radeon driver
and the direct-complete optimization is used for the radeon device
during system-wide suspend, the system doesn't resume.

Preventing direct-complete from being used with the radeon device by
setting the DPM_FLAG_NEVER_SKIP driver flag for it makes the problem
go away, which indicates that direct-complete is not safe for the
radeon driver in general and should not be used with it (at least
for now).

This fixes a regression introduced by commit c62ec4610c40
("PM / core: Fix direct_complete handling for devices with no
callbacks") which allowed direct-complete to be applied to
devices without PM callbacks (again) which in turn unlocked
direct-complete for radeon on HP ProBook 4540s.

Fixes: c62ec4610c40 ("PM / core: Fix direct_complete handling for devices with no callbacks")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201519
Reported-by: Ярослав Семченко <ukrkyi@gmail.com>
Tested-by: Ярослав Семченко <ukrkyi@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/gpu/drm/radeon/radeon_kms.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/drivers/gpu/drm/radeon/radeon_kms.c
===================================================================
--- linux-pm.orig/drivers/gpu/drm/radeon/radeon_kms.c
+++ linux-pm/drivers/gpu/drm/radeon/radeon_kms.c
@@ -172,6 +172,7 @@ int radeon_driver_load_kms(struct drm_de
 	}
 
 	if (radeon_is_px(dev)) {
+		dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
 		pm_runtime_set_active(dev->dev);
