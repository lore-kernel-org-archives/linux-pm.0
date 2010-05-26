From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Wed, 26 May 2010 14:00:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005261352440.1328-100000__21645.4157060527$1274896938$gmane$org@iolanthe.rowland.org>
References: <20100526165748.GA7965@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100526165748.GA7965@srcf.ucam.org>
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
Cc: linux-pci@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010, Matthew Garrett wrote:

> On Wed, May 26, 2010 at 12:56:33PM -0400, Alan Stern wrote:
> 
> > I don't know how that works.  However an easy approach would be to make
> > opening the device file (or however the userspace driver gets a
> > reference to the device) cause the core to do a pm_runtime_get_sync(),
> > with a corresponding pm_runtime_put_sync() when the file is closed.
> 
> No, X is far worse than you think. It's handled by mmap()ping /dev/mem.

Ugh.

Well, we still need some sort of map for how this will work, otherwise 
things will quickly get messed up.

Is it necessary to stick to a policy that _all_ unbound PCI devices 
must be active?  Even those which were bound to a driver and then 
unbound?

Is there some way for the core to tell which devices will be handled by
X, so that all others can be runtime suspended?

When a PCI driver's probe routine is called, it shouldn't need to call
pm_runtime_set_active() or pm_runtime_enable().  The core should take
care of this before the device is registered.  One reasonably design
would be to make PM-aware drivers responsible for doing an initial
pm_runtime_put_sync() in order to allow their devices to suspend (plus 
a corresponding pm_runtime_get_sync() in the release method).

Alan Stern
