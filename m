From: Jim Rees <rees@umich.edu>
Subject: WARNING: at kref_get
Date: Thu, 10 Mar 2011 00:49:45 -0500
Message-ID: <20110310054945.GB3058@merit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
List-Id: linux-pm@vger.kernel.org

Was there ever a resolution to this bug?

Date: Tue Nov 2 14:49:08 PDT 2010
Subject: [GIT PULL] One more power management fix for 2.6.37
https://lists.linux-foundation.org/pipermail/linux-pm/2010-November/029299.html

I'm still seeing this in the Ubuntu version of 2.6.38-rc6.  I'd be happy to
try with the kernel.org version if anyone thinks it would make a difference.

WARNING: at /u/rees/l/linux-natty/lib/kref.c:34 kref_get+0x21/0x30()
Hardware name: 2386BHU
Modules linked in: sha1_generic arc4 ppp_mppe ppp_async crc_ccitt michael_mic orinoco_cs orinoco cfg80211 parport_pc dm_crypt ppdev snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm_oss pcmcia snd_mixer_oss snd_pcm thinkpad_acpi snd_timer yenta_socket psmouse snd pcmcia_rsrc serio_raw pcmcia_core snd_page_alloc soundcore nvram lp parport i915 fbcon tileblit font bitblit softcursor drm_kms_helper drm usbhid intel_agp i2c_algo_bit intel_gtt e1000 sdhci_pci hid ata_piix sdhci video agpgart
Pid: 7110, comm: pm-suspend Not tainted 2.6.38-rc6-x40 #5
Call Trace:
 [<c0147dd2>] ? warn_slowpath_common+0x72/0xa0
 [<c031fc51>] ? kref_get+0x21/0x30
 [<c031fc51>] ? kref_get+0x21/0x30
 [<c0147e22>] ? warn_slowpath_null+0x22/0x30
 [<c031fc51>] ? kref_get+0x21/0x30
 [<c031ebd2>] ? kobject_get+0x12/0x20
 [<c03b6958>] ? get_device+0x18/0x20
 [<c03bfd70>] ? dpm_resume_end+0x1c0/0x2b0
 [<c0180768>] ? suspend_devices_and_enter+0xb8/0x260
 [<c0577f95>] ? printk+0x1d/0x20
 [<c0180a18>] ? enter_state+0x108/0x130
 [<c017ffbd>] ? state_store+0x6d/0xb0
 [<c017ff50>] ? state_store+0x0/0xb0
 [<c031e7b0>] ? kobj_attr_store+0x20/0x30
 [<c02637c9>] ? sysfs_write_file+0x99/0xf0
 [<c020a9d2>] ? vfs_write+0xa2/0x170
 [<c0263730>] ? sysfs_write_file+0x0/0xf0
 [<c020ab72>] ? sys_write+0x42/0x70
 [<c057ae0c>] ? syscall_call+0x7/0xb
---[ end trace 3295bc3b85c7d9eb ]---
PM: resume devices took 0.916 seconds
Restarting tasks ... 
done.
video LNXVIDEO:00: Restoring backlight state
EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro,commit=0
