From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [LKP] [lkp] [x86 tsc] 19fa5e7364: WARNING: CPU: 0 PID: 0 at
 arch/x86/mm/extable.c:50 ex_handler_rdmsr_unsafe+0x72/0x80
Date: Tue, 21 Jun 2016 21:59:20 +0800
Message-ID: <CANRm+CxvBqauRuddRig03_fwdhPpxBh2z17vG0rnHmHMjxrwJQ@mail.gmail.com>
References: <CADjb_WQVKRWZs+d2iK17i42_kRHBN=m8xo5i3ydDv1QWbT5MyA@mail.gmail.com>
 <SG2PR02MB15503CF343A5B5868F11C637802B0@SG2PR02MB1550.apcprd02.prod.outlook.com>
 <CANRm+Cyu8Vd_BudEPFBnvq4MuA0XY4RTNudfpwbEiM5yCzJpZw@mail.gmail.com>
 <1e840272-9a0c-1e95-0356-12c031df7458@redhat.com> <CANRm+CzS3CKb43ipjoBMwOJ49bmqx=3zMSU7u6-spmt1uk9ULQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CANRm+CzS3CKb43ipjoBMwOJ49bmqx=3zMSU7u6-spmt1uk9ULQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yu Chen <yu.chen.surf@gmail.com>, kernel test robot <xiaolong.ye@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, lkp@01.org
List-Id: linux-pm@vger.kernel.org

Hi Paolo,
2016-06-21 18:24 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> 2016-06-21 18:10 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>>
>>
>> On 21/06/2016 08:08, Wanpeng Li wrote:
>>> Cc KVM ML, Paolo, Radim,
>>>>> FYI, raw QEMU command line is:
>>>>>
>>>>>         qemu-system-x86_64 -enable-kvm -cpu SandyBridge -kernel /=
pkg/linux/x86_64-randconfig-w0-06180628/gcc-6/19fa5e73647fde1e6a7038a8f=
05cddf4c43f08d3/vmlinuz-4.7.0-rc3-00009-g19fa5e7 -append 'root=3D/dev/r=
am0 user=3Dlkp job=3D/lkp/scheduled/vm-kbuild-yocto-x86_64-32/bisect_bo=
ot-1-yocto-minimal-x86_64.cgz-x86_64-randconfig-w0-06180628-19fa5e73647=
fde1e6a7038a8f05cddf4c43f08d3-20160618-25535-h82bax-0.yaml~ ARCH=3Dx86_=
64 kconfig=3Dx86_64-randconfig-w0-06180628 branch=3Dinternal-eywa/maste=
r commit=3D19fa5e73647fde1e6a7038a8f05cddf4c43f08d3 BOOT_IMAGE=3D/pkg/l=
inux/x86_64-randconfig-w0-06180628/gcc-6/19fa5e73647fde1e6a7038a8f05cdd=
f4c43f08d3/vmlinuz-4.7.0-rc3-00009-g19fa5e7 max_uptime=3D600 RESULT_ROO=
T=3D/result/boot/1/vm-kbuild-yocto-x86_64/yocto-minimal-x86_64.cgz/x86_=
64-randconfig-w0-06180628/gcc-6/19fa5e73647fde1e6a7038a8f05cddf4c43f08d=
3/0 LKP_SERVER=3Dinn earlyprintk=3DttyS0,115200 systemd.log_level=3Derr=
 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=
=3D100 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpani=
c load_ramdisk=3D2 prompt_ramdisk=3D0 console=3DttyS0,115200 console=3D=
tty0 vga=3Dnormal rw ip=3D::::vm-kbuild-yocto-x86_64-32::dhcp drbd.mino=
r_count=3D8'  -initrd /fs/sdh1/initrd-vm-kbuild-yocto-x86_64-32 -m 320 =
-smp 1 -device e1000,netdev=3Dnet0 -netdev user,id=3Dnet0 -boot order=3D=
nc -no-reboot -watchdog i6300esb -rtc base=3Dlocaltime -drive file=3D/f=
s/sdh1/disk0-vm-kbuild-yocto-x86_64-32,media=3Ddisk,if=3Dvirtio -pidfil=
e /dev/shm/kboot/pid-vm-kbuild-yocto-x86_64-32 -serial file:/dev/shm/kb=
oot/serial-vm-kbuild-yocto-x86_64-32 -daemonize -display none -monitor =
null
>>>>>
>>>> This  problem was caused due to kvm does not support MSR_PLATFORM_=
INFO(0xce),
>>>> according to Wanpeng's feedback.
>>>>
>>>> Hi Wanpeng, is it possible for kvm to simulate this MSR, otherwise=
 we
