From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 4/4] PM: Permit registrarion of
	parentless devices during system suspend
Date: Tue, 14 Dec 2010 00:05:49 +0100
Message-ID: <201012140005.49193.rjw__4960.69431906125$1292281745$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1012122253120.4379-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1012122253120.4379-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, December 13, 2010, Alan Stern wrote:
> On Mon, 13 Dec 2010, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The registration of a new parentless device during system suspend
> > will not lead to any complications affecting the PM core (the device
> > will be effectively seen after the subsequent resume has completed),
> > so remove the code used for detection of such events.
> 
> Actually the tests you're changing were never as strong as they should
> have been.  Drivers are supposed to avoid registering new children
> beneath a device as soon as the device has gone through the "prepare"
> stage, not just after the device is suspended.  Should there be a 
> "prepared" bitflag to help implement this stronger test?

The in_suspend flag introduced by [3/4] works like this, actually.

> In principle the same idea applies to parentless devices, since they
> can be considered children of the "system device" (a fictitious node at
> the root of the device tree).  The "system" goes into the prepared
> state before all the real devices; that's what the transition_started
> variable was all about.  It's nothing more than the "prepared" bitflag
> for the "system device".

It has never worked like this, because it was cleared as early as at the
_noirq() stage.

Hmm.  It looks like I should modify [3/4] to clear the in_suspend flag earlier
to follow the current behavior (if a device is DPM_RESUMING, registration of
new children doesn't trigger the warning).

> I guess it's okay to be lenient and not check for this.  But should we
> then change the documentation to match?  (Note that the warning won't
> be triggered if a new child is registered _as_ the parent is
> suspending.  Not to mention the possibilities for mischief when devices
> are suspended asynchronously.  But as you say, these complications
> don't affect the PM core.)

The documentation is fine, I think, as it says what people are not supposed to
do and that doesn't really change. :-)

Thanks,
Rafael
