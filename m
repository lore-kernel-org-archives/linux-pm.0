From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 23:23:50 +0200
Message-ID: <200707172323.51702.rjw__18514.0296853662$1184707122$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707171416120.3728-100000@iolanthe.rowland.org>
	<200707172217.01890.rjw@sisk.pl>
	<Pine.LNX.4.64.0707171328450.2467@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707171328450.2467@asgard.lang.hm>
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

On Tuesday, 17 July 2007 22:34, david@lang.hm wrote:
> On Tue, 17 Jul 2007, Rafael J. Wysocki wrote:
> 
> > On Tuesday, 17 July 2007 20:32, Alan Stern wrote:
> >
> >> I'm still not entirely clear on how "suspend-to-both" ought to be
> >> handled.  Presumably it will start off as a normal hibernation.  But
> >> instead of shutting down, wouldn't the kexec'd kernel return to the
> >> original kernel?
> >
> > No, I think the image-saving kernel should suspend.  Then, on resume the
> > platform will go back to it and it will jump back to the hibernated kernel.
> >
> >> After all, the original kernel knows about all the devices and can put them
> >> into a low-power state, while the kexec'd kernel might not have sufficient
> >> information.
> >
> > That's correct, but ...
> >
> >> But what about the freezer?  The original reason for using kexec was to
> >> avoid the need for the freezer.  With no freezer, while the original
> >> kernel is busy powering down its devices, user tasks will be free to
> >> carry out I/O -- which will make the memory snapshot inconsistent with
> >> the on-disk data structures.
> >
> > ... we can't return to the hibernated kernel unless we are going to cancel the
> > hibernation.
> 
> this is where we disagree.
> 
> why not? if all that the hibernated kernel does is to suspend-to-ram and 
> makes no changes to disks or TCP connections anything that it does do 
> would be lost if power were to fail and you instead did a restore from 
> disk.

How do you guarantee that no tasks are scheduled when you get back to the
hibernated kernel?

> there is only a problem if something takes place that would prevent the 
> restore-from-disk from working. if this is done in a non-ACPI way that 
> will work across a power cycle you don't have to worry about the hardware 
> state not matching anyway.
> 
> > That's why I think that for the suspend-to-both the image-saving kernel will
> > need to support the same set of devices as the hibernated kernel.
> 
> suspend-to-both doesn't really make sense if the suspend-to-disk portion 
> is useing the ACPI S4 mode.

Well, not exactly.  If your battery runs out of power while you're suspended,
but you have the image saved, it's still better to restore from the image, even
if something may not work correctly after the restore, than to risk a loss of
data.

> if you don't run out of power you will restore-from-ram
> 
> if you do run out of power the restore-from-disk won't work either becouse 
> devices are not in the right ACPI states.

See above.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