>>>> might have to use
>>>> rdmsr_safe instead.
>>>
>>> There is a thread discussed this before
>>> https://patchwork.kernel.org/patch/8833021/, MSR_PLATFORM_INFO can'=
t
>>> be simple emulation.
>>>
>>> Ping Paolo, Radim. :)
>>
>> rdmsr_safe must be used instead.  I'll prepare a patch.
>
> Actually I have such a patch on hand under testing, I will send out s=
oon. :)

I have a temporal patch as below, it seems that guest tsc(~300MHz) is
still not correct and guest kernel panic during boot w/ message
"MP-BIOS bug: 8254 timer not connect to IO-APIC, kernel-panic - not
syncing: IOAPIC + timer doesn't work" etc. Any proposal to improve my
patch is a great appreciated. :) The patch is against x86 branch on
Len Brown's tree. And try to fix this commit:
https://git.kernel.org/cgit/linux/kernel/git/lenb/linux.git/commit/?h=3D=
x86&id=3Dfc141535ad8a67fd58623289c04e35465e2a07f2

--------------------

=46rom 8033ae4c7e44d6bfe26642b151de03c613125066 Mon Sep 17 00:00:00 200=
1
=46rom: Wanpeng Li <wanpeng.li@hotmail.com>
Date: Tue, 21 Jun 2016 19:41:12 +0800
Subject: [PATCH] x86: fix rdmsr MSR_PLATFORM_INFO unsafe warning in kvm=
 guest

=46rom: Wanpeng Li <wanpeng.li@hotmail.com>

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at arch/x86/mm/extable.c:50
ex_handler_rdmsr_unsafe+0x6a/0x70
unchecked MSR access error: RDMSR from 0xce
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.7.0-rc3+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01=
/2011
 0000000000000000 ffffffff81c03ce0 ffffffff813b3eae ffffffff81c03d30
 0000000000000000 ffffffff81c03d20 ffffffff81067181 0000003200000001
 ffffffff81c03df8 ffffffff8179676c 0000000000000000 ffffffff81fcd2c0
Call Trace:
 dump_stack+0x67/0x99
 __warn+0xd1/0xf0
 warn_slowpath_fmt+0x4f/0x60
 ex_handler_rdmsr_unsafe+0x6a/0x70
 fixup_exception+0x39/0x50
 do_general_protection+0x93/0x1b0
 general_protection+0x22/0x30
 ? cpu_khz_from_msr+0xd8/0x1c0
 native_calibrate_cpu+0x30/0x5b0
 tsc_init+0x2b/0x297
 x86_late_time_init+0xf/0x11
 start_kernel+0x398/0x451
 ? set_init_arg+0x55/0x55
 x86_64_start_reservations+0x2f/0x31
 x86_64_start_kernel+0xea/0xed

After commit (fc141535ad8 : "x86 tsc_msr: Extend to include Intel Core
Architecture"),
rdmsr MSR_PLATFORM_INFO is used to get maximum non-turbo ratio for
recent Intel Core
Architecture which results in kvm guest rdmsr unsafe warning.

As Radim pointed out before:

| MSR_PLATFORM_INFO: Intel changes it from family to family and there i=
s
| no obvious overlap or default.  If we picked 0 (any other fixed value=
),
| then the guest would have to know that 0 doesn't mean that
| MSR_PLATFORM_INFO returned 0, but that KVM doesn't emulate this MSR a=
nd
| the value cannot be used.  This is very similar to handling a #GP in =
the
| guest, but also has a disadvantage, because KVM cannot say that
| MSR_PLATFORM_INFO is 0.  Simple emulation is not possible.

This patch fix it by using rdmsr_safe to read MSR_PLATFORM_INFO in kvm =
guest
in order that #GP can be fixed up.

Reported-by: kernel test robot <xiaolong.ye@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Chen Yu <y.c.chen@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
Cc: jacob.jun.pan@intel.com
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
---
 arch/x86/kernel/tsc_msr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index e0c2b30..15e06e1 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -123,8 +123,11 @@ unsigned long cpu_khz_from_msr(void)
  }

 get_ratio:
- rdmsr(MSR_PLATFORM_INFO, lo, hi);
- ratio =3D (lo >> 8) & 0xff;
+ if (rdmsr_safe(MSR_PLATFORM_INFO, &lo, &hi)) {
+ rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
+ ratio =3D (hi >> 8) & 0x1f;
+ } else
+ ratio =3D (lo >> 8) & 0xff;

 done:
  /* TSC frequency =3D maximum resolved freq * maximum resolved bus rat=
io */
--=20
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
