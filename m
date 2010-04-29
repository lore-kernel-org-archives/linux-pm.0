From: Kunjan Shah <kunjanpshah@gmail.com>
Subject: [PATCH]. EPB_ARM9_A - New machine patch
Date: Thu, 29 Apr 2010 10:55:46 +0530
Message-ID: <k2m2dd754ea1004282225r23a1618fif221c4f8c66653b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7534731892619472030=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============7534731892619472030==
Content-Type: multipart/alternative; boundary=001636b2bb87e3ca920485595bf6

--001636b2bb87e3ca920485595bf6
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

*From:*

Ketan Patel <ketanec2007@gmail.com>

Kunjan Shah <kunjanpshah@gmail.com>



* *

*Description:*

We are using ARM9 target board from Edutech Systems Pvt. Ltd. We have
registered the machine named, EPB_ARM9_A. In this patch we are submitting
few board specific changes.



Changes in the required files are as shown below,

* *

*1: *

File name: epb_arm9_a_defconfig

Location: linux-2.6.29.4/arch/arm/configs/

Description: This file consist the default configuration for the edutech
system=92s *epb_arm9_a* target board.



*2:*



File name: epb_arm9_a.c

Location: linux-2.6.29.4/arch/arm/mach-at91/

Description: This file consists of start up related functions for the
edutech system=92s *epb_arm9_a* target board.



*3:*

File name: Kconfig

Location: linux-2.6.29.4/arch/arm/mach-at91/

Description: This file displays the edutech system=92s *epb_arm9_a* target
board=92s NAME in the configuration.





*4:*

File name: Makefile

Location: linux-2.6.29.4/arch/arm/mach-at91/

Description: This file is used to generate the epb_arm9_a.o output file fro=
m
epb_arm9_a.c





*5:*

File name: at91rm9200.c

Location: linux-2.6.29.4/drivers/mtd/maps/

Description: this file handles mapping of NOR flash AT49BV642DT for Edutech
Systems Pvt. Ltd. EPB_ARM9_A board





*6:*

File name: Kconfig

Location: linux-2.6.29.4/drivers/mtd/maps/

Description: This file displays the edutech system=92s *epb_arm9_a* target
board=92s NAME in the configuration





*7:*

File name: Makefile

Location: linux-2.6.29.4/drivers/mtd/maps/

Description: This file is used to generate the at91rm9200.o output file fro=
m
at91rm9200.c









*Kernel Version:* linux-2.6.29.4







*Sign-off*



Developer's Certificate of Origin 1.1



By making a contribution to this project, I certify that:



        (a) The contribution was created in whole or in part by me and I

            have the right to submit it under the open source license

            indicated in the file; or



        (b) The contribution is based upon previous work that, to the best

            of my knowledge, is covered under an appropriate open source

            license and I have the right under that license to submit that

            work with modifications, whether created in whole or in part

            by me, under the same open source license (unless I am

            permitted to submit under a different license), as indicated

            in the file; or



        (c) The contribution was provided directly to me by some other

            person who certified (a), (b) or (c) and I have not modified

            it.



(d) I understand and agree that this project and the contribution

                are public and that a record of the contribution (including
all

                personal information I submit with it, including my
sign-off) is

                maintained indefinitely and may be redistributed consistent
with

                this project or the open source license(s) involved.



Signed-off-by: Ketan Patel <ketanec2007@gmail.com>

                        Kunjan Shah <kunjanpshah@gmail.com>



*Tested-by:*



A Tested-by: tag indicates that the patch has been successfully tested (in

Linux Opensuse-11.1) by the person named (Ketan Patel <ketanec2007@gmail.co=
m
>

,Kunjan Shah <kunjanpshah@gmail.com>).





*Reviewed-by:*, Ketan Patel <ketanec2007@gmail.com>

                        Kunjan Shah <kunjanpshah@gmail.com>







            Reviewer's statement of oversight



            By offering our Reviewed-by: tag, we state that:



             (a) we have carried out a technical review of this patch to

                 evaluate its appropriateness and readiness for inclusion
into

                 the mainline kernel.



             (b) Any problems, concerns, or questions relating to the patch

                 have been communicated back to the submitter.   We are
satisfied

                 with the submitter's response to our comments.



             (c) While there may be things that could be improved with this

                 submission, we believe that it is, at this time, (1) a

                 worthwhile modification to the kernel, and (2) free of
known

                 issues which would argue against its inclusion.



             (d) While we have reviewed the patch and believe it to be
sound, we

                 do not (unless explicitly stated elsewhere) make any

                 warranties or guarantees that it will achieve its stated

                 purpose or function properly in any given situation.



---

diff -rupN linux-2.6.29.4_Edutech//arch/arm/configs/epb_arm9_a_defconfig
linux-2.6.29.4//arch/arm/configs/epb_arm9_a_defconfig

--- linux-2.6.29.4_Edutech//arch/arm/configs/epb_arm9_a_defconfig
     2010-04-23
