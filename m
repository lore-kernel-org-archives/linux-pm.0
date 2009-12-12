From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: System sleep vs. runtime PM
Date: Sat, 12 Dec 2009 18:33:37 +0100
Message-ID: <200912121833.37563.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912121004220.10105-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912121004220.10105-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 12 December 2009, Alan Stern wrote:
> Rafael:

Hi,

> What should happen during system wakeup if a device was
> runtime-suspended when the sleep began?
> 
> Although there are circumstances where the device could remain
> suspended, on the whole it seems a lot safer and easier always to go
> back to full power.

I think we should do this, at least to start with.  For things like PCI there's
no other choice really, because we usually get pully powered devices from
the BIOS.

> Certainly it's necessary during the RESTORE phase
> of hibernation, because then the device's physical state is unknown.  
> And even during the RESUME phase of system suspend, the firmware could
> have made some unwelcome changes to the device.  In the THAW phase of
> hibernation it may not be necessary -- but consider the disk drive
> that will be used for storing the memory image.  If it was
> runtime-suspended then it will need a runtime-resume, and it will
> probably have to use an async pm_request_resume() call, but the PM
> workqueue will be frozen so nothing will happen.  Not to mention all
> the issues involved with remote wakeup.
> 
> So okay.  This should be mentioned in the documentation since it is
> important, especially for drivers that have different pathways for
> system resume and runtime resume.

Agreed.

> This means that when a driver's system-resume routine is finished, the
> device will be at full power and so dev->power.runtime_status needs to
> be changed to RPM_ACTIVE.  Hence a runtime-PM-aware driver will have to
> do something like:
> 
> 	pm_runtime_disable(dev);
> 	pm_runtime_set_active(dev);
> 	pm_runtime_enable(dev);
> 
> in its system-resume routine.

Unless it does runtime resume during system suspend, that is.

> There probably should be a function in the PM core to encapsulate this.

Very likely, but I'd defer introducing all of these helper functions to the
when somebody really needs them, ie. introduce them along with the first
user.

> Whether there is or not, drivers must know to do it so it should be mentioned
> in the documentation.  (The PM core can't do it automatically, because it
> would mess up drivers that aren't runtime-PM-aware.)

Agreed.

> Also, when the system resume is finished, drivers need a chance to 
> runtime-suspend again.  Hence the pm_runtime_put_noidle() call in 
> dpm_complete() should be changed to pm_runtime_put_sync().

OK

Are you going to send a patch or do you want me to prepare one?

Rafael
