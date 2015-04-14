From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] power supply changes for 4.1
Date: Mon, 13 Apr 2015 18:09:03 -0700
Message-ID: <CA+55aFyuc35uMsHHFAyNEMq4WodBjNLv58KMt4xOfMW+6Tqe1Q@mail.gmail.com>
References: <20150413133508.GA3377@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:32885 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbbDNBJE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2015 21:09:04 -0400
In-Reply-To: <20150413133508.GA3377@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Mon, Apr 13, 2015 at 6:35 AM, Sebastian Reichel <sre@ring0.de> wrote:
>
>  * new API for safe access of power supply function attrs
>  * devres support for power supply (un)registration

I'm not sure this is the reason, but suspend/resume on my laptop now
complains wildly.

I'm *assuming* the culprit is commit 297d716f6260 ("power_supply:
Change ownership from driver to core") and probably the ACPI changes
in particular. But I didn't bisect, I'm just pasting the warning
messages here.

Hmm?

               Linus

--- snip snip ---


   ------------[ cut here ]------------
   WARNING: CPU: 0 PID: 4018 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x55/0x70()
   sysfs: cannot create duplicate filename
'/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/PNP0C09:00/PNP0C0A:00/power_supply/BAT0'
   CPU: 0 PID: 4018 Comm: systemd-sleep Not tainted
4.0.0-02620-gb79013b2449c #28
   Hardware name: Sony Corporation SVP11213CXB/VAIO, BIOS R0270V7 05/17/2013
   Call Trace:
     dump_stack+0x40/0x50
     warn_slowpath_common+0x77/0xb0
     warn_slowpath_fmt+0x45/0x50
     kernfs_path+0x42/0x50
     sysfs_warn_dup+0x55/0x70
     sysfs_create_dir_ns+0x7e/0x90
     kobject_add_internal+0xac/0x370
     kobject_add+0x66/0xb0
     device_add+0x106/0x670
     __power_supply_register+0x134/0x280
     sysfs_add_battery+0x6d/0x99
     battery_notify+0x3b/0x5f
     notifier_call_chain+0x47/0x70
     __blocking_notifier_call_chain+0x3c/0x60
     pm_notifier_call_chain+0x15/0x40
     pm_suspend+0x231/0x2f0
     from_kgid_munged+0x9/0x20
     state_store+0x71/0xf0
     kernfs_fop_write+0x124/0x180
     vfs_write+0xad/0x1e0
     SyS_write+0x3d/0xa0
     system_call_fastpath+0x12/0x6a
   ---[ end trace 48e03e2b845e5eff ]---
   ------------[ cut here ]------------
   WARNING: CPU: 0 PID: 4018 at lib/kobject.c:240
kobject_add_internal+0x2f4/0x370()
   kobject_add_internal failed for BAT0 with -EEXIST, don't try to
register things with the same name in the same directory.
   CPU: 0 PID: 4018 Comm: systemd-sleep Tainted: G        W
4.0.0-02620-gb79013b2449c #28
   Hardware name: Sony Corporation SVP11213CXB/VAIO, BIOS R0270V7 05/17/2013
   Call Trace:
     dump_stack+0x40/0x50
     warn_slowpath_common+0x77/0xb0
     warn_slowpath_fmt+0x45/0x50
     sysfs_create_dir_ns+0x7e/0x90
     kobject_add_internal+0x2f4/0x370
     kobject_add+0x66/0xb0
     device_add+0x106/0x670
     __power_supply_register+0x134/0x280
     sysfs_add_battery+0x6d/0x99
     battery_notify+0x3b/0x5f
     notifier_call_chain+0x47/0x70
     __blocking_notifier_call_chain+0x3c/0x60
     pm_notifier_call_chain+0x15/0x40
     pm_suspend+0x231/0x2f0
     from_kgid_munged+0x9/0x20
     state_store+0x71/0xf0
     kernfs_fop_write+0x124/0x180
     vfs_write+0xad/0x1e0
     SyS_write+0x3d/0xa0
     system_call_fastpath+0x12/0x6a
   ---[ end trace 48e03e2b845e5f00 ]---