16:34:31.000000000 +0530

+++ linux-2.6.29.4//arch/arm/configs/epb_arm9_a_defconfig           1970-01=
-01
05:30:00.000000000 +0530

@@ -1,1312 +0,0 @@

-#

-# Automatically generated make config: don't edit

-# Linux kernel version: 2.6.29.4

-# Fri Apr 23 16:33:08 2010

-#

-CONFIG_ARM=3Dy

-CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy

-CONFIG_GENERIC_GPIO=3Dy

-CONFIG_GENERIC_TIME=3Dy

-CONFIG_GENERIC_CLOCKEVENTS=3Dy

-CONFIG_MMU=3Dy

-# CONFIG_NO_IOPORT is not set

-CONFIG_GENERIC_HARDIRQS=3Dy

-CONFIG_STACKTRACE_SUPPORT=3Dy

-CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy

-CONFIG_LOCKDEP_SUPPORT=3Dy

-CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy

-CONFIG_HARDIRQS_SW_RESEND=3Dy

-CONFIG_GENERIC_IRQ_PROBE=3Dy

-CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy

-# CONFIG_ARCH_HAS_ILOG2_U32 is not set

-# CONFIG_ARCH_HAS_ILOG2_U64 is not set

-CONFIG_GENERIC_HWEIGHT=3Dy

-CONFIG_GENERIC_CALIBRATE_DELAY=3Dy

-CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=3Dy

-CONFIG_VECTORS_BASE=3D0xffff0000

-CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"

-

-#

-# General setup

-#

-CONFIG_EXPERIMENTAL=3Dy

-CONFIG_BROKEN_ON_SMP=3Dy

-CONFIG_INIT_ENV_ARG_LIMIT=3D32

-CONFIG_LOCALVERSION=3D"-9-pae"

-CONFIG_LOCALVERSION_AUTO=3Dy

-# CONFIG_SWAP is not set

-# CONFIG_SYSVIPC is not set

-# CONFIG_POSIX_MQUEUE is not set

-# CONFIG_BSD_PROCESS_ACCT is not set

-# CONFIG_TASKSTATS is not set

-# CONFIG_AUDIT is not set

-

-#

-# RCU Subsystem

-#

-CONFIG_CLASSIC_RCU=3Dy

-# CONFIG_TREE_RCU is not set

-# CONFIG_PREEMPT_RCU is not set

-# CONFIG_TREE_RCU_TRACE is not set

-# CONFIG_PREEMPT_RCU_TRACE is not set

-# CONFIG_IKCONFIG is not set

-CONFIG_LOG_BUF_SHIFT=3D17

-# CONFIG_GROUP_SCHED is not set

-# CONFIG_CGROUPS is not set

-CONFIG_SYSFS_DEPRECATED=3Dy

-CONFIG_SYSFS_DEPRECATED_V2=3Dy

-CONFIG_RELAY=3Dy

-CONFIG_NAMESPACES=3Dy

-# CONFIG_UTS_NS is not set

-# CONFIG_USER_NS is not set

-# CONFIG_PID_NS is not set

-# CONFIG_NET_NS is not set

-CONFIG_BLK_DEV_INITRD=3Dy

-CONFIG_INITRAMFS_SOURCE=3D""

-CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy

-CONFIG_SYSCTL=3Dy

-CONFIG_ANON_INODES=3Dy

-# CONFIG_EMBEDDED is not set

-CONFIG_UID16=3Dy

-CONFIG_SYSCTL_SYSCALL=3Dy

-CONFIG_KALLSYMS=3Dy

-CONFIG_KALLSYMS_ALL=3Dy

-# CONFIG_KALLSYMS_EXTRA_PASS is not set

-CONFIG_HOTPLUG=3Dy

-CONFIG_PRINTK=3Dy

-CONFIG_BUG=3Dy

-CONFIG_ELF_CORE=3Dy

-CONFIG_BASE_FULL=3Dy

-CONFIG_FUTEX=3Dy

-CONFIG_EPOLL=3Dy

-CONFIG_SIGNALFD=3Dy

-CONFIG_TIMERFD=3Dy

-CONFIG_EVENTFD=3Dy

-CONFIG_SHMEM=3Dy

-CONFIG_AIO=3Dy

-CONFIG_VM_EVENT_COUNTERS=3Dy

-# CONFIG_COMPAT_BRK is not set

-CONFIG_SLAB=3Dy

-# CONFIG_SLUB is not set

-# CONFIG_SLOB is not set

-# CONFIG_PROFILING is not set

-CONFIG_HAVE_OPROFILE=3Dy

-# CONFIG_KPROBES is not set

-CONFIG_HAVE_KPROBES=3Dy

-CONFIG_HAVE_KRETPROBES=3Dy

-CONFIG_HAVE_CLK=3Dy

-CONFIG_HAVE_GENERIC_DMA_COHERENT=3Dy

-CONFIG_SLABINFO=3Dy

