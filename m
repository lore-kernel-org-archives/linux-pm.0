From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] PM: Do not destroy/create devices while
	suspended
Date: Tue, 25 Dec 2007 13:33:20 +0100
Message-ID: <20071225123320.GA1670__23446.1223859855$1198586209$gmane$org@elf.ucw.cz>
References: <200712240155.14765.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0712241045150.25920-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0712241045150.25920-100000@netrider.rowland.org>
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
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2007-12-24 10:51:15, Alan Stern wrote:
> On Mon, 24 Dec 2007, Rafael J. Wysocki wrote:
> 
> > Hi,
> > 
> > Some device drivers register CPU hotplug notifiers and use them to destroy
> > device objects when removing the corresponding CPUs and to create these objects
> > when adding the CPUs back.
> > 
> > Unfortunately, this is not the right thing to do during suspend/hibernation,
> > since in that cases the CPU hotplug notifiers are called after suspending
> > devices and before resuming them, so the operations in question are carried
> > out on the objects representing suspended devices which shouldn't be
> > unregistered behing the PM core's back.  Although right now it usually doesn't
> > lead to any practical complications, it will predictably deadlock if
> > gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch is applied.
> > 
> > The solution is to prevent drivers from removing/adding devices from within
> > CPU hotplug notifiers during suspend/hibernation using the FROZEN bit
> > in the notifier's action argument.  The following three patches modify the
> > MSR, x86-64 MCE and cpuid drivers along these lines.
> 
> Do we need to worry about the possibility that when the system wakes up 
> from hibernation, the set of usable CPUs might be smaller than it was 
> beforehand?  Is any special handling needed for this, or is it already 
> accounted for?

That should not happen... but it does in some error cases.... so
handling it would be a bonus.

Waking up with one cpu out of 8 is bad, but still way better than not
waking up at all ;-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
