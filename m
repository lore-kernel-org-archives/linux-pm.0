From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: Re: swsusp 'disk' fails in bk-current - intel_agp at
	fault?
Date: Thu, 31 Mar 2005 02:26:02 -0500
Message-ID: <200503310226.03495.dtor_core@ameritech.net>
References: <20050329181831.GB8125@elf.ucw.cz>
	<1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
	<20050329223519.GI8125@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <20050329223519.GI8125-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 29 March 2005 17:35, Pavel Machek wrote:
> Hi!
> 
> > > We currently freeze processes for suspend-to-ram, too. I guess that
> > > disable_usermodehelper is probably better and that in_suspend() should
> > > only be used for sanity checks... go with disable_usermodehelper and
> > > sorry for the noise.
> > 
> > Here's another possibility: Freeze the workqueue that
> > call_usermodehelper uses (remember that code I didn't push hard enough
> > to Andrew?), and let invocations of call_usermodehelper block in
> > TASK_UNINTERRUPTIBLE. In refrigerating processes, don't choke on
> 
> There may be many devices in the system, and you are going to need
> quite a lot of RAM for all that... That's why they do not queue it
> during boot, IIRC. Disabling usermode helper seems right.

Ok, what do you think about this one?

===================================================================

swsusp: disable usermodehelper after generating memory snapshot and
        before resuming devices, so when device fails to resume we
        won't try to call hotplug - userspace stopped anyway.

Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>


 include/linux/kmod.h  |    3 +++
 kernel/kmod.c         |   14 +++++++++++++-
 kernel/power/disk.c   |    2 ++
 kernel/power/swsusp.c |    1 -
 4 files changed, 18 insertions(+), 2 deletions(-)

Index: dtor/kernel/power/disk.c
===================================================================
--- dtor.orig/kernel/power/disk.c
+++ dtor/kernel/power/disk.c
@@ -205,6 +205,8 @@ int pm_suspend_disk(void)
 
 	if (in_suspend) {
 		pr_debug("PM: writing image.\n");
+		usermodehelper_disable();
+		device_resume();
 		error = swsusp_write();
 		if (!error)
 			power_down(pm_disk_mode);
Index: dtor/kernel/power/swsusp.c
===================================================================
--- dtor.orig/kernel/power/swsusp.c
+++ dtor/kernel/power/swsusp.c
@@ -853,7 +853,6 @@ static int suspend_prepare_image(void)
 int swsusp_write(void)
 {
 	int error;
-	device_resume();
 	lock_swapdevices();
 	error = write_suspend_image();
 	/* This will unlock ignored swap devices since writing is finished */
Index: dtor/kernel/kmod.c
===================================================================
--- dtor.orig/kernel/kmod.c
+++ dtor/kernel/kmod.c
@@ -124,6 +124,8 @@ struct subprocess_info {
 	int retval;
 };
 
+static int usermodehelper_disabled;
+
 /*
  * This is the task which runs the usermode application
  */
@@ -240,7 +242,7 @@ int call_usermodehelper(char *path, char
 	if (!khelper_wq)
 		return -EBUSY;
 
-	if (path[0] == '\0')
+	if (usermodehelper_disabled || path[0] == '\0')
 		return 0;
 
 	queue_work(khelper_wq, &work);
@@ -249,6 +251,16 @@ int call_usermodehelper(char *path, char
 }
 EXPORT_SYMBOL(call_usermodehelper);
 
+void usermodehelper_enable(void)
+{
+	usermodehelper_disabled = 0;
+}
+
+void usermodehelper_disable(void)
+{
+	usermodehelper_disabled = 1;
+}
+
 void __init usermodehelper_init(void)
 {
 	khelper_wq = create_singlethread_workqueue("khelper");
Index: dtor/include/linux/kmod.h
===================================================================
--- dtor.orig/include/linux/kmod.h
+++ dtor/include/linux/kmod.h
@@ -34,7 +34,10 @@ static inline int request_module(const c
 #endif
 
 #define try_then_request_module(x, mod...) ((x) ?: (request_module(mod), (x)))
+
 extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
 extern void usermodehelper_init(void);
+extern void usermodehelper_enable(void);
+extern void usermodehelper_disable(void);
 
 #endif /* __LINUX_KMOD_H__ */
