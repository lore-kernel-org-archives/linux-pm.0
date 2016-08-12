From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC] Documentation/: update hibernation debug documentation
Date: Fri, 12 Aug 2016 15:31:33 +0200
Message-ID: <1760965.g7WzOE9Hrf@vostro.rjw.lan>
References: <1470917891-8386-1-git-send-email-yu.c.chen@intel.com> <CAJZ5v0jo3r+XFCkh1oH726bwu0CfMnq7xr-seT1Cq_0r6BcTFg@mail.gmail.com> <36DF59CE26D8EE47B0655C516E9CE64028786F3F@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE64028786F3F@shsmsx102.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux PM List <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, August 12, 2016 11:55:43 AM Chen, Yu C wrote:
> 
> > -----Original Message-----
> > From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
> > Rafael J. Wysocki
> > Sent: Friday, August 12, 2016 7:54 PM
> > To: Chen, Yu C
> > Cc: Pavel Machek; Linux PM List; Rafael J. Wysocki; Len Brown; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH][RFC] Documentation/: update hibernation debug
> > documentation
> > 
> > On Fri, Aug 12, 2016 at 1:46 PM, Chen, Yu C <yu.c.chen@intel.com> wrote:
> > > Hi Pavel,
> > >
> > >> -----Original Message-----
> > >> From: Pavel Machek [mailto:pavel@ucw.cz]
> > >> Sent: Friday, August 12, 2016 2:23 PM
> > >> To: Chen, Yu C
> > >> Cc: Linux PM List; Rafael J. Wysocki; Len Brown;
> > >> linux-kernel@vger.kernel.org
> > >> Subject: Re: [PATCH][RFC] Documentation/: update hibernation debug
> > >> documentation
> > >>
> > >> Hi!
> > >>
> > >> > Update the description of test_resume mode for hibernation.
> > >> >
> > >> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > >> > ---
> > >> >  Documentation/power/basic-pm-debugging.txt | 7 +++++++
> > >> >  1 file changed, 7 insertions(+)
> > >>
> > >> That's certainly step in the right direction, but I guess it should
> > >> be mentioned in the other places, too. Something like this?
> > >>
> > >> Additionally, we have testproc. Should we move it to test_proc for
> > >> consistency (or replace test_resume with simple "resume"? That's what
> > >> it does... it is
> > >> hibernate+resume...
> > > It looks like testproc has been removed in commit
> > > 48580ab8729865c81e148d59159fbe2aa7865511,
> > 
> > Yes, it was removed, back in 2011.
> > 
> > > so I think we can replace 'testproc/test' with 'resume' in
> > > interface.txt and add some description in it, I'll do that, thanks.
> > 
> > You mean "test_resume" I suppose?
> Yes.
> > 
> > Clearly, the documentation needs to be updated.
> > 
> > Let me take care of that later today.
> OK, thanks!

OK, there you go.

Thanks,
Rafael


---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] PM / sleep: Update some system sleep documentation

Update some documentation related to system sleep to document new
features and remove outdated information from it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/power/basic-pm-debugging.txt |   27 +++++
 Documentation/power/interface.txt          |  140 ++++++++++++++---------------
 2 files changed, 96 insertions(+), 71 deletions(-)

Index: linux-pm/Documentation/power/interface.txt
===================================================================
--- linux-pm.orig/Documentation/power/interface.txt
+++ linux-pm/Documentation/power/interface.txt
@@ -1,75 +1,75 @@
-Power Management Interface
+Power Management Interface for System Sleep
 
+Copyright (c) 2016 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
-The power management subsystem provides a unified sysfs interface to 
-userspace, regardless of what architecture or platform one is
-running. The interface exists in /sys/power/ directory (assuming sysfs
-is mounted at /sys). 
-
-/sys/power/state controls system power state. Reading from this file
-returns what states are supported, which is hard-coded to 'freeze',
-'standby' (Power-On Suspend), 'mem' (Suspend-to-RAM), and 'disk'
-(Suspend-to-Disk). 
-
-Writing to this file one of those strings causes the system to
-transition into that state. Please see the file
-Documentation/power/states.txt for a description of each of those
-states.
-
-
-/sys/power/disk controls the operating mode of the suspend-to-disk
-mechanism. Suspend-to-disk can be handled in several ways. We have a
-few options for putting the system to sleep - using the platform driver
-(e.g. ACPI or other suspend_ops), powering off the system or rebooting the
-system (for testing).
-
-Additionally, /sys/power/disk can be used to turn on one of the two testing
-modes of the suspend-to-disk mechanism: 'testproc' or 'test'.  If the
-suspend-to-disk mechanism is in the 'testproc' mode, writing 'disk' to
-/sys/power/state will cause the kernel to disable nonboot CPUs and freeze
-tasks, wait for 5 seconds, unfreeze tasks and enable nonboot CPUs.  If it is
-in the 'test' mode, writing 'disk' to /sys/power/state will cause the kernel
-to disable nonboot CPUs and freeze tasks, shrink memory, suspend devices, wait
-for 5 seconds, resume devices, unfreeze tasks and enable nonboot CPUs.  Then,
-we are able to look in the log messages and work out, for example, which code
-is being slow and which device drivers are misbehaving.
-
-Reading from this file will display all supported modes and the currently
-selected one in brackets, for example
-
-	[shutdown] reboot test testproc
-
-Writing to this file will accept one of
-
-       'platform' (only if the platform supports it)
-       'shutdown'
-       'reboot'
-       'testproc'
-       'test'
-
-/sys/power/image_size controls the size of the image created by
-the suspend-to-disk mechanism.  It can be written a string
-representing a non-negative integer that will be used as an upper
-limit of the image size, in bytes.  The suspend-to-disk mechanism will
-do its best to ensure the image size will not exceed that number.  However,
-if this turns out to be impossible, it will try to suspend anyway using the
-smallest image possible.  In particular, if "0" is written to this file, the
-suspend image will be as small as possible.
-
-Reading from this file will display the current image size limit, which
-is set to 2/5 of available RAM by default.
-
-/sys/power/pm_trace controls the code which saves the last PM event point in
-the RTC across reboots, so that you can debug a machine that just hangs
-during suspend (or more commonly, during resume).  Namely, the RTC is only
-used to save the last PM event point if this file contains '1'.  Initially it
-contains '0' which may be changed to '1' by writing a string representing a
-nonzero integer into it.
+The power management subsystem provides userspace with a unified sysfs interface
+for system sleep regardless of the underlying system architecture or platform.
+The interface is located in the /sys/power/ directory (assuming that sysfs is
+mounted at /sys).
 
