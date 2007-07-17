From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 22:17:00 +0200
Message-ID: <200707172217.01890.rjw__15482.0098927759$1184703121$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707171416120.3728-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707171416120.3728-100000@iolanthe.rowland.org>
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
Cc: david@lang.hm, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 17 July 2007 20:32, Alan Stern wrote:
> On Tue, 17 Jul 2007, Rafael J. Wysocki wrote:
> 
> > I'm afraid of one thing, though.
> > 
> > If we create a framework without ACPI (well, ACPI needs to be enabled in the
> > kernel anyway for other reasons, like the ability to suspend to RAM) and then
> > it turns out that we have to add some ACPI hooks to it, that might be difficult
> > to do cleanly.
> > 
> > Thus, it seems reasonable to think of the ACPI handling in advance.
> 
> Absolutely.  This needs to be done in such a way that it will work:
> 
> 	On platforms without ACPI;
> 
> 	On platforms with ACPI where we do a non-ACPI type of shutdown
> 	to whatever extent it is possible (or perhaps an ACPI-aware
> 	shutdown rather than change to S4);
> 
> 	On platforms with ACPI where we do an ACPI-aware transition
> 	to S4.
> 
> Rafael, for those of us who aren't thoroughly familiar with all the ins
> and outs of the ACPI spec, could you please summarize a list of the
> ACPI calls needed in the second and third cases above?  Indicate which
> ones need to be done from within the original kernel and which should
> be done from within a kexec'd hibernation kernel.

Sure.

In the third case (ie. transition to S4) we are supposed to do the following:

(1) Upon entering the sleep state, which IMO can be done _after_ the image
    has been saved:
  * figure out which devices can wake up
  * put devices into low power states (wake-up devices are placed in the Dx
    states compatible with the wake capability, the others are powered off)
  * execute the _PTS global control method
  * switch off the nonlocal CPUs (eg. nonboot CPUs on x86)
  * execute the _GTS global control method
  * set the GPE enable registers corresponding to the wake-up devices)
  * make the platform enter S4 (there's a well defined procedure for that)
  I think that this should be done by the image-saving kernel.

(2) Upon start-up (by which I mean what happens after the user has pressed
    the power button or something like that):
  * check if the image is present (and valid) _without_ enabling ACPI (we don't
    do that now, but I see no reason for not doing it in the new framework)
  * if the image is present (and valid), load it
  * turn on ACPI (unless already turned on by the BIOS, that is)
  * execute the _BFS global control method
  * execute the _WAK global control method
  * continue
  Here, the first two things should be done by the image-loading kernel, but
  the remaining operations have to be carried out by the restored kernel.

In the remaining two cases we generally don't need to bother with the global
ACPI handling.

> I'm still not entirely clear on how "suspend-to-both" ought to be
> handled.  Presumably it will start off as a normal hibernation.  But
> instead of shutting down, wouldn't the kexec'd kernel return to the
> original kernel?

No, I think the image-saving kernel should suspend.  Then, on resume the
platform will go back to it and it will jump back to the hibernated kernel.

> After all, the original kernel knows about all the devices and can put them
> into a low-power state, while the kexec'd kernel might not have sufficient
> information.

That's correct, but ...

> But what about the freezer?  The original reason for using kexec was to
> avoid the need for the freezer.  With no freezer, while the original
> kernel is busy powering down its devices, user tasks will be free to
> carry out I/O -- which will make the memory snapshot inconsistent with
> the on-disk data structures.

... we can't return to the hibernated kernel unless we are going to cancel the
hibernation.

That's why I think that for the suspend-to-both the image-saving kernel will
need to support the same set of devices as the hibernated kernel.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
