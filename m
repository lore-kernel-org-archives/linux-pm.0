From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] PCI: Runtime power management
Date: Fri, 14 Aug 2009 10:43:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908141032070.2987-100000__36122.2461135641$1250261092$gmane$org@iolanthe.rowland.org>
References: <20090814123059.GA27995@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090814123059.GA27995@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pci@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-usb@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Aug 2009, Matthew Garrett wrote:

> On Thu, Aug 13, 2009 at 11:22:44AM -0400, Alan Stern wrote:
>
> > You have to call the HCD's pci_suspend method!  Not to mention calling
> > synchronize_irq and all the other stuff in hcd_pci_suspend and
> > hcd_pci_suspend_noirq.
>
> The bus level code does this, assuming that the driver-level code
> doesn't return an error.

So it does; my mistake.


On Fri, 14 Aug 2009, Matthew Garrett wrote:

> On Thu, Aug 13, 2009 at 10:47:01PM +0100, Matthew Garrett wrote:
> 
> > Ugh. I'd really prefer us to assume that drivers are able to cope unless 
> > proven otherwise. Userspace policy makes sense where we don't have any 
> > idea whether something will work or not, but I'd really expect that most 
> > PCI drivers will either cope (in which case they'll have enabling code) 
> > or won't (in which case they won't). Why would we want userspace to 
> > influence this?
> 
> Though, thinking about it, you're right that setting this does override 
> user policy. I think we need an additional flag to indicate that the 
> device supports runtime wakeup and test that as well when doing 
> device_may_wakeup().

You are suggesting separate flag sets for system-wide wakeup and
runtime wakeup?  I don't disagree, but implementing them will be
problematical.

That's because it's not always possible to change a device's wakeup 
setting while it is suspended.  Thus if a device was runtime suspended 
with wakeup enabled, and then we want to do a system sleep and change 
the device's wakeup setting to disabled, we would have to wake the 
device back up in order to do it.


> > > This misses the point.  The whole idea of runtime_idle is to tell you 
> > > that the device is idle and might be ready to be suspended.  If you're 
> > > going to call pm_schedule_suspend anyway, there's no reason to invoke 
> > > pm->runtime_idle.
> > 
> > My understanding of the API was that pm_device_put() invokes 
> > runtime_idle if the refcount hits 0. The bus layer has no idea of the 
> > refcount, and calling suspend directly from the driver would defeat the 
> > point of the system-wide recounting.
> 
> From the API docs:
> 
> "The action performed by a bus type's ->runtime_idle() callback is 
> totally dependent on the bus type in question, but the expected and 
> recommended action is to check if the device can be suspended (i.e. if 
> all of the conditions necessary for suspending the device are satisfied) 
> and to queue up a suspend request for the device in that case."
> 
> Though perhaps the device level runtime_idle shouldn't be void - that 
> way the bus can ask the driver whether its suspend conditions have been 
> satisfied? Right now there doesn't seem to be any way for the bus to ask 
> that.

If you want to get the device-level runtime_idle involved, you can make
_it_ responsible for scheduling the suspend.  Then the bus-level code
simply has to check whether everything is okay at the bus level, and if
it is, call the device-level routine.

However changing the return type wouldn't hurt anything, and it would 
allow the pm_schedule_suspend call to be centralized in the bus code.  
You could ask Rafael about it, or just send him a patch.

Alan Stern
