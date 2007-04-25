From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [3/3] 2.6.21-rc7: known regressions (v2)
Date: Wed, 25 Apr 2007 21:34:53 +0200
Message-ID: <200704252134.55481.rjw__26831.901985179$1177529519$gmane$org@sisk.pl>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070423214909.GD3468@stusta.de>
	<20070425040605.6d6b4a82.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070425040605.6d6b4a82.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Mikael Pettersson <mikpe@it.uu.se>, John Stultz <johnstul@us.ibm.com>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, Guilherme Schroeder <guilherme@centralinf.com.br>, Jeff Chua <jeff.chua.linux@gmail.com>, Adrian Bunk <bunk@stusta.de>, linux-pci@atrey.karlin.mff.cuni.cz, ak@suse.de, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, discuss@x86-64.org, gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 25 April 2007 13:06, Andrew Morton wrote:
> On Mon, 23 Apr 2007 23:49:09 +0200 Adrian Bunk <bunk@stusta.de> wrote:
> 
> > This email lists some known regressions in Linus' tree compared to 2.6.20.
> > 
> > If you find your name in the Cc header, you are either submitter of one
> > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > of you caused a breakage or I'm considering you in any other way
> > possibly involved with one or more of these issues.
> > 
> > Due to the huge amount of recipients, please trim the Cc when answering.
> > 
> > 
> > Subject    : HPET enabled freeze my machine at boot
> >              workaround: clocksource=acpi_pm
> > References : http://lkml.org/lkml/2007/4/19/370
> > Submitter  : Guilherme Schroeder <guilherme@centralinf.com.br>
> > Caused-By  : Thomas Gleixner <tglx@linutronix.de>
> >              commit 5d8b34fdcb384161552d01ee8f34af5ff11f9684
> > Handled-By : John Stultz <johnstul@us.ibm.com>
> > Status     : problem is being debugged
> > 
> > 
> > Subject    : acpi_pm clocksource loses time on x86-64
> > References : http://lkml.org/lkml/2007/4/17/143
> > Submitter  : Mikael Pettersson <mikpe@it.uu.se>
> > Handled-By : John Stultz <johnstul@us.ibm.com>
> > Status     : problem is being debugged
> > 
> > 
> > Subject    : suspend to disk hangs  (CONFIG_NO_HZ)
> > References : http://lkml.org/lkml/2007/3/25/217
> > Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
> > Status     : unknown
> 
> That's still rather a lot of bustage from the timekeeping changes.  Is
> anything really happening here or have we all given up?
> 
> > 
> > Subject    : ThinkPad X60: resume no longer works  (PCI related?)
> >              workaround: CONFIG_FB_BACKLIGHT=n
> > References : http://lkml.org/lkml/2007/3/13/3
> > Submitter  : Dave Jones <davej@redhat.com>
> > Caused-By  : PCI merge
> >              commit 78149df6d565c36675463352d0bfe0000b02b7a7
> > Handled-By : Eric W. Biederman <ebiederm@xmission.com>
> >              Rafael J. Wysocki <rjw@sisk.pl>
> >              Antonino A. Daplas <adaplas@gmail.com>
> > Status     : unknown
> > 
> 
> Is this related to the problems Jeremy has been looking at?
> 
> > Subject    : suspend to disk works only once
> >              workaround: "echo shutdown > /sys/power/disk"
> > References : http://lkml.org/lkml/2007/4/13/240
> > Submitter  : Tobias Diedrich <ranma+kernel@tdiedrich.de>
> > Caused-By  : Rafael J. Wysocki <rjw@sisk.pl>
> >              commit ed746e3b18f4df18afa3763155972c5835f284c5
> > Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
> >              Dmitry Torokhov <dtor@insightbb.com>
> > Status     : problem is being debugged
> 
> That's been happening on my Vaio-of-death for several weeks now.  I spent a
> bit of time with the ACPI guys on it but we didn't get far.  I need to
> find an hour or two to work out what's gone wrong.

I can't reproduce it on any of my machines ...

Does the appended patch help, BTW?


---
 kernel/power/disk.c |    4 ++--
 kernel/power/user.c |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.21-rc7/kernel/power/disk.c
===================================================================
--- linux-2.6.21-rc7.orig/kernel/power/disk.c
+++ linux-2.6.21-rc7/kernel/power/disk.c
@@ -170,9 +170,9 @@ int pm_suspend_disk(void)
 
 	if (in_suspend) {
 		enable_nonboot_cpus();
-		platform_finish();
 		device_resume();
 		resume_console();
+		platform_finish();
 		pr_debug("PM: writing image.\n");
 		error = swsusp_write();
 		if (!error)
@@ -189,9 +189,9 @@ int pm_suspend_disk(void)
  Enable_cpus:
 	enable_nonboot_cpus();
  Resume_devices:
-	platform_finish();
 	device_resume();
 	resume_console();
+	platform_finish();
  Thaw:
 	unprepare_processes();
  Finish:
Index: linux-2.6.21-rc7/kernel/power/user.c
===================================================================
--- linux-2.6.21-rc7.orig/kernel/power/user.c
+++ linux-2.6.21-rc7/kernel/power/user.c
@@ -170,11 +170,11 @@ static inline int snapshot_suspend(int p
 	}
 	enable_nonboot_cpus();
  Resume_devices:
+	device_resume();
+	resume_console();
 	if (platform_suspend)
 		platform_finish();
 
-	device_resume();
-	resume_console();
  Finish:
 	mutex_unlock(&pm_mutex);
 	return error;
@@ -202,11 +202,11 @@ static inline int snapshot_restore(int p
 
 	enable_nonboot_cpus();
  Resume_devices:
+	device_resume();
+	resume_console();
 	if (platform_suspend)
 		platform_finish();
 
-	device_resume();
-	resume_console();
  Finish:
 	pm_restore_console();
 	mutex_unlock(&pm_mutex);
