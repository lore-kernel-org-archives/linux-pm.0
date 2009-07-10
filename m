From: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.31-rc2+: Interrupts enabled after cpufreq_suspend
Date: Fri, 10 Jul 2009 16:13:08 -0400
Message-ID: <20090710201308.GA11075__17592.8776771345$1247256851$gmane$org@redhat.com>
References: <4A561074.5080407@gmail.com> <20090710192511.GB6240@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090710192511.GB6240@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcin Slusarz <marcin.slusarz@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 10, 2009 at 03:25:11PM -0400, Dave Jones wrote:

 >     [PATCH] Add suspend method to cpufreq core
 >     
 >     In order to properly fix some issues with cpufreq vs. sleep on
 >     PowerBooks, I had to add a suspend callback to the pmac_cpufreq driver.
 >     I must force a switch to full speed before sleep and I switch back to
 >     previous speed on resume.
 > 
 > 
 > Ben, is there something better we can do here ?
 > 
 > I really don't want to add an #ifdef __powerpc__ to core code if we can help it.
 > I'd rather we didn't call into driver guts at all from the suspend path.

Marcin,
 Unless we get a better solution proposed, try running with this, which just
skips doing all that code entirely.

	Dave
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5cc77fb..8d3b3d1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1288,6 +1288,14 @@ static int cpufreq_suspend(struct sys_device *sysdev, pm_message_t pmsg)
 
 	dprintk("suspending cpu %u\n", cpu);
 
+	/*
+	 * This whole bogosity is here because Powerbooks are made of fail.
+	 * No sane platform should need any of the code below to be run.
+	 * (it's entirely the wrong thing to do, as driver->get may
+	 *  reenable interrupts on some architectures).
+	 */
+
+#ifdef __powerpc__
 	if (!cpu_online(cpu))
 		return 0;
 
@@ -1346,6 +1354,7 @@ static int cpufreq_suspend(struct sys_device *sysdev, pm_message_t pmsg)
 
 out:
 	cpufreq_cpu_put(cpu_policy);
+#endif	/* __powerpc__ */
 	return ret;
 }
 
@@ -1365,6 +1374,11 @@ static int cpufreq_resume(struct sys_device *sysdev)
 
 	dprintk("resuming cpu %u\n", cpu);
 
+	/* As with the ->suspend method, all the code below is
+	 * only necessary because Powerbooks suck.
+	 * See commit 42d4dc3f4e1e for jokes. */
+#ifdef __powerpc__
+
 	if (!cpu_online(cpu))
 		return 0;
 
@@ -1428,6 +1442,7 @@ out:
 	schedule_work(&cpu_policy->update);
 fail:
 	cpufreq_cpu_put(cpu_policy);
+#endif	/* __powerpc__ */
 	return ret;
 }
 
