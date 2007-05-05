From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Sat, 5 May 2007 12:19:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705051216490.1976-100000@netrider.rowland.org>
References: <200705042324.24104.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705042324.24104.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Fri, 4 May 2007, Rafael J. Wysocki wrote:

> > > Entering hibernation basically involves these steps:
> > > 
> > > 	1. Freeze tasks
> > > 
> > > 	2. Quiesce devices and drivers
> > > 
> > > 	3. Create snapshot
> > > 
> > > 	4. Reactivate devices and drivers
> > > 
> > > 	5. Save snapshot to disk
> > > 
> > > 	6. Prepare devices for wakeup
> > > 
> > > 	7. Power down (ACPI S4 on systems which support it)
> > > 
> > > Leaving hibernation involves a similar sequence which I won't discuss.
> > > 
> > > Notice that steps 1-5 above are _completely_ independent of all issues 
> > > concerning wakeup devices and S4 vs. S5 vs. whatever.  They have to
> > > be
> > 
> > No, they are not. You probably should tell ACPI at step 2 that you are
> > suspending,

At step 2 you don't _know_ that you are suspending!  Step 5 might fail.  
You should tell ACPI during step 6 or 7.

> You can, but even if you don't, the BIOS shouldn't have problems.  What might
> have problems is our ACPI code during the resume, if it cannot get appropriate
> information from the BIOS.
> 
> > and you definitely need to tell ACPI that you have resumed 
> > (so it can re-scan AC adapters, for example).
> 
> Yes, but that can be done in two different ways:
> 
> 1) "We have restored the hibernation image, but the BIOS state corresponds to
> a fresh reboot, so please initialize everything from scratch."
> 
> 2) "We have restored the hibernation image and the ACPI S4 was used for
> powering off (hint: you may try not to initialize everything from scratch)."
> 
> Of course, in the case 2) we are responsible for ensuring that the contents of
> the hibernation image are consistent with the information preserved by the
> BIOS.

Keep in mind also that before you can do either 1) or 2), the boot kernel 
has already communicated with the BIOS, possibly changing some of the ACPI 
state.

Alan Stern