-CONFIG_RT_MUTEXES=3Dy

-CONFIG_BASE_SMALL=3D0

-CONFIG_MODULES=3Dy

-# CONFIG_MODULE_FORCE_LOAD is not set

-CONFIG_MODULE_UNLOAD=3Dy

-# CONFIG_MODULE_FORCE_UNLOAD is not set

-# CONFIG_MODVERSIONS is not set

-# CONFIG_MODULE_SRCVERSION_ALL is not set

-CONFIG_BLOCK=3Dy

-# CONFIG_LBD is not set

-# CONFIG_BLK_DEV_IO_TRACE is not set

-# CONFIG_BLK_DEV_BSG is not set

-# CONFIG_BLK_DEV_INTEGRITY is not set

-

-#

-# IO Schedulers

-#

-CONFIG_IOSCHED_NOOP=3Dy

-CONFIG_IOSCHED_AS=3Dy

-CONFIG_IOSCHED_DEADLINE=3Dy

-CONFIG_IOSCHED_CFQ=3Dy

-# CONFIG_DEFAULT_AS is not set

-# CONFIG_DEFAULT_DEADLINE is not set

-CONFIG_DEFAULT_CFQ=3Dy

-# CONFIG_DEFAULT_NOOP is not set

-CONFIG_DEFAULT_IOSCHED=3D"cfq"

-# CONFIG_FREEZER is not set

-

-#

-# System Type

-#

-# CONFIG_ARCH_AAEC2000 is not set

-# CONFIG_ARCH_INTEGRATOR is not set

-# CONFIG_ARCH_REALVIEW is not set

-# CONFIG_ARCH_VERSATILE is not set

-CONFIG_ARCH_AT91=3Dy

-# CONFIG_ARCH_CLPS711X is not set

-# CONFIG_ARCH_EBSA110 is not set

-# CONFIG_ARCH_EP93XX is not set

-# CONFIG_ARCH_FOOTBRIDGE is not set

-# CONFIG_ARCH_NETX is not set

-# CONFIG_ARCH_H720X is not set

-# CONFIG_ARCH_IMX is not set

-# CONFIG_ARCH_IOP13XX is not set

-# CONFIG_ARCH_IOP32X is not set

-# CONFIG_ARCH_IOP33X is not set

-# CONFIG_ARCH_IXP23XX is not set

-# CONFIG_ARCH_IXP2000 is not set

-# CONFIG_ARCH_IXP4XX is not set

-# CONFIG_ARCH_L7200 is not set

-# CONFIG_ARCH_KIRKWOOD is not set

-# CONFIG_ARCH_KS8695 is not set

-# CONFIG_ARCH_NS9XXX is not set

-# CONFIG_ARCH_LOKI is not set

-# CONFIG_ARCH_MV78XX0 is not set

-# CONFIG_ARCH_MXC is not set

-# CONFIG_ARCH_ORION5X is not set

-# CONFIG_ARCH_PNX4008 is not set

-# CONFIG_ARCH_PXA is not set

-# CONFIG_ARCH_RPC is not set

-# CONFIG_ARCH_SA1100 is not set

-# CONFIG_ARCH_S3C2410 is not set

-# CONFIG_ARCH_S3C64XX is not set

-# CONFIG_ARCH_SHARK is not set

-# CONFIG_ARCH_LH7A40X is not set

-# CONFIG_ARCH_DAVINCI is not set

-# CONFIG_ARCH_OMAP is not set

-# CONFIG_ARCH_MSM is not set

-# CONFIG_ARCH_W90X900 is not set

-

-#

-# Atmel AT91 System-on-Chip

-#

-CONFIG_ARCH_AT91RM9200=3Dy

-# CONFIG_ARCH_AT91SAM9260 is not set

-# CONFIG_ARCH_AT91SAM9261 is not set

-# CONFIG_ARCH_AT91SAM9263 is not set

-# CONFIG_ARCH_AT91SAM9RL is not set

-# CONFIG_ARCH_AT91SAM9G20 is not set

-# CONFIG_ARCH_AT91CAP9 is not set

-# CONFIG_ARCH_AT91X40 is not set

-CONFIG_AT91_PMC_UNIT=3Dy

-

-#

-# AT91RM9200 Board Type

-#

-# CONFIG_MACH_ONEARM is not set

-# CONFIG_ARCH_AT91RM9200DK is not set

-# CONFIG_MACH_AT91RM9200EK is not set

-# CONFIG_MACH_CSB337 is not set

-# CONFIG_MACH_CSB637 is not set

-# CONFIG_MACH_CARMEVA is not set

-# CONFIG_MACH_ATEB9200 is not set

-# CONFIG_MACH_KB9200 is not set

-# CONFIG_MACH_PICOTUX2XX is not set

-# CONFIG_MACH_KAFA is not set

-# CONFIG_MACH_ECBAT91 is not set

-# CONFIG_MACH_YL9200 is not set

-CONFIG_MACH_EPB_ARM9_A=3Dy

