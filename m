From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Thu, 3 May 2007 15:59:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705031556150.7259-100000@iolanthe.rowland.org>
References: <200705032147.31370.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705032147.31370.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 May 2007, Rafael J. Wysocki wrote:

> > This suggests that the poweroff methods be completely independent of
> > hibernation_ops (or whatever you are now calling it).  Perhaps there
> > should be a separate sysfs attribute controlling whether or not wakeup is
> > enabled.  If it is then poweroff should go through all the ACPI (or the
> > platform's equivalent) hoops, otherwise everything should just be turned
> > off completely.  Regardless of whether the poweroff is part of a
> > hibernate sequence.
> 
> Well, after reviewing the code once again I see that we already do it this
> way on ACPI systems, since the 'normal' power off is done by entering the
> ACPI S5 state.  Moreover, there shouldn't be any difference between
> ACPI S4 and 'power off' with respect to the wake-up devices, so you're
> absolutely right.
> 
> It seems, though, that we need to do acpi_enter_sleep_state(ACPI_STATE_S4)
> to finish the hibernation in order to avoid problems like (*) and for this purpose
> we need to use hibernation_ops earlier during the hibernation.

But why shouldn't a "normal" poweroff enter ACPI S4?  And why shouldn't a 
"hibernate" poweroff enter ACPI S5?  The choice of which state to enter is 
independent of the reason for shutting down, right?

In other words, the choice for whether or not to call
acpi_enter_sleep_state(ACPI_STATE_S4) shouldn't depend on whether or not 
you're hibernating.  So it shouldn't affect the usage of hibernation_ops 
at all.

Alan Stern
