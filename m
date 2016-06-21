From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: Re: [LKP] [lkp] [x86 tsc] 19fa5e7364: WARNING: CPU: 0 PID: 0 at
 arch/x86/mm/extable.c:50 ex_handler_rdmsr_unsafe+0x72/0x80
Date: Tue, 21 Jun 2016 14:08:50 +0800
Message-ID: <CANRm+Cyu8Vd_BudEPFBnvq4MuA0XY4RTNudfpwbEiM5yCzJpZw@mail.gmail.com>
References: <CADjb_WQVKRWZs+d2iK17i42_kRHBN=m8xo5i3ydDv1QWbT5MyA@mail.gmail.com>
 <SG2PR02MB15503CF343A5B5868F11C637802B0@SG2PR02MB1550.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f195.google.com ([209.85.214.195]:33128 "EHLO
	mail-ob0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392AbcFUGI6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 02:08:58 -0400
In-Reply-To: <SG2PR02MB15503CF343A5B5868F11C637802B0@SG2PR02MB1550.apcprd02.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yu Chen <yu.chen.surf@gmail.com>, kernel test robot <xiaolong.ye@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, lkp@01.org

Cc KVM ML, Paolo, Radim,
> Hi,
>
> On Mon, Jun 20, 2016 at 3:31 PM, kernel test robot
> <xiaolong.ye@intel.com> wrote:
>>
>> FYI, we noticed the following commit:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git x86
>> commit 19fa5e73647fde1e6a7038a8f05cddf4c43f08d3 ("x86 tsc: enumerate SKL cpu_khz and tsc_khz via CPUID")
>>
>>
>> on test machine: vm-kbuild-yocto-x86_64: 1 threads qemu-system-x86_64 -enable-kvm -cpu SandyBridge with 320M memory
>>
>> caused below changes:
>>
>>
>> +------------------------------------------------------------------+------------+------------+
>> |                                                                  | cc50dc7f73 | 19fa5e7364 |
>> +------------------------------------------------------------------+------------+------------+
>> | boot_successes                                                   | 0          | 0          |
>> | boot_failures                                                    | 10         | 12         |
>> | invoked_oom-killer:gfp_mask=0x                                   | 10         | 10         |
>> | Mem-Info                                                         | 10         | 10         |
>> | Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes | 10         | 10         |
>> | backtrace:btrfs_test_extent_io                                   | 10         | 10         |
>> | backtrace:init_btrfs_fs                                          | 10         | 10         |
>> | backtrace:kernel_init_freeable                                   | 10         | 10         |
>> | WARNING:at_arch/x86/mm/extable.c:#ex_handler_rdmsr_unsafe        | 0          | 10         |
>> | backtrace:native_calibrate_cpu                                   | 0          | 10         |
>> | backtrace:tsc_init                                               | 0          | 10         |
>> | backtrace:x86_late_time_init                                     | 0          | 10         |
>> +------------------------------------------------------------------+------------+------------+
>>
>>
>>
>> [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
>> [    0.000000] hpet clockevent registered
>> [    0.000000] ------------[ cut here ]------------
>> [    0.000000] WARNING: CPU: 0 PID: 0 at arch/x86/mm/extable.c:50 ex_handler_rdmsr_unsafe+0x72/0x80
>> [    0.000000] unchecked MSR access error: RDMSR from 0xce
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.7.0-rc3-00009-g19fa5e7 #1
>> [    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
>> [    0.000000]  0000000000000000 ffffffff83203c38 ffffffff816da89d ffffffff83203c88
>> [    0.000000]  0000000000000000 ffffffff82e71808 ffffffff8104e8c2 ffffffff83203c78
>> [    0.000000]  ffffffff810b796b 000000328453b4a0 ffffffff82e71808 0000000000000032
>> [    0.000000] Call Trace:
>> [    0.000000]  [<ffffffff816da89d>] dump_stack+0x83/0xb6
>> [    0.000000]  [<ffffffff8104e8c2>] ? ex_handler_rdmsr_unsafe+0x72/0x80
>> [    0.000000]  [<ffffffff810b796b>] __warn+0x10b/0x130
>> [    0.000000]  [<ffffffff810b79f3>] warn_slowpath_fmt+0x63/0x70
>> [    0.000000]  [<ffffffff8104e8c2>] ex_handler_rdmsr_unsafe+0x72/0x80
>> [    0.000000]  [<ffffffff8104ea26>] fixup_exception+0x46/0x60
>> [    0.000000]  [<ffffffff81020fdb>] do_general_protection+0x7b/0x150
>> [    0.000000]  [<ffffffff828101d8>] general_protection+0x28/0x30
>> [    0.000000]  [<ffffffff810496d6>] ? native_read_msr+0x6/0x20
>> [    0.000000]  [<ffffffff810281e1>] cpu_khz_from_msr+0xf1/0x150
>> [    0.000000]  [<ffffffff8341b16b>] ? trap_init+0x22e/0x22e
>> [    0.000000]  [<ffffffff81027935>] native_calibrate_cpu+0x85/0x5b0
>> [    0.000000]  [<ffffffff81049826>] ? native_restore_fl+0x6/0x10
>> [    0.000000]  [<ffffffff81112556>] ? __setup_irq+0x196/0x750
>> [    0.000000]  [<ffffffff8341b16b>] ? trap_init+0x22e/0x22e
>> [    0.000000]  [<ffffffff8341ec3f>] tsc_init+0x42/0x3c3
>> [    0.000000]  [<ffffffff81112c5f>] ? setup_irq+0x6f/0xc0
>> [    0.000000]  [<ffffffff8341b16b>] ? trap_init+0x22e/0x22e
>> [    0.000000]  [<ffffffff8341b16b>] ? trap_init+0x22e/0x22e
>> [    0.000000]  [<ffffffff8341b17a>] x86_late_time_init+0xf/0x11
>> [    0.000000]  [<ffffffff8341b17a>] ? x86_late_time_init+0xf/0x11
>> [    0.000000]  [<ffffffff83414173>] start_kernel+0x3f3/0x4b1
>> [    0.000000]  [<ffffffff83413120>] ? early_idt_handler_array+0x120/0x120
>> [    0.000000]  [<ffffffff8341329e>] x86_64_start_reservations+0x2f/0x31
>> [    0.000000]  [<ffffffff83413386>] x86_64_start_kernel+0xe6/0xf3
>> [    0.000000] ---[ end trace 7c0d92684f22f4ac ]---
>> [    0.000000] tsc: Fast TSC calibration using PIT
>>
>>
>> FYI, raw QEMU command line is:
>>
>>         qemu-system-x86_64 -enable-kvm -cpu SandyBridge -kernel /pkg/linux/x86_64-randconfig-w0-06180628/gcc-6/19fa5e73647fde1e6a7038a8f05cddf4c43f08d3/vmlinuz-4.7.0-rc3-00009-g19fa5e7 -append 'root=/dev/ram0 user=lkp job=/lkp/scheduled/vm-kbuild-yocto-x86_64-32/bisect_boot-1-yocto-minimal-x86_64.cgz-x86_64-randconfig-w0-06180628-19fa5e73647fde1e6a7038a8f05cddf4c43f08d3-20160618-25535-h82bax-0.yaml~ ARCH=x86_64 kconfig=x86_64-randconfig-w0-06180628 branch=internal-eywa/master commit=19fa5e73647fde1e6a7038a8f05cddf4c43f08d3 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-w0-06180628/gcc-6/19fa5e73647fde1e6a7038a8f05cddf4c43f08d3/vmlinuz-4.7.0-rc3-00009-g19fa5e7 max_uptime=600 RESULT_ROOT=/result/boot/1/vm-kbuild-yocto-x86_64/yocto-minimal-x86_64.cgz/x86_64-randconfig-w0-06180628/gcc-6/19fa5e7364
 7fde1e6a7038a8f05cddf4c43f08d3/0 LKP_SERVER=inn earlyprintk=ttyS0,115200 systemd.log_level=err debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 console=ttyS0,115200 console=tty0 vga=normal rw ip=::::vm-kbuild-yocto-x86_64-32::dhcp drbd.minor_count=8'  -initrd /fs/sdh1/initrd-vm-kbuild-yocto-x86_64-32 -m 320 -smp 1 -device e1000,netdev=net0 -netdev user,id=net0 -boot order=nc -no-reboot -watchdog i6300esb -rtc base=localtime -drive file=/fs/sdh1/disk0-vm-kbuild-yocto-x86_64-32,media=disk,if=virtio -pidfile /dev/shm/kboot/pid-vm-kbuild-yocto-x86_64-32 -serial file:/dev/shm/kboot/serial-vm-kbuild-yocto-x86_64-32 -daemonize -display none -monitor null
>>
> This  problem was caused due to kvm does not support MSR_PLATFORM_INFO(0xce),
> according to Wanpeng's feedback.
>
> Hi Wanpeng, is it possible for kvm to simulate this MSR, otherwise we
> might have to use
> rdmsr_safe instead.

There is a thread discussed this before
https://patchwork.kernel.org/patch/8833021/, MSR_PLATFORM_INFO can't
be simple emulation.

Ping Paolo, Radim. :)

Regards,
Wanpeng Li