-

-#

-# AT91 Board Options

-#

-

-#

-# AT91 Feature Selections

-#

-# CONFIG_AT91_PROGRAMMABLE_CLOCKS is not set

-CONFIG_AT91_TIMER_HZ=3D128

-CONFIG_AT91_EARLY_DBGU=3Dy

-# CONFIG_AT91_EARLY_USART0 is not set

-# CONFIG_AT91_EARLY_USART1 is not set

-# CONFIG_AT91_EARLY_USART2 is not set

-# CONFIG_AT91_EARLY_USART3 is not set

-# CONFIG_AT91_EARLY_USART4 is not set

-# CONFIG_AT91_EARLY_USART5 is not set

-

-#

-# Processor Type

-#

-CONFIG_CPU_32=3Dy

-CONFIG_CPU_ARM920T=3Dy

-CONFIG_CPU_32v4T=3Dy

-CONFIG_CPU_ABRT_EV4T=3Dy

-CONFIG_CPU_PABRT_NOIFAR=3Dy

-CONFIG_CPU_CACHE_V4WT=3Dy

-CONFIG_CPU_CACHE_VIVT=3Dy

-CONFIG_CPU_COPY_V4WB=3Dy

-CONFIG_CPU_TLB_V4WBI=3Dy

-CONFIG_CPU_CP15=3Dy

-CONFIG_CPU_CP15_MMU=3Dy

-

-#

-# Processor Features

-#

-CONFIG_ARM_THUMB=3Dy

-# CONFIG_CPU_ICACHE_DISABLE is not set

-# CONFIG_CPU_DCACHE_DISABLE is not set

-# CONFIG_CPU_DCACHE_WRITETHROUGH is not set

-# CONFIG_OUTER_CACHE is not set

-

-#

-# Bus support

-#

-# CONFIG_PCI_SYSCALL is not set

-# CONFIG_ARCH_SUPPORTS_MSI is not set

-# CONFIG_PCCARD is not set

-

-#

-# Kernel Features

-#

-# CONFIG_NO_HZ is not set

-# CONFIG_HIGH_RES_TIMERS is not set

-CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy

-CONFIG_VMSPLIT_3G=3Dy

-# CONFIG_VMSPLIT_2G is not set

-# CONFIG_VMSPLIT_1G is not set

-CONFIG_PAGE_OFFSET=3D0xC0000000

-# CONFIG_PREEMPT is not set

-CONFIG_HZ=3D128

-# CONFIG_AEABI is not set

-CONFIG_ARCH_FLATMEM_HAS_HOLES=3Dy

-# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set

-# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set

-CONFIG_SELECT_MEMORY_MODEL=3Dy

-CONFIG_FLATMEM_MANUAL=3Dy

-# CONFIG_DISCONTIGMEM_MANUAL is not set

-# CONFIG_SPARSEMEM_MANUAL is not set

-CONFIG_FLATMEM=3Dy

-CONFIG_FLAT_NODE_MEM_MAP=3Dy

-CONFIG_PAGEFLAGS_EXTENDED=3Dy

-CONFIG_SPLIT_PTLOCK_CPUS=3D4096

-# CONFIG_PHYS_ADDR_T_64BIT is not set

-CONFIG_ZONE_DMA_FLAG=3D0

-CONFIG_VIRT_TO_BUS=3Dy

-# CONFIG_UNEVICTABLE_LRU is not set

-# CONFIG_LEDS is not set

-CONFIG_ALIGNMENT_TRAP=3Dy

-

-#

-# Boot options

-#

-CONFIG_ZBOOT_ROM_TEXT=3D0

-CONFIG_ZBOOT_ROM_BSS=3D0

-CONFIG_CMDLINE=3D""

-# CONFIG_XIP_KERNEL is not set

-# CONFIG_KEXEC is not set

-

-#

-# CPU Power Management

-#

-# CONFIG_CPU_IDLE is not set

-

-#

-# Floating point emulation

-#

-

-#

-# At least one emulation must be selected

-#

-CONFIG_FPE_NWFPE=3Dy

-# CONFIG_FPE_NWFPE_XP is not set

-# CONFIG_FPE_FASTFPE is not set

-

-#

-# Userspace binary formats

-#

-CONFIG_BINFMT_ELF=3Dy

-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set

-CONFIG_HAVE_AOUT=3Dy

-# CONFIG_BINFMT_AOUT is not set

-# CONFIG_BINFMT_MISC is not set

-# CONFIG_ARTHUR is not set

-

-#

-# Power management options

-#

-# CONFIG_PM is not set

-CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy

-CONFIG_NET=3Dy

-

-#

-# Networking options

-#

-CONFIG_COMPAT_NET_DEV_OPS=3Dy

-CONFIG_PACKET=3Dy

-# CONFIG_PACKET_MMAP is not set

-# CONFIG_UNIX is not set

-CONFIG_XFRM=3Dy

-# CONFIG_XFRM_USER is not set

