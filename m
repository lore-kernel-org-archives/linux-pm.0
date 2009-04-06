From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: pm-hibernate : possible circular locking dependency
 detected
Date: Mon, 6 Apr 2009 10:37:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0904061031420.3012-100000__12676.9754024737$1239028983$gmane$org@iolanthe.rowland.org>
References: <200904061529.44780.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904061529.44780.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Rusty Russell <rusty@rustcorp.com.au>, Linux Kernel List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Mon, 6 Apr 2009, Rafael J. Wysocki wrote:

> On Monday 06 April 2009, Gautham R Shenoy wrote:
> > On Sun, Apr 05, 2009 at 03:44:54PM +0200, Ingo Molnar wrote:
> > > 
> > > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > 
> > > > On Sunday 05 April 2009, Ming Lei wrote:
> > > > > kernel version : one simple usb-serial patch against  commit
> > > > > 6bb597507f9839b13498781e481f5458aea33620.
> > > > > 
> > > > > Thanks.
> > > > 
> > > > Hmm, CPU hotplug again, it seems.
> > > > 
> > > > I'm not sure who's the maintainer at the moment.  Andrew, is that 
> > > > Gautham?
> > > 
> > > CPU hotplug tends to land on the scheduler people's desk normally.
> > > 
> > > But i'm not sure that's the real thing here - key appears to be this 
> > > work_on_cpu() worklet by the cpufreq code:
> > 
> > Actually, there are two dependency chains here which can lead to a deadlock.
> > The one we're seeing here is the longer of the two.
> > 
> > If the relevant locks are numbered as follows:
> > [1]: cpu_policy_rwsem
> > [2]: work_on_cpu
> > [3]: cpu_hotplug.lock
> > [4]: dpm_list_mtx
> > 
> > 
> > The individual callpaths are:
> > 
> > 1) do_dbs_timer()[1] --> dbs_check_cpu() --> __cpufreq_driver_getavg()
> >                                                                   |
> >                       work_on_cpu()[2] <-- get_measured_perf() <--|
> > 
> > 
> > 2) pci_device_probe() --> .. --> pci_call_probe() [3] --> work_on_cpu()[2]
> >                                                                      |
> >                   [4] device_pm_add() <-- ..<-- local_pci_probe() <--|
> 
> This should block on [4] held by hibernate().  That's why it calls
> device_pm_lock() after all.
> 
> > 3) hibernate() --> hibernatioin_snapshot() --> create_image()
> >                                                           |
> >        disable_nonboot_cpus() <-- [4] device_pm_lock() <--|
> >        |
> >        |--> _cpu_down() [3] --> cpufreq_cpu_callback() [1]
> > 
> > 
> > The two chains which can deadlock are
> > 
> > a) [1] --> [2] --> [4] --> [3] --> [1] (The one in this log)
> > and
> > b) [3] --> [2] --> [4] --> [3]
> 
> What exactly is the b) scenario?

If I understand correctly it isn't really a deadlock scenario, but it
is a lockdep violation.  The violation is:

	The pci_device_probe() path 2) proves that dpm_list_mtx [4] can
	be acquired while cpu_hotplug.lock [3] is held;

	The hibernate() path 3) proves that cpu_hotplug.lock [3] can be
	acquired while dpm_list_mtx [4] is held.

The two pathways cannot run simultaneously (and hence cannot deadlock) 
because the prepare() stage of hibernation is supposed to stop all 
device probing.  But lockdep will still report a problem.

Alan Stern
