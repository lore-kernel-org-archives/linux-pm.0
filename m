From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 2.6.21-rc6
Date: Sat, 14 Apr 2007 22:23:31 +0200
Message-ID: <200704142223.32410.rjw@sisk.pl>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<200704142028.04694.rjw@sisk.pl>
	<20070414195611.GC806@yamamaya.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070414195611.GC806@yamamaya.is-a-geek.org>
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
To: Tobias Diedrich <ranma@tdiedrich.de>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

On Saturday, 14 April 2007 21:56, Tobias Diedrich wrote:
> Rafael J. Wysocki wrote:
> > On Saturday, 14 April 2007 15:00, Adrian Bunk wrote:
> > > On Sat, Apr 14, 2007 at 02:31:54PM +0200, Tobias Diedrich wrote:
> > > > Tobias Diedrich wrote:
> > > > > > ed746e3b18f4df18afa3763155972c5835f284c5 is first bad commit
> > > > > > commit ed746e3b18f4df18afa3763155972c5835f284c5
> > > > > > Author: Rafael J. Wysocki <rjw@sisk.pl>
> > > > > > Date:   Sat Feb 10 01:43:32 2007 -0800
> > > > > > =

> > > > > >     [PATCH] swsusp: Change code ordering in disk.c
> > > > > >     =

> > > > > >     Change the ordering of code in kernel/power/disk.c so that =
device_suspend() is
> > > > > >     called before disable_nonboot_cpus() and platform_finish() =
is called after
> > > > > >     enable_nonboot_cpus() and before device_resume(), as indica=
ted by the recent
> > > > > >     discussion on Linux-PM (cf.
> > > > > >     http://lists.osdl.org/pipermail/linux-pm/2006-November/0041=
64.html).
> > > > > >     =

> > > > > >     The changes here only affect the built-in swsusp.
> > > > > >     =

> > > > > >     [alexey.y.starikovskiy@linux.intel.com: fix LED blinking du=
ring image load]
> > > > > >     Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > > > >     Acked-by: Pavel Machek <pavel@ucw.cz>
> > > > > >     Cc: Greg KH <greg@kroah.com>
> > > > > >     Cc: Nigel Cunningham <nigel@suspend2.net>
> > > > > >     Cc: Patrick Mochel <mochel@digitalimplant.org>
> > > > > >     Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.=
com>
> > > > > >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > > > >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.or=
g>
> > > > > > =

> > > > > > :040000 040000 7eca5b3a8f9606bc4f2ff41192ec8c9d4ca90d18 8313b67=
4e1d1bdf6849350af06d28a89b3bb3054 M      kernel
> > > > > > =

> > > > > > =

> > > > > > Now, the remaining test is to try reverting this commit from -r=
c6. :)
> > > > > =

> > > > > Doesn't apply cleanly against -rc6, but fixes the problem when
> > > > > reverted from -rc1.
> > > > =

> > > > Now, this was already reported in
> > > > http://lkml.org/lkml/2007/3/16/126
> > > > and I even flagged that message in my local folder, but apparently =
forgot
> > > > to follow up on it... *sigh*
> > > =

> > > Unless I misunderstood something, all of the problems Maxim described=
 in =

> > > this email are fixed for him in -rc6.
> > > =

> > > But it's quite possible that you are running into a different issue =

> > > exposed by this commit.
> > =

> > Yes, it's likely.
> > =

> > Tobias, I'm unable to reproduce the problem with your .config, but my h=
ardware
> > is certainly different.  Which suspend mode do you use?  If that's "pla=
tform",
> > can you try to use "shutdown" or "reboot" and see if that helps?
> =

> Sure.
> shutdown/reboot works fine, only platform is broken.

Thanks.

Now, I suspect the problem is somehow related to the hardware, so it would =
help
a lot if we could identify the piece of hardware (or driver) involved.

AFAICT, your system is a non-SMP one, so we can rule out
disable/enable_nonboot_cpus().  To confirm that the problem is related to
platform_finish(), can you please apply the appended debug patch and
see if the suspend in the 'platform' mode works with it?

Also, would that be feasible for you to use 'shutdown' as a workaround in c=
ase
the source of the problem is difficult to find and/or fix?

Rafael

---
 kernel/power/disk.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.21-rc6/kernel/power/disk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21-rc6.orig/kernel/power/disk.c
+++ linux-2.6.21-rc6/kernel/power/disk.c
@@ -170,8 +170,8 @@ int pm_suspend_disk(void)
 =

 	if (in_suspend) {
 		enable_nonboot_cpus();
-		platform_finish();
 		device_resume();
+		platform_finish();
 		resume_console();
 		pr_debug("PM: writing image.\n");
 		error =3D swsusp_write();
@@ -189,8 +189,8 @@ int pm_suspend_disk(void)
  Enable_cpus:
 	enable_nonboot_cpus();
  Resume_devices:
-	platform_finish();
 	device_resume();
+	platform_finish();
 	resume_console();
  Thaw:
 	unprepare_processes();
