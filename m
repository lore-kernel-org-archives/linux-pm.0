From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 14:32:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707171416120.3728-100000__12756.6913528883$1184697173$gmane$org@iolanthe.rowland.org>
References: <200707171640.39955.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707171640.39955.rjw@sisk.pl>
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
Cc: david@lang.hm, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Jul 2007, Rafael J. Wysocki wrote:

> I'm afraid of one thing, though.
> 
> If we create a framework without ACPI (well, ACPI needs to be enabled in the
> kernel anyway for other reasons, like the ability to suspend to RAM) and then
> it turns out that we have to add some ACPI hooks to it, that might be difficult
> to do cleanly.
> 
> Thus, it seems reasonable to think of the ACPI handling in advance.

Absolutely.  This needs to be done in such a way that it will work:

	On platforms without ACPI;

	On platforms with ACPI where we do a non-ACPI type of shutdown
	to whatever extent it is possible (or perhaps an ACPI-aware
	shutdown rather than change to S4);

	On platforms with ACPI where we do an ACPI-aware transition
	to S4.

Rafael, for those of us who aren't thoroughly familiar with all the ins
and outs of the ACPI spec, could you please summarize a list of the
ACPI calls needed in the second and third cases above?  Indicate which
ones need to be done from within the original kernel and which should
be done from within a kexec'd hibernation kernel.


I'm still not entirely clear on how "suspend-to-both" ought to be
handled.  Presumably it will start off as a normal hibernation.  But
instead of shutting down, wouldn't the kexec'd kernel return to the
original kernel?  After all, the original kernel knows about all the
devices and can put them into a low-power state, while the kexec'd
kernel might not have sufficient information.

But what about the freezer?  The original reason for using kexec was to
avoid the need for the freezer.  With no freezer, while the original
kernel is busy powering down its devices, user tasks will be free to
carry out I/O -- which will make the memory snapshot inconsistent with
the on-disk data structures.

Alan Stern
