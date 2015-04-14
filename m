From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH] ACPI / battery: Fix doubly added battery on system suspend
Date: Tue, 14 Apr 2015 22:24:13 +0900
Message-ID: <1429017853-3520-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34061 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbbDNNeV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2015 09:34:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

The commit 297d716f6260 ("power_supply: Change ownership from driver to
core") inverted the logic in battery_notify(). As an effect already
present battery was re-added on each system suspend or hibernation.

Dmesg:
[  107.999370] WARNING: CPU: 0 PID: 303 at ../fs/sysfs/dir.c:31 sysfs_warn_dup+0x68/0x80()
[  107.999374] sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0A:00/power_supply/BAT0'
[  107.999418] CPU: 0 PID: 303 Comm: rtcwake Not tainted 4.0.0-ARCH-02621-g07e6253af953 #48
[  107.999421] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  107.999425]  0000000000000000 000000008600f41a ffff88001cf3f9f8 ffffffff8156c77d
[  107.999430]  0000000000000000 ffff88001cf3fa50 ffff88001cf3fa38 ffffffff81074cea
[  107.999434]  000029b71cf3fa38 ffff88001e387000 ffff88001cc3bfb8 ffff88001ce1e258
[  107.999439] Call Trace:
[  107.999446]  [<ffffffff8156c77d>] dump_stack+0x4c/0x6e
[  107.999453]  [<ffffffff81074cea>] warn_slowpath_common+0x8a/0xc0
[  107.999458]  [<ffffffff81074d75>] warn_slowpath_fmt+0x55/0x70
[  107.999464]  [<ffffffff8124c548>] ? kernfs_path+0x48/0x60
[  107.999468]  [<ffffffff8124fd28>] sysfs_warn_dup+0x68/0x80
[  107.999472]  [<ffffffff8124fdcd>] sysfs_create_dir_ns+0x8d/0xa0
[  107.999478]  [<ffffffff812bfae6>] kobject_add_internal+0xb6/0x370
[  107.999483]  [<ffffffff812bffbf>] kobject_add+0x6f/0xd0
[  107.999489]  [<ffffffff813e0310>] device_add+0x120/0x6c0
[  107.999494]  [<ffffffff813de800>] ? dev_set_name+0x50/0x70
[  107.999500]  [<ffffffff8141ed95>] __power_supply_register+0x145/0x290
[  107.999506]  [<ffffffffa0104234>] ? extract_package+0x73/0xc5 [battery]
[  107.999511]  [<ffffffff8141ef10>] power_supply_register_no_ws+0x10/0x20
[  107.999517]  [<ffffffffa01044aa>] sysfs_add_battery+0x84/0xc5 [battery]
[  107.999522]  [<ffffffffa0104b7f>] battery_notify+0x45/0x6b [battery]
[  107.999527]  [<ffffffff8109476f>] notifier_call_chain+0x4f/0x80
[  107.999532]  [<ffffffff81094b5b>] __blocking_notifier_call_chain+0x4b/0x70
[  107.999537]  [<ffffffff81094b96>] blocking_notifier_call_chain+0x16/0x20
[  107.999543]  [<ffffffff810c20aa>] pm_notifier_call_chain+0x1a/0x40
[  107.999548]  [<ffffffff810c399d>] pm_suspend+0x3ed/0x4e0
[  107.999552]  [<ffffffff810c2087>] state_store+0xa7/0xb0
[  107.999557]  [<ffffffff812bee0f>] kobj_attr_store+0xf/0x20
[  107.999561]  [<ffffffff8124f41a>] sysfs_kf_write+0x3a/0x50
[  107.999565]  [<ffffffff8124e8f7>] kernfs_fop_write+0x127/0x180
[  107.999571]  [<ffffffff811d5727>] vfs_write+0xb7/0x200
[  107.999576]  [<ffffffff811d6409>] SyS_write+0x59/0xd0
[  107.999581]  [<ffffffff81571f2e>] system_call_fastpath+0x12/0x71
[  107.999586] ---[ end trace 3977e3a58591fca2 ]---

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>

---

This fixes commit 297d716f6260 which was recently pulled from battery
tree:
https://lkml.org/lkml/2015/4/13/396.
---
 drivers/acpi/battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index fdc16ce9d272..672263a3832c 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1106,7 +1106,7 @@ static int battery_notify(struct notifier_block *nb,
 		if (!acpi_battery_present(battery))
 			return 0;
 
-		if (battery->bat) {
+		if (!battery->bat) {
 			result = acpi_battery_get_info(battery);
 			if (result)
 				return result;
-- 
2.1.0

