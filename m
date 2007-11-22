From: Jiri Slaby <jirislaby@gmail.com>
Subject: WARNING: at kernel/resource.c:189 __release_resource
Date: Thu, 22 Nov 2007 22:41:16 +0100
Message-ID: <4745F77C.7040402__6837.29942325062$1195767756$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@suse.de>, linux-pm@lists.linux-foundation.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi,

Step aside. What's the purpose of having two similar patches for one issue,
it then warns about the same thing twice:
make-sure-nobodys-leaking-resources.patch
releasing-resources-with-children.patch

Ok, I hit the bug, suspend of 00:06 device complains about it:
WARNING: at .../kernel/resource.c:185 __release_resource()

Call Trace:
 [<ffffffff8023f7b5>] release_resource+0xb5/0xf0
 [<ffffffff8036cda0>] pnp_release_resources+0x70/0x130
 [<ffffffff8036db85>] pnp_stop_dev+0x45/0x90
 [<ffffffff8036c942>] pnp_bus_suspend+0x92/0xb0
 [<ffffffff803b9f73>] suspend_device+0x113/0x180
 [<ffffffff803ba330>] device_suspend+0x200/0x320
 [<ffffffff80266905>] suspend_devices_and_enter+0xa5/0x170
 [<ffffffff80266bd9>] enter_state+0x209/0x270
 [<ffffffff80266cef>] state_store+0xaf/0xf0
 [<ffffffff8032ca67>] kobj_attr_store+0x17/0x20
 [<ffffffff802e459e>] sysfs_write_file+0xce/0x140
 [<ffffffff80299cc7>] vfs_write+0xc7/0x170
 [<ffffffff8029a360>] sys_write+0x50/0x90
 [<ffffffff8020bcde>] system_call+0x7e/0x83

# LANG=en ll /sys/devices/pnp0/00:06/
total 0
lrwxrwxrwx 1 root root    0 Nov 22 22:35 driver -> ../../../bus/pnp/drivers/serial
-r--r--r-- 1 root root 4096 Nov 22 22:35 id
-r--r--r-- 1 root root 4096 Nov 22 22:35 options
drwxr-xr-x 2 root root    0 Nov 22 22:35 power
-rw-r--r-- 1 root root 4096 Nov 22 22:35 resources
lrwxrwxrwx 1 root root    0 Nov 22 22:35 subsystem -> ../../../bus/pnp
drwxr-xr-x 3 root root    0 Nov 22 22:35 tty
-rw-r--r-- 1 root root 4096 Nov 22 22:35 uevent

regards,
-- 
Jiri Slaby (jirislaby@gmail.com)
Faculty of Informatics, Masaryk University
