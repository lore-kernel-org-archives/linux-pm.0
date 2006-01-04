From: <rasmit.ranjan@wipro.com>
Subject: RE: swsusp1 not working
Date: Wed, 4 Jan 2006 11:23:53 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB20136297A@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============96893771027496922=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rjw@sisk.pl
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============96893771027496922==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

 
Hi,
	Thank you Rafael. I tried with linux-2.6.14.5 and it worked.
The steps I followed are

1. Add the following line as kernel parameter in grub.conf
	resume=/dev/hdb2  // /dev/hdb2 is my swap partition
2. Then I did the following
	echo shutdown > /sys/power/disk
	echo disk > /sys/power/state

This worked.But after resuming I checked my /var/log/message and got the
following message which cotains the oops messages as well.



******************************************
Jan  4 10:51:45 rasmit kernel: Stopping tasks:
======================================================================|
Jan  4 10:51:47 rasmit kernel: Freeing memory...  done (49638 pages
freed)
Jan  4 10:51:47 rasmit kernel: ACPI: PCI interrupt for device
0000:00:0c.0 disabled
Jan  4 10:51:47 rasmit kernel: ACPI: PCI interrupt for device
0000:00:01.2 disabled
Jan  4 10:51:48 rasmit kernel: Debug: sleeping function called from
invalid context at mm/slab.c:2459
Jan  4 10:51:49 rasmit kernel: in_atomic():0, irqs_disabled():1
Jan  4 10:51:51 rasmit kernel:  [<c011a183>] __might_sleep+0xa3/0xc0
Jan  4 10:51:52 rasmit kernel:  [<c014b1d4>] kmem_cache_alloc+0x54/0x70
Jan  4 10:51:52 rasmit kernel:  [<c0212264>]
acpi_pci_link_set+0x4a/0x1a2
Jan  4 10:51:52 rasmit kernel:  [<c02127f8>] irqrouter_resume+0x26/0x38
Jan  4 10:51:52 rasmit kernel:  [<c02555c4>] __sysdev_resume+0x44/0x90
Jan  4 10:51:52 rasmit kernel:  [<c02558a8>] sysdev_resume+0x38/0x5b
Jan  4 10:51:52 rasmit kernel:  [<c025a475>] device_power_up+0x5/0xa
Jan  4 10:51:52 rasmit kernel:  [<c013abf5>] swsusp_suspend+0xa5/0xd0
Jan  4 10:51:52 rasmit kernel:  [<c011cf97>] printk+0x17/0x20
Jan  4 10:51:52 rasmit kernel:  [<c013b7e0>] pm_suspend_disk+0x40/0xd0
Jan  4 10:51:52 rasmit kernel:  [<c01391ea>] enter_state+0x9a/0xb0
Jan  4 10:51:52 rasmit kernel:  [<c013932b>] state_store+0x9b/0xae
Jan  4 10:51:52 rasmit kernel:  [<c0139290>] state_store+0x0/0xae
Jan  4 10:51:52 rasmit kernel:  [<c01a2958>] subsys_attr_store+0x38/0x50
Jan  4 10:51:52 rasmit kernel:  [<c01a2c0e>]
flush_write_buffer+0x2e/0x40
Jan  4 10:51:52 rasmit kernel:  [<c01a2c76>] sysfs_write_file+0x56/0x90
Jan  4 10:51:52 rasmit kernel:  [<c0161c05>] vfs_write+0x175/0x180
Jan  4 10:51:52 rasmit kernel:  [<c0161cc1>] sys_write+0x41/0x70
Jan  4 10:51:52 rasmit kernel:  [<c0102fff>] sysenter_past_esp+0x54/0x75
Jan  4 10:51:52 rasmit kernel: irq 5: nobody cared (try booting with the
"irqpoll" option)
Jan  4 10:51:52 rasmit kernel:  [<c01413f4>] __report_bad_irq+0x24/0x80
Jan  4 10:51:52 rasmit kernel:  [<c014150b>] note_interrupt+0x8b/0xe0
Jan  4 10:51:52 rasmit kernel:  [<c0140e0a>] __do_IRQ+0xda/0xf0
Jan  4 10:51:52 rasmit kernel:  [<c0104776>] do_IRQ+0x36/0x70
Jan  4 10:51:52 rasmit kernel:  [<c0103226>] common_interrupt+0x1a/0x20
Jan  4 10:51:52 rasmit kernel:  [<c0140ce9>] handle_IRQ_event+0x29/0x70
Jan  4 10:51:52 rasmit kernel:  [<c0140db1>] __do_IRQ+0x81/0xf0
Jan  4 10:51:52 rasmit kernel:  [<c0104776>] do_IRQ+0x36/0x70
Jan  4 10:51:52 rasmit kernel:  [<c011cc80>]
__call_console_drivers+0x40/0x60
Jan  4 10:51:52 rasmit kernel:  [<c0103226>] common_interrupt+0x1a/0x20
Jan  4 10:51:52 rasmit kernel:  [<c014acd5>] cache_grow+0xa5/0x190
Jan  4 10:51:52 rasmit kernel:  [<c011d318>]
release_console_sem+0x78/0xc0
Jan  4 10:51:52 rasmit kernel:  [<c014af91>]
cache_alloc_refill+0x1d1/0x210
Jan  4 10:51:52 rasmit kernel:  [<c014b1e4>] kmem_cache_alloc+0x64/0x70
Jan  4 10:51:52 rasmit kernel:  [<c01f82b6>]
acpi_os_acquire_object+0xb/0x36
Jan  4 10:51:52 rasmit kernel:  [<c020d35e>]
acpi_ut_create_generic_state+0xb/0x23
Jan  4 10:51:52 rasmit kernel:  [<c0204ead>]
acpi_ns_evaluate_relative+0x41/0xc3
Jan  4 10:51:52 rasmit kernel:  [<c020968e>]
acpi_rs_set_srs_method_data+0x8f/0xb5
Jan  4 10:51:52 rasmit kernel:  [<c021233b>]
acpi_pci_link_set+0x121/0x1a2
Jan  4 10:51:52 rasmit kernel:  [<c02127f8>] irqrouter_resume+0x26/0x38
Jan  4 10:51:52 rasmit kernel:  [<c02555c4>] __sysdev_resume+0x44/0x90
Jan  4 10:51:52 rasmit kernel:  [<c02558a8>] sysdev_resume+0x38/0x5b
Jan  4 10:51:53 rasmit kernel:  [<c025a475>] device_power_up+0x5/0xa
Jan  4 10:51:52 rasmit kernel:  [<c013abf5>] swsusp_suspend+0xa5/0xd0
Jan  4 10:51:52 rasmit kernel:  [<c011cf97>] printk+0x17/0x20
Jan  4 10:51:52 rasmit kernel:  [<c013b7e0>] pm_suspend_disk+0x40/0xd0
Jan  4 10:51:52 rasmit kernel:  [<c01391ea>] enter_state+0x9a/0xb0
Jan  4 10:51:52 rasmit kernel:  [<c013932b>] state_store+0x9b/0xae
Jan  4 10:51:52 rasmit kernel:  [<c0139290>] state_store+0x0/0xae
Jan  4 10:51:52 rasmit kernel:  [<c01a2958>] subsys_attr_store+0x38/0x50
Jan  4 10:51:52 rasmit kernel:  [<c01a2c0e>]
flush_write_buffer+0x2e/0x40
Jan  4 10:51:52 rasmit kernel:  [<c01a2c76>] sysfs_write_file+0x56/0x90
Jan  4 10:51:52 rasmit kernel:  [<c0161c05>] vfs_write+0x175/0x180
Jan  4 10:51:52 rasmit kernel:  [<c0161cc1>] sys_write+0x41/0x70
Jan  4 10:51:52 rasmit kernel:  [<c0102fff>] sysenter_past_esp+0x54/0x75
Jan  4 10:51:52 rasmit kernel: handlers:
Jan  4 10:51:52 rasmit kernel: [<d00b7970>]
(snd_es1938_interrupt+0x0/0x190 [snd_es1938])
Jan  4 10:51:52 rasmit kernel: Disabling IRQ #5
Jan  4 10:51:52 rasmit kernel: irq 10: nobody cared (try booting with
the "irqpoll" option)
Jan  4 10:51:52 rasmit kernel:  [<c01413f4>] __report_bad_irq+0x24/0x80
Jan  4 10:51:52 rasmit kernel:  [<c014150b>] note_interrupt+0x8b/0xe0
Jan  4 10:51:52 rasmit kernel:  [<c0140e0a>] __do_IRQ+0xda/0xf0
Jan  4 10:51:52 rasmit kernel:  [<c0104776>] do_IRQ+0x36/0x70
Jan  4 10:51:52 rasmit kernel:  [<c0103226>] common_interrupt+0x1a/0x20
Jan  4 10:51:52 rasmit kernel:  [<c01216fe>] __do_softirq+0x2e/0xa0
Jan  4 10:51:52 rasmit kernel:  [<c0121797>] do_softirq+0x27/0x30
Jan  4 10:51:52 rasmit kernel:  [<c010477b>] do_IRQ+0x3b/0x70
Jan  4 10:51:52 rasmit kernel:  [<c011cc80>]
__call_console_drivers+0x40/0x60
Jan  4 10:51:52 rasmit kernel:  [<c0103226>] common_interrupt+0x1a/0x20
Jan  4 10:51:52 rasmit kernel:  [<c014acd5>] cache_grow+0xa5/0x190
Jan  4 10:51:52 rasmit kernel:  [<c011d318>]
release_console_sem+0x78/0xc0
Jan  4 10:51:53 rasmit kernel:  [<c014af91>]
cache_alloc_refill+0x1d1/0x210
Jan  4 10:51:53 rasmit kernel:  [<c014b1e4>] kmem_cache_alloc+0x64/0x70
Jan  4 10:51:53 rasmit kernel:  [<c01f82b6>]
acpi_os_acquire_object+0xb/0x36
Jan  4 10:51:53 rasmit kernel:  [<c020d35e>]
acpi_ut_create_generic_state+0xb/0x23
Jan  4 10:51:53 rasmit kernel:  [<c0204ead>]
acpi_ns_evaluate_relative+0x41/0xc3
Jan  4 10:51:53 rasmit kernel:  [<c020968e>]
acpi_rs_set_srs_method_data+0x8f/0xb5
Jan  4 10:51:53 rasmit kernel:  [<c021233b>]
acpi_pci_link_set+0x121/0x1a2
Jan  4 10:51:53 rasmit kernel:  [<c02127f8>] irqrouter_resume+0x26/0x38
Jan  4 10:51:53 rasmit kernel:  [<c02555c4>] __sysdev_resume+0x44/0x90
Jan  4 10:51:53 rasmit kernel:  [<c02558a8>] sysdev_resume+0x38/0x5b
Jan  4 10:51:53 rasmit kernel:  [<c025a475>] device_power_up+0x5/0xa
Jan  4 10:51:53 rasmit kernel:  [<c013abf5>] swsusp_suspend+0xa5/0xd0
Jan  4 10:51:53 rasmit kernel:  [<c011cf97>] printk+0x17/0x20
Jan  4 10:51:53 rasmit kernel:  [<c013b7e0>] pm_suspend_disk+0x40/0xd0
Jan  4 10:51:53 rasmit kernel:  [<c01391ea>] enter_state+0x9a/0xb0
Jan  4 10:51:53 rasmit kernel:  [<c013932b>] state_store+0x9b/0xae
Jan  4 10:51:53 rasmit kernel:  [<c0139290>] state_store+0x0/0xae
Jan  4 10:51:53 rasmit kernel:  [<c01a2958>] subsys_attr_store+0x38/0x50
Jan  4 10:51:53 rasmit kernel:  [<c01a2c0e>]
flush_write_buffer+0x2e/0x40
Jan  4 10:51:53 rasmit kernel:  [<c01a2c76>] sysfs_write_file+0x56/0x90
Jan  4 10:51:53 rasmit kernel:  [<c0161c05>] vfs_write+0x175/0x180
Jan  4 10:51:53 rasmit kernel:  [<c0161cc1>] sys_write+0x41/0x70
Jan  4 10:51:53 rasmit kernel:  [<c0102fff>] sysenter_past_esp+0x54/0x75
Jan  4 10:51:53 rasmit kernel: handlers:
Jan  4 10:51:53 rasmit kernel: [<d0057340>] (rtl8139_interrupt+0x0/0x1e0
[8139too])
Jan  4 10:51:53 rasmit kernel: Disabling IRQ #10
Jan  4 10:51:53 rasmit kernel: Debug: sleeping function called from
invalid context at include/asm/semaphore.h:102
Jan  4 10:51:53 rasmit kernel: in_atomic():0, irqs_disabled():1
Jan  4 10:51:53 rasmit kernel:  [<c011a183>] __might_sleep+0xa3/0xc0
Jan  4 10:51:53 rasmit kernel:  [<c01f8182>]
acpi_os_wait_semaphore+0x75/0xdb
Jan  4 10:51:53 rasmit kernel:  [<c020d4f1>]
acpi_ut_acquire_mutex+0x2d/0x40
Jan  4 10:51:53 rasmit kernel:  [<c0204ebd>]
acpi_ns_evaluate_relative+0x51/0xc3
Jan  4 10:51:53 rasmit kernel:  [<c020968e>]
acpi_rs_set_srs_method_data+0x8f/0xb5
Jan  4 10:51:53 rasmit kernel:  [<c021233b>]
acpi_pci_link_set+0x121/0x1a2
Jan  4 10:51:53 rasmit kernel:  [<c02127f8>] irqrouter_resume+0x26/0x38
Jan  4 10:51:53 rasmit kernel:  [<c02555c4>] __sysdev_resume+0x44/0x90
Jan  4 10:51:53 rasmit kernel:  [<c02558a8>] sysdev_resume+0x38/0x5b
Jan  4 10:51:53 rasmit kernel:  [<c025a475>] device_power_up+0x5/0xa
Jan  4 10:51:53 rasmit kernel:  [<c013abf5>] swsusp_suspend+0xa5/0xd0
Jan  4 10:51:53 rasmit kernel:  [<c011cf97>] printk+0x17/0x20
Jan  4 10:51:53 rasmit kernel:  [<c013b7e0>] pm_suspend_disk+0x40/0xd0
Jan  4 10:51:53 rasmit kernel:  [<c01391ea>] enter_state+0x9a/0xb0
Jan  4 10:51:53 rasmit kernel:  [<c013932b>] state_store+0x9b/0xae
Jan  4 10:51:53 rasmit kernel:  [<c0139290>] state_store+0x0/0xae
Jan  4 10:51:53 rasmit kernel:  [<c01a2958>] subsys_attr_store+0x38/0x50
Jan  4 10:51:53 rasmit kernel:  [<c01a2c0e>]
flush_write_buffer+0x2e/0x40
Jan  4 10:51:53 rasmit kernel:  [<c01a2c76>] sysfs_write_file+0x56/0x90
Jan  4 10:51:53 rasmit kernel:  [<c0161c05>] vfs_write+0x175/0x180
Jan  4 10:51:53 rasmit kernel:  [<c0161cc1>] sys_write+0x41/0x70
Jan  4 10:51:53 rasmit kernel:  [<c0102fff>] sysenter_past_esp+0x54/0x75
Jan  4 10:51:53 rasmit kernel: ACPI: PCI Interrupt 0000:00:00.1[A]: no
GSI
Jan  4 10:51:53 rasmit kernel: ACPI: PCI Interrupt 0000:00:01.2[A] ->
Link [PILE] -> GSI 9 (level, low) -> IRQ 9
Jan  4 10:51:53 rasmit kernel: ACPI: PCI Interrupt 0000:00:01.2[A] ->
Link [PILE] -> GSI 9 (level, low) -> IRQ 9
Jan  4 10:51:54 rasmit kernel: eth0: link up, 100Mbps, full-duplex, lpa
0x41E1
Jan  4 10:51:54 rasmit kernel: ACPI: PCI Interrupt 0000:00:0c.0[A] ->
Link [PILD] -> GSI 5 (level, low) -> IRQ 5
Jan  4 10:51:54 rasmit kernel: Restarting tasks... done
*********************************************




