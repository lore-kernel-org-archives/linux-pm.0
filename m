From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Tue, 1 Jun 2010 10:59:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006011055440.2949-100000__27831.9543031559$1275404411$gmane$org@iolanthe.rowland.org>
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

Can we rely on the forbid/allow mechanism?  If userspace never allows 
runtime suspend for devices like the video controller then there's no 
problem.  Conversely, if a PCI device really doesn't have a driver and 
isn't used for anything, then by default it should go into a lower 
power state if userspace allows this.

I admit this is a slightly brittle solution, in that it depends on 
userspace not doing the wrong thing.  But the default (runtime PM 
forbidden) is always safe.

Alan Stern
