From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: S0ix failure due to "clk: x86: Do not gate clocks enabled by the firmware"
Date: Fri, 22 Sep 2017 00:20:55 +0200
Message-ID: <2582638.tGggrMFmYq@aspire.rjw.lan>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net> <4036229.gTT6xKEFIS@aspire.rjw.lan> <20170921162307.amdz2uyei7eackhs@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170921162307.amdz2uyei7eackhs@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, September 21, 2017 6:23:07 PM CEST Johannes Stezenbach wrote:
> On Thu, Sep 21, 2017 at 04:21:46PM +0200, Rafael J. Wysocki wrote:
> > So I would be inclined to think of that as a BIOS issue.
> 
> OK, wrt $Subject it sparks the question how to fix the
> issue exposed by commit d31fd43c0f9a4 "clk: x86: Do not
> gate clocks enabled by the firmware".  Add quirks to
> the drivers for the devices that have the dangling
> PowerResources and manually call _OFF/_ON during suspend/resume?

Well, it may just be better to do that in the core at the suspend
time, so I'm wondering if the appended patch makes any difference?

---
 drivers/acpi/power.c |   36 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/sleep.h |    1 +
 2 files changed, 37 insertions(+)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -64,6 +64,7 @@ struct acpi_power_resource {
 	unsigned int ref_count;
 	bool wakeup_enabled;
 	struct mutex resource_lock;
+	bool suspended;
 };
 
 struct acpi_power_resource_entry {
@@ -839,6 +840,37 @@ int acpi_add_power_resource(acpi_handle
 }
 
 #ifdef CONFIG_ACPI_SLEEP
+void acpi_suspend_power_resources(u32 acpi_state)
+{
+	struct acpi_power_resource *resource;
+
+	mutex_lock(&power_resource_list_lock);
+
+	list_for_each_entry(resource, &acpi_power_resource_list, list_node) {
+		int result, state;
+
+		mutex_lock(&resource->resource_lock);
+
+		result = acpi_power_get_state(resource->device.handle, &state);
+		if (result) {
+			mutex_unlock(&resource->resource_lock);
+			continue;
+		}
+
+		if (state == ACPI_POWER_RESOURCE_STATE_ON
+		    && resource->system_level < acpi_state) {
+			dev_info(&resource->device.dev, "Turning OFF\n");
+			__acpi_power_off(resource);
+			resource->ref_count++;
+			resource->suspended = true;
+		}
+
+		mutex_unlock(&resource->resource_lock);
+	}
+
+	mutex_unlock(&power_resource_list_lock);
+}
+
 void acpi_resume_power_resources(void)
 {
 	struct acpi_power_resource *resource;
@@ -860,6 +892,10 @@ void acpi_resume_power_resources(void)
 		    && resource->ref_count) {
 			dev_info(&resource->device.dev, "Turning ON\n");
 			__acpi_power_on(resource);
+			if (resource->suspended) {
+				resource->ref_count--;
+				resource->suspended = false;
+			}
 		}
 
 		mutex_unlock(&resource->resource_lock);
Index: linux-pm/drivers/acpi/sleep.h
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.h
+++ linux-pm/drivers/acpi/sleep.h
@@ -5,6 +5,7 @@ extern void acpi_disable_wakeup_devices(
 extern struct list_head acpi_wakeup_device_list;
 extern struct mutex acpi_device_lock;
 
+extern void acpi_suspend_power_resources(u32 acpi_state);
 extern void acpi_resume_power_resources(void);
 extern void acpi_turn_off_unused_power_resources(void);
 

