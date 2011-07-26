From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Fw: Panic while enabling 2nd CPU core after suspend
	to ram on Intel Atom CPU
Date: Tue, 26 Jul 2011 22:03:25 +0200
Message-ID: <201107262203.25816.rjw@sisk.pl>
References: <20110721140935.18e9a297.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110721140935.18e9a297.akpm@linux-foundation.org>
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
Cc: Ingo Molnar <mingo@elte.hu>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, July 21, 2011, Andrew Morton wrote:
> =

> who would be an appropriate person to look at this one? =

> =

> The suspend_test warning is Rafael, I guess.  But the mwait_idle oops?

The suspend_test warning only means that the resuming of devices took
too much time.

Thanks,
Rafael


> Begin forwarded message:
> =

> Date: Sun, 17 Jul 2011 17:00:14 +0200
> From: Martin S=FCfke <martinlkml2011@piximail.de>
> To: linux-kernel@vger.kernel.org
> Subject: Panic while enabling 2nd CPU core after suspend to ram on Intel =
Atom CPU
> =

> =

> Hello, everybody.
> =

> I get the following kernel panic after my system has been sent to "suspen=
d to ram":
> The system has an Intel Atom D525 Dual Core CPU with hyperthreading, show=
ing up as 4 cpus in /proc/cpuinfo. After the kernel panic happened, the cap=
s-lock and scroll-lock LED on the keyboard are blinking.
> =

> $ ksymoops -m /boot/System.map-3.0.0-rc7min oops_without_timestamps.log
> ksymoops 2.4.11 on x86_64 3.0.0-rc7min.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/3.0.0-rc7min/ (default)
>      -m /boot/System.map-3.0.0-rc7min (specified)
> =

> Error (regular_file): read_ksyms stat /proc/ksyms failed
> ksymoops: No such file or directory
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
>  CPU 1
>  Pid: 0, comm: kworker/0:0 Tainted: G        W   3.0.0-rc7min #14 Gigabyt=
e Technology Co., Ltd. D525TUD/D525TUD
>  RIP: 0010:[<ffffffff810088cf>]  [<ffffffff810088cf>] mwait_idle+0xd2/0x1=
59
> Using defaults from ksymoops -t elf64-x86-64 -a i386:x86-64
>  RSP: 0000:ffff88013f515ef8  EFLAGS: 00010046
>  RAX: ffff88013f514010 RBX: ffff88013f515fd8 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff818df108
>  RBP: ffff88013f515f08 R08: 0000000000000000 R09: 0000000000000000
>  R10: 7fffffffffffffff R11: ffffffff8184e4d0 R12: 0000000000000001
>  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  FS:  0000000000000000(0000) GS:ffff88013fc80000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>  CR2: 0000000000000000 CR3: 0000000001803000 CR4: 00000000000006e0
>   ffffffff818525a0 ffff88013f514010 ffff88013f515f28 ffffffff81001c88
>   0000000000000001 0000000000000000 ffff88013f515f48 ffffffff81411371
>   0000000000000000 0000000000000000 0000000000000000 0000000000000000
>  Call Trace:
>   [<ffffffff81001c88>] cpu_idle+0x5a/0x91
>   [<ffffffff81411371>] start_secondary+0x19c/0x1a0
>  Code: c2 74 13 65 48 8b 04 25 88 b5 00 00 48 2d d8 1f 00 00 0f ae 78 10 =
31 d2 65 48 8b 1c 25 88 b5 00 00 48 89 d1 48 8d 83 38 e0 ff ff <0f> 01 c8 0=
f ae f0 48 8b 83 38 e0 ff ff a8 08 75 08 31 c0 fb 0f
> =

> =

> >>RIP; ffffffff810088cf <mwait_idle+d2/159>   <=3D=3D=3D=3D=3D
> =

> >>RAX; ffff88013f514010 <phys_startup_64+ffff88013e514010/ffffffff8000000=
0>
> >>RBX; ffff88013f515fd8 <phys_startup_64+ffff88013e515fd8/ffffffff8000000=
0>
> >>RDI; ffffffff818df108 <idle_notifier+8/10>
> >>RBP; ffff88013f515f08 <phys_startup_64+ffff88013e515f08/ffffffff8000000=
0>
> >>R10; 7fffffffffffffff <phys_startup_64+7ffffffffeffffff/ffffffff8000000=
0>
> >>R11; ffffffff8184e4d0 <migration_notifier+0/20>
> =

> Trace; ffffffff81001c88 <cpu_idle+5a/91>
> Trace; ffffffff81411371 <start_secondary+19c/1a0>
> =

> Code;  ffffffff810088a4 <mwait_idle+a7/159>
> 0000000000000000 <_RIP>:
> Code;  ffffffff810088a4 <mwait_idle+a7/159>
>    0:   c2 74 13                  retq   $0x1374
> Code;  ffffffff810088a7 <mwait_idle+aa/159>
>    3:   65 48 8b 04 25 88 b5      mov    %gs:0xb588,%rax
> Code;  ffffffff810088ae <mwait_idle+b1/159>
>    a:   00 00
> Code;  ffffffff810088b0 <mwait_idle+b3/159>
>    c:   48 2d d8 1f 00 00         sub    $0x1fd8,%rax
> Code;  ffffffff810088b6 <mwait_idle+b9/159>
>   12:   0f ae 78 10               clflush 0x10(%rax)
> Code;  ffffffff810088ba <mwait_idle+bd/159>
>   16:   31 d2                     xor    %edx,%edx
> Code;  ffffffff810088bc <mwait_idle+bf/159>
>   18:   65 48 8b 1c 25 88 b5      mov    %gs:0xb588,%rbx
> Code;  ffffffff810088c3 <mwait_idle+c6/159>
>   1f:   00 00
> Code;  ffffffff810088c5 <mwait_idle+c8/159>
>   21:   48 89 d1                  mov    %rdx,%rcx
> Code;  ffffffff810088c8 <mwait_idle+cb/159>
>   24:   48 8d 83 38 e0 ff ff      lea    -0x1fc8(%rbx),%rax
> Code;  ffffffff810088cf <mwait_idle+d2/159>   <=3D=3D=3D=3D=3D
>   2b:   0f 01 c8                  monitor %rax,%rcx,%rdx   <=3D=3D=3D=3D=
=3D
> Code;  ffffffff810088d2 <mwait_idle+d5/159>
>   2e:   0f ae f0                  mfence
> Code;  ffffffff810088d5 <mwait_idle+d8/159>
>   31:   48 8b 83 38 e0 ff ff      mov    -0x1fc8(%rbx),%rax
> Code;  ffffffff810088dc <mwait_idle+df/159>
>   38:   a8 08                     test   $0x8,%al
> Code;  ffffffff810088de <mwait_idle+e1/159>
>   3a:   75 08                     jne    44 <_RIP+0x44>
> Code;  ffffffff810088e0 <mwait_idle+e3/159>
>   3c:   31 c0                     xor    %eax,%eax
> Code;  ffffffff810088e2 <mwait_idle+e5/159>
>   3e:   fb                        sti
> Code;  ffffffff810088e3 <mwait_idle+e6/159>
>   3f:
> =

