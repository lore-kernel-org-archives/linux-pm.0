From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Hibernation considerations
Date: Sun, 15 Jul 2007 12:29:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707151220570.24011-100000__19910.9329296791$1184517016$gmane$org@netrider.rowland.org>
References: <200707151810.33554.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707151810.33554.a1426z@gawab.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Al Boldi <a1426z@gawab.com>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sun, 15 Jul 2007, Al Boldi wrote:

> >     If possible, during a restore devices should be brought back to the
> > same state in which they were before the corresponding hibernation.  Of
> > course in some situations it might be impossible to do that (eg. the user
> > connected the hibernated system to a different IP subnet and then
> > restored), but as a general rule, we should do our best to restore the
> > state of devices, which is directly related to point (5) above.
> 
> This part could easily be handled by the normal kernel before and after 
> resume.

I agree with you except for the word "easily".  And there are some 
things the kernel simply punts on (I'm thinking of the current VGA 
font).

> > (7) On ACPI systems special platform-related actions have to be carried
> > out at the right points, so that the platform works correctly after the
> > restore
> >
> >     The ACPI specification requires us to invoke some global ACPI methods
> >     during the hibernation and during the restore.  Moreover, the ordering
> > of code related to these ACPI methods may not be arbitrary (eg. some of
> > them have to be executed after devices are put into low power states
> > etc.).
> 
> This should be the responsibility of the kexec'd hibernating kernel.  Note 
> though in (6), the normal kernel takes care of preparing devices, then the 
> hibernating kernel dumps the image and either calls S4 or S3.  On resume 
> from S3 it can immediately switch over to the normal kernel, and from S4 the 
> known bootup would occur.

Is it really that simple?  Somehow I doubt it.  In order for some 
devices to remain available for the kexec'd kernel to use, they cannot 
be suspended at the ACPI level.  So the kexec'd kernel will have to 
handle the ACPI requirements for those devices.  Likewise, it would 
have to handle the ACPI interactions which need to be done after all 
devices are prepared for the transition to S3 or S4.

> > (8) Hibernation and restore should not be too slow
> >
> >     In my opinion, if more than one minute is needed to hibernate the
> > system with the help of certain hibernation framework, then this framework
> > is not very useful in practice.  It might be useful to perform some
> > special tasks (eg. moving a server to another place without taking it
> > down), but it is not very useful, for example, to notebook users.
> 
> The latest hibernating kexec patches boot a kexec'd modular kernel with 
> initramfs into crashkernel=16M@16M in less than one second.  Switch-back is 
> almost instant.  Add to this the time required to either store or restore 
> the image, and it may be obvious that this approach isn't slower, but maybe 
> even faster than the current swsusp.

Does that include the time required for probing PCI buses?  On my
desktop system, PCI probing incurs a five-second timeout delay because
of a bug in the BIOS's USB firmware.  Don't be so sure that kexec will
always be lightning fast; it is always better to avoid unnecessary
boots.

Alan Stern