-To use this debugging feature you should attempt to suspend the machine, then
-reboot it and run
+/sys/power/state is the system sleep state control file.
 
-	dmesg -s 1000000 | grep 'hash matches'
+Reading from it returns a list of supported sleep states, encoded as:
 
-CAUTION: Using it will cause your machine's real-time (CMOS) clock to be
-set to a random invalid time after a resume.
+'freeze' (Suspend-to-Idle)
+'standby' (Power-On Suspend)
+'mem' (Suspend-to-RAM)
+'disk' (Suspend-to-Disk)
+
+Suspend-to-Idle is always supported.  Suspend-to-Disk is always supported
+too as long the kernel has been configured to support hibernation at all
+(ie. CONFIG_HIBERNATION is set in the kernel configuration file).  Support
+for Suspend-to-RAM and Power-On Suspend depends on the capabilities of the
+platform.
+
+If one of the strings listed in /sys/power/state is writtent to it, the system
+will attempt to transition into the corresponding sleep state.  Refer to
+Documentation/power/states.txt for a description of each of those states.
+
+/sys/power/disk controls the operating mode of hibernation (Suspend-to-Disk).
+Specifically, it tells the kernel what to do after creating a hibernation image.
+
+Reading from it returs a list of supported options encoded as:
+
+'platform' (put the system into sleep using a platform-provided method)
+'shutdown' (shut the system down)
+'reboot' (reboot the system)
+'suspend' (trigger a Suspend-to-RAM transition)
+'test_resume' (resume-after-hibernation test mode)
+
+The currently selected option is printed in brackets.
+
+The 'platform' option is only available if the platform provides a special
+mechanism to put the system to sleep after creating a hibernation image (ACPI
+does that, for example).  The 'suspend' option is available if Suspend-to-RAM
+is supported.  Refer to Documentation/power/basic_pm_debugging.txt for the
+description of the 'test_resume' option.
+
+To select an option, write the string representing it to /sys/power/disk.
+
+/sys/power/image_size controls the size of hibernation images.
+
+It can be written a string representing a non-negative integer that will be
+used as a best-effort upper limit of the image size, in bytes.  The hibernation
+core will do its best to ensure that the image size will not exceed that number.
+However, if that turns out to be impossible to achieve, a hibernation image will
+still be created and its size will be as small as possible.  In particular,
+writing '0' to this file will enforce hibernation images to be possibly small.
+
+Reading from this file returns the current image size limit, which is set to
+around 2/5 of available RAM by default.
+
+/sys/power/pm_trace controls the PM trace mechanism saving the last suspend
+or resume event point in the RTC across reboots.
+
+It helps to debug hard lockups or reboots due to device driver failures that
+occur during system suspend or resume (which is more common) more effectively.
+
+If /sys/power/pm_trace contains '1', the fingerprint of each suspend/resume
+event point in turn will be stored in the RTC memory (overwriting the actual
+RTC information), so it will survive a system crash if one occurs right after
+storing it and it can be used later to identify the driver that caused the crash
+to happen (see Documentation/power/s2ram.txt for more information).
+
+Initially it contains '0' which may be changed to '1' by writing a string
+representing a nonzero integer into it.
Index: linux-pm/Documentation/power/basic-pm-debugging.txt
===================================================================
--- linux-pm.orig/Documentation/power/basic-pm-debugging.txt
+++ linux-pm/Documentation/power/basic-pm-debugging.txt
@@ -164,7 +164,32 @@ load n/2 modules more and try again.
 Again, if you find the offending module(s), it(they) must be unloaded every time
 before hibernation, and please report the problem with it(them).
 
-c) Advanced debugging
+c) Using the "test_resume" hibernation option
+
+/sys/power/disk generally tells the kernel what to do after creating a
+hibernation image.  One of the available options is "test_resume" which
+causes the just created image to be used for immediate restoration.  Namely,
+after doing:
+
+# echo test_resume > /sys/power/disk
+# echo disk > /sys/power/state
+
+a hibernation image will be created and a resume from it will be triggered
+immediately without involving the platform firmware in any way.
+
+That test can be used to check if failres to resume from hibernation are related
+to bad interactions with the platform firmware.  That is, if the above works
+every time, but resume from actual hibernation does not work or is unreliable,
+the platform firmware may be responsible for the failures.
+
+On architectures and platforms that support using different kernels to restore
+hibernation images (that is, the kernel used to read the image from storage and
+load it into memory is different from the one included in the image) or support
+kernel address space randomization, it also can be used to check if failures
+to resume may be related to the differences between the restore and image
+kernels.
+
+d) Advanced debugging
 
 In case that hibernation does not work on your system even in the minimal
 configuration and compiling more drivers as modules is not practical or some
