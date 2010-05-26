From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Wed, 26 May 2010 12:56:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005261248060.1328-100000__24470.5253317536$1274893706$gmane$org@iolanthe.rowland.org>
References: <20100526160002.GA6242@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100526160002.GA6242@srcf.ucam.org>
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

> On Wed, May 26, 2010 at 11:51:12AM -0400, Alan Stern wrote:
> 
> (leaving the wakeup stuff to Rafael for the moment...)
> 
> > Another question...  The PCI core doesn't call pm_runtime_enable() or
> > pci_runtime_set_active() anywhere.  Apparently this is left up to the
> > individual device driver.  But shouldn't the core take this
> > responsibility?  What happens to PCI devices for which there is no
> > driver?  Shouldn't the core put them into runtime suspend by default?
> 
> This is problematic in the GPU case, at least, since there are still 
> many that get driven by userspace rather than by the kernel.

I don't know how that works.  However an easy approach would be to make
opening the device file (or however the userspace driver gets a
reference to the device) cause the core to do a pm_runtime_get_sync(),
with a corresponding pm_runtime_put_sync() when the file is closed.

Alan Stern
