From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Fri, 21 Sep 2007 10:45:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0709211040201.4167-100000@iolanthe.rowland.org>
References: <200709211631.19130.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709211631.19130.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, huang ying <huang.ying.caritas@gmail.com>
List-Id: linux-pm@vger.kernel.org

[CC: list trimmed]

On Fri, 21 Sep 2007, Rafael J. Wysocki wrote:

> Well, the problem is that apparently some systems (eg. my HP nx6325) expect us
> to execute the _PTS ACPI global control method before creating the image _and_
> to execute acpi_enter_sleep_state(ACPI_STATE_S4) in order to finally put the
> system into the sleep state.  In particular, on nx6325, if we don't do that,
> then after the restore the status of the AC power will not be reported
> correctly (and if you replace the battery while in the sleep state, the
> battery status will not be updated correctly after the restore).  Similar
> issues have been reported for other machines.
> 
> Now, the ACPI specification requires us to put devices into low power states
> before executing _PTS and that's exactly what we're doing before a suspend to
> RAM.  Thus, it seems that in general we need to do the same for hibernation on
> ACPI systems.

I'm confused.  You seem to be saying that for hibernation the required 
sequence of steps is:

	1. Put devices into low-power states
	2. Execute _PTS method
	3. Create and write out the image
	4. Execute acpi_enter_sleep_state()

Am I missing something -- a step to put devices back in their 
full-power states before writing out the image?  After all, you can't 
write an image if the disk drive isn't at full power.

Also, how exactly does this conflict with the requirements of the 
kexec-based approach?  At what point in the above sequence would the 
kexec call be made?

Alan Stern
