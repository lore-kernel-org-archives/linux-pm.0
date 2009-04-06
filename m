From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pm-hibernate : possible circular locking dependency
	detected
Date: Mon, 6 Apr 2009 15:29:43 +0200
Message-ID: <200904061529.44780.rjw__33099.5837496177$1239024827$gmane$org@sisk.pl>
References: <d82e647a0904050253n31bd2654s9b216465eec4d038@mail.gmail.com>
	<20090405134454.GB25250@elte.hu>
	<20090406005515.GA28200@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090406005515.GA28200@in.ibm.com>
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
To: ego@in.ibm.com
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Rusty Russell <rusty@rustcorp.com.au>, Linux Kernel List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 06 April 2009, Gautham R Shenoy wrote:
> On Sun, Apr 05, 2009 at 03:44:54PM +0200, Ingo Molnar wrote:
> > 
> > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > 
> > > On Sunday 05 April 2009, Ming Lei wrote:
> > > > kernel version : one simple usb-serial patch against  commit
> > > > 6bb597507f9839b13498781e481f5458aea33620.
> > > > 
> > > > Thanks.
> > > 
> > > Hmm, CPU hotplug again, it seems.
> > > 
> > > I'm not sure who's the maintainer at the moment.  Andrew, is that 
> > > Gautham?
> > 
> > CPU hotplug tends to land on the scheduler people's desk normally.
> > 
> > But i'm not sure that's the real thing here - key appears to be this 
> > work_on_cpu() worklet by the cpufreq code:
> 
> Actually, there are two dependency chains here which can lead to a deadlock.
> The one we're seeing here is the longer of the two.
> 
> If the relevant locks are numbered as follows:
> [1]: cpu_policy_rwsem
> [2]: work_on_cpu
> [3]: cpu_hotplug.lock
> [4]: dpm_list_mtx
> 
> 
> The individual callpaths are:
> 
> 1) do_dbs_timer()[1] --> dbs_check_cpu() --> __cpufreq_driver_getavg()
>                                                                   |
>                       work_on_cpu()[2] <-- get_measured_perf() <--|
> 
> 
> 2) pci_device_probe() --> .. --> pci_call_probe() [3] --> work_on_cpu()[2]
>                                                                      |
>                   [4] device_pm_add() <-- ..<-- local_pci_probe() <--|

This should block on [4] held by hibernate().  That's why it calls
device_pm_lock() after all.

> 3) hibernate() --> hibernatioin_snapshot() --> create_image()
>                                                           |
>        disable_nonboot_cpus() <-- [4] device_pm_lock() <--|
>        |
>        |--> _cpu_down() [3] --> cpufreq_cpu_callback() [1]
> 
> 
> The two chains which can deadlock are
> 
> a) [1] --> [2] --> [4] --> [3] --> [1] (The one in this log)
> and
> b) [3] --> [2] --> [4] --> [3]

What exactly is the b) scenario?

> Ingo,
> do_dbs_timer() function of the ondemand governor is run from a per-cpu
> workqueue. Hence it is already running on the cpu whose perf counters
> we're interested in.
> 
> Does it make sense to introduce a get_this_measured_perf() API
> for users who are already running on the relevant CPU ?
> And have get_measured_perf(cpu) for other users (currently there are
> none) ?
> 
> Thus, do_dbs_timer() can avoid calling work_on_cpu() thereby preventing
> deadlock a) from occuring.
> 
> Rafael,
> Sorry, I am not well versed with the hibernation code. But does the
> following make sense:

Not really ->

> create_image()
> {
> 	device_pm_lock();
> 	 device_power_down(PMSG_FREEZE);
> 	 platform_pre_snapshot(platform_mode);
> 
>         device_pm_unlock();

-> because dpm_list is under control of the hibernation code at this point
and it should remain locked.

> 	disable_nonboot_cpus()

disable_nonboot_cpus() must not take dpm_list_mtx itself.

> 	device_pm_lock();
> 	.
> 	.
> 	.
> 	.
> }

Thanks,
Rafael
