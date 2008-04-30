From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup()
 policy inputs
Date: Wed, 30 Apr 2008 09:58:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804300950460.2432-100000__32646.2767007344$1209564156$gmane$org@iolanthe.rowland.org>
References: <200804291638.30469.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804291638.30469.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 29 Apr 2008, David Brownell wrote:

> > Indeed, it's easy to imagine a situation where somebody suspends their 
> > laptop and then unplugs a USB mouse, thereby causing a wakeup event.
> 
> It's also easy to imagine getting used to unplugging
> such devices *first* ... :)

Maybe.  But people aren't likely to unplug the mouse first if
suspending the laptop is done by clicking on a "Suspend" button.  :-)

Or consider the case of a flash drive with a mounted filesystem.  You 
can't safely unplug it before suspending, but you can safely unplug it 
after suspending (provided you remember to plug it back in before 
resuming).

Besides, people will complain that the [insert your choice] operating 
system doesn't make them remember to unplug USB devices before 
suspending, so why should Linux?

> > I suspect many PCI devices should be disabled for remote wakeup during 
> > system sleeps.
> 
> I wouldn't say that it's "PCI devices".  Remember, these
> patches only change ACPI behavior ... making it act more
> like non-ACPI systems.  If there's any change, in defaults
> it should not be a global "for all PCI devices" one ... it
> should be limited (and temporary!) for some ACPI devices.

I wasn't talking about defaults; I was talking about the settings 
people will find most useful.

> The situation is that *currently* ACPI is configured so
> that it's acts unlike non-ACPI systems:  wakeup isn't
> enabled.  And in at least some systems, it doesn't work
> when it's enabled either.
> 
> One can argue about how to deal with that breakage.  It
> seems likely to me that -- since this ACPI wakeup code
> has hardly ever been used on Linux -- using it will turn
> up bugs in the ACPI stack.  At which point a significant
> question is:  how are those bugs ever going to be found
> and fixed, if ACPI never actually turns on its wakeup
> mechanisms?

None of this is in dispute.

I'm simply pointing out that until common userspace tools are available
to change the wakeup behavior from the default "Always on if it's
available", people will run into problems and complain about
"regressions".

Alan Stern
