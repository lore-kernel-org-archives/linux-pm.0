From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI PM: Restore the 2.6.24 suspend ordering
Date: Sun, 30 Mar 2008 15:15:32 +0200
Message-ID: <200803301515.33922.rjw__6355.70589588514$1206883082$gmane$org@sisk.pl>
References: <200803300319.08398.rjw@sisk.pl> <200803301358.39831.rjw@sisk.pl>
	<20080330122838.GA7093@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080330122838.GA7093@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, LKML <linux-kernel@vger.kernel.org>, Arthur Erhardt <erhardt@pit.physik.uni-tuebingen.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Felix =?iso-8859-1?q?M=F6ller?= <fm@opensuse.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 30 of March 2008, Pavel Machek wrote:
> Hi!

Hi,

> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > Some time ago it turned out that our suspend code ordering broke
> > > > some NVidia-based systems that hung if _PTS was executed with one of
> > > > the PCI devices, specifically a USB controller, in a low power state.
> > > > Then, it was noticed that the suspend code ordering was not compliant
> > > > with ACPI 1.0, although it was compliant with ACPI 2.0 (and later),
> > > > and it was argued that the code had to be changed for that reason
> > > > (ref. http://bugzilla.kernel.org/show_bug.cgi?id=9528).  So we did,
> > > > but evidently we did wrong, because it's now turning out that some
> > > > systems have been broken by this change (refs.
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=10340 ,
> > > > https://bugzilla.novell.com/show_bug.cgi?id=374217#c16).  [I said
> > > > at that time that something like this might happend, but the majority
> > > > of people involved thought that it was improbable due to the
> > > > necessity to preserve the compliance of hardware with ACPI 1.0.]
> > > > This actually is a quite serious regression from 2.6.24.
> > > > 
> > > > Moreover, the ACPI 1.0 ordering of suspend code introduced another
> > > > issue that I have only noticed recently.  Namely, if the suspend of
> > > > one of devices fails, the already suspended devices will be resumed
> > > > without executing _WAK before, which leads to problems on some
> > > > systems (for example, in such situations thermal management is
> > > > broken on my HP nx6325).  Consequently, it also breaks suspend
> > > > debugging on the affected systems.
> > > > 
> > > > Note also, that the requirement to execute _PTS before suspending
> > > > devices does not really make sense, because the device in question
> > > > may be put into a low power state at run time for a reason unrelated
> > > > to a system-wide suspend.
> 
> Yes, but if we are putting them into lowpower state ourselves, we
> should probably be doing that "by hand", without calling acpi
> methods. _PTS may prepare something for acpi methods (which tell us
> which PCI Dx state to put the device in at the very least).

I meant "the requirement to execute _PTS before suspending devices, because
it would hang otherwise".

> > > > For the reasons outlined above, the change of the suspend ordering
> > > > should be reverted, which is done by the patch below.
> > > 
> > > But this will break those few nvidia-based systems, no?
> > > 
> > > this may have been a good idea in -rc1 days, but we are in -rc7
> > > now... and the patch is slightly big.
> > 
> > It's quite obvious, though.
> 
> Yes, but breaking systems between -rc7 and final is _very_ unnice.

Breaking systems between 2.6.24 and 2.6.25 is even worse, which is why
I've posted this patch.

IOW, we tried to fix systems that were broken with 2.6.24, but it didn't work,
because our "fix" broke systems that were OK with 2.6.24.  Solution: revert
the "fix" and go back to the design board.  That's all we can do so late in
the release cycle, IMO.

> > > What about something like: (hand-edited patch, sorry)
> > 
> > Well, I think that would be confusing.
> > 
> > The NVidia systems are broken anyway on 2.6.24.x, so we just don't fix them
> > rather than break them and there are more reasons to do what the patch does
> > (as pointed out in the changelog).  For example, your suggested patch doesn't
> >  fix the error paths/debugging breakage described in the changelog.
> 
> But that should not be impossible to fix, right?

No, it shouldn't, but it would be more complicated than it seemed to be.

> > I think we _can_ do something about the failing NVidia systems in the 2.6.26
> > time frame, but that will require some more consideration.
> 
> We could simply blacklist them, no?

Yes, but for this purpose we'll have to redesign the core so that everything
(including debugging and the error paths) works if _PTS is executed before
suspending devices.  _That_, however, is not a 2.6.25 thing.

Thanks,
Rafael
