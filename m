From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [RFC] Adding board access to struct pm_ops pxa_pm_ops
Date: Mon, 10 Oct 2005 21:49:20 +0100
Message-ID: <1128977360.8356.56.camel@localhost.localdomain>
References: <1128868700.8704.66.camel@localhost.localdomain>
	<434AAB04.50806@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============082166555179685297=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <434AAB04.50806@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Russell King <rmk@arm.linux.org.uk>, Todd Poynor <tpoynor@mvista.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============082166555179685297==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-10-10 at 10:55 -0700, Todd Poynor wrote:
> cc'ing linux-pm list.  A cell phone maker has expressed interest in 
> approximately the same thing, in their case to barely wake from suspend, 
> update the time and other display info, check to see if they need to 
> fully resume, and if not go back to suspend.
> 
> A new optional pm_ops wakeup hook, called after the enter_state callback 
> returns, that can veto resume and go back to call enter_state for the 
> previous state should work, yes?  This hook would be intended for 
> system-specific customization (should always be NULL in generic board 
> support), and would avoid global access to pm_ops and the fragile 
> process of inserting new routines into the suspend/resume callback 
> paths.  I can float a patch for that if that sounds suitable.  Thanks -- 

[I've taken arm off the cc but have sent a similar email to the arm
list]

I think the best solution is going to be for board specific drivers to
set their own pm_ops function which replaces the generic board provided
one. I've included a sample patch below which exports enough
functionality to do this (and should give other flexibility should
anyone need it in future).

Richard


Allow access to the PXA pm_ops functions so boards can add custom power
handlers. Decrease the initcall level so any board specific code has a
chance to register.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: git/arch/arm/mach-pxa/pm.c
===================================================================
--- git.orig/arch/arm/mach-pxa/pm.c     2005-10-09 00:11:21.000000000 +0100
+++ git/arch/arm/mach-pxa/pm.c  2005-10-10 21:38:17.000000000 +0100
@@ -72,7 +72,7 @@
 };
 
 
-static int pxa_pm_enter(suspend_state_t state)
+int pxa_pm_enter(suspend_state_t state)
 {
        unsigned long sleep_save[SLEEP_SAVE_SIZE];
        unsigned long checksum = 0;
@@ -191,6 +191,8 @@
        return 0;
 }
 
+EXPORT_SYMBOL_GPL(pxa_pm_enter);
+
 unsigned long sleep_phys_sp(void *sp)
 {
        return virt_to_phys(sp);
@@ -199,21 +201,25 @@
 /*
  * Called after processes are frozen, but before we shut down devices.
  */
-static int pxa_pm_prepare(suspend_state_t state)
+int pxa_pm_prepare(suspend_state_t state)
 {
        extern int pxa_cpu_pm_prepare(suspend_state_t state);
 
        return pxa_cpu_pm_prepare(state);
 }
 
+EXPORT_SYMBOL_GPL(pxa_pm_prepare);
+
 /*
  * Called after devices are re-setup, but before processes are thawed.
  */
-static int pxa_pm_finish(suspend_state_t state)
+int pxa_pm_finish(suspend_state_t state)
 {
        return 0;
 }
 
+EXPORT_SYMBOL_GPL(pxa_pm_finish);
+
 /*
  * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
  */
@@ -230,4 +236,4 @@
        return 0;
 }
 
-late_initcall(pxa_pm_init);
+subsys_initcall(pxa_pm_init);


--===============082166555179685297==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============082166555179685297==--