>  Kernel panic - not syncing: Attempted to kill the idle task!
>  Pid: 0, comm: kworker/0:0 Tainted: G      D W   3.0.0-rc7min #14
>  Call Trace:
>   [<ffffffff81414bc4>] panic+0x8c/0x199
>   [<ffffffff810343d5>] do_exit+0xab/0x737
>   [<ffffffff8103137a>] ? kmsg_dump+0x44/0xe3
>   [<ffffffff81004fe4>] oops_end+0xb1/0xb9
>   [<ffffffff810050d2>] die+0x55/0x5e
>   [<ffffffff81002bce>] do_trap+0x11c/0x12b
>   [<ffffffff81002f4e>] do_invalid_op+0x91/0x9a
>   [<ffffffff810088cf>] ? mwait_idle+0xd2/0x159
>   [<ffffffff81016a71>] ? __setup_APIC_LVTT+0x67/0x88
>   [<ffffffff81052939>] ? ktime_get+0x5f/0xb5
>   [<ffffffff81016aaa>] ? lapic_next_event+0x18/0x1c
>   [<ffffffff81056a4a>] ? clockevents_program_event+0x75/0x7e
>   [<ffffffff81056d77>] ? tick_setup_periodic+0x6f/0x81
>   [<ffffffff814186d5>] invalid_op+0x15/0x20
>   [<ffffffff810088cf>] ? mwait_idle+0xd2/0x159
>   [<ffffffff8104f5dc>] ? atomic_notifier_call_chain+0x13/0x15
>   [<ffffffff81001c88>] cpu_idle+0x5a/0x91
>   [<ffffffff81411371>] start_secondary+0x19c/0x1a0
> Warning (Oops_read): Code line not seen, dumping what data is available
> =

> =

> Trace; ffffffff81414bc4 <panic+8c/199>
> Trace; ffffffff810343d5 <do_exit+ab/737>
> Trace; ffffffff8103137a <kmsg_dump+44/e3>
> Trace; ffffffff81004fe4 <oops_end+b1/b9>
> Trace; ffffffff810050d2 <die+55/5e>
> Trace; ffffffff81002bce <do_trap+11c/12b>
> Trace; ffffffff81002f4e <do_invalid_op+91/9a>
> Trace; ffffffff810088cf <mwait_idle+d2/159>
> Trace; ffffffff81016a71 <__setup_APIC_LVTT+67/88>
> Trace; ffffffff81052939 <ktime_get+5f/b5>
> Trace; ffffffff81016aaa <lapic_next_event+18/1c>
> Trace; ffffffff81056a4a <clockevents_program_event+75/7e>
> Trace; ffffffff81056d77 <tick_setup_periodic+6f/81>
> Trace; ffffffff814186d5 <invalid_op+15/20>
> Trace; ffffffff810088cf <mwait_idle+d2/159>
> Trace; ffffffff8104f5dc <atomic_notifier_call_chain+13/15>
> Trace; ffffffff81001c88 <cpu_idle+5a/91>
> Trace; ffffffff81411371 <start_secondary+19c/1a0>
> 1 warning and 1 error issued.  Results may not be reliable.
> =

> To get there, I do the following:
> 1) disable cpu1 and cpu2 (both on cpu core 1 if I got it right) with:
> $ echo 0 > /sys/devices/system/cpu/cpu1/online
> $ echo 0 > /sys/devices/system/cpu/cpu2/online
> this leaves me with cpu0 and cpu3 which are both hyperthreads on
> =

> 2) suspend to ram, then resume the system
> $ echo mem > /sys/power/state
> (system goes into suspend, resumable by pressing the power button)
> =

> 2a) During supend, a warning is issuted. My guess is that the harddisk is=
 simply slow to spin up. Is that guess right ?
> $ dmesg
> [  104.092215] PM: Syncing filesystems ... done.
> [  104.096763] PM: Preparing system for mem sleep
> [  104.104047] Freezing user space processes ... (elapsed 0.01 seconds) d=
one.
> [  104.121723] Freezing remaining freezable tasks ... (elapsed 0.01 secon=
ds) done.
> [  104.139774] PM: Entering mem sleep
> [  104.143700] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
> [  104.143721] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [  104.143878] sd 0:0:0:0: [sda] Stopping disk
> [  104.158499] sd 1:0:0:0: [sdb] Stopping disk
> [  104.169431] serial 00:08: disabled
> [  104.172946] serial 00:08: wake-up capability disabled by ACPI
> [  108.652030] serial 00:08: activated
> [  108.963044] ata6: SATA link down (SStatus 0 SControl 300)
> [  108.968599] ata5: SATA link down (SStatus 0 SControl 300)
> [  110.156028] ata1: link is slow to respond, please be patient (ready=3D=
0)
> [  110.162673] ata2: link is slow to respond, please be patient (ready=3D=
0)
> [  113.943040] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  113.951711] ata2.00: configured for UDMA/133
> [  114.803024] ata1: COMRESET failed (errno=3D-16)
> [  117.050031] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  117.086293] ata1.00: configured for UDMA/133
> [  117.100984] PM: resume of devices complete after 12306.735 msecs
> [  117.107275] PM: resume devices took 12.313 seconds
> [  117.112177] ------------[ cut here ]------------
> [  117.116910] WARNING: at kernel/power/suspend_test.c:53 suspend_test_fi=
nish+0x7b/0x84()
> [  117.125009] Hardware name: D525TUD
> [  117.128511] Component: resume devices, time: 12313
> [  117.133414] Pid: 3612, comm: echo Not tainted 3.0.0-rc7min #14
> [  117.139352] Call Trace:
> [  117.141905]  [<ffffffff81030f02>] warn_slowpath_common+0x7b/0x93
> [  117.148024]  [<ffffffff81030fae>] warn_slowpath_fmt+0x41/0x43
> [  117.153882]  [<ffffffff8105dabb>] suspend_test_finish+0x7b/0x84
> [  117.159918]  [<ffffffff8105d853>] suspend_devices_and_enter+0x1d9/0x236
> [  117.166642]  [<ffffffff8105d98f>] enter_state+0xdf/0x135
> [  117.172062]  [<ffffffff8105d062>] state_store+0xb1/0xce
> [  117.177403]  [<ffffffff81210ee3>] kobj_attr_store+0x17/0x19
> [  117.183088]  [<ffffffff81113a97>] sysfs_write_file+0xef/0x12b
> [  117.188947]  [<ffffffff810c5687>] vfs_write+0xae/0x153
> [  117.194196]  [<ffffffff810c57e5>] sys_write+0x45/0x6c
> [  117.199362]  [<ffffffff81417afb>] system_call_fastpath+0x16/0x1b
> [  117.205481] ---[ end trace 27f1f84a48a28b3a ]---
> [  117.210220] PM: Finishing wakeup.
> [  117.213636] Restarting tasks ... done.
> =

