From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Sat, 06 Jan 2007 19:35:06 +0800
Message-ID: <1168083306.5619.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

This patch set is against acpi-test sysfs branch, and will duplicate several ACPI procfs functions in sysfs.
As struct subsystem power_subsys is referred and the interface under /sys/power/ is changed by this patch series,
I wish to receive some comments from linux-pm too.

Patch 01:
	add a Kconfig option which is used to make ACPI procfs interface configurable.
	This will be used by all the following sysfs conversion patches.

Patch 02:
	add ACPI debug attribute in sysfs.
	By applying this patch, /proc/acpi/debug_layer && debug_level is deprecated by
	/sys/module/acpi/parameter/debug_layer && debug_level.

Patch 03-05:
	add ACPI sleep attributes in sysfs.
	/proc/acpi/sleep is already deprecated by /sys/power/state.
	/proc/acpi/alarm is deprecated by /sys/power/alarm.
	For those devices that support "wake" attribute, two files, "sleep_state" and "wakeup", are created for these devices.
	"sleep_state" indicates the lowest sleeping state that can be entered while still providing wake functionality.
	"wakeup" can be used to enable/disable the device's ability to wake a sleeping system.
	So /proc/acpi/wakeup is deprecated by /sys/devices/acpi_system/.../xxx/sleep_state && wakeup.

Patch 06:
	add ACPI info in sysfs which indicates ACPICA version.
	/sys/firmware/acpi/info is create and /proc/acpi/info is marked as deprecated.

Things not do:
	/proc/acpi/dsdt and /proc/acpi/fadt are not duplicated in sysfs, as the acpidump tools are quite handy.
	And another reason is that, if we do this, we want all the ACPI tables be shown in sysfs, like
	the multiple ssdts and dynamic loaded ssdts. And we are not able to do this now. 

Things will do:
	This patch set only duplicates the ACPI attributes shown in /proc/acpi/.
	The next patch set will duplicate attributes in sysfs for ACPI devices.

For users who are used to the procfs interface, setting CONFIG_ACPI_PROCFS will make them feel nothing different.
But I'd like you guys to try the ACPI sysfs interfaces though it's not complete now. :)
