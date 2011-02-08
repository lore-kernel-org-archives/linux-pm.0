From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [PATCH 0/2] Fix hangup after creating checkpoint on
	Xen.
Date: Tue, 08 Feb 2011 11:22:58 +0000
Message-ID: <1297164178.9388.65.camel__23247.7003163241$1297179576$gmane$org@zakaz.uk.xensource.com>
References: <20110207.180718.885783824287845425.kaz@jp.fujitsu.com>
	<201102071035.29922.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102071035.29922.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com, "SUZUKI,
	Kazuhiro" <kaz@jp.fujitsu.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2011-02-07 at 10:35 +0100, Rafael J. Wysocki wrote:
> On Monday, February 07, 2011, SUZUKI, Kazuhiro wrote:
> > Hi,
> 
> Hi,
> 
> > The following patch series fixes hangup after creating checkpoint on
> > Xen. The Linux Xen guest can be saved the state to restore later, and
> > also created snapshot like checkpoint via the hypervisor.
> > But, when the snapshot is created for the PV guest, it will hangup.
> > 
> > We added 'PMSG_CANCEL' message and 'cancel' handler in dev_pm_ops
> > struct in the pm-linux part.
> 
> Please don't do that, unless you can convince me there's no other way to fix
> the problem you're trying to address.

Sorry, it was my advise to Kazuhiro that solving the underlying issue by
extending the core would be preferable to making Xen specific hacks.

The problem is that currently we have:

        dpm_suspend_start(PMSG_SUSPEND);
        
                dpm_suspend_noirq(PMSG_SUSPEND);
                        
                        sysdev_suspend(PMSG_SUSPEND);
                        /* suspend hypercall */
                        sysdev_resume();
                
                dpm_resume_noirq(PMSG_RESUME);
        
        dpm_resume_end(PMSG_RESUME);

However the suspend hypercall can return a value indicating that the
suspend didn't actually happen (e.g. was cancelled). This is used e.g.
when checkpointing guests, because in that case you want the original
guest to continue. When the suspend didn't happen the drivers need to
recover differently from if it did.

The originally proposed solution was to only call dpm_resume_end if the
suspend was not cancelled. My concern with this was that unbalancing the
dpm_suspend_* and dpm_resume_* did not seem like a correct interaction
with the core. For example dpm_suspend_* adds stuff to
dpm_suspended_list and if dpm_resume_* is not called presumably this all
gets out of sync for next time. Hence my suggestion to add a cancel
message type.

> In my opinion it's highly unrealistic to assume that device drivers
> (or even subsystems) will implement the ->cancel() callback just for the
> benefit of Xen.

I did vague wonder if a similar message might be of interest to e.g.
cancelling hibernations or similar.

> And if the only subsystem that needs to implement ->cancel() is Xen, then the
> issue should be addressed without modifying the device core code, in a different
> way.

I thought it would be preferable to make use of/extend core
functionality where possible but if that's not the case we can find
another way.

Do you have any suggestions for how to correctly interact with the core
functions?

Is adding a suspend_cancel operation to just at the struct xenbus_driver
level and introducing a xen specific function to walk to the bus the
sort of thing you were thinking of? (it seems reasonable). Should we be
doing anything with dpm_*_list in that case?

(FWIW original thread is on xen-devel at
http://thread.gmane.org/gmane.comp.emulators.xen.devel/95265/)

Ian.

-- 
Ian Campbell
Current Noise: Crowbar - Dead Sun

Why on earth do people buy old bottles of wine when they can get a
fresh one for a quarter of the price?
