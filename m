From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB suspend and resume for PCI host controllers
Date: Thu, 11 Dec 2008 10:00:47 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812110947540.2526-100000__36786.6575871178$1229007839$gmane$org@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0812101709260.2082-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0812101709260.2082-100000@iolanthe.rowland.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 10 Dec 2008, Alan Stern wrote:

> On Wed, 10 Dec 2008, Rafael J. Wysocki wrote:
> 
> > > > Well, it looks like you forgot to actually call pci_save_power_state(). :-)
> > > 
> > > I didn't forget it -- in my tree there is no such function!  :-)
> > 
> > That should have been pci_save_state(). [Note to self: don't send email when
> > you're too tired.]
> 
> Yes, adding pci_save_state() fixed the problem.  Here is the new patch;  
> it seems to work.  Anything else need to be changed?

I spoke a little too soon.  It appears that there is a small bug in 
pci_enable_wake():

int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
{
	int error = 0;
	bool pme_done = false;

	if (!device_may_wakeup(&dev->dev))
		return -EINVAL;

This is wrong; the test should be:

	if (enable && !device_may_wakeup(&dev->dev))

Alan Stern
