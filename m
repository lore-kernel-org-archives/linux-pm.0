From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation considerations
Date: Mon, 16 Jul 2007 01:22:08 +0200
Message-ID: <200707160122.09840.rjw__23013.9098167003$1184541353$gmane$org@sisk.pl>
References: <200707151433.34625.rjw@sisk.pl> <200707160047.28420.rjw@sisk.pl>
	<Pine.LNX.4.64.0707151538130.25614@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707151538130.25614@asgard.lang.hm>
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
To: david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Monday, 16 July 2007 00:42, david@lang.hm wrote:
> On Mon, 16 Jul 2007, Rafael J. Wysocki wrote:
> 
> > On Sunday, 15 July 2007 22:13, david@lang.hm wrote:
> >> On Sun, 15 Jul 2007, Rafael J. Wysocki wrote:
> >>
> >>> Hi,
> >>>
> >>> Since many alternative approaches to hibernation are now being considered and
> >>> discussed, I thought it might be a good idea to list some things that in my not
> >>> so humble opinion should be taken care of by any hibernation framework.  They
> >>> are listed below, not in any particular order, because I think they all are
> >>> important.  Still, I might have forgotten something, so everyone with
> >>> experience in implementing hibernation, especially Pavel and Nigel, please
> >>> check if the list is complete.
> >>>
> >>> (1) Filesystems mounted before the hibernation are untouchable
> >>>
> >>>    When there's a memory snapshot, either in the form of a hibernation image,
> >>>    or in the form of the "old" kernel and processes available to the "new"
> >>>    kexeced kernel responsible for saving their memory, the filesystems mounted
> >>>    before the hibernation should not be accessed, even for reading, because
> >>>    that would cause their on-disk state to be inconsistent with the snapshot
> >>>    and might lead to a filesystem corruption.
> >>
> >> AFAIK this is only the case with ext3, all other filesystems could be
> >> accessed read-only safely
> >>
> >> this is arguably a bug with ext3 (and has been discussed as such), but
> >> right now the ext3 team has decided not to change this bahavior so
> >> hibernate needs to work around it. but don't mistake a work-around for a
> >> single (admittedly very popular) filesystem with a hard and fast
> >> directive.
> >>
> >>> (2) Swap space in use before the hibernation must be handled with care
> >>>
> >>>    If swap space is used for saving the memory snapshot, the snapshot-saving
> >>>    application (or kernel) must be careful enough not to overwrite swap pages
> >>>    that contain valid memory contents stored in there before the hibernation.
> >>
> >> true, in fact, given that many distros and live-CD's autodetect swap
> >> partitions and consider them fair game, I would argue that the best thing
> >> to do would be to have the main system free up it's swap partitions before
> >> going into hibernation.
> >>
> >> however, this could be a decision of the particular hibernate routines.
> >>
> >> for the kexec approach the mapping of what swap pages are in use is one
> >> more chunk of data that needs to be assembled and made available through a
> >> defined interface.
> >>
> >>> (4) The user should be able to limit the size of a hibernation image
> >>>
> >>>    There are a couple of reasons of that.  For example, the storage space
> >>>    used for saving the image may be smaller than the entire RAM or the user
> >>>    may want the image to be saved quickier.
> >>
> >> it may make sense for this to be split into hard and soft limits.
> >>
> >> if you try to save more then the storage space can hold you cannot
> >> continue, but if you are just a little over the arbatrary size limit that
> >> was set to make things fast you are better off saving things as-is then
> >> punting, going back to the system, trying to free more ram, and trying a
> >> hibernate again.
> >>
> >> with the kexec approach the enforcment of these limits is also split into
> >> two sections.
> >>
> >> when the hibernate command is given in the main kernel, it's userspace
> >> needs to follow some policy to decide how much (if any) memory to free.
> >
> > How are you going to achieve this without (a) having hibernation-aware
> > user space or (b) the freezer?
> 
> the hibernate command is a userspace command, but the fact that other 
> things in userspace are running at the same time is exactly why this is 
> only an estimate and best-effort as I said in the paragraph below.
> 
> >> but since the kexec command and the preporation of the devices can change
> >> the memory, the estimates done by the first kernel's userspace are just
> >> that, estimates.
> >>
> >>> (7) On ACPI systems special platform-related actions have to be carried out at
> >>>    the right points, so that the platform works correctly after the restore
> >>>
> >>>    The ACPI specification requires us to invoke some global ACPI methods
> >>>    during the hibernation and during the restore.  Moreover, the ordering of
> >>>    code related to these ACPI methods may not be arbitrary (eg. some of
> >>>    them have to be executed after devices are put into low power states etc.).
> >>
> >> for a pure hibernate mode, you will be powering off the box after saving
> >> the suspend image. why are there any special ACPI modes involved?
> >
> > Because, for example, on my machine the status of power supply (present
> > vs not present) is not updated correctly after the restore if ACPI callbacks
> > aren't used during the hibernation.  That's just experience and it's in line
> > with the ACPI spec.
> 
> so if a machine is actually powered off the /dev/suspend process won't 
> work?

No, it sort of works as usual, but after the restore the platform is not in the
correct state.

> remember that the system may run a different OS between the hibernate and 
> the resume, makeing any assumptions about what state the hardware is in 
> when you start the resume is a problem.

True, that's problematic.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
