From: Andrew Morton <akpm@linux-foundation.org>
Subject: 2.6.25-mm1: suspend-to-disk warning, resume failure
Date: Thu, 17 Apr 2008 22:21:25 -0700
Message-ID: <20080417222125.99e807b6.akpm__1609.18580736524$1208496234$gmane$org@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is the Vaio.

This:

<cold boot>
<suspend-to-ram>
<resume-from-ram>
<suspend-to-ram>
<resume-from-ram>

works OK.


This:

<cold boot>
<suspend-to-disk>
<resume-from-disk>

works OK.


But this:

<cold boot>
<suspend-to-ram>
<resume-from-ram>
<suspend-to-disk>
<resume-from-disk>

hangs at the end of resume-from-disk.


During the suspend-to-disk I saw:

ipw2200: Radio Frequency Kill Switch is On:
Kill switch must be turned off for wireless networking to work.
PM: Device usb1 failed to (unknown PM event): error -113
PM: Device usb2 failed to (unknown PM event): error -113
PM: Device usb3 failed to (unknown PM event): error -113
PM: Device usb4 failed to (unknown PM event): error -113
Suspending console(s)

But it suspends OK.

Resume _almost_ works.  It gets to:

calling  hpet_insert_resource+0x0/0x1e()
initcall hpet_insert_resource+0x0/0x1e() returned 1 after 0 msecs
initcall hpet_insert_resource+0x0/0x1e() returned with error code 1
calling  init_lapic_nmi_sysfs+0x0/0x33()
initcall init_lapic_nmi_sysfs+0x0/0x33() returned 0 after 0 msecs
calling  io_apic_bug_finalize+0x0/0x1c()
initcall io_apic_bug_finalize+0x0/0x1c() returned 0 after 0 msecs
calling  check_early_ioremap_leak+0x0/0x3d()
initcall check_early_ioremap_leak+0x0/0x3d() returned 0 after 0 msecs
calling  print_ipi_mode+0x0/0x26()
Using IPI Shortcut mode
initcall print_ipi_mode+0x0/0x26() returned 0 after 2 msecs
calling  init_oops_id+0x0/0x23()
initcall init_oops_id+0x0/0x23() returned 0 after 0 msecs
calling  disable_boot_consoles+0x0/0x36()
initcall disable_boot_consoles+0x0/0x36() returned 0 after 0 msecs
calling  pm_qos_power_init+0x0/0x54()
initcall pm_qos_power_init+0x0/0x54() returned 0 after 0 msecs
calling  software_resume+0x0/0x179()
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... <6>input: PS/2 Mouse as /class/input/input3
input: AlpsPS/2 ALPS GlidePoint as /class/input/input4
(elapsed 0.14 seconds) done.
PM: Loading image data pages (88965 pages) ... done
PM: Read 355860 kbytes in 16.36 seconds (21.75 MB/s)
Suspending console(s)

then stops with fans whirring.

http://userweb.kernel.org/~akpm/config-sony.txt
http://userweb.kernel.org/~akpm/dmesg-sony.txt


I guess I get to bisect this.