-# CONFIG_XFRM_SUB_POLICY is not set

-# CONFIG_XFRM_MIGRATE is not set

-# CONFIG_XFRM_STATISTICS is not set

-# CONFIG_NET_KEY is not set

-CONFIG_INET=3Dy

-CONFIG_IP_MULTICAST=3Dy

-# CONFIG_IP_ADVANCED_ROUTER is not set

-CONFIG_IP_FIB_HASH=3Dy

-CONFIG_IP_PNP=3Dy

-CONFIG_IP_PNP_DHCP=3Dy

-# CONFIG_IP_PNP_BOOTP is not set

-# CONFIG_IP_PNP_RARP is not set

-# CONFIG_NET_IPIP is not set

-# CONFIG_NET_IPGRE is not set

-# CONFIG_IP_MROUTE is not set

-# CONFIG_ARPD is not set

-# CONFIG_SYN_COOKIES is not set

-# CONFIG_INET_AH is not set

-# CONFIG_INET_ESP is not set

-# CONFIG_INET_IPCOMP is not set

-# CONFIG_INET_XFRM_TUNNEL is not set

-# CONFIG_INET_TUNNEL is not set

-CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy

-CONFIG_INET_XFRM_MODE_TUNNEL=3Dy

-CONFIG_INET_XFRM_MODE_BEET=3Dy

-# CONFIG_INET_LRO is not set

-CONFIG_INET_DIAG=3Dy

-CONFIG_INET_TCP_DIAG=3Dy

-# CONFIG_TCP_CONG_ADVANCED is not set

-CONFIG_TCP_CONG_CUBIC=3Dy

-CONFIG_DEFAULT_TCP_CONG=3D"cubic"

-# CONFIG_TCP_MD5SIG is not set

-# CONFIG_IPV6 is not set

-# CONFIG_NETWORK_SECMARK is not set

-# CONFIG_NETFILTER is not set

-# CONFIG_IP_DCCP is not set

-CONFIG_IP_SCTP=3Dm

-# CONFIG_SCTP_DBG_MSG is not set

-# CONFIG_SCTP_DBG_OBJCNT is not set

-CONFIG_SCTP_HMAC_NONE=3Dy

-# CONFIG_SCTP_HMAC_SHA1 is not set

-# CONFIG_SCTP_HMAC_MD5 is not set

-# CONFIG_TIPC is not set

-# CONFIG_ATM is not set

-# CONFIG_BRIDGE is not set

-# CONFIG_NET_DSA is not set

--001636b2bb87e3ca920485595bf6
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div id=3D":29o" class=3D"ii gt"><p class=3D"MsoNormal" style=3D"margin: 0i=
n 0in 0pt; line-height: normal;"><b><span style=3D"font-size: 12pt; font-fa=
mily: &#39;Times New Roman&#39;,&#39;serif&#39;;">From:</span></b></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Ketan Patel &lt;<a href=3D"mailto:ketanec2007@gmail.com" targ=
et=3D"_blank">ketanec2007@gmail.com</a>&gt;</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Kunjan Shah &lt;<a href=3D"mailto:kunjanpshah@gmail.com" targ=
et=3D"_blank">kunjanpshah@gmail.com</a>&gt;</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">=A0</span></b></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">Description:</span></b></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">We
are using ARM9 target board from Edutech Systems Pvt. Ltd. We have
registered the machine named, EPB_ARM9_A. In this patch we are
submitting few board specific changes.</span></p>

<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Changes in the required files are as shown below,</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">=A0</span></b></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">1: </span></b></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">File name: epb_arm9_a_defconfig</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Location: linux-2.6.29.4/arch/arm/configs/</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Description: This file consist the default configuration for =
the edutech system=92s <b>epb_arm9_a</b> target board.</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">2:</span></b></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">File name: epb_arm9_a.c</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Location: linux-2.6.29.4/arch/arm/mach-at91/</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Description: This file consists of start up related functions=
 for the edutech system=92s <b>epb_arm9_a</b> target board.</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">3:</span></b></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">File name: Kconfig</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Location: linux-2.6.29.4/arch/arm/mach-at91/</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Description: This file displays the edutech system=92s <b>epb=
_arm9_a</b> target board=92s NAME in the configuration.</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">4:</span></b></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">File name: Makefile</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Location: linux-2.6.29.4/arch/arm/mach-at91/</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Description: This file is used to generate the epb_arm9_a.o o=
utput file from epb_arm9_a.c</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">5:</span></b></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">File name: at91rm9200.c</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Location: linux-2.6.29.4/drivers/mtd/maps/</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Description: this file handles mapping of NOR flash AT49BV642=
DT for Edutech Systems Pvt. Ltd. EPB_ARM9_A board</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">6:</span></b></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">File name: Kconfig</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Location: linux-2.6.29.4/drivers/mtd/maps/</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Description: This file displays the edutech system=92s <b>epb=
_arm9_a</b> target board=92s NAME in the configuration</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">7:</span></b></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">File name: Makefile</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Location: linux-2.6.29.4/drivers/mtd/maps/</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Description: This file is used to generate the at91rm9200.o o=
utput file from at91rm9200.c</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">Kernel Version:</span></b><span style=3D"font-size: 12pt; =
font-family: &#39;Times New Roman&#39;,&#39;serif&#39;;"> linux-2.6.29.4</s=
pan></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">Sign-off</span></b></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Developer&#39;s Certificate of Origin 1.1</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">By making a contribution to this project, I certify that:</sp=
an></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0 </span>(a) The contribution was c=
reated in whole or in part by me and I</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>have the right=
 to submit it under the open source license</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>indicated in t=
