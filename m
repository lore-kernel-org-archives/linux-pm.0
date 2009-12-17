From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Thu, 17 Dec 2009 02:30:24 +0100
Message-ID: <200912170230.24147.rjw__26684.6753810116$1261013553$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912161753540.2643-100000@iolanthe.rowland.org>
	<200912170018.05175.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912170018.05175.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 17 December 2009, Rafael J. Wysocki wrote:
> On Thursday 17 December 2009, Alan Stern wrote:
> > On Wed, 16 Dec 2009, Rafael J. Wysocki wrote:
> > 
> > > I've just put the first set of data, for the HP nx6325 at:
> > > http://www.sisk.pl/kernel/data/nx6325/
> > >  
> > > The *-dmesg.log files contain full dmesg outputs starting from a cold boot and
> > > including one suspend-resume cycle in each case, with debug_initcall enabled.
> > > 
> > > The *-suspend.log files are excerpts from the *-dmesg.log files containing
> > > the suspend messages only, and analogously for *-resume.log.
> > 
> > I've just started looking at the sync-suspend.log file.  What are all 
> > the '+' characters and " @ 3368" strings after the device names?
> 
> I think the + is necessary for the Arjan's graph-generating script and the
> @ number is the value of current (ie. the PID of the calling task).
> 
> > You didn't print out the parent name for each device, so the tree 
> > structure has been lost.
> 
> That's because the original Arjan's patch doesn't do that, I'm adding it
> right now.
> 
> > Why do those "sd 0:0:0:0 [sda]" messages appear in between two 
> > callbacks?  The cache-synchronization and the spin-down commands are
> > not executed asynchronously.
> 
> Because the data are incomplete.  :-(
> 
> I've just realized that the Arjan's patch only covers bus types and classes
> that have been converted to dev_pm_ops already, so I'm extending it to the
> "legacy" ones at the moment.

New data files have been uploaded to:

http://www.sisk.pl/kernel/data/nx6325/
http://www.sisk.pl/kernel/data/wind/

Please let me know if you need more information.

Rafael
