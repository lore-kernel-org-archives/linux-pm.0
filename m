From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: resume of mmc card on pxa320 device
Date: Wed, 21 Apr 2010 17:36:40 +0200
Message-ID: <4BCF1B88.1030806@gandalf.sssup.it>
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
To: linux-pm@lists.linux-foundation.org
Cc: ARM Linux Mailing List <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Hi,

I have done all the pm_test before submit this mail and all pass and mmc 
card work before suspending

I'm testing the resume from standby. Kernel version is 2.6.32.

[ 1036.567020] platform pxa2xx-ac97: resume
[ 1036.570922] pxa2xx-mci pxa2xx-mci.0: resume
[ 1036.575086] mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 20 width 0 
timing 0
[ 1036.582264] PXAMCI: clkrt = ffffffff cmdat = 800

The resume process stop here:


[ 1368.710901] [<c01d0cd4>] (schedule+0x0/0x3c8) from [<c01d1458>] 
(schedule_timeout+0x14c/0x200)
[ 1368.719465] [<c01d130c>] (schedule_timeout+0x0/0x200) from 
[<c01d1534>] (schedule_timeout_uninterruptible+0x28/0x2c)
[ 1368.729931] [<c01d150c>] (schedule_timeout_uninterruptible+0x0/0x2c) 
from [<c004cdb0>] (msleep+0x1c/0x28)
[ 1368.739442] [<c004cd94>] (msleep+0x0/0x28) from [<c01c2b4c>] 
(mmc_power_up+0xc4/0x14c)
[ 1368.747318] [<c01c2a88>] (mmc_power_up+0x0/0x14c) from [<c01c382c>] 
(mmc_resume_host+0x11c/0x1c8)
[ 1368.756131]  r8:c02692dc r7:00000010 r6:c78ffe60 r5:c6595518 r4:c6595400
[ 1368.762876] [<c01c3710>] (mmc_resume_host+0x0/0x1c8) from 
[<c01cbe24>] (pxamci_resume+0x1c/0x28)
[ 1368.771604]  r5:c01ec4b8 r4:c02692a8
[ 1368.775195] [<c01cbe08>] (pxamci_resume+0x0/0x28) from [<c019e570>] 
(platform_pm_resume+0x34/0x54)
[ 1368.784104] [<c019e53c>] (platform_pm_resume+0x0/0x54) from 
[<c01a0a74>] (pm_op+0x6c/0x94)
[ 1368.792324] [<c01a0a08>] (pm_op+0x0/0x94) from [<c01a104c>] 
(dpm_resume_end+0x108/0x478)
[ 1368.800362]  r5:c0289e64 r4:c02692a8
[ 1368.803957] [<c01a0f44>] (dpm_resume_end+0x0/0x478) from [<c0071ea8>] 
(suspend_devices_and_enter+0x108/0x1dc)
[ 1368.813818] [<c0071da0>] (suspend_devices_and_enter+0x0/0x1dc) from 
[<c007206c>] (enter_state+0xf0/0x128)
[ 1368.823322]  r7:c01d5a50 r6:00000000 r5:c0233af0 r4:00000001
[ 1368.829015] [<c0071f7c>] (enter_state+0x0/0x128) from [<c0071664>] 
(state_store+0x88/0xc4)
[ 1368.837227]  r7:c01d5a50 r6:00000007 r5:00000001 r4:c17ef000
[ 1368.842918] [<c00715dc>] (state_store+0x0/0xc4) from [<c0162d78>] 
(kobj_attr_store+0x1c/0x28)
[ 1368.851401] [<c0162d5c>] (kobj_attr_store+0x0/0x28) from [<c00fbfe0>] 
(sysfs_write_file+0x10c/0x18c)
[ 1368.860482] [<c00fbed4>] (sysfs_write_file+0x0/0x18c) from 
[<c00af9f0>] (vfs_write+0xb8/0x16c)
[ 1368.869041] [<c00af938>] (vfs_write+0x0/0x16c) from [<c00afb74>] 
(sys_write+0x44/0x74)


Change the msleep with udelay let complete the resume process. All the 
task are blocked or in sleep state.
The device start from a ramdisk and the mmc is not mounted before 
suspend. The kernel doesn't rise any exception
or problem. The funny thing is that a friend has the same device and he 
doesn't have the same problem with the same
kernel. Any suggest or test that I can do?

Michael Trimarchi
