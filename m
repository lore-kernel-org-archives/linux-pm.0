From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 9/10] sh: Use struct syscore_ops instead of
	sysdev class and sysdev
Date: Tue, 22 Mar 2011 23:04:20 +0900
Message-ID: <20110322140420.GA24004__6983.11445671624$1300802868$gmane$org@linux-sh.org>
References: <201103100131.58206.rjw@sisk.pl>
	<201103131403.49561.rwys@fuw.edu.pl>
	<20110317082016.GB13315@linux-sh.org>
	<201103190147.28001.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103190147.28001.rjw@sisk.pl>
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
Cc: Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 19, 2011 at 01:47:27AM +0100, Rafael J. Wysocki wrote:
> On Thursday, March 17, 2011, Paul Mundt wrote:
> > On Sun, Mar 13, 2011 at 02:03:49PM +0100, R. J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Convert the SuperH clocks framework and shared interrupt handling
> > > code to using struct syscore_ops instead of a sysdev classes and
> > > sysdevs for power managment.
> > > 
> > > This reduces the code size significantly and simplifies it.  The
> > > optimizations causing things not to be restored after creating a
> > > hibernation image are removed, but they might lead to undesirable
> > > effects during resume from hibernation (e.g. the clocks would be left
> > > as the boot kernel set them, which might be not the same way as the
> > > hibernated kernel had seen them before the hibernation).
> > > 
> > > This also is necessary for removing sysdevs from the kernel entirely
> > > in the future.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > This misses the use of the sysdev class by the userimask code, though I'm
> > open to suggestions for alternatives.
> 
> For now, I'd simply move the sysdev class definition to userimask.c, like
> in the patch below.  The current goal is to eliminate the suspend/resume and
> shutdown operations from sysdevs (and sysdev drivers), the next step will
> be to replace the remaining sysdevs with alternative mechanisms.
> 
It's not quite that straightforward, you've also killed off the name
attribute for each of the intc sysdevs, so we no longer have a visible
way to map a given intc controller number to the controller name in a
user visible way.

I'm not opposed to the syscore thing for suspend/resume ops, but I'm not
willing to trash the userimask and name mapping interface in the process
with no alternatives.

userimask was the first global configuration item I added, but there are
other per-controller and global configuration knobs that I plan to export
through the interface, so there really needs to be a compelling reason
for moving off of sysdevs.