It is showing 
		Disabling IRQ #5
		Disabling IRQ #10
	
I checked /proc/interrupts file and found 
		IRQ-5 is Es1938	 
		IRQ-10 is eth0
Is there something going wrong or the log is correct ????
Please suggest

Thanks and regards,
Rasmit.
-----Original Message-----
From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
Sent: Tuesday, January 03, 2006 3:00 PM
To: Rasmit Ranjan (WT01 - Semiconductors & Consumer Electronics)
Cc: linux-pm@lists.osdl.org
Subject: Re: [linux-pm] swsusp1 not working

Hi,

On Tuesday, 3 January 2006 07:39, rasmit.ranjan@wipro.com wrote:
> 	As you have suggested I will try with kernel 2.6.14.5.This time
I 
> tried something differenet.Now I changed my swap partition.Now my swap

> partition is on LVM.So I reinstalled Linux-2.6.9 from cd. Then I 
> downloaded linux-2.6.13.3 and recompiled it.
> I followed one document "acpi-how-to" and did the following steps to 
> suspend my system.
> 
> 1. I did not use kernel parameter "resume= " in grub.config as it is 
> given that the 1st swap space will be used for image storage.

The resume= is necessary for resume anyway, because it is done before
swap partitions are activated.  If you don't use resume=, the kernel
won't be able to find the image.

