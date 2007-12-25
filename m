From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] PM: Do not destroy/create devices while
	suspended
Date: Tue, 25 Dec 2007 17:21:41 +0100
Message-ID: <200712251721.42233.rjw__23369.4005561576$1198598596$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0712241045150.25920-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0712241045150.25920-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 24 of December 2007, Alan Stern wrote:
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
> beforehand?

This is possible in error conditions.

> Is any special handling needed for this, or is it already accounted for?

Hm, well.  The cleanest thing would be to allow the drivers to remove the
device objects on CPU_UP_CANCELED_FROZEN, which means that we weren't able to
bring the CPU up during a resume, but still that will deadlock with
gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch.

Greetings,
Rafael
