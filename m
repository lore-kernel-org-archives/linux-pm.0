From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 6/7] ACPI / PM: Move device PM functions related to sleep
 states
Date: Tue, 6 Nov 2012 11:52:42 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211061150190.6467@chino.kir.corp.google.com>
References: <1766582.8gdQKXoi0K@vostro.rjw.lan> <1456107.KxymqUQLId@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1456107.KxymqUQLId@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Aaron Lu <aaron.lu@intel.com>, Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit b87b49cd0efd ("ACPI / PM: Move device PM functions related to sleep 
states") declared acpi_target_system_state() for CONFIG_PM_SLEEP whereas 
it is only defined for CONFIG_ACPI_SLEEP, resulting in the following link 
error:

drivers/built-in.o: In function `acpi_pm_device_sleep_wake':
drivers/acpi/device_pm.c:342: undefined reference to `acpi_target_system_state'
drivers/built-in.o: In function `acpi_dev_suspend_late':
drivers/acpi/device_pm.c:501: undefined reference to `acpi_target_system_state'
drivers/built-in.o: In function `acpi_pm_device_sleep_state':
drivers/acpi/device_pm.c:221: undefined reference to `acpi_target_system_state'

Define it only for CONFIG_ACPI_SLEEP and fallback to a dummy definition 
for other configs.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 include/acpi/acpi_bus.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -469,11 +469,9 @@ static inline int acpi_pm_device_run_wake(struct device *dev, bool enable)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
-u32 acpi_target_system_state(void);
 int __acpi_device_sleep_wake(struct acpi_device *, u32, bool);
 int acpi_pm_device_sleep_wake(struct device *, bool);
 #else
-static inline u32 acpi_target_system_state(void) { return ACPI_STATE_S0; }
 static inline int __acpi_device_sleep_wake(struct acpi_device *adev,
 					   u32 target_state, bool enable)
 {
@@ -485,6 +483,12 @@ static inline int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
 }
 #endif
 
+#ifdef CONFIG_ACPI_SLEEP
+u32 acpi_target_system_state(void);
+#else
+static inline u32 acpi_target_system_state(void) { return ACPI_STATE_S0; }
+#endif
+
 static inline bool acpi_device_power_manageable(struct acpi_device *adev)
 {
 	return adev->flags.power_manageable;