> 3) Now enabling the cpu1 or cpu2 (on core 1) leads to the panic:
> $ echo 1 > /sys/devices/system/cpu/cpu1/online
> [  162.550537] Booting Node 0 Processor 1 APIC 0x2
> [  162.555190] smpboot cpu 1: start_ip =3D 9a000
> [   28.795663] Disabled fast string operations
> [  162.638260] invalid opcode: 0000 [#1] SMP
> [  162.638260] CPU 1
> [  162.638260] Pid: 0, comm: kworker/0:0 Tainted: G        W   3.0.0-rc7m=
in #14 Gigabyte Technology Co., Ltd. D525TUD/D525TUD
> ... this is the oops which is at the beginnin ot the message ...
> =

> Attached: kernel .config, cpuinfo, content of /sys/power/* and content of=
 /sys/devices/system/cpu/*
> =

> More info:
> enabling and disabling cpu1, cpu2 and/or cpu3 in any combination or seque=
nce works without errror if the system had not been suspended to ram before.
> Suspend to disk works, also works if all cpus are enabled
> Testing suspend to ram with /sys/power/pm_test works with all tests, incl=
uding "core" even if all cpus are enabled
> suspend to ram does not work with all cpus enabled, the system will only =
show the VGA BIOS greeting message and blinking keyboard leds.
> =

> If CONFIG_INTEL_IDLE is set in kernel config, the oops trace will include=
 "intel_idle" instead of "mwait_idle" but not differ much otherwise. I can =
provide an oops trace with intel_idle if it helps.
> =

> I have tested kernels 2.6.35.10 2.6.36.2 2.6.37-rc6 2.6.39-git all with t=
he same problem half a year ago.
> Back then, the system had BIOS revision F3, this got upgraded to F4 for t=
he tests with the 3.0.0-rc7 kernel.
> =

> Earlier, I had tried posting the problem to the linux-pm mailing list
>  https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/0296=
54.html
>  https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/0296=
55.html
>  https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/0296=
56.html
> However, I got the only answer I got was to try it on the LKML
> =

> Any help is appreciated.
> =

> I am NOT on the LKML, so please CC me in replies.
> -Martin
> =

> ------------------   Kernel config -------------
> CONFIG_64BIT=3Dy
> CONFIG_X86_64=3Dy
> CONFIG_X86=3Dy
> CONFIG_INSTRUCTION_DECODER=3Dy
> CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
> CONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/x86_64_defconfig"
> CONFIG_GENERIC_CMOS_UPDATE=3Dy
> CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
> CONFIG_GENERIC_CLOCKEVENTS=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
> CONFIG_LOCKDEP_SUPPORT=3Dy
> CONFIG_STACKTRACE_SUPPORT=3Dy
> CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
> CONFIG_MMU=3Dy
> CONFIG_ZONE_DMA=3Dy
> CONFIG_NEED_DMA_MAP_STATE=3Dy
> CONFIG_NEED_SG_DMA_LENGTH=3Dy
> CONFIG_GENERIC_ISA_DMA=3Dy
> CONFIG_GENERIC_IOMAP=3Dy
> CONFIG_GENERIC_BUG=3Dy
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
> CONFIG_GENERIC_HWEIGHT=3Dy
> CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
> CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> CONFIG_ARCH_HAS_CPU_IDLE_WAIT=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_GENERIC_TIME_VSYSCALL=3Dy
> CONFIG_ARCH_HAS_CPU_RELAX=3Dy
> CONFIG_ARCH_HAS_DEFAULT_IDLE=3Dy
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
> CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
> CONFIG_HAVE_CPUMASK_OF_CPU_MAP=3Dy
> CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
> CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> CONFIG_ZONE_DMA32=3Dy
> CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
> CONFIG_AUDIT_ARCH=3Dy
> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=3Dy
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> CONFIG_X86_64_SMP=3Dy
> CONFIG_X86_HT=3Dy
> CONFIG_ARCH_HWEIGHT_CFLAGS=3D"-fcall-saved-rdi -fcall-saved-rsi -fcall-sa=
ved-rdx -fcall-saved-rcx -fcall-saved-r8 -fcall-saved-r9 -fcall-saved-r10 -=
fcall-saved-r11"
> CONFIG_ARCH_CPU_PROBE_RELEASE=3Dy
> CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
> CONFIG_HAVE_IRQ_WORK=3Dy
> CONFIG_IRQ_WORK=3Dy
> CONFIG_EXPERIMENTAL=3Dy
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
> CONFIG_CROSS_COMPILE=3D""
> CONFIG_LOCALVERSION=3D"min"
> CONFIG_HAVE_KERNEL_GZIP=3Dy
> CONFIG_HAVE_KERNEL_BZIP2=3Dy
> CONFIG_HAVE_KERNEL_LZMA=3Dy
> CONFIG_HAVE_KERNEL_XZ=3Dy
> CONFIG_HAVE_KERNEL_LZO=3Dy
> CONFIG_KERNEL_GZIP=3Dy
> CONFIG_DEFAULT_HOSTNAME=3D"behemoth"
> CONFIG_SWAP=3Dy
> CONFIG_SYSVIPC=3Dy
> CONFIG_SYSVIPC_SYSCTL=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_FHANDLE=3Dy
> CONFIG_TASKSTATS=3Dy
> CONFIG_TASK_DELAY_ACCT=3Dy
> CONFIG_TASK_XACCT=3Dy
> CONFIG_TASK_IO_ACCOUNTING=3Dy
> CONFIG_AUDIT=3Dy
> CONFIG_AUDITSYSCALL=3Dy
> CONFIG_AUDIT_WATCH=3Dy
> CONFIG_AUDIT_TREE=3Dy
> CONFIG_HAVE_GENERIC_HARDIRQS=3Dy
> CONFIG_GENERIC_HARDIRQS=3Dy
> CONFIG_HAVE_SPARSE_IRQ=3Dy
> CONFIG_GENERIC_IRQ_PROBE=3Dy
> CONFIG_GENERIC_IRQ_SHOW=3Dy
> CONFIG_GENERIC_PENDING_IRQ=3Dy
> CONFIG_IRQ_FORCED_THREADING=3Dy
> CONFIG_SPARSE_IRQ=3Dy
> CONFIG_TREE_RCU=3Dy
> CONFIG_RCU_FANOUT=3D32
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> CONFIG_LOG_BUF_SHIFT=3D20
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
> CONFIG_NAMESPACES=3Dy
> CONFIG_UTS_NS=3Dy
> CONFIG_IPC_NS=3Dy
> CONFIG_USER_NS=3Dy
> CONFIG_PID_NS=3Dy
> CONFIG_NET_NS=3Dy
> CONFIG_RELAY=3Dy
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_INITRAMFS_SOURCE=3D""
> CONFIG_RD_GZIP=3Dy
> CONFIG_RD_BZIP2=3Dy
> CONFIG_RD_LZMA=3Dy
> CONFIG_RD_XZ=3Dy
> CONFIG_RD_LZO=3Dy
> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> CONFIG_SYSCTL=3Dy
> CONFIG_ANON_INODES=3Dy
> CONFIG_SYSCTL_SYSCALL=3Dy
> CONFIG_KALLSYMS=3Dy
> CONFIG_HOTPLUG=3Dy
> CONFIG_PRINTK=3Dy
> CONFIG_BUG=3Dy
> CONFIG_ELF_CORE=3Dy
> CONFIG_PCSPKR_PLATFORM=3Dy
> CONFIG_BASE_FULL=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SIGNALFD=3Dy
> CONFIG_TIMERFD=3Dy
> CONFIG_EVENTFD=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_AIO=3Dy
> CONFIG_HAVE_PERF_EVENTS=3Dy
> CONFIG_PERF_EVENTS=3Dy
> CONFIG_VM_EVENT_COUNTERS=3Dy
> CONFIG_PCI_QUIRKS=3Dy
> CONFIG_SLAB=3Dy
> CONFIG_TRACEPOINTS=3Dy
> CONFIG_HAVE_OPROFILE=3Dy
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> CONFIG_HAVE_IOREMAP_PROT=3Dy
> CONFIG_HAVE_KPROBES=3Dy
> CONFIG_HAVE_KRETPROBES=3Dy
> CONFIG_HAVE_OPTPROBES=3Dy
> CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> CONFIG_HAVE_DMA_ATTRS=3Dy
> CONFIG_USE_GENERIC_SMP_HELPERS=3Dy
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
> CONFIG_HAVE_DMA_API_DEBUG=3Dy
> CONFIG_HAVE_HW_BREAKPOINT=3Dy
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
> CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
> CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
> CONFIG_SLABINFO=3Dy
> CONFIG_RT_MUTEXES=3Dy
> CONFIG_BASE_SMALL=3D0
> CONFIG_STOP_MACHINE=3Dy
> CONFIG_BLOCK=3Dy
> CONFIG_BLK_DEV_BSG=3Dy
> CONFIG_IOSCHED_NOOP=3Dy
> CONFIG_IOSCHED_DEADLINE=3Dy
> CONFIG_IOSCHED_CFQ=3Dy
> CONFIG_DEFAULT_CFQ=3Dy
> CONFIG_DEFAULT_IOSCHED=3D"cfq"
> CONFIG_INLINE_SPIN_UNLOCK=3Dy
> CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy
> CONFIG_INLINE_READ_UNLOCK=3Dy
> CONFIG_INLINE_READ_UNLOCK_IRQ=3Dy
> CONFIG_INLINE_WRITE_UNLOCK=3Dy
> CONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy
> CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
> CONFIG_FREEZER=3Dy
> CONFIG_TICK_ONESHOT=3Dy
> CONFIG_NO_HZ=3Dy
> CONFIG_HIGH_RES_TIMERS=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
> CONFIG_SMP=3Dy
> CONFIG_X86_MPPARSE=3Dy
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
> CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
> CONFIG_NO_BOOTMEM=3Dy
> CONFIG_MATOM=3Dy
> CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
> CONFIG_X86_CMPXCHG=3Dy
> CONFIG_CMPXCHG_LOCAL=3Dy
> CONFIG_X86_L1_CACHE_SHIFT=3D6
> CONFIG_X86_XADD=3Dy
> CONFIG_X86_WP_WORKS_OK=3Dy
> CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
> CONFIG_X86_TSC=3Dy
> CONFIG_X86_CMPXCHG64=3Dy
> CONFIG_X86_CMOV=3Dy
> CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
> CONFIG_X86_DEBUGCTLMSR=3Dy
> CONFIG_CPU_SUP_INTEL=3Dy
> CONFIG_CPU_SUP_AMD=3Dy
> CONFIG_CPU_SUP_CENTAUR=3Dy
> CONFIG_HPET_TIMER=3Dy
> CONFIG_HPET_EMULATE_RTC=3Dy
> CONFIG_DMI=3Dy
> CONFIG_GART_IOMMU=3Dy
> CONFIG_SWIOTLB=3Dy
> CONFIG_IOMMU_HELPER=3Dy
> CONFIG_NR_CPUS=3D4
> CONFIG_SCHED_MC=3Dy
> CONFIG_PREEMPT_NONE=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_X86_IO_APIC=3Dy
> CONFIG_X86_MCE=3Dy
> CONFIG_X86_MCE_INTEL=3Dy
> CONFIG_X86_MCE_THRESHOLD=3Dy
> CONFIG_X86_THERMAL_VECTOR=3Dy
> CONFIG_MICROCODE=3Dy
> CONFIG_MICROCODE_INTEL=3Dy
> CONFIG_MICROCODE_OLD_INTERFACE=3Dy
> CONFIG_X86_MSR=3Dy
> CONFIG_X86_CPUID=3Dy
> CONFIG_ARCH_PHYS_ADDR_T_64BIT=3Dy
> CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
> CONFIG_DIRECT_GBPAGES=3Dy
> CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
> CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
> CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
> CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
> CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
> CONFIG_SELECT_MEMORY_MODEL=3Dy
> CONFIG_SPARSEMEM_MANUAL=3Dy
> CONFIG_SPARSEMEM=3Dy
> CONFIG_HAVE_MEMORY_PRESENT=3Dy
> CONFIG_SPARSEMEM_EXTREME=3Dy
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
> CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=3Dy
> CONFIG_SPARSEMEM_VMEMMAP=3Dy
> CONFIG_HAVE_MEMBLOCK=3Dy
> CONFIG_PAGEFLAGS_EXTENDED=3Dy
> CONFIG_SPLIT_PTLOCK_CPUS=3D4
> CONFIG_COMPACTION=3Dy
> CONFIG_MIGRATION=3Dy
> CONFIG_PHYS_ADDR_T_64BIT=3Dy
> CONFIG_ZONE_DMA_FLAG=3D1
> CONFIG_BOUNCE=3Dy
> CONFIG_VIRT_TO_BUS=3Dy
> CONFIG_KSM=3Dy
> CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
> CONFIG_CLEANCACHE=3Dy
> CONFIG_X86_CHECK_BIOS_CORRUPTION=3Dy
> CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=3Dy
> CONFIG_X86_RESERVE_LOW=3D64
> CONFIG_MTRR=3Dy
> CONFIG_MTRR_SANITIZER=3Dy
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D0
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
> CONFIG_X86_PAT=3Dy
> CONFIG_ARCH_USES_PG_UNCACHED=3Dy
> CONFIG_SECCOMP=3Dy
> CONFIG_HZ_1000=3Dy
> CONFIG_HZ=3D1000
> CONFIG_SCHED_HRTICK=3Dy
> CONFIG_KEXEC=3Dy
> CONFIG_CRASH_DUMP=3Dy
> CONFIG_PHYSICAL_START=3D0x1000000
> CONFIG_RELOCATABLE=3Dy
> CONFIG_PHYSICAL_ALIGN=3D0x1000000
> CONFIG_HOTPLUG_CPU=3Dy
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
> CONFIG_ARCH_HIBERNATION_HEADER=3Dy
> CONFIG_SUSPEND=3Dy
> CONFIG_SUSPEND_FREEZER=3Dy
> CONFIG_HIBERNATE_CALLBACKS=3Dy
> CONFIG_HIBERNATION=3Dy
> CONFIG_PM_STD_PARTITION=3D""
> CONFIG_PM_SLEEP=3Dy
> CONFIG_PM_SLEEP_SMP=3Dy
> CONFIG_PM_RUNTIME=3Dy
> CONFIG_PM=3Dy
> CONFIG_PM_DEBUG=3Dy
> CONFIG_PM_ADVANCED_DEBUG=3Dy
> CONFIG_PM_TEST_SUSPEND=3Dy
> CONFIG_CAN_PM_TRACE=3Dy
> CONFIG_PM_TRACE=3Dy
> CONFIG_PM_TRACE_RTC=3Dy
> CONFIG_ACPI=3Dy
> CONFIG_ACPI_SLEEP=3Dy
> CONFIG_ACPI_PROC_EVENT=3Dy
> CONFIG_ACPI_BUTTON=3Dy
> CONFIG_ACPI_PROCESSOR=3Dy
> CONFIG_ACPI_HOTPLUG_CPU=3Dy
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=3Dy
> CONFIG_ACPI_THERMAL=3Dy
> CONFIG_ACPI_BLACKLIST_YEAR=3D0
> CONFIG_X86_PM_TIMER=3Dy
> CONFIG_ACPI_CONTAINER=3Dy
> CONFIG_ACPI_CUSTOM_METHOD=3Dy
> CONFIG_CPU_IDLE=3Dy
> CONFIG_CPU_IDLE_GOV_LADDER=3Dy
> CONFIG_CPU_IDLE_GOV_MENU=3Dy
> CONFIG_PCI=3Dy
> CONFIG_PCI_DIRECT=3Dy
> CONFIG_PCI_MMCONFIG=3Dy
> CONFIG_PCI_DOMAINS=3Dy
> CONFIG_PCIEPORTBUS=3Dy
> CONFIG_PCIEAER=3Dy
> CONFIG_PCIEASPM=3Dy
> CONFIG_PCIE_PME=3Dy
> CONFIG_ARCH_SUPPORTS_MSI=3Dy
> CONFIG_PCI_MSI=3Dy
> CONFIG_HT_IRQ=3Dy
> CONFIG_PCI_IOAPIC=3Dy
> CONFIG_PCI_LABEL=3Dy
> CONFIG_ISA_DMA_API=3Dy
> CONFIG_AMD_NB=3Dy
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> CONFIG_BINFMT_MISC=3Dy
> CONFIG_HAVE_TEXT_POKE_SMP=3Dy
> CONFIG_NET=3Dy
> CONFIG_PACKET=3Dy
> CONFIG_UNIX=3Dy
> CONFIG_XFRM=3Dy
> CONFIG_XFRM_USER=3Dy
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_ADVANCED_ROUTER=3Dy
> CONFIG_IP_MULTIPLE_TABLES=3Dy
> CONFIG_IP_ROUTE_MULTIPATH=3Dy
> CONFIG_IP_ROUTE_VERBOSE=3Dy
> CONFIG_IP_PNP=3Dy
> CONFIG_IP_PNP_DHCP=3Dy
> CONFIG_IP_PNP_BOOTP=3Dy
> CONFIG_IP_PNP_RARP=3Dy
> CONFIG_IP_MROUTE=3Dy
> CONFIG_IP_PIMSM_V1=3Dy
> CONFIG_IP_PIMSM_V2=3Dy
> CONFIG_SYN_COOKIES=3Dy
> CONFIG_INET_TUNNEL=3Dy
> CONFIG_INET_LRO=3Dy
> CONFIG_TCP_CONG_ADVANCED=3Dy
> CONFIG_TCP_CONG_CUBIC=3Dy
> CONFIG_DEFAULT_CUBIC=3Dy
> CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> CONFIG_TCP_MD5SIG=3Dy
> CONFIG_IPV6=3Dy
> CONFIG_INET6_AH=3Dy
> CONFIG_INET6_ESP=3Dy
> CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dy
> CONFIG_INET6_XFRM_MODE_TUNNEL=3Dy
> CONFIG_INET6_XFRM_MODE_BEET=3Dy
> CONFIG_IPV6_SIT=3Dy
> CONFIG_IPV6_NDISC_NODETYPE=3Dy
> CONFIG_NETWORK_SECMARK=3Dy
> CONFIG_NETFILTER=3Dy
> CONFIG_NETFILTER_NETLINK=3Dy
> CONFIG_NETFILTER_NETLINK_LOG=3Dy
> CONFIG_NF_CONNTRACK=3Dy
> CONFIG_NF_CONNTRACK_SECMARK=3Dy
> CONFIG_NF_CONNTRACK_FTP=3Dy
> CONFIG_NF_CONNTRACK_IRC=3Dy
> CONFIG_NF_CONNTRACK_SIP=3Dy
> CONFIG_NF_CT_NETLINK=3Dy
> CONFIG_NETFILTER_XTABLES=3Dy
> CONFIG_NETFILTER_XT_MARK=3Dy
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dy
> CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dy
> CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dy
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dy
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dy
> CONFIG_NETFILTER_XT_MATCH_POLICY=3Dy
> CONFIG_NETFILTER_XT_MATCH_STATE=3Dy
> CONFIG_NF_DEFRAG_IPV4=3Dy
> CONFIG_NF_CONNTRACK_IPV4=3Dy
> CONFIG_NF_CONNTRACK_PROC_COMPAT=3Dy
> CONFIG_IP_NF_IPTABLES=3Dy
> CONFIG_IP_NF_FILTER=3Dy
> CONFIG_IP_NF_TARGET_REJECT=3Dy
> CONFIG_IP_NF_TARGET_LOG=3Dy
> CONFIG_IP_NF_TARGET_ULOG=3Dy
> CONFIG_NF_NAT=3Dy
> CONFIG_NF_NAT_NEEDED=3Dy
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dy
> CONFIG_NF_NAT_FTP=3Dy
> CONFIG_NF_NAT_IRC=3Dy
> CONFIG_NF_NAT_SIP=3Dy
> CONFIG_IP_NF_MANGLE=3Dy
> CONFIG_NF_DEFRAG_IPV6=3Dy
> CONFIG_NF_CONNTRACK_IPV6=3Dy
> CONFIG_IP6_NF_IPTABLES=3Dy
> CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dy
> CONFIG_IP6_NF_TARGET_LOG=3Dy
> CONFIG_IP6_NF_FILTER=3Dy
> CONFIG_IP6_NF_TARGET_REJECT=3Dy
> CONFIG_IP6_NF_MANGLE=3Dy
> CONFIG_IP_SCTP=3Dy
> CONFIG_SCTP_HMAC_MD5=3Dy
> CONFIG_NET_SCHED=3Dy
> CONFIG_NET_CLS=3Dy
> CONFIG_NET_EMATCH=3Dy
> CONFIG_NET_EMATCH_STACK=3D32
> CONFIG_NET_CLS_ACT=3Dy
> CONFIG_NET_SCH_FIFO=3Dy
> CONFIG_DNS_RESOLVER=3Dy
> CONFIG_RPS=3Dy
> CONFIG_RFS_ACCEL=3Dy
> CONFIG_XPS=3Dy
> CONFIG_HAVE_BPF_JIT=3Dy
> CONFIG_FIB_RULES=3Dy
> CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
> CONFIG_STANDALONE=3Dy
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
> CONFIG_FW_LOADER=3Dy
> CONFIG_FIRMWARE_IN_KERNEL=3Dy
> CONFIG_EXTRA_FIRMWARE=3D""
> CONFIG_PNP=3Dy
> CONFIG_PNP_DEBUG_MESSAGES=3Dy
> CONFIG_PNPACPI=3Dy
> CONFIG_BLK_DEV=3Dy
> CONFIG_BLK_DEV_LOOP=3Dy
> CONFIG_BLK_DEV_NBD=3Dy
> CONFIG_BLK_DEV_RAM=3Dy
> CONFIG_BLK_DEV_RAM_COUNT=3D16
> CONFIG_BLK_DEV_RAM_SIZE=3D16384
> CONFIG_HAVE_IDE=3Dy
> CONFIG_SCSI_MOD=3Dy
> CONFIG_RAID_ATTRS=3Dy
> CONFIG_SCSI=3Dy
> CONFIG_SCSI_DMA=3Dy
> CONFIG_SCSI_PROC_FS=3Dy
> CONFIG_BLK_DEV_SD=3Dy
> CONFIG_ATA=3Dy
> CONFIG_ATA_VERBOSE_ERROR=3Dy
> CONFIG_ATA_ACPI=3Dy
> CONFIG_SATA_AHCI=3Dy
> CONFIG_ATA_SFF=3Dy
> CONFIG_ATA_BMDMA=3Dy
> CONFIG_PATA_JMICRON=3Dy
> CONFIG_ATA_GENERIC=3Dy
> CONFIG_MD=3Dy
> CONFIG_BLK_DEV_MD=3Dy
> CONFIG_MD_AUTODETECT=3Dy
> CONFIG_MD_RAID0=3Dy
> CONFIG_MD_RAID1=3Dy
> CONFIG_BLK_DEV_DM=3Dy
> CONFIG_DM_SNAPSHOT=3Dy
> CONFIG_DM_MIRROR=3Dy
> CONFIG_NETDEVICES=3Dy
> CONFIG_MII=3Dy
> CONFIG_NETDEV_1000=3Dy
> CONFIG_R8169=3Dy
> CONFIG_NETCONSOLE=3Dy
> CONFIG_NETCONSOLE_DYNAMIC=3Dy
> CONFIG_NETPOLL=3Dy
> CONFIG_NET_POLL_CONTROLLER=3Dy
> CONFIG_INPUT=3Dy
> CONFIG_INPUT_FF_MEMLESS=3Dy
> CONFIG_INPUT_POLLDEV=3Dy
> CONFIG_INPUT_SPARSEKMAP=3Dy
> CONFIG_INPUT_MOUSEDEV=3Dy
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> CONFIG_INPUT_EVDEV=3Dy
> CONFIG_INPUT_KEYBOARD=3Dy
> CONFIG_KEYBOARD_ATKBD=3Dy
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dy
> CONFIG_MOUSE_PS2_ALPS=3Dy
> CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
> CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
> CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
> CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
> CONFIG_INPUT_JOYSTICK=3Dy
> CONFIG_INPUT_TABLET=3Dy
> CONFIG_INPUT_TOUCHSCREEN=3Dy
> CONFIG_INPUT_MISC=3Dy
> CONFIG_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> CONFIG_SERIO_SERPORT=3Dy
> CONFIG_SERIO_LIBPS2=3Dy
> CONFIG_SERIO_RAW=3Dy
> CONFIG_VT=3Dy
> CONFIG_CONSOLE_TRANSLATIONS=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> CONFIG_UNIX98_PTYS=3Dy
> CONFIG_SERIAL_NONSTANDARD=3Dy
> CONFIG_DEVKMEM=3Dy
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_FIX_EARLYCON_MEM=3Dy
> CONFIG_SERIAL_8250_PCI=3Dy
> CONFIG_SERIAL_8250_PNP=3Dy
> CONFIG_SERIAL_8250_NR_UARTS=3D32
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> CONFIG_SERIAL_8250_EXTENDED=3Dy
> CONFIG_SERIAL_8250_MANY_PORTS=3Dy
> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
> CONFIG_SERIAL_8250_RSA=3Dy
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> CONFIG_HW_RANDOM=3Dy
> CONFIG_HW_RANDOM_INTEL=3Dy
> CONFIG_HW_RANDOM_AMD=3Dy
> CONFIG_HW_RANDOM_VIA=3Dy
> CONFIG_NVRAM=3Dy
> CONFIG_HPET=3Dy
> CONFIG_HANGCHECK_TIMER=3Dy
> CONFIG_DEVPORT=3Dy
> CONFIG_RAMOOPS=3Dy
> CONFIG_I2C=3Dy
> CONFIG_I2C_BOARDINFO=3Dy
> CONFIG_I2C_COMPAT=3Dy
> CONFIG_I2C_HELPER_AUTO=3Dy
> CONFIG_I2C_ALGOBIT=3Dy
> CONFIG_I2C_I801=3Dy
> CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
> CONFIG_HWMON=3Dy
> CONFIG_THERMAL=3Dy
> CONFIG_SSB_POSSIBLE=3Dy
> CONFIG_BCMA_POSSIBLE=3Dy
> CONFIG_AGP=3Dy
> CONFIG_AGP_INTEL=3Dy
> CONFIG_VGA_ARB=3Dy
> CONFIG_VGA_ARB_MAX_GPUS=3D16
> CONFIG_DRM=3Dy
> CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
> CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> CONFIG_BACKLIGHT_GENERIC=3Dy
> CONFIG_VGA_CONSOLE=3Dy
> CONFIG_VGACON_SOFT_SCROLLBACK=3Dy
> CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=3D64
> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_RTC_LIB=3Dy
> CONFIG_RTC_CLASS=3Dy
> CONFIG_RTC_INTF_SYSFS=3Dy
> CONFIG_RTC_INTF_PROC=3Dy
> CONFIG_RTC_INTF_DEV=3Dy
> CONFIG_RTC_DRV_CMOS=3Dy
> CONFIG_FIRMWARE_MEMMAP=3Dy
> CONFIG_EXT2_FS=3Dy
> CONFIG_EXT2_FS_XATTR=3Dy
> CONFIG_EXT2_FS_POSIX_ACL=3Dy
> CONFIG_EXT2_FS_SECURITY=3Dy
> CONFIG_EXT2_FS_XIP=3Dy
> CONFIG_EXT3_FS=3Dy
> CONFIG_EXT3_FS_XATTR=3Dy
> CONFIG_EXT3_FS_POSIX_ACL=3Dy
> CONFIG_EXT3_FS_SECURITY=3Dy
> CONFIG_EXT4_FS=3Dy
> CONFIG_EXT4_FS_XATTR=3Dy
> CONFIG_EXT4_FS_POSIX_ACL=3Dy
> CONFIG_EXT4_FS_SECURITY=3Dy
> CONFIG_FS_XIP=3Dy
> CONFIG_JBD=3Dy
> CONFIG_JBD2=3Dy
> CONFIG_FS_MBCACHE=3Dy
> CONFIG_REISERFS_FS=3Dy
> CONFIG_REISERFS_PROC_INFO=3Dy
> CONFIG_REISERFS_FS_XATTR=3Dy
> CONFIG_REISERFS_FS_POSIX_ACL=3Dy
> CONFIG_REISERFS_FS_SECURITY=3Dy
> CONFIG_FS_POSIX_ACL=3Dy
> CONFIG_EXPORTFS=3Dy
> CONFIG_FILE_LOCKING=3Dy
> CONFIG_FSNOTIFY=3Dy
> CONFIG_DNOTIFY=3Dy
> CONFIG_INOTIFY_USER=3Dy
> CONFIG_FANOTIFY=3Dy
> CONFIG_QUOTA=3Dy
> CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
> CONFIG_QUOTACTL=3Dy
> CONFIG_AUTOFS4_FS=3Dy
> CONFIG_FUSE_FS=3Dy
> CONFIG_GENERIC_ACL=3Dy
> CONFIG_FSCACHE=3Dy
> CONFIG_FSCACHE_STATS=3Dy
> CONFIG_FSCACHE_HISTOGRAM=3Dy
> CONFIG_CACHEFILES=3Dy
> CONFIG_CACHEFILES_HISTOGRAM=3Dy
> CONFIG_ISO9660_FS=3Dy
> CONFIG_JOLIET=3Dy
> CONFIG_ZISOFS=3Dy
> CONFIG_FAT_FS=3Dy
> CONFIG_MSDOS_FS=3Dy
> CONFIG_VFAT_FS=3Dy
> CONFIG_FAT_DEFAULT_CODEPAGE=3D850
> CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-15"
> CONFIG_NTFS_FS=3Dy
> CONFIG_NTFS_RW=3Dy
> CONFIG_PROC_FS=3Dy
> CONFIG_PROC_KCORE=3Dy
> CONFIG_PROC_VMCORE=3Dy
> CONFIG_PROC_SYSCTL=3Dy
> CONFIG_PROC_PAGE_MONITOR=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_TMPFS=3Dy
> CONFIG_TMPFS_POSIX_ACL=3Dy
> CONFIG_TMPFS_XATTR=3Dy
> CONFIG_CONFIGFS_FS=3Dy
> CONFIG_PARTITION_ADVANCED=3Dy
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_BSD_DISKLABEL=3Dy
> CONFIG_MINIX_SUBPARTITION=3Dy
> CONFIG_SOLARIS_X86_PARTITION=3Dy
> CONFIG_UNIXWARE_DISKLABEL=3Dy
> CONFIG_LDM_PARTITION=3Dy
> CONFIG_SUN_PARTITION=3Dy
> CONFIG_EFI_PARTITION=3Dy
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"utf8"
> CONFIG_NLS_CODEPAGE_437=3Dy
> CONFIG_NLS_CODEPAGE_850=3Dy
> CONFIG_NLS_ASCII=3Dy
> CONFIG_NLS_ISO8859_1=3Dy
> CONFIG_NLS_ISO8859_15=3Dy
> CONFIG_NLS_UTF8=3Dy
> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> CONFIG_PRINTK_TIME=3Dy
> CONFIG_DEFAULT_MESSAGE_LOGLEVEL=3D7
> CONFIG_ENABLE_MUST_CHECK=3Dy
> CONFIG_FRAME_WARN=3D2048
> CONFIG_MAGIC_SYSRQ=3Dy
> CONFIG_DEBUG_FS=3Dy
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_LOCKUP_DETECTOR=3Dy
> CONFIG_HARDLOCKUP_DETECTOR=3Dy
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D0
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
> CONFIG_STACKTRACE=3Dy
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_DEBUG_INFO_REDUCED=3Dy
> CONFIG_DEBUG_MEMORY_INIT=3Dy
> CONFIG_ARCH_WANT_FRAME_POINTERS=3Dy
> CONFIG_FRAME_POINTER=3Dy
> CONFIG_BOOT_PRINTK_DELAY=3Dy
> CONFIG_RCU_CPU_STALL_TIMEOUT=3D60
> CONFIG_LKDTM=3Dy
> CONFIG_CPU_NOTIFIER_ERROR_INJECT=3Dy
> CONFIG_SYSCTL_SYSCALL_CHECK=3Dy
> CONFIG_USER_STACKTRACE_SUPPORT=3Dy
> CONFIG_NOP_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=3Dy
> CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
> CONFIG_HAVE_C_RECORDMCOUNT=3Dy
> CONFIG_RING_BUFFER=3Dy
> CONFIG_EVENT_TRACING=3Dy
> CONFIG_EVENT_POWER_TRACING_DEPRECATED=3Dy
> CONFIG_CONTEXT_SWITCH_TRACER=3Dy
> CONFIG_TRACING=3Dy
> CONFIG_GENERIC_TRACER=3Dy
> CONFIG_TRACING_SUPPORT=3Dy
> CONFIG_FTRACE=3Dy
> CONFIG_BRANCH_PROFILE_NONE=3Dy
> CONFIG_BLK_DEV_IO_TRACE=3Dy
> CONFIG_HAVE_ARCH_KGDB=3Dy
> CONFIG_HAVE_ARCH_KMEMCHECK=3Dy
> CONFIG_STRICT_DEVMEM=3Dy
> CONFIG_X86_VERBOSE_BOOTUP=3Dy
> CONFIG_EARLY_PRINTK=3Dy
> CONFIG_DEBUG_RODATA=3Dy
> CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
> CONFIG_IO_DELAY_TYPE_0X80=3D0
> CONFIG_IO_DELAY_TYPE_0XED=3D1
> CONFIG_IO_DELAY_TYPE_UDELAY=3D2
> CONFIG_IO_DELAY_TYPE_NONE=3D3
> CONFIG_IO_DELAY_0X80=3Dy
> CONFIG_DEFAULT_IO_DELAY_TYPE=3D0
> CONFIG_KEYS=3Dy
> CONFIG_DEFAULT_SECURITY_DAC=3Dy
> CONFIG_DEFAULT_SECURITY=3D""
> CONFIG_CRYPTO=3Dy
> CONFIG_CRYPTO_ALGAPI=3Dy
> CONFIG_CRYPTO_ALGAPI2=3Dy
> CONFIG_CRYPTO_AEAD=3Dy
> CONFIG_CRYPTO_AEAD2=3Dy
> CONFIG_CRYPTO_BLKCIPHER=3Dy
> CONFIG_CRYPTO_BLKCIPHER2=3Dy
> CONFIG_CRYPTO_HASH=3Dy
> CONFIG_CRYPTO_HASH2=3Dy
> CONFIG_CRYPTO_RNG2=3Dy
> CONFIG_CRYPTO_PCOMP2=3Dy
> CONFIG_CRYPTO_MANAGER=3Dy
> CONFIG_CRYPTO_MANAGER2=3Dy
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
> CONFIG_CRYPTO_WORKQUEUE=3Dy
> CONFIG_CRYPTO_AUTHENC=3Dy
> CONFIG_CRYPTO_CBC=3Dy
> CONFIG_CRYPTO_HMAC=3Dy
> CONFIG_CRYPTO_CRC32C=3Dy
> CONFIG_CRYPTO_MD5=3Dy
> CONFIG_CRYPTO_SHA1=3Dy
> CONFIG_CRYPTO_AES=3Dy
> CONFIG_CRYPTO_DES=3Dy
> CONFIG_HAVE_KVM=3Dy
> CONFIG_BINARY_PRINTF=3Dy
> CONFIG_BITREVERSE=3Dy
> CONFIG_GENERIC_FIND_FIRST_BIT=3Dy
> CONFIG_CRC16=3Dy
> CONFIG_CRC32=3Dy
> CONFIG_LIBCRC32C=3Dy
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_LZO_COMPRESS=3Dy
> CONFIG_LZO_DECOMPRESS=3Dy
> CONFIG_XZ_DEC=3Dy
> CONFIG_XZ_DEC_X86=3Dy
> CONFIG_XZ_DEC_POWERPC=3Dy
> CONFIG_XZ_DEC_IA64=3Dy
> CONFIG_XZ_DEC_ARM=3Dy
> CONFIG_XZ_DEC_ARMTHUMB=3Dy
> CONFIG_XZ_DEC_SPARC=3Dy
> CONFIG_XZ_DEC_BCJ=3Dy
> CONFIG_DECOMPRESS_GZIP=3Dy
> CONFIG_DECOMPRESS_BZIP2=3Dy
> CONFIG_DECOMPRESS_LZMA=3Dy
> CONFIG_DECOMPRESS_XZ=3Dy
> CONFIG_DECOMPRESS_LZO=3Dy
> CONFIG_HAS_IOMEM=3Dy
> CONFIG_HAS_IOPORT=3Dy
> CONFIG_HAS_DMA=3Dy
> CONFIG_CHECK_SIGNATURE=3Dy
> CONFIG_CPU_RMAP=3Dy
> CONFIG_NLATTR=3Dy
> ----------------
> =

> ------ contents of /sys/devices/system/cpu/* after cpu 1 and cpu2 have be=
en turned off -----------
> $ grep -r . /sys/devices/system/cpu/
> grep: /sys/devices/system/cpu/probe: Permission denied
> grep: /sys/devices/system/cpu/release: Permission denied
> /sys/devices/system/cpu/online:0,3
> /sys/devices/system/cpu/possible:0-3
> /sys/devices/system/cpu/present:0-3
> /sys/devices/system/cpu/kernel_max:3
> /sys/devices/system/cpu/offline:1-2
> /sys/devices/system/cpu/cpuidle/current_driver:intel_idle
> /sys/devices/system/cpu/cpuidle/current_governor_ro:menu
> /sys/devices/system/cpu/cpu0/crash_notes:13fc14a10
> /sys/devices/system/cpu/cpu0/cache/index0/type:Data
> /sys/devices/system/cpu/cpu0/cache/index0/level:1
> /sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size:64
> /sys/devices/system/cpu/cpu0/cache/index0/physical_line_partition:1
> /sys/devices/system/cpu/cpu0/cache/index0/ways_of_associativity:6
> /sys/devices/system/cpu/cpu0/cache/index0/number_of_sets:64
> /sys/devices/system/cpu/cpu0/cache/index0/size:24K
> /sys/devices/system/cpu/cpu0/cache/index0/shared_cpu_map:9
> /sys/devices/system/cpu/cpu0/cache/index0/shared_cpu_list:0,3
> /sys/devices/system/cpu/cpu0/cache/index1/type:Instruction
> /sys/devices/system/cpu/cpu0/cache/index1/level:1
> /sys/devices/system/cpu/cpu0/cache/index1/coherency_line_size:64
> /sys/devices/system/cpu/cpu0/cache/index1/physical_line_partition:1
> /sys/devices/system/cpu/cpu0/cache/index1/ways_of_associativity:8
> /sys/devices/system/cpu/cpu0/cache/index1/number_of_sets:64
> /sys/devices/system/cpu/cpu0/cache/index1/size:32K
> /sys/devices/system/cpu/cpu0/cache/index1/shared_cpu_map:9
> /sys/devices/system/cpu/cpu0/cache/index1/shared_cpu_list:0,3
> /sys/devices/system/cpu/cpu0/cache/index2/type:Unified
> /sys/devices/system/cpu/cpu0/cache/index2/level:2
> /sys/devices/system/cpu/cpu0/cache/index2/coherency_line_size:64
> /sys/devices/system/cpu/cpu0/cache/index2/physical_line_partition:1
> /sys/devices/system/cpu/cpu0/cache/index2/ways_of_associativity:8
> /sys/devices/system/cpu/cpu0/cache/index2/number_of_sets:1024
> /sys/devices/system/cpu/cpu0/cache/index2/size:512K
> /sys/devices/system/cpu/cpu0/cache/index2/shared_cpu_map:9
> /sys/devices/system/cpu/cpu0/cache/index2/shared_cpu_list:0,3
> /sys/devices/system/cpu/cpu0/thermal_throttle/core_throttle_count:0
> grep: /sys/devices/system/cpu/cpu0/microcode/reload: Permission denied
> /sys/devices/system/cpu/cpu0/microcode/version:0x107
> /sys/devices/system/cpu/cpu0/microcode/processor_flags:0x8
> /sys/devices/system/cpu/cpu0/cpuidle/state0/name:POLL
> /sys/devices/system/cpu/cpu0/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
> /sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/power:4294967295
> /sys/devices/system/cpu/cpu0/cpuidle/state0/usage:8
> /sys/devices/system/cpu/cpu0/cpuidle/state0/time:1838938
> /sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1-ATM
> /sys/devices/system/cpu/cpu0/cpuidle/state1/desc:MWAIT 0x00
> /sys/devices/system/cpu/cpu0/cpuidle/state1/latency:1
> /sys/devices/system/cpu/cpu0/cpuidle/state1/power:4294967294
> /sys/devices/system/cpu/cpu0/cpuidle/state1/usage:15944
> /sys/devices/system/cpu/cpu0/cpuidle/state1/time:167329609
> /sys/devices/system/cpu/cpu0/topology/physical_package_id:0
> /sys/devices/system/cpu/cpu0/topology/core_id:0
> /sys/devices/system/cpu/cpu0/topology/thread_siblings:9
> /sys/devices/system/cpu/cpu0/topology/thread_siblings_list:0,3
> /sys/devices/system/cpu/cpu0/topology/core_siblings:9
> /sys/devices/system/cpu/cpu0/topology/core_siblings_list:0,3
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:225000
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:1800000
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency:10000001
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:225000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:1800000
> /sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0 3
> /sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0 3
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:userspace
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:p4-clockmod
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:ondemand=
 userspace performance
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:1800000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:225000=
 450000 675000 900000 1125000 1350000 1575000 1800000
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1800000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1800000
> /sys/devices/system/cpu/cpu1/online:0
> /sys/devices/system/cpu/cpu1/crash_notes:13fc94a10
> /sys/devices/system/cpu/cpu1/cpuidle/state0/name:POLL
> /sys/devices/system/cpu/cpu1/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
> /sys/devices/system/cpu/cpu1/cpuidle/state0/latency:0
> /sys/devices/system/cpu/cpu1/cpuidle/state0/power:4294967295
> /sys/devices/system/cpu/cpu1/cpuidle/state0/usage:10
> /sys/devices/system/cpu/cpu1/cpuidle/state0/time:3742
> /sys/devices/system/cpu/cpu1/cpuidle/state1/name:C1-ATM
> /sys/devices/system/cpu/cpu1/cpuidle/state1/desc:MWAIT 0x00
> /sys/devices/system/cpu/cpu1/cpuidle/state1/latency:1
> /sys/devices/system/cpu/cpu1/cpuidle/state1/power:4294967294
> /sys/devices/system/cpu/cpu1/cpuidle/state1/usage:3388
> /sys/devices/system/cpu/cpu1/cpuidle/state1/time:24732806
> /sys/devices/system/cpu/cpu2/online:0
> /sys/devices/system/cpu/cpu2/crash_notes:13fd14a10
> /sys/devices/system/cpu/cpu2/cpuidle/state0/name:POLL
> /sys/devices/system/cpu/cpu2/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
> /sys/devices/system/cpu/cpu2/cpuidle/state0/latency:0
> /sys/devices/system/cpu/cpu2/cpuidle/state0/power:4294967295
> /sys/devices/system/cpu/cpu2/cpuidle/state0/usage:12
> /sys/devices/system/cpu/cpu2/cpuidle/state0/time:855620
> /sys/devices/system/cpu/cpu2/cpuidle/state1/name:C1-ATM
> /sys/devices/system/cpu/cpu2/cpuidle/state1/desc:MWAIT 0x00
> /sys/devices/system/cpu/cpu2/cpuidle/state1/latency:1
> /sys/devices/system/cpu/cpu2/cpuidle/state1/power:4294967294
> /sys/devices/system/cpu/cpu2/cpuidle/state1/usage:4455
> /sys/devices/system/cpu/cpu2/cpuidle/state1/time:27807198
> /sys/devices/system/cpu/cpu3/online:1
> /sys/devices/system/cpu/cpu3/crash_notes:13fd94a10
> /sys/devices/system/cpu/cpu3/thermal_throttle/core_throttle_count:0
> /sys/devices/system/cpu/cpu3/topology/physical_package_id:0
> /sys/devices/system/cpu/cpu3/topology/core_id:0
> /sys/devices/system/cpu/cpu3/topology/thread_siblings:9
> /sys/devices/system/cpu/cpu3/topology/thread_siblings_list:0,3
> /sys/devices/system/cpu/cpu3/topology/core_siblings:9
> /sys/devices/system/cpu/cpu3/topology/core_siblings_list:0,3
> /sys/devices/system/cpu/cpu3/cache/index0/type:Data
> /sys/devices/system/cpu/cpu3/cache/index0/level:1
> /sys/devices/system/cpu/cpu3/cache/index0/coherency_line_size:64
> /sys/devices/system/cpu/cpu3/cache/index0/physical_line_partition:1
> /sys/devices/system/cpu/cpu3/cache/index0/ways_of_associativity:6
> /sys/devices/system/cpu/cpu3/cache/index0/number_of_sets:64
> /sys/devices/system/cpu/cpu3/cache/index0/size:24K
> /sys/devices/system/cpu/cpu3/cache/index0/shared_cpu_map:9
> /sys/devices/system/cpu/cpu3/cache/index0/shared_cpu_list:0,3
> /sys/devices/system/cpu/cpu3/cache/index1/type:Instruction
> /sys/devices/system/cpu/cpu3/cache/index1/level:1
> /sys/devices/system/cpu/cpu3/cache/index1/coherency_line_size:64
> /sys/devices/system/cpu/cpu3/cache/index1/physical_line_partition:1
> /sys/devices/system/cpu/cpu3/cache/index1/ways_of_associativity:8
> /sys/devices/system/cpu/cpu3/cache/index1/number_of_sets:64
> /sys/devices/system/cpu/cpu3/cache/index1/size:32K
> /sys/devices/system/cpu/cpu3/cache/index1/shared_cpu_map:9
> /sys/devices/system/cpu/cpu3/cache/index1/shared_cpu_list:0,3
> /sys/devices/system/cpu/cpu3/cache/index2/type:Unified
> /sys/devices/system/cpu/cpu3/cache/index2/level:2
> /sys/devices/system/cpu/cpu3/cache/index2/coherency_line_size:64
> /sys/devices/system/cpu/cpu3/cache/index2/physical_line_partition:1
> /sys/devices/system/cpu/cpu3/cache/index2/ways_of_associativity:8
> /sys/devices/system/cpu/cpu3/cache/index2/number_of_sets:1024
> /sys/devices/system/cpu/cpu3/cache/index2/size:512K
> /sys/devices/system/cpu/cpu3/cache/index2/shared_cpu_map:9
> /sys/devices/system/cpu/cpu3/cache/index2/shared_cpu_list:0,3
> grep: /sys/devices/system/cpu/cpu3/microcode/reload: Permission denied
> /sys/devices/system/cpu/cpu3/microcode/version:0x107
> /sys/devices/system/cpu/cpu3/microcode/processor_flags:0x8
> /sys/devices/system/cpu/cpu3/cpuidle/state0/name:POLL
> /sys/devices/system/cpu/cpu3/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
> /sys/devices/system/cpu/cpu3/cpuidle/state0/latency:0
> /sys/devices/system/cpu/cpu3/cpuidle/state0/power:4294967295
> /sys/devices/system/cpu/cpu3/cpuidle/state0/usage:21
> /sys/devices/system/cpu/cpu3/cpuidle/state0/time:2055565
> /sys/devices/system/cpu/cpu3/cpuidle/state1/name:C1-ATM
> /sys/devices/system/cpu/cpu3/cpuidle/state1/desc:MWAIT 0x00
> /sys/devices/system/cpu/cpu3/cpuidle/state1/latency:1
> /sys/devices/system/cpu/cpu3/cpuidle/state1/power:4294967294
> /sys/devices/system/cpu/cpu3/cpuidle/state1/usage:13834
> /sys/devices/system/cpu/cpu3/cpuidle/state1/time:166939905
> ---------------------
> =

> ------------------------------ contents of /sys/power/* -----------------
> $ grep -r . /sys/power/
> /sys/power/state:mem disk
> /sys/power/pm_trace:0
> /sys/power/pm_async:1
> /sys/power/wakeup_count:0
> /sys/power/pm_test:[none] core processors platform devices freezer
> /sys/power/disk:[platform] test testproc shutdown reboot
> /sys/power/resume:8:2
> /sys/power/image_size:1628569600
> /sys/power/reserved_size:1048576
> --------------------------------------------------------------------
> =

> =

> ______________________________________________________
> PixiMail - The secret Freedom
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> =

> =
