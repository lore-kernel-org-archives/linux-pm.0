From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH] drivers: cpufreq: Remove unused function in cpufreq.c
Date: Wed, 26 Feb 2014 21:16:25 +0530
Message-ID: <20140226154625.GA10701@rashika>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, josh@joshtriplett.org
List-Id: linux-pm@vger.kernel.org

Remove unused function show_boost() in drivers/cpufreq/cpufreq.c.

This eliminates the following warning in drivers/cpufreq/cpufreq.c:
drivers/cpufreq/cpufreq.c:355:9: warning: no previous prototype for =E2=
=80=98show_boost=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
---
 drivers/cpufreq/cpufreq.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 08ca8c9..6dce474 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -352,12 +352,6 @@ EXPORT_SYMBOL_GPL(cpufreq_notify_post_transition);
 /*********************************************************************
  *                          SYSFS INTERFACE                          *
  *********************************************************************=
/
-ssize_t show_boost(struct kobject *kobj,
-				 struct attribute *attr, char *buf)
-{
-	return sprintf(buf, "%d\n", cpufreq_driver->boost_enabled);
-}
-
 static ssize_t store_boost(struct kobject *kobj, struct attribute *att=
r,
 				  const char *buf, size_t count)
 {
--=20
1.7.9.5
