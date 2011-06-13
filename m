From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Question about expected behavior when PM runtime is
	disabled
Date: Mon, 13 Jun 2011 21:51:17 +0200
Message-ID: <201106132151.17569.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106131506110.1983-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106131506110.1983-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, June 13, 2011, Alan Stern wrote:
> On Mon, 13 Jun 2011, Kenneth Heitke wrote:
> 
> > > If runtime PM isn't present, why do you want to manage your clocks etc.
> > > at all?  The fact that it's not in the kernel means the system manager
> > > doesn't care about power usage.
> > 
> > I am trying to be backwards compatible.  There is likely a period of 
> > time from when the runtime PM feature was added to when it was turned on 
> > by default.  If the feature happens to be disabled, I think it makes 
> > sense for the driver to still do what it can to manage its resources. 
> > The power guys aren't going to let me off the hook that easily :)
> 
> Maybe not...  but then you can point out that it's somebody else's 
> fault!  :-)  More to the point, runtime PM should be enabled at the 
> same time it is added.  The code for both belongs in the subsystem and 
> driver, so there's no reason not to do them together.
> 
> IMO it's silly to bypass the runtime PM core's notion of when power 
> management should or should not be available.  If you're going to do 
> that, why bother using the runtime PM framework in the first place?
> 
> 
> > > It's up to the driver and the subsystem, since they are the entities
> > > that are responsible for disabling runtime PM.  If you think disabling
> > > runtime PM will cause problems, then don't do it.
> > 
> > I'm thinking about within runtime PM itself.  I believe during system 
> > suspend, disable() followed by enable() can be called.  If that happens, 
> > are there any scenarios that I need to be concerned about?  Can my 
> > autosuspend timer just happen to fire during that window between disable 
> > and enable resulting in a failure to suspend?  My driver is part of the 
> > i2c subsystem, do I know for a fact that disable() won't be used?
> 
> Ah -- that's a very good question.
> 
> The PM core doesn't call disable followed by enable, but subsystems do
> as part of system resume.  In fact, I'm not at all sure that the
> current implementation is correct in this regard.  The failure scenario
> you bring up seems entirely possible.
> 
> I think we need to have the PM core call pm_runtime_get_noresume()  
> before invoking the resume_noirq (or thaw_noirq or restore_noirq)  
> callback, and then call pm_runtime_put_sync() after invoking the
> complete callback.  This would solve your race: The put_sync would 
> invoke the runtime_idle method, which would start another runtime 
> suspend or autosuspend.
> 
> (It used to be that the PM core called pm_runtime_get_noresume() 
> earlier on, before the prepare callback.  This also solved your race, 
> but it caused other problems and so was changed.)
> 
> It's true that subsystems could do this for themselves, but then they'd
> _all_ have to do it.  So we might as well put it in the PM core.
> 
> Rafael, what do you think?

Yes, we can do that.

I even suspect that all subsystems will end up calling pm_runtime_disable()
somewhere in the system suspend code path and pm_runtime_enable() during
system resume.  It might be a good idea to do that in the core too, after
calling the subsystem's .suspend() and before calling its .resume(),
respectively.

Thanks,
Rafael
