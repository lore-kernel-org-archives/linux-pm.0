From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks
Date: Tue, 18 Mar 2008 11:01:06 +0100
Message-ID: <20080318100106.GA10830__22144.757587421$1205840974$gmane$org@elf.ucw.cz>
References: <200803170020.55473.rjw@sisk.pl> <200803170022.30345.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803170022.30345.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi!

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

> + * The externally visible transitions are handled with the help of the following
> + * callbacks included in this structure:
> + *
> + * @prepare: Prepare the device for the upcoming transition, but do NOT change
> + *	its hardware state.  Prevent new children of the device from being
> + *	registered and prevent new calls to the probe method from being made
> + *	after @prepare() returns.  Also, if a concurrent child registration
> + *	or a call to the probe method already in progress is detected by
> + *	@prepare(), it may return -EAGAIN, so that the PM core can execute it
> + *	once again (e.g. after suspending the newly registered child) to recover
> + *	from the race condition. This method is executed for all kinds of
> + *	suspend transitions and is immediately followed by one of the suspend
> + *	callbacks: @suspend(), @freeze(), @poweroff(), or @quiesce().
> + *
> + * @complete: Undo the changes made by @prepare().  This method is executed for
> + *	all kinds of resume transitions, immediately following one of the resume
> + *	callbacks: @resume(), @thaw(), @restore(), or @recover().  Also executed
> + *	if a suspend callback (@suspend(), @freeze(), @poweroff(), @quiesce())
> + *	immediately following a successful @prepare() fails OR if a new child
> + *	of the device has been registered during @prepare().

So... we do prepare() but it detects new child, so it returns -EAGAIN.
  so we call complete() based on description above
...and then we call prepare() to suspend again?

> + * @suspend: Executed before putting the system into a sleep state in which the
> + *	contents of main memory are preserved.  Quiesce the device, put it into

content....is?

> + * @resume: Executed after waking the system up from a sleep state in which the
> + *	contents of main memory were preserved.  Put the device into the

content...is?

> + * @freeze: Hibernation-specific, executed before creating a hibernation image.
> + *	Quiesce operations so that a consistent image can be created, but do NOT
> + *	otherwise put the device into a low power device state and do NOT emit
> + *	system wakeup events.  Save in main memory the device settings to be

"Save device settings (used by @restore()) into main memory"?

> + * @quiesce: Hibernation-specific, executed after loading a hibernation image
> + *	and before restoring the contents of main memory from it.  Quiesce
> + *	operations so that the contents of main memory can be restored from the

operations, so ?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/
