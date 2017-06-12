From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] PM / sysfs: Constify attribute groups
Date: Mon, 12 Jun 2017 17:19:33 +0200
Message-ID: <20170612151933.7588-3-krzk@kernel.org>
References: <20170612151933.7588-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612151933.7588-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pm@vger.kernel.org

Local instances of struct attribute_group are not modified so they can
be made const to increase code safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/base/power/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 33b4b902741a..185a52581cfa 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -607,7 +607,7 @@ static struct attribute *power_attrs[] = {
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
 	NULL,
 };
-static struct attribute_group pm_attr_group = {
+static const struct attribute_group pm_attr_group = {
 	.name	= power_group_name,
 	.attrs	= power_attrs,
 };
@@ -629,7 +629,7 @@ static struct attribute *wakeup_attrs[] = {
 #endif
 	NULL,
 };
-static struct attribute_group pm_wakeup_attr_group = {
+static const struct attribute_group pm_wakeup_attr_group = {
 	.name	= power_group_name,
 	.attrs	= wakeup_attrs,
 };
@@ -644,7 +644,7 @@ static struct attribute *runtime_attrs[] = {
 	&dev_attr_autosuspend_delay_ms.attr,
 	NULL,
 };
-static struct attribute_group pm_runtime_attr_group = {
+static const struct attribute_group pm_runtime_attr_group = {
 	.name	= power_group_name,
 	.attrs	= runtime_attrs,
 };
@@ -653,7 +653,7 @@ static struct attribute *pm_qos_resume_latency_attrs[] = {
 	&dev_attr_pm_qos_resume_latency_us.attr,
 	NULL,
 };
-static struct attribute_group pm_qos_resume_latency_attr_group = {
+static const struct attribute_group pm_qos_resume_latency_attr_group = {
 	.name	= power_group_name,
 	.attrs	= pm_qos_resume_latency_attrs,
 };
@@ -662,7 +662,7 @@ static struct attribute *pm_qos_latency_tolerance_attrs[] = {
 	&dev_attr_pm_qos_latency_tolerance_us.attr,
 	NULL,
 };
-static struct attribute_group pm_qos_latency_tolerance_attr_group = {
+static const struct attribute_group pm_qos_latency_tolerance_attr_group = {
 	.name	= power_group_name,
 	.attrs	= pm_qos_latency_tolerance_attrs,
 };
@@ -672,7 +672,7 @@ static struct attribute *pm_qos_flags_attrs[] = {
 	&dev_attr_pm_qos_remote_wakeup.attr,
 	NULL,
 };
-static struct attribute_group pm_qos_flags_attr_group = {
+static const struct attribute_group pm_qos_flags_attr_group = {
 	.name	= power_group_name,
 	.attrs	= pm_qos_flags_attrs,
 };
-- 
2.9.3