he file; or</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0 </span>(b) The contribution is ba=
sed upon previous work that, to the best</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>of my knowledg=
e, is covered under an appropriate open source</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>license and I =
have the right under that license to submit that</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>work with modi=
fications, whether created in whole or in part</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>by me, under t=
he same open source license (unless I am</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>permitted to s=
ubmit under a different license), as indicated</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>in the file; o=
r</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0 </span>(c) The contribution was p=
rovided directly to me by some other</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>person who cer=
tified (a), (b) or (c) and I have not modified</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>it.</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">(d) I understand and agree that this project and the contribu=
tion</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0 </span>are public and that a record of the contribution (including all<=
/span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0 </span>personal information I submit with it, including my sign-off) is=
</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0 </span>maintained indefinitely and may be redistributed consistent with=
</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0 </span>this project or the open source license(s) involved.</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Signed-off-by: Ketan Patel &lt;<a href=3D"mailto:ketanec2007@=
gmail.com" target=3D"_blank">ketanec2007@gmail.com</a>&gt;</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 </span>Kunjan Shah &lt;<a href=3D"mailto:kunjanpshah@gmail.=
com" target=3D"_blank">kunjanpshah@gmail.com</a>&gt;</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">Tested-by:</span></b></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">A Tested-by: tag indicates that the patch has been successful=
ly tested (in</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">Linux Opensuse-11.1) by the person named (Ketan Patel &lt;<a =
href=3D"mailto:ketanec2007@gmail.com" target=3D"_blank">ketanec2007@gmail.c=
om</a>&gt;</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">,Kunjan Shah &lt;<a href=3D"mailto:kunjanpshah@gmail.com" tar=
get=3D"_blank">kunjanpshah@gmail.com</a>&gt;).</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<b><span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&=
#39;serif&#39;;">Reviewed-by:</span></b><span style=3D"font-size: 12pt; fon=
t-family: &#39;Times New Roman&#39;,&#39;serif&#39;;">, Ketan Patel &lt;<a =
href=3D"mailto:ketanec2007@gmail.com" target=3D"_blank">ketanec2007@gmail.c=
om</a>&gt;</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 </span>Kunjan Shah &lt;<a href=3D"mailto:kunjanpshah@gmail.=
com" target=3D"_blank">kunjanpshah@gmail.com</a>&gt;</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>Reviewer&#39;s=
 statement of oversight</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>By offering ou=
r Reviewed-by: tag, we state that:</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0</span><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><=
span>=A0</span>(a) we have carried out a technical review of this patch to<=
/span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0=A0 </span>evaluate its appropriateness and readiness for inclusion into=
</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0=A0 </span>the mainline kernel.</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0</spa=
n>(b) Any problems, concerns, or questions relating to the patch</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0=A0 </span>have been communicated back to the submitter.<span>=A0 </span=
><span>=A0</span>We are satisfied</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0=A0 </span>with the submitter&#39;s response to our comments.</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0</spa=
n>(c) While there may be things that could be improved with this</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0=A0 </span>submission, we believe that it is, at this time, (1) a</span>=
</p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0=A0 </span>worthwhile modification to the kernel, and (2) free of known<=
/span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0=A0 </span>issues which would argue against its inclusion.</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0</spa=
n>(d) While we have reviewed the patch and believe it to be sound, we</span=
></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0=A0 </span>do not (unless explicitly stated elsewhere) make any</span></=
p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0=A0 </span>warranties or guarantees that it will achieve its stated</spa=
n></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=
=A0=A0 </span>purpose or function properly in any given situation.</span></=
p>


