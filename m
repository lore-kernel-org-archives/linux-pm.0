From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 07/12] PM / devfreq: export devfreq_class
Date: Tue,  3 Jul 2018 16:47:00 -0700
Message-ID: <20180703234705.227473-8-mka@chromium.org>
References: <20180703234705.227473-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703234705.227473-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

Exporting the device class allows other parts of the kernel to enumerate
the devfreq devices and receive notification when a devfreq device is
added or removed.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---
Changes in v5:
- none

Changes in v4:
- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag

Changes in v3:
- none

Changes in v2:
- patch added to series
---
 drivers/devfreq/devfreq.c | 3 ++-
 include/linux/devfreq.h   | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4cbaa7ad1972..38b90b64fc6e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -31,7 +31,8 @@
 #define MAX(a,b)	((a > b) ? a : b)
 #define MIN(a,b)	((a < b) ? a : b)
 
-static struct class *devfreq_class;
+struct class *devfreq_class;
+EXPORT_SYMBOL_GPL(devfreq_class);
 
 /*
  * devfreq core provides delayed work based load monitoring helper
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index c4f84a769cb5..964e064a951f 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -206,6 +206,8 @@ struct devfreq_freqs {
 };
 
 #if defined(CONFIG_PM_DEVFREQ)
+extern struct class *devfreq_class;
+
 extern struct devfreq *devfreq_add_device(struct device *dev,
 				  struct devfreq_dev_profile *profile,
 				  const char *governor_name,
-- 
2.18.0.203.gfac676dfb9-goog
