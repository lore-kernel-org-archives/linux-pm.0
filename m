From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: use of pm_runtime_disable() from driver probe?
Date: Tue, 10 Jul 2012 20:31:15 +0200
Message-ID: <201207102031.15579.rjw@sisk.pl>
References: <873954a5ho.fsf@ti.com> <201207072125.26189.rjw@sisk.pl>
	<87r4sjo5a2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87r4sjo5a2.fsf@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 10, 2012, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > Hi,
> >
> > On Saturday, July 07, 2012, Kevin Hilman wrote:
> >> Hello,
> >> 
> >> I've got a question around the proper use of pm_runtime_disable() in a
> >> driver's ->probe method.  Basically, using pm_runtime_disable() in
> >> ->probe() (e.g because of a error/failure) can result in the device
> >> remaning runtime enabled forever.
> >
> > Er, no.
> 
> Right, poor choice of words.  What I meant was "...can result in the
> device remaining powered on forever."  
> 
> >> This is because the driver core wraps
> >> the probe in _get_noresume()/_put_sync() so any usage of _put_sync() in
> >> ->probe itself does not trigger an actual device runtime suspend.  If
> >> the driver also calls pm_runtime_disable() in probe, that results in the
> >> device remaining runtime enabled.
> >
> > I'm not quite sure what way.  pm_runtime_disable() increments
> > dev->power.disable_count and if that is not decremented later, the
> > device remains runtime disabled.
> >
> > You probably wanted to say that the device will end up in the full-power
> > state in that case, which isn't the same and is intentional.
> 
> Correct.  I'm glad you understood what I meant instead of what I said.
> I wish my kids could do that.  ;)
> 
> [...]
> 
> >> So, the question is: is it right to use pm_runtime_disable() this way?
> >
> > If your intention is to put the device into a low-power state in case of
> > a failing .probe(), this isn't the way to do it.  pm_runtime_disable()
> > means "don't do any runtime power management on this device any more"
> > regardless of the current state of the device (it may resume the device
> > in some situations, but it won't suspend it, although it may wait for
> > a suspend in progress to complete).
> 
> That's correct, but I also think that is what driver writers probably
> believe they are doing.  IOW, after a probe failure, the driver writer
> does indeed mean "don't do runtime PM on this device any more."  But
> they really mean "don't do runtime PM on this device *after* it's been
> powered down."
> 
> However, because of the get/put in the driver core, it's not entirely
> obvious to driver writers that calling pm_runtime_disable() actually
> keeps the device powered up, even though they just called _put_sync().
> 
> Another way of stating the problem is that the _put_sync() in the driver
> core's driver_probe_device() assumes that runtime PM is enabled for that
> device.
> 
> > That said, I'm not aware of any other generally reliable way to do that
> > either.  
> 
> That's what I was afraid of. :(
> 
> > The problem is, if .probe() is failing we don't have callbacks
> > allowing us to power manage the device (there may be bus type callbacks
> > knowing how to do that, but not for the platform bus type).
> 
> There are callbacks for the PM domains, but they are not called either
> if the driver calls pm_runtime_disable().

Oh, I think I see what the problem is.

> >> Removing it means the device is left in runtime suspended state even in
> >> the error case.  However, without the pm_runtime_disable(), if this
> >> driver was a module, repeated attempts to load would result in
> >> unbalalced calls to pm_runtime_enable.
> >> 
> >> What is the right way to handle the runtime PM enable/disable in a
> >> failed probe attempt?
> >
> > I would recommend using pm_runtime_disable() and then either
> > pm_runtime_set_active() or pm_runtime_set_suspended() depending on what the
> > real power state of the device is at this point.
> 
> That doesn't help because it only changes the runtime PM core's notion
> of the power state, not the physical power state because it doesn't call
> the subsystem callbacks.
> 
> Or, are you suggesting to set the state to suspended, and then use a
> late_initcall to compare the runtime status with the physical device
> status and power down devices accordingly?
> 
> > Anyway, you can't force the device into a low-power state using
> > runtime PM after a failing probe, at least in general.
> 
> Well, using PM domains, that's exactly what can happen if the driver
> doesn't call pm_runtime_disable() because the _put_sync() in the driver
> core will trigger the PM domain callbacks.

OK, so if you have PM domains, then the case is equivalent to having a bus
type with its own runtime PM callbacks.  In that case, if .probe() fails,
it obviously doesn't mean that the device shouldn't be power managed,
so the driver shouldn't call pm_runtime_disable().

Generally, if runtime PM was enabled for a device before .probe() has been
called, the driver shouldn't disable it in .probe() whatever the reason,
because it may not have enough information for deciding whether or not
runtime PM should be disabled.

Thanks,
Rafael