<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;"><br clear=3D"all"></span>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">=A0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">---</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">diff -rupN linux-2.6.29.4_Edutech//arch/arm/configs/epb_arm9_=
a_defconfig linux-2.6.29.4//arch/arm/configs/epb_arm9_a_defconfig</span></p=
>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">--- linux-2.6.29.4_Edutech//arch/arm/configs/epb_arm9_a_defco=
nfig<span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>2010-04-23 16:34:31.0000000=
00 +0530</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">+++ linux-2.6.29.4//arch/arm/configs/epb_arm9_a_defconfig<spa=
n>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>1970-01-01 05:30:00.000000000 +0530=
</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">@@ -1,1312 +0,0 @@</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# Automatically generated make config: don&#39;t edit</span>=
</p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# Linux kernel version: 2.6.29.4</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# Fri Apr 23 16:33:08 2010</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_ARM=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_GENERIC_GPIO=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_GENERIC_TIME=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_GENERIC_CLOCKEVENTS=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_MMU=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_NO_IOPORT is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_GENERIC_HARDIRQS=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_STACKTRACE_SUPPORT=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_LOCKDEP_SUPPORT=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_HARDIRQS_SW_RESEND=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_GENERIC_IRQ_PROBE=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_HAS_ILOG2_U32 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_HAS_ILOG2_U64 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_GENERIC_HWEIGHT=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_GENERIC_CALIBRATE_DELAY=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_VECTORS_BASE=3D0xffff0000</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_DEFCONFIG_LIST=3D&quot;/lib/modules/$UNAME_RELEASE/.c=
onfig&quot;</span></p>



