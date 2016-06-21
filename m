From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [LKP] [lkp] [x86 tsc] 19fa5e7364: WARNING: CPU: 0 PID: 0 at
 arch/x86/mm/extable.c:50 ex_handler_rdmsr_unsafe+0x72/0x80
Date: Tue, 21 Jun 2016 18:24:18 +0800
Message-ID: <CANRm+CzS3CKb43ipjoBMwOJ49bmqx=3zMSU7u6-spmt1uk9ULQ@mail.gmail.com>
References: <CADjb_WQVKRWZs+d2iK17i42_kRHBN=m8xo5i3ydDv1QWbT5MyA@mail.gmail.com>
 <SG2PR02MB15503CF343A5B5868F11C637802B0@SG2PR02MB1550.apcprd02.prod.outlook.com>
 <CANRm+Cyu8Vd_BudEPFBnvq4MuA0XY4RTNudfpwbEiM5yCzJpZw@mail.gmail.com> <1e840272-9a0c-1e95-0356-12c031df7458@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1e840272-9a0c-1e95-0356-12c031df7458@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yu Chen <yu.chen.surf@gmail.com>, kernel test robot <xiaolong.ye@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, lkp@01.org
List-Id: linux-pm@vger.kernel.org

2016-06-21 18:10 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>
>
> On 21/06/2016 08:08, Wanpeng Li wrote:
>> Cc KVM ML, Paolo, Radim,
>>>> FYI, raw QEMU command line is:
>>>>
>>>>         qemu-system-x86_64 -enable-kvm -cpu SandyBridge -kernel /pkg/linux/x86_64-randconfig-w0-06180628/gcc-6/19fa5e73647fde1e6a7038a8f05cddf4c43f08d3/vmlinuz-4.7.0-rc3-00009-g19fa5e7 -append 'root=/dev/ram0 user=lkp job=/lkp/scheduled/vm-kbuild-yocto-x86_64-32/bisect_boot-1-yocto-minimal-x86_64.cgz-x86_64-randconfig-w0-06180628-19fa5e73647fde1e6a7038a8f05cddf4c43f08d3-20160618-25535-h82bax-0.yaml~ ARCH=x86_64 kconfig=x86_64-randconfig-w0-06180628 branch=internal-eywa/master commit=19fa5e73647fde1e6a7038a8f05cddf4c43f08d3 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-w0-06180628/gcc-6/19fa5e73647fde1e6a7038a8f05cddf4c43f08d3/vmlinuz-4.7.0-rc3-00009-g19fa5e7 max_uptime=600 RESULT_ROOT=/result/boot/1/vm-kbuild-yocto-x86_64/yocto-minimal-x86_64.cgz/x86_64-randconfig-w0-06180628/gcc-6/19fa5e73
 647fde1e6a7038a8f05cddf4c43f08d3/0 LKP_SERVER=inn earlyprintk=ttyS0,115200 systemd.log_level=err debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 console=ttyS0,115200 console=tty0 vga=normal rw ip=::::vm-kbuild-yocto-x86_64-32::dhcp drbd.minor_count=8'  -initrd /fs/sdh1/initrd-vm-kbuild-yocto-x86_64-32 -m 320 -smp 1 -device e1000,netdev=net0 -netdev user,id=net0 -boot order=nc -no-reboot -watchdog i6300esb -rtc base=localtime -drive file=/fs/sdh1/disk0-vm-kbuild-yocto-x86_64-32,media=disk,if=virtio -pidfile /dev/shm/kboot/pid-vm-kbuild-yocto-x86_64-32 -serial file:/dev/shm/kboot/serial-vm-kbuild-yocto-x86_64-32 -daemonize -display none -monitor null
>>>>
>>> This  problem was caused due to kvm does not support MSR_PLATFORM_INFO(0xce),
>>> according to Wanpeng's feedback.
>>>
>>> Hi Wanpeng, is it possible for kvm to simulate this MSR, otherwise we
>>> might have to use
>>> rdmsr_safe instead.
>>
>> There is a thread discussed this before
>> https://patchwork.kernel.org/patch/8833021/, MSR_PLATFORM_INFO can't
>> be simple emulation.
>>
>> Ping Paolo, Radim. :)
>
> rdmsr_safe must be used instead.  I'll prepare a patch.

Actually I have such a patch on hand under testing, I will send out soon. :)

Regards,
Wanpeng Li
