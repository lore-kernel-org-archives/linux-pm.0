From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] PCI: Runtime power management
Date: Fri, 14 Aug 2009 22:05:19 +0200
Message-ID: <200908142205.20093.rjw__29612.3913176872$1250280437$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908141032070.2987-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908141032070.2987-100000@iolanthe.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 14 August 2009, Alan Stern wrote:
> On Thu, 13 Aug 2009, Matthew Garrett wrote:
> 
> > On Thu, Aug 13, 2009 at 11:22:44AM -0400, Alan Stern wrote:
> >
> > > You have to call the HCD's pci_suspend method!  Not to mention calling
> > > synchronize_irq and all the other stuff in hcd_pci_suspend and
> > > hcd_pci_suspend_noirq.
> >
> > The bus level code does this, assuming that the driver-level code
> > doesn't return an error.
> 
> So it does; my mistake.
> 
> 
> On Fri, 14 Aug 2009, Matthew Garrett wrote:
> 
> > On Thu, Aug 13, 2009 at 10:47:01PM +0100, Matthew Garrett wrote:
> > 
> > > Ugh. I'd really prefer us to assume that drivers are able to cope unless 
> > > proven otherwise. Userspace policy makes sense where we don't have any 
> > > idea whether something will work or not, but I'd really expect that most 
> > > PCI drivers will either cope (in which case they'll have enabling code) 
> > > or won't (in which case they won't). Why would we want userspace to 
> > > influence this?
> > 
> > Though, thinking about it, you're right that setting this does override 
> > user policy. I think we need an additional flag to indicate that the 
> > device supports runtime wakeup and test that as well when doing 
> > device_may_wakeup().
> 
> You are suggesting separate flag sets for system-wide wakeup and
> runtime wakeup?  I don't disagree, but implementing them will be
> problematical.
> 
> That's because it's not always possible to change a device's wakeup 
> setting while it is suspended.  Thus if a device was runtime suspended 
> with wakeup enabled, and then we want to do a system sleep and change 
> the device's wakeup setting to disabled, we would have to wake the 
> device back up in order to do it.

Well, sometimes the user may want a device to be power managed at run time
and not to be able to wake up the system from sleep states.  For example,
I'd like the USB controller in my box to be suspended at run time whenever it's
not used, but surely I wouldn't like it to do system-wide wakeup, because it
does that when I move the mouse which is a cordless one.  Simply turning the
mouse on causes the system to wake up. :-)

So, I don't think we have a choice here.  If the user forbids the device to
wake up the system from sleep states, we have to do what he wants, even if
that means the devices has to be resumed before putting the system into a
sleep state.

Why don't we add a flag indicating whether or not the device is allowed to
be power managed at run time, something like runtime_forbidden, that the
user space will be able to set through sysfs?

If the user space does that, we can't power manage the device at run time,
so it can't do runtime wakeup as well.  Otherwise, the device is power
manageable at run time, which implies runtime wakeup if supported.

Thanks,
Rafael
