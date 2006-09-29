From: Dave Jones <davej@redhat.com>
Subject: Re: suspending to disk on FC6 not working
Date: Fri, 29 Sep 2006 16:54:22 -0400
Message-ID: <20060929205422.GA22014@redhat.com>
References: <1159138520.19021.11.camel@soncomputer>
	<200609261200.28635.rjw@sisk.pl>
	<1159307254.2780.4.camel@soncomputer>
	<200609270001.50063.rjw@sisk.pl> <20060926221556.GD4714@elf.ucw.cz>
	<20060927023631.GD3108@redhat.com>
	<20060927025134.GB29182@redhat.com>
	<1159340129.2547.3.camel@soncomputer>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1159340129.2547.3.camel@soncomputer>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 27, 2006 at 02:55:29AM -0400, Louis Garcia wrote:

 > >  >  > > > > goes to the 2nd runlevel (ie. without network servers and X).  Then log in
 > >  >  > > > > as root, do "echo 8 > /proc/sys/kernel/printk" and
 > >  >  > > > > "echo disk > /sys/power/state".  The system should suspend to disk and power
 > >  >  > > > > off the machine.  If it doesn't do that (ie. if it returns to the shell
 > >  >  > > > > immediately), please do "dmesg > dmesg.log" and send the dmesg.log file
 > >  >  > > > > to me.
 > >  >  > > > 
 > >  >  > > > The system didn't power off, it returned to the shell. I attached dmesg.
 > >  >  > > 
 > >  >  > > Pavel, it looks like we have a problem with the CPU suspend on this box:
 > >  >  > > 
 > >  >  > > acpi acpi: freeze
 > >  >  > > PM: snapshotting memory.
 > >  >  > > Class driver suspend failed for cpu0
 > >  >  > > Could not power down device &q->lock: error -22
 > >  >  > > Some devices failed to power down, aborting suspend
 > >  >  > > acpi acpi: resuming
 > >  >  > 
 > >  >  > That looks like cpufreq/acpi, no?
 > >  > 
 > >  > Looking at drivers/cpufreq/cpufreq.c:cpufreq_suspend(),
 > >  > There's only two ways we can fail that function. In one way,
 > >  > we'll see a printk, and the other we silently -EINVAL.
 > >  > Given the log doesn't show the printk, we must be failing here..
 > >  > 
 > >  >     cpu_policy = cpufreq_cpu_get(cpu);
 > >  >     if (!cpu_policy)
 > >  >         return -EINVAL;
 > >  > 
 > >  > cpufreq_cpu_get has a number of potential ways it could fail however,
 > >  > and isn't very chatty about failing, so we've no real idea
 > >  > what's falling apart there.
 > > 
 > > This patch might give us some more clues.
 > >  
 > > --- 1/drivers/cpufreq/cpufreq.c	2006-09-24 00:26:42.000000000 -0400
 > > +++ 2/drivers/cpufreq/cpufreq.c	2006-09-26 22:48:49.000000000 -0400
 > > @@ -63,27 +63,36 @@ struct cpufreq_policy *cpufreq_cpu_get(u
 > >  	struct cpufreq_policy *data;
 > >  	unsigned long flags;
 > >  
 > > -	if (cpu >= NR_CPUS)
 > > +	if (cpu >= NR_CPUS) {
 > > +		printk(KERN_DEBUG "cpufreq_cpu_get failed (!>=NR_CPUS)\n");
 > >  		goto err_out;
 > > +	}
 > >  
 > >  	/* get the cpufreq driver */
 > >  	spin_lock_irqsave(&cpufreq_driver_lock, flags);
 > >  
 > > -	if (!cpufreq_driver)
 > > +	if (!cpufreq_driver) {
 > > +		printk(KERN_DEBUG "cpufreq_cpu_get failed (!driver)\n");
 > >  		goto err_out_unlock;
 > > +	}
 > >  
 > > -	if (!try_module_get(cpufreq_driver->owner))
 > > +	if (!try_module_get(cpufreq_driver->owner)) {
 > > +		printk(KERN_DEBUG "cpufreq_cpu_get failed (!try_module_get)\n");
 > >  		goto err_out_unlock;
 > > -
 > > +	}
 > >  
 > >  	/* get the CPU */
 > >  	data = cpufreq_cpu_data[cpu];
 > >  
 > > -	if (!data)
 > > +	if (!data) {
 > > +		printk(KERN_DEBUG "cpufreq_cpu_get failed (!data)\n");
 > >  		goto err_out_put_module;
 > > +	}
 > >  
 > > -	if (!kobject_get(&data->kobj))
 > > +	if (!kobject_get(&data->kobj)) {
 > > +		printk(KERN_DEBUG "cpufreq_cpu_get failed (!kobject_get)\n");
 > >  		goto err_out_put_module;
 > > +	}
 > >  
 > >  	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
 > >  	return data;
 > >
 > ... 
 > PM: snapshotting memory.
 > cpufreq_cpu_get failed (!data)
 > Class driver suspend failed for cpu0
 > Could not power down device &q->lock: error -22
 > Some devices failed to power down, aborting suspend

Ok, I'm not quite sure how we got into this state.  Venkatesh, any ideas ?
acpi-cpufreq got quite a few changes between .17 and .18, including the
two large 'P-state coordination' change.

Louis, I'm attaching two smaller changes that went into .18.
Can you apply those with -R, and see if either of those makes a difference?

	Dave


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=commit-a0cc621

commit a0cc621f52a4dea10c34eeed6eb4e36b26db63dc
Author: Dave Jones <davej@redhat.com>
Date:   Sun Aug 27 01:23:35 2006 -0700

    [PATCH] cpufreq: acpi-cpufreq: Ignore failure from acpi_cpufreq_early_init_acpi
    
    Ignore the return value of early_init_acpi(), as it can give false error
    messages.  If there is something really wrong, then register_driver will
    fail cleanly with EINVAL later.
    
    [ background: modprobe acpi-cpufreq on systems not capable of speed-scaling
      started failing with 'invalid argument', where previously it would only
      ever -ENODEV
    
      I'm not 100% happy with the solution. It'd be better to handle
      failure properly, but this is a low-impact change for 2.6.18
      We can always revisit doing this better in .19   --davej.]
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Dave Jones <davej@redhat.com>
    Cc: Greg KH <greg@kroah.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
index efb41e8..e6ea00e 100644
--- a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -567,16 +567,11 @@ static struct cpufreq_driver acpi_cpufre
 static int __init
 acpi_cpufreq_init (void)
 {
-	int                     result = 0;
-
 	dprintk("acpi_cpufreq_init\n");
 
-	result = acpi_cpufreq_early_init_acpi();
+	acpi_cpufreq_early_init_acpi();
 
-	if (!result)
- 		result = cpufreq_register_driver(&acpi_cpufreq_driver);
-	
-	return (result);
+ 	return cpufreq_register_driver(&acpi_cpufreq_driver);
 }
 
 

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=commit-12e704d

commit 12e704db809cd4101b7d3594fc9a96f30fe88a31
Author: bert hubert <bert.hubert@netherlabs.nl>
Date:   Sun Jul 30 21:19:32 2006 +0200

    [CPUFREQ] Propagate acpi_processor_preregister_performance return value.
    
    Note how any error from acpi_processor_preregister_performance is ignored.
    
    From: bert hubert <bert.hubert@netherlabs.nl>
    Signed-off-by: Dave Jones <davej@redhat.com>

diff --git a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
index 567b39b..efb41e8 100644
--- a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -384,8 +384,7 @@ static int acpi_cpufreq_early_init_acpi(
 	}
 
 	/* Do initialization in ACPI core */
-	acpi_processor_preregister_performance(acpi_perf_data);
-	return 0;
+	return acpi_processor_preregister_performance(acpi_perf_data);
 }
 
 static int

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--PNTmBPCT7hxwcZjr--
