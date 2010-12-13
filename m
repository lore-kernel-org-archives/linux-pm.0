From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 4/4] PM: Permit registrarion of
 parentless devices during system suspend
Date: Sun, 12 Dec 2010 23:09:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012122253120.4379-100000__34374.3901736618$1292213399$gmane$org@netrider.rowland.org>
References: <201012130133.52072.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012130133.52072.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 13 Dec 2010, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The registration of a new parentless device during system suspend
> will not lead to any complications affecting the PM core (the device
> will be effectively seen after the subsequent resume has completed),
> so remove the code used for detection of such events.

Actually the tests you're changing were never as strong as they should
have been.  Drivers are supposed to avoid registering new children
beneath a device as soon as the device has gone through the "prepare"
stage, not just after the device is suspended.  Should there be a 
"prepared" bitflag to help implement this stronger test?

In principle the same idea applies to parentless devices, since they
can be considered children of the "system device" (a fictitious node at
the root of the device tree).  The "system" goes into the prepared
state before all the real devices; that's what the transition_started
variable was all about.  It's nothing more than the "prepared" bitflag
for the "system device".

I guess it's okay to be lenient and not check for this.  But should we
then change the documentation to match?  (Note that the warning won't
be triggered if a new child is registered _as_ the parent is
suspending.  Not to mention the possibilities for mischief when devices
are suspended asynchronously.  But as you say, these complications
don't affect the PM core.)

Alan Stern
