From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.17-rc4-git] remove duplication from
	Documentation/power/devices.txt
Date: Tue, 16 May 2006 17:00:08 -0700
Message-ID: <200605161700.10100.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KemaEcAKsMJLsX7"
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_KemaEcAKsMJLsX7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The last 180 lines are two copies of the same text.


--Boundary-00=_KemaEcAKsMJLsX7
Content-Type: text/x-diff;
  charset="us-ascii";
  name="doc1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="doc1.patch"

Remove a chunk of duplicated documentation text.

Index: linux/Documentation/power/devices.txt
===================================================================
--- linux.orig/Documentation/power/devices.txt	2006-05-15 09:08:36.000000000 -0700
+++ linux/Documentation/power/devices.txt	2006-05-15 09:09:36.000000000 -0700
@@ -135,96 +135,6 @@ HW.
 
 FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
 scratch. That probably means stop accepting upstream requests, the
-actual policy of what to do with them beeing specific to a given
-driver. It's acceptable for a network driver to just drop packets
-while a block driver is expected to block the queue so no request is
-lost. (Use IDE as an example on how to do that). FREEZE requires no
-power state change, and it's expected for drivers to be able to
-quickly transition back to operating state.
-
-SUSPEND -- like FREEZE, but also put hardware into low-power state. If
-there's need to distinguish several levels of sleep, additional flag
-is probably best way to do that.
-
-Transitions are only from a resumed state to a suspended state, never
-between 2 suspended states. (ON -> FREEZE or ON -> SUSPEND can happen,
-FREEZE -> SUSPEND or SUSPEND -> FREEZE can not).
-
-All events are:
-
-[NOTE NOTE NOTE: If you are driver author, you should not care; you
-should only look at event, and ignore flags.]
-
-#Prepare for suspend -- userland is still running but we are going to
-#enter suspend state. This gives drivers chance to load firmware from
-#disk and store it in memory, or do other activities taht require
-#operating userland, ability to kmalloc GFP_KERNEL, etc... All of these
-#are forbiden once the suspend dance is started.. event = ON, flags =
-#PREPARE_TO_SUSPEND
-
-Apm standby -- prepare for APM event. Quiesce devices to make life
-easier for APM BIOS. event = FREEZE, flags = APM_STANDBY
-
-Apm suspend -- same as APM_STANDBY, but it we should probably avoid
-spinning down disks. event = FREEZE, flags = APM_SUSPEND
-
-System halt, reboot -- quiesce devices to make life easier for BIOS. event
-= FREEZE, flags = SYSTEM_HALT or SYSTEM_REBOOT
-
-System shutdown -- at least disks need to be spun down, or data may be
-lost. Quiesce devices, just to make life easier for BIOS. event =
-FREEZE, flags = SYSTEM_SHUTDOWN
-
-Kexec    -- turn off DMAs and put hardware into some state where new
-kernel can take over. event = FREEZE, flags = KEXEC
-
-Powerdown at end of swsusp -- very similar to SYSTEM_SHUTDOWN, except wake
-may need to be enabled on some devices. This actually has at least 3
-subtypes, system can reboot, enter S4 and enter S5 at the end of
-swsusp. event = FREEZE, flags = SWSUSP and one of SYSTEM_REBOOT,
-SYSTEM_SHUTDOWN, SYSTEM_S4
-
-Suspend to ram  -- put devices into low power state. event = SUSPEND,
-flags = SUSPEND_TO_RAM
-
-Freeze for swsusp snapshot -- stop DMA and interrupts. No need to put
-devices into low power mode, but you must be able to reinitialize
-device from scratch in resume method. This has two flavors, its done
-once on suspending kernel, once on resuming kernel. event = FREEZE,
-flags = DURING_SUSPEND or DURING_RESUME
-
-Device detach requested from /sys -- deinitialize device; proably same as
-SYSTEM_SHUTDOWN, I do not understand this one too much. probably event
-= FREEZE, flags = DEV_DETACH.
-
-#These are not really events sent:
-#
-#System fully on -- device is working normally; this is probably never
-#passed to suspend() method... event = ON, flags = 0
-#
-#Ready after resume -- userland is now running, again. Time to free any
-#memory you ate during prepare to suspend... event = ON, flags =
-#READY_AFTER_RESUME
-#
-
-
-pm_message_t meaning
-
-pm_message_t has two fields. event ("major"), and flags.  If driver
-does not know event code, it aborts the request, returning error. Some
-drivers may need to deal with special cases based on the actual type
-of suspend operation being done at the system level. This is why
-there are flags.
-
-Event codes are:
-
-ON -- no need to do anything except special cases like broken
-HW.
-
-# NOTIFICATION -- pretty much same as ON?
-
-FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
-scratch. That probably means stop accepting upstream requests, the
 actual policy of what to do with them being specific to a given
 driver. It's acceptable for a network driver to just drop packets
 while a block driver is expected to block the queue so no request is

--Boundary-00=_KemaEcAKsMJLsX7
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_KemaEcAKsMJLsX7--
