From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Fri, 21 Sep 2007 17:27:34 +0200
Message-ID: <200709211727.34867.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0709211040201.4167-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0709211040201.4167-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, huang ying <huang.ying.caritas@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Friday, 21 September 2007 16:45, Alan Stern wrote:
> [CC: list trimmed]
> 
> On Fri, 21 Sep 2007, Rafael J. Wysocki wrote:
> 
> > Well, the problem is that apparently some systems (eg. my HP nx6325) expect us
> > to execute the _PTS ACPI global control method before creating the image _and_
> > to execute acpi_enter_sleep_state(ACPI_STATE_S4) in order to finally put the
> > system into the sleep state.  In particular, on nx6325, if we don't do that,
> > then after the restore the status of the AC power will not be reported
> > correctly (and if you replace the battery while in the sleep state, the
> > battery status will not be updated correctly after the restore).  Similar
> > issues have been reported for other machines.
> > 
> > Now, the ACPI specification requires us to put devices into low power states
> > before executing _PTS and that's exactly what we're doing before a suspend to
> > RAM.  Thus, it seems that in general we need to do the same for hibernation on
> > ACPI systems.
> 
> I'm confused.  You seem to be saying that for hibernation the required 
> sequence of steps is:
> 
> 	1. Put devices into low-power states
> 	2. Execute _PTS method
> 	3. Create and write out the image
> 	4. Execute acpi_enter_sleep_state()
> 
> Am I missing something -- a step to put devices back in their 
> full-power states before writing out the image?  After all, you can't 
> write an image if the disk drive isn't at full power.

Well, of course we put devices into the full power states in order to create
the image and we put them back into low power states (or switch them off,
depending on the kernel version) before executing
acpi_enter_sleep_state(ACPI_STATE_S4).

However, all of that seems to be irrelevant for the above problem.  Namely, it
follows from my tests that if we don't execute _PTS before creating the image
or we don't use acpi_enter_sleep_state(ACPI_STATE_S4) to finally go to sleep,
the system will be semi-functional after the restore and the steps done in
between don't actually matter.

> Also, how exactly does this conflict with the requirements of the 
> kexec-based approach?

I'm not sure whether or not this really conflicts with them, but the point is
that if we have to put devices into low power states before executing _PTS,
which is exactly what we do before a suspend to RAM, then separate
hibernation methods for device drivers are not needed (*).

> At what point in the above sequence would the kexec call be made?

I think that kexec would have to be made after executing _PTS and
acpi_enter_sleep_state(ACPI_STATE_S4) would have to be called by the
image-saving kernel.

However, I think that what we really should be doing is to:

1) put devices into low power states
2) execute _PTS
3) create the image
4) resume _only_ those devices that are needed to save the image
5) save the image
6) finalize the transition to the sleep state

(please note that I've omitted some details, like the handling of the nonboot
CPUs etc., which are difficult by themselves, but don't seem to be relevant
here).

(*) I think we'll need some hibernation-specific methods in order to carry out
step 4) above, ie. to resume devices needed for saving the image.

Greetings,
Rafael
