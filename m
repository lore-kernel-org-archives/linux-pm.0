From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.25-mm1: suspend-to-disk warning, resume failure
Date: Fri, 18 Apr 2008 11:40:58 +0200
Message-ID: <20080418094054.GA23572@elf.ucw.cz>
References: <20080417222125.99e807b6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080417222125.99e807b6.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 2008-04-17 22:21:25, Andrew Morton wrote:
> This is the Vaio.
> 
> This:
> 
> <cold boot>
> <suspend-to-ram>
> <resume-from-ram>
> <suspend-to-ram>
> <resume-from-ram>
> 
> works OK.
> 
> 
> This:
> 
> <cold boot>
> <suspend-to-disk>
> <resume-from-disk>
> 
> works OK.
> 
> 
> But this:
> 
> <cold boot>
> <suspend-to-ram>
> <resume-from-ram>
> <suspend-to-disk>
> <resume-from-disk>
> 
> hangs at the end of resume-from-disk.

You could try echo disk > /sys/power/state to see if it is ACPI acting
funny or some driver

> During the suspend-to-disk I saw:
> 
> ipw2200: Radio Frequency Kill Switch is On:
> Kill switch must be turned off for wireless networking to work.
> PM: Device usb1 failed to (unknown PM event): error -113
> PM: Device usb2 failed to (unknown PM event): error -113
> PM: Device usb3 failed to (unknown PM event): error -113
> PM: Device usb4 failed to (unknown PM event): error -113
> Suspending console(s)
> 
> But it suspends OK.



> Resume _almost_ works.  It gets to:
> 
> calling  hpet_insert_resource+0x0/0x1e()
> initcall hpet_insert_resource+0x0/0x1e() returned 1 after 0 msecs
> initcall hpet_insert_resource+0x0/0x1e() returned with error code 1
> calling  init_lapic_nmi_sysfs+0x0/0x33()
> initcall init_lapic_nmi_sysfs+0x0/0x33() returned 0 after 0 msecs
> calling  io_apic_bug_finalize+0x0/0x1c()
> initcall io_apic_bug_finalize+0x0/0x1c() returned 0 after 0 msecs
> calling  check_early_ioremap_leak+0x0/0x3d()
> initcall check_early_ioremap_leak+0x0/0x3d() returned 0 after 0 msecs
> calling  print_ipi_mode+0x0/0x26()
> Using IPI Shortcut mode
> initcall print_ipi_mode+0x0/0x26() returned 0 after 2 msecs
> calling  init_oops_id+0x0/0x23()
> initcall init_oops_id+0x0/0x23() returned 0 after 0 msecs
> calling  disable_boot_consoles+0x0/0x36()
> initcall disable_boot_consoles+0x0/0x36() returned 0 after 0 msecs
> calling  pm_qos_power_init+0x0/0x54()
> initcall pm_qos_power_init+0x0/0x54() returned 0 after 0 msecs
> calling  software_resume+0x0/0x179()
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... <6>input: PS/2 Mouse as /class/input/input3
> input: AlpsPS/2 ALPS GlidePoint as /class/input/input4
> (elapsed 0.14 seconds) done.
> PM: Loading image data pages (88965 pages) ... done
> PM: Read 355860 kbytes in 16.36 seconds (21.75 MB/s)
> Suspending console(s)

no_console_suspend should get you a bit more output...

> I guess I get to bisect this.

Either that, or you can try if it works with minimum config (no
wireless, no usb, no fancy drivers).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
