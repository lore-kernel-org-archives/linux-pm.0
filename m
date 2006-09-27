From: Dave Jones <davej@redhat.com>
Subject: Re: suspending to disk on FC6 not working
Date: Tue, 26 Sep 2006 22:51:34 -0400
Message-ID: <20060927025134.GB29182@redhat.com>
References: <1159138520.19021.11.camel@soncomputer>
	<200609261200.28635.rjw@sisk.pl>
	<1159307254.2780.4.camel@soncomputer>
	<200609270001.50063.rjw@sisk.pl> <20060926221556.GD4714@elf.ucw.cz>
	<20060927023631.GD3108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060927023631.GD3108@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 26, 2006 at 10:36:31PM -0400, Dave Jones wrote:
 > On Wed, Sep 27, 2006 at 12:15:56AM +0200, Pavel Machek wrote:
 >  > Hi!
 >  > =

 >  > > > > Please boot the kernel with "2" appended to the command line, s=
o the system
 >  > > > > goes to the 2nd runlevel (ie. without network servers and X).  =
Then log in
 >  > > > > as root, do "echo 8 > /proc/sys/kernel/printk" and
 >  > > > > "echo disk > /sys/power/state".  The system should suspend to d=
isk and power
 >  > > > > off the machine.  If it doesn't do that (ie. if it returns to t=
he shell
 >  > > > > immediately), please do "dmesg > dmesg.log" and send the dmesg.=
log file
 >  > > > > to me.
 >  > > > =

 >  > > > The system didn't power off, it returned to the shell. I attached=
 dmesg.
 >  > > =

 >  > > Pavel, it looks like we have a problem with the CPU suspend on this=
 box:
 >  > > =

 >  > > acpi acpi: freeze
 >  > > PM: snapshotting memory.
 >  > > Class driver suspend failed for cpu0
 >  > > Could not power down device &q->lock: error -22
 > =

 > That's an interesting device name.
 > =

 >  > > Some devices failed to power down, aborting suspend
 >  > > acpi acpi: resuming
 >  > =

 >  > That looks like cpufreq/acpi, no?
 > =

 > Looking at drivers/cpufreq/cpufreq.c:cpufreq_suspend(),
 > There's only two ways we can fail that function. In one way,
 > we'll see a printk, and the other we silently -EINVAL.
 > Given the log doesn't show the printk, we must be failing here..
 > =

 >     cpu_policy =3D cpufreq_cpu_get(cpu);
 >     if (!cpu_policy)
 >         return -EINVAL;
 > =

 > cpufreq_cpu_get has a number of potential ways it could fail however,
 > and isn't very chatty about failing, so we've no real idea
 > what's falling apart there.

This patch might give us some more clues.

	Dave
 =

--- 1/drivers/cpufreq/cpufreq.c	2006-09-24 00:26:42.000000000 -0400
+++ 2/drivers/cpufreq/cpufreq.c	2006-09-26 22:48:49.000000000 -0400
@@ -63,27 +63,36 @@ struct cpufreq_policy *cpufreq_cpu_get(u
 	struct cpufreq_policy *data;
 	unsigned long flags;
 =

-	if (cpu >=3D NR_CPUS)
+	if (cpu >=3D NR_CPUS) {
+		printk(KERN_DEBUG "cpufreq_cpu_get failed (!>=3DNR_CPUS)\n");
 		goto err_out;
+	}
 =

 	/* get the cpufreq driver */
 	spin_lock_irqsave(&cpufreq_driver_lock, flags);
 =

-	if (!cpufreq_driver)
+	if (!cpufreq_driver) {
+		printk(KERN_DEBUG "cpufreq_cpu_get failed (!driver)\n");
 		goto err_out_unlock;
+	}
 =

-	if (!try_module_get(cpufreq_driver->owner))
+	if (!try_module_get(cpufreq_driver->owner)) {
+		printk(KERN_DEBUG "cpufreq_cpu_get failed (!try_module_get)\n");
 		goto err_out_unlock;
-
+	}
 =

 	/* get the CPU */
 	data =3D cpufreq_cpu_data[cpu];
 =

-	if (!data)
+	if (!data) {
+		printk(KERN_DEBUG "cpufreq_cpu_get failed (!data)\n");
 		goto err_out_put_module;
+	}
 =

-	if (!kobject_get(&data->kobj))
+	if (!kobject_get(&data->kobj)) {
+		printk(KERN_DEBUG "cpufreq_cpu_get failed (!kobject_get)\n");
 		goto err_out_put_module;
+	}
 =

 	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
 	return data;
