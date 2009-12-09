From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ rwsems (was: Re: [GIT
 PULL] PM updates for 2.6.33)
Date: Wed, 9 Dec 2009 17:38:39 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912091729530.2672-100000__582.596640060906$1260398440$gmane$org@iolanthe.rowland.org>
References: <200912092318.24475.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912092318.24475.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Dec 2009, Rafael J. Wysocki wrote:

> On Wednesday 09 December 2009, Alan Stern wrote:
> > On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:
> > 
> > > For completness, below is the full async suspend/resume patch with rwlocks,
> > > that has been (very slightly) tested and doesn't seem to break things.
> > > 
> > > [Note to Alan: lockdep doesn't seem to complain about the not annotated nested
> > > locks.]
> > 
> > I can't imagine why not.  And wouldn't lockdep get confused by the fact
> > that in the async case, the rwsems are released by a different process
> > from the one that acquired them?
> 
> /me looks at the .config
> 
> I have CONFIG_LOCKDEP_SUPPORT set, is there anything else I need to set
> in .config?

How about CONFIG_PROVE_LOCKING?  If lockdep really does start 
complaining then switching to completions would be a simple way to 
appease it.

> > > @@ -683,10 +835,12 @@ static int dpm_suspend(pm_message_t stat
> > >  
> > >  	INIT_LIST_HEAD(&list);
> > >  	mutex_lock(&dpm_list_mtx);
> > > +	pm_transition = state;
> > >  	while (!list_empty(&dpm_list)) {
> > >  		struct device *dev = to_device(dpm_list.prev);
> > >  
> > >  		get_device(dev);
> > > +		dev->power.status = DPM_OFF;
> > 
> > What's that for?  dev->power.status is supposed to be DPM_SUSPENDING 
> > until the suspend method is successfully completed.
> 
> If the suspend is run asynchronoysly, the main thread will always get a
> "success" from device_suspend(), so it can't change power.status on this
> basis.  I thought we could set power.status to DPM_OFF upfront and change
> it back when error is returned.
> 
> The alternative would be to move the modification of power.status to
> device_suspend() and async_suspend().  Well, maybe that's better.

Yes, I think so.  Or into __device_suspend().  And the same thing in 
dpm_suspend_noirq().

> > How about exporting a wait_for_device_to_resume() routine?  Drivers
> > could call it for non-tree resume constraints:
> > 
> > 	void wait_for_device_to_resume(struct device *other)
> > 	{
> > 		down_read(&other->power.rwsem);
> > 		up_read(&other->power.rwsem);
> > 	}
> > 
> > Unfortunately there is no equivalent for non-tree suspend constraints.
> 
> If we use completions, it will be possible to just export something like
> 
> dpm_wait(dev)
> {
>         if (dev)
>                 wait_for_completion(dev->power.completion);
> }
> 
> I think.  It appears that will also work for suspend, unless I'm missing
> something.

It will.

Alan Stern