> 2.Then I create my initrd using the following command
> 	mkinitrd --allow-missing -f /boot/initrd-2.6.13.3.img 2.6.13.3
> 
> 3.Then I did the following
> 	echo shutdown > /sys/power/disk
> 	echo disk > /sys/power/state
> 
> It seems my system is suspended. So when I press the power button it 
> did not resume but restarted.

This happened because you didn't use resume= (see above).

> In boot log message I found something like this 
> 		swapon:/dev/VolGroup00/LogVol01: invalid argument
> 		rc.sysinit: enabling swap space failed

swsusp changed the signature of your swap partition, so it cannot be
used as swap space any more.  Normally the signature would be restored
during resume, but the system didn't resume so the image is still there
and it is "locked".

> Now it seems my swap partition has been crashed.
> So after rebooting I tried following command
> 		swapon -s  //showed nothing
> 		cat /proc/swaps //showed nothing
> 		free  //this showed that the size of swap space is 0
> 
> So I tried to activate my swap space and typed this command
> 		swapon -a
> 
> But this gave the following error
> 		Unable to find swap-space signature
> 		swapon:/dev/VolGroup00/LogVol01: invalid argument
> 
> Now I can not do any thing until my swap space becomes activated.
> First I did not get why my swap space got crashed ??

See above.

> Second is there any way to activate my swap space ??

Yes, there is.  Use mkswap.

Greetings,
Rafael


--===============96893771027496922==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============96893771027496922==--
