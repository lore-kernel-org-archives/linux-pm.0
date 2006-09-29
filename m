From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: suspending to disk on FC6 not working
Date: Fri, 29 Sep 2006 14:35:43 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454ABBA55@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>, Louis Garcia <louisg00@bellsouth.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


>-----Original Message-----
>From: Dave Jones [mailto:davej@redhat.com] =

>Sent: Friday, September 29, 2006 1:54 PM
>To: Louis Garcia
>Cc: Pallipadi, Venkatesh; Pavel Machek; linux-pm@lists.osdl.org
>Subject: Re: [linux-pm] suspending to disk on FC6 not working
>
>On Wed, Sep 27, 2006 at 02:55:29AM -0400, Louis Garcia wrote:
>
> > >  >  > > > > goes to the 2nd runlevel (ie. without network =

>servers and X).  Then log in
> > >  >  > > > > as root, do "echo 8 > /proc/sys/kernel/printk" and
> > >  >  > > > > "echo disk > /sys/power/state".  The system =

>should suspend to disk and power
> > >  >  > > > > off the machine.  If it doesn't do that (ie. =

>if it returns to the shell
> > >  >  > > > > immediately), please do "dmesg > dmesg.log" =

>and send the dmesg.log file
> > >  >  > > > > to me.
> > >  >  > > > =

> > >  >  > > > The system didn't power off, it returned to the =

>shell. I attached dmesg.
> > >  >  > > =

> > >  >  > > Pavel, it looks like we have a problem with the =

>CPU suspend on this box:
> > >  >  > > =

> > >  >  > > acpi acpi: freeze
> > >  >  > > PM: snapshotting memory.
> > >  >  > > Class driver suspend failed for cpu0
> > >  >  > > Could not power down device &q->lock: error -22
> > >  >  > > Some devices failed to power down, aborting suspend
> > >  >  > > acpi acpi: resuming
> > >  >  > =

> > >  >  > That looks like cpufreq/acpi, no?
> > >  > =

> > >  > Looking at drivers/cpufreq/cpufreq.c:cpufreq_suspend(),
> > >  > There's only two ways we can fail that function. In one way,
> > >  > we'll see a printk, and the other we silently -EINVAL.
> > >  > Given the log doesn't show the printk, we must be =

>failing here..
> > >  > =

> > >  >     cpu_policy =3D cpufreq_cpu_get(cpu);
> > >  >     if (!cpu_policy)
> > >  >         return -EINVAL;
> > >  > =

> > >  > cpufreq_cpu_get has a number of potential ways it =

>could fail however,
> > >  > and isn't very chatty about failing, so we've no real idea
> > >  > what's falling apart there.
> > > =

> > > This patch might give us some more clues.
> > >  =

> > > --- 1/drivers/cpufreq/cpufreq.c	2006-09-24 =

>00:26:42.000000000 -0400
> > > +++ 2/drivers/cpufreq/cpufreq.c	2006-09-26 =

>22:48:49.000000000 -0400
> > > @@ -63,27 +63,36 @@ struct cpufreq_policy *cpufreq_cpu_get(u
> > >  	struct cpufreq_policy *data;
> > >  	unsigned long flags;
> > >  =

> > > -	if (cpu >=3D NR_CPUS)
> > > +	if (cpu >=3D NR_CPUS) {
> > > +		printk(KERN_DEBUG "cpufreq_cpu_get failed =

>(!>=3DNR_CPUS)\n");
> > >  		goto err_out;
> > > +	}
> > >  =

> > >  	/* get the cpufreq driver */
> > >  	spin_lock_irqsave(&cpufreq_driver_lock, flags);
> > >  =

> > > -	if (!cpufreq_driver)
> > > +	if (!cpufreq_driver) {
> > > +		printk(KERN_DEBUG "cpufreq_cpu_get failed (!driver)\n");
> > >  		goto err_out_unlock;
> > > +	}
> > >  =

> > > -	if (!try_module_get(cpufreq_driver->owner))
> > > +	if (!try_module_get(cpufreq_driver->owner)) {
> > > +		printk(KERN_DEBUG "cpufreq_cpu_get failed =

>(!try_module_get)\n");
> > >  		goto err_out_unlock;
> > > -
> > > +	}
> > >  =

> > >  	/* get the CPU */
> > >  	data =3D cpufreq_cpu_data[cpu];
> > >  =

> > > -	if (!data)
> > > +	if (!data) {
> > > +		printk(KERN_DEBUG "cpufreq_cpu_get failed (!data)\n");
> > >  		goto err_out_put_module;
> > > +	}
> > >  =

> > > -	if (!kobject_get(&data->kobj))
> > > +	if (!kobject_get(&data->kobj)) {
> > > +		printk(KERN_DEBUG "cpufreq_cpu_get failed =

>(!kobject_get)\n");
> > >  		goto err_out_put_module;
> > > +	}
> > >  =

> > >  	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
> > >  	return data;
> > >
> > ... =

> > PM: snapshotting memory.
> > cpufreq_cpu_get failed (!data)
> > Class driver suspend failed for cpu0
> > Could not power down device &q->lock: error -22
> > Some devices failed to power down, aborting suspend
>
>Ok, I'm not quite sure how we got into this state.  Venkatesh, =

>any ideas ?
>acpi-cpufreq got quite a few changes between .17 and .18, including the
>two large 'P-state coordination' change.
>
>Louis, I'm attaching two smaller changes that went into .18.
>Can you apply those with -R, and see if either of those makes =

>a difference?
>
>	Dave
>

cpufreq_cpu_data[] =3D NULL; only happens when acpi_cpufreq driver init
fails;
Looks like acpi_cpufreq driver init is failing at some point in this
case and the driver is staying loaded after that failure. That in turn
seems similar to one other bug I saw recently.

Louis, Can you check whether cpufreq is really working In you case. Boot
normally and before you try suspending, just see whether
/sys/devices/system/cpu/cpu0/cpufreq exists and if it does, cat
everything in that directory.

Thanks,
Venki =
