From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/15] rtc-cmos / PM: report wakeup event on ACPI
	RTC alarm
Date: Mon,  4 Jun 2012 01:39:55 -0400
Message-ID: <b2201e5482bc2376ea5c049442850a260142ac40.1338786831.git.len.brown@intel.com>
References: <1338788406-29981-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1338788406-29981-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c5971456964290da7e98222892797b71ef793e62.1338786831.git.len.brown@intel.com>
References: <c5971456964290da7e98222892797b71ef793e62.1338786831.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Daniel Drake <dsd@laptop.org>
List-Id: linux-pm@vger.kernel.org

From: Daniel Drake <dsd@laptop.org>

When the ACPI-driven RTC alarm wakes the system, report it as a wakeup
event. This allows userspace to determine that the reason for system
wakeup was RTC alarm.

Signed-off-by: Daniel Drake <dsd@laptop.org>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/rtc/rtc-cmos.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 7d5f56e..4267789 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -910,14 +910,17 @@ static inline int cmos_poweroff(struct device *dev)
 
 static u32 rtc_handler(void *context)
 {
+	struct device *dev = context;
+
+	pm_wakeup_event(dev, 0);
 	acpi_clear_event(ACPI_EVENT_RTC);
 	acpi_disable_event(ACPI_EVENT_RTC, 0);
 	return ACPI_INTERRUPT_HANDLED;
 }
 
-static inline void rtc_wake_setup(void)
+static inline void rtc_wake_setup(struct device *dev)
 {
-	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, NULL);
+	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, dev);
 	/*
 	 * After the RTC handler is installed, the Fixed_RTC event should
 	 * be disabled. Only when the RTC alarm is set will it be enabled.
@@ -950,7 +953,7 @@ cmos_wake_setup(struct device *dev)
 	if (acpi_disabled)
 		return;
 
-	rtc_wake_setup();
+	rtc_wake_setup(dev);
 	acpi_rtc_info.wake_on = rtc_wake_on;
 	acpi_rtc_info.wake_off = rtc_wake_off;
 
-- 
1.7.11.rc0.100.g5498c5f