<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# General setup</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_EXPERIMENTAL=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_BROKEN_ON_SMP=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_INIT_ENV_ARG_LIMIT=3D32</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_LOCALVERSION=3D&quot;-9-pae&quot;</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_LOCALVERSION_AUTO=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_SWAP is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_SYSVIPC is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_POSIX_MQUEUE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_BSD_PROCESS_ACCT is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_TASKSTATS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_AUDIT is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# RCU Subsystem</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CLASSIC_RCU=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_TREE_RCU is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_PREEMPT_RCU is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_TREE_RCU_TRACE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_PREEMPT_RCU_TRACE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_IKCONFIG is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_LOG_BUF_SHIFT=3D17</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_GROUP_SCHED is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_CGROUPS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_SYSFS_DEPRECATED=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_SYSFS_DEPRECATED_V2=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_RELAY=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_NAMESPACES=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_UTS_NS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_USER_NS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_PID_NS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_NET_NS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_BLK_DEV_INITRD=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_INITRAMFS_SOURCE=3D&quot;&quot;</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_SYSCTL=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_ANON_INODES=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_EMBEDDED is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_UID16=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_SYSCTL_SYSCALL=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_KALLSYMS=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_KALLSYMS_ALL=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_KALLSYMS_EXTRA_PASS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_HOTPLUG=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_PRINTK=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_BUG=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_ELF_CORE=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_BASE_FULL=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_FUTEX=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_EPOLL=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_SIGNALFD=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_TIMERFD=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_EVENTFD=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_SHMEM=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_AIO=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_VM_EVENT_COUNTERS=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_COMPAT_BRK is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_SLAB=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_SLUB is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_SLOB is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_PROFILING is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_HAVE_OPROFILE=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_KPROBES is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_HAVE_KPROBES=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_HAVE_KRETPROBES=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_HAVE_CLK=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_HAVE_GENERIC_DMA_COHERENT=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_SLABINFO=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_RT_MUTEXES=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_BASE_SMALL=3D0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_MODULES=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MODULE_FORCE_LOAD is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_MODULE_UNLOAD=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MODULE_FORCE_UNLOAD is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MODVERSIONS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MODULE_SRCVERSION_ALL is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_BLOCK=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_LBD is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_BLK_DEV_IO_TRACE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_BLK_DEV_BSG is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_BLK_DEV_INTEGRITY is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# IO Schedulers</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_IOSCHED_NOOP=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_IOSCHED_AS=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_IOSCHED_DEADLINE=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_IOSCHED_CFQ=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_DEFAULT_AS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_DEFAULT_DEADLINE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_DEFAULT_CFQ=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_DEFAULT_NOOP is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_DEFAULT_IOSCHED=3D&quot;cfq&quot;</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_FREEZER is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# System Type</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_AAEC2000 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_INTEGRATOR is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_REALVIEW is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_VERSATILE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_ARCH_AT91=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_CLPS711X is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_EBSA110 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_EP93XX is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_FOOTBRIDGE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_NETX is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_H720X is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_IMX is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_IOP13XX is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_IOP32X is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_IOP33X is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_IXP23XX is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_IXP2000 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_IXP4XX is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_L7200 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_KIRKWOOD is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_KS8695 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_NS9XXX is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_LOKI is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_MV78XX0 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_MXC is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_ORION5X is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_PNX4008 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_PXA is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_RPC is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_SA1100 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_S3C2410 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_S3C64XX is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_SHARK is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_LH7A40X is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_DAVINCI is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_OMAP is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_MSM is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_W90X900 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# Atmel AT91 System-on-Chip</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_ARCH_AT91RM9200=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_AT91SAM9260 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_AT91SAM9261 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_AT91SAM9263 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_AT91SAM9RL is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_AT91SAM9G20 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_AT91CAP9 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_AT91X40 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_AT91_PMC_UNIT=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# AT91RM9200 Board Type</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MACH_ONEARM is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_AT91RM9200DK is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MACH_AT91RM9200EK is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MACH_CSB337 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MACH_CSB637 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MACH_CARMEVA is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MACH_ATEB9200 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MACH_KB9200 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MACH_PICOTUX2XX is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MACH_KAFA is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MACH_ECBAT91 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_MACH_YL9200 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_MACH_EPB_ARM9_A=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# AT91 Board Options</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# AT91 Feature Selections</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_AT91_PROGRAMMABLE_CLOCKS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_AT91_TIMER_HZ=3D128</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_AT91_EARLY_DBGU=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_AT91_EARLY_USART0 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_AT91_EARLY_USART1 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_AT91_EARLY_USART2 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_AT91_EARLY_USART3 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_AT91_EARLY_USART4 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_AT91_EARLY_USART5 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# Processor Type</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CPU_32=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CPU_ARM920T=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CPU_32v4T=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CPU_ABRT_EV4T=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CPU_PABRT_NOIFAR=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CPU_CACHE_V4WT=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CPU_CACHE_VIVT=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CPU_COPY_V4WB=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CPU_TLB_V4WBI=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CPU_CP15=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CPU_CP15_MMU=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# Processor Features</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_ARM_THUMB=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_CPU_ICACHE_DISABLE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_CPU_DCACHE_DISABLE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_CPU_DCACHE_WRITETHROUGH is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_OUTER_CACHE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# Bus support</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_PCI_SYSCALL is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_SUPPORTS_MSI is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_PCCARD is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# Kernel Features</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_NO_HZ is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_HIGH_RES_TIMERS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_VMSPLIT_3G=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_VMSPLIT_2G is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_VMSPLIT_1G is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_PAGE_OFFSET=3D0xC0000000</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_PREEMPT is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_HZ=3D128</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_AEABI is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_ARCH_FLATMEM_HAS_HOLES=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_SELECT_MEMORY_MODEL=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_FLATMEM_MANUAL=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_DISCONTIGMEM_MANUAL is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_SPARSEMEM_MANUAL is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_FLATMEM=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_FLAT_NODE_MEM_MAP=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_PAGEFLAGS_EXTENDED=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_SPLIT_PTLOCK_CPUS=3D4096</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_PHYS_ADDR_T_64BIT is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_ZONE_DMA_FLAG=3D0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_VIRT_TO_BUS=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_UNEVICTABLE_LRU is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_LEDS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_ALIGNMENT_TRAP=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# Boot options</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_ZBOOT_ROM_TEXT=3D0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_ZBOOT_ROM_BSS=3D0</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_CMDLINE=3D&quot;&quot;</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_XIP_KERNEL is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_KEXEC is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CPU Power Management</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_CPU_IDLE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# Floating point emulation</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# At least one emulation must be selected</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_FPE_NWFPE=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_FPE_NWFPE_XP is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_FPE_FASTFPE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# Userspace binary formats</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_BINFMT_ELF=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_HAVE_AOUT=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_BINFMT_AOUT is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_BINFMT_MISC is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARTHUR is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# Power management options</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_PM is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_NET=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# Networking options</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-#</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_COMPAT_NET_DEV_OPS=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_PACKET=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_PACKET_MMAP is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_UNIX is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_XFRM=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_XFRM_USER is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_XFRM_SUB_POLICY is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_XFRM_MIGRATE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_XFRM_STATISTICS is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_NET_KEY is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_INET=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_IP_MULTICAST=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_IP_ADVANCED_ROUTER is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_IP_FIB_HASH=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_IP_PNP=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_IP_PNP_DHCP=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_IP_PNP_BOOTP is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_IP_PNP_RARP is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_NET_IPIP is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_NET_IPGRE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_IP_MROUTE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ARPD is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_SYN_COOKIES is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_INET_AH is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_INET_ESP is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_INET_IPCOMP is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_INET_XFRM_TUNNEL is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_INET_TUNNEL is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_INET_XFRM_MODE_TUNNEL=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_INET_XFRM_MODE_BEET=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_INET_LRO is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_INET_DIAG=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_INET_TCP_DIAG=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_TCP_CONG_ADVANCED is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_TCP_CONG_CUBIC=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_DEFAULT_TCP_CONG=3D&quot;cubic&quot;</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_TCP_MD5SIG is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_IPV6 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_NETWORK_SECMARK is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_NETFILTER is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_IP_DCCP is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_IP_SCTP=3Dm</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_SCTP_DBG_MSG is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_SCTP_DBG_OBJCNT is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-CONFIG_SCTP_HMAC_NONE=3Dy</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_SCTP_HMAC_SHA1 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_SCTP_HMAC_MD5 is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_TIPC is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_ATM is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_BRIDGE is not set</span></p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0pt; line-height: normal;">=
<span style=3D"font-size: 12pt; font-family: &#39;Times New Roman&#39;,&#39=
;serif&#39;;">-# CONFIG_NET_DSA is not set</span></p>
</div>

--001636b2bb87e3ca920485595bf6--

--===============7534731892619472030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7534731892619472030==--
