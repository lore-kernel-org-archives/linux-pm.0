From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH 1/2] PM: Split up
	sysdev_[suspend|resume] from	device_power_[down|up]
Date: Sun, 22 Feb 2009 22:12:05 +0100
Message-ID: <20090222211205.GA28655@elte.hu>
References: <200902221837.49396.rjw@sisk.pl> <200902221838.51548.rjw@sisk.pl>
	<20090222205654.GC4485@localhost.pp.htv.fi>
	<alpine.LFD.2.00.0902221306090.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0902221306090.3111@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Bunk <bunk@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Jeremy Fitzhardinge <jeremy@goop.org>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Sun, 22 Feb 2009, Adrian Bunk wrote:
> > ...
> >   MODPOST 2586 modules
> > ERROR: "sysdev_resume" [arch/x86/kernel/apm.ko] undefined!
> > ERROR: "sysdev_suspend" [arch/x86/kernel/apm.ko] undefined!
> > make[2]: *** [__modpost] Error 1
> 
> Ahh. device_power_[down|up] were EXPORT_SYMBOL_GPL, so now that we've 
> split them, so must sysdev_[suspend|resume] be.
> 
> Does this fix it?

I just hit the same issue in -tip testing and did the same fix:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git core/urgent

	Ingo

------------------>
Ingo Molnar (1):
      PM: Split up sysdev_[suspend|resume] from device_power_[down|up], fix


 drivers/base/sys.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/base/sys.c b/drivers/base/sys.c
index c98c31e..b428c8c 100644
--- a/drivers/base/sys.c
+++ b/drivers/base/sys.c
@@ -303,7 +303,6 @@ void sysdev_unregister(struct sys_device * sysdev)
  *	is guaranteed by virtue of the fact that child devices are registered
  *	after their parents.
  */
-
 void sysdev_shutdown(void)
 {
 	struct sysdev_class * cls;
@@ -363,7 +362,6 @@ static void __sysdev_resume(struct sys_device *dev)
  *	This is only called by the device PM core, so we let them handle
  *	all synchronization.
  */
-
 int sysdev_suspend(pm_message_t state)
 {
 	struct sysdev_class * cls;
@@ -432,7 +430,7 @@ aux_driver:
 	}
 	return ret;
 }
-
+EXPORT_SYMBOL_GPL(sysdev_suspend);
 
 /**
  *	sysdev_resume - Bring system devices back to life.
@@ -442,7 +440,6 @@ aux_driver:
  *
  *	Note: Interrupts are disabled when called.
  */
-
 int sysdev_resume(void)
 {
 	struct sysdev_class * cls;
@@ -463,7 +460,7 @@ int sysdev_resume(void)
 	}
 	return 0;
 }
-
+EXPORT_SYMBOL_GPL(sysdev_resume);
 
 int __init system_bus_init(void)
 {
