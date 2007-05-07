From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Mon, 7 May 2007 18:41:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705071831360.4301-100000@iolanthe.rowland.org>
References: <200705071443.17429.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705071443.17429.david-b@pacbell.net>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Mon, 7 May 2007, David Brownell wrote:

> This summary suggests there are two S5 states, which I believe
> is incorrect.  G2 is just another name for S5.  See Fig 3-1;
> the ACPI 2.0 spec has the same figure.
> 
> Also, section 2.2 highlights that after S5 the OS restarts,
> which it doesn't do from S4 (table 2-1) ... although when it
> describes S4/NVS it fuzzes that issue by saying the key issue
> is whether an NVS state file is found and used, not the level
> of power available.

It also says that the NVS state file is found and used when the system
leaves the Soft Off (G2) or Mechanical Off (G3) state.  How did it enter
either of those states in the first place if S4-NVS is a Sleeping (G1)
state?

I imagine that business about the OS not restarting from S4-NVS is 
intended to mean the OS continues from the restored image rather than 
starting over completely fresh.

> Figure 3-1 seemed quite explicit to me ... S4 is one of the G1
> states, S5 is the only G2 state, and G3 is is a different beast.
> Text elsewhere agrees with that.

Yes, okay.

> What's confusing is how it describes NVS/hibernate.  It's very
> explicitly a G1 state.  But leaving G2 or G3 can also trigger
> a resume-from-NVS ... according to the text in 2.2 but not the
> state diagrams, which don't show entering G3 even cleanly, much
> less uncleanly (like a neighborhood power failure).  Bleech.

You can understand my confusion...

> I think the implication is that going to either G2 or G3 "off"
> states discards something that a G1 state preserves.  But I'd
> have to search more deeply to see if that's clearly defined.

Or what it is that gets discarded.  Especially since 2.4 lists only one 
difference between S5 and S4: whether or not there is a saved image.

> I suspect there's a reason this part of ACPI is so vague;
> it may relate to the desire to allow direct BIOS handling
> of the NVS state.

Could be.  I wish the spec was more upfront about its vagueness,
explaining what has been left out and why instead of just skipping over
some things and contradicting itself.

> G2/S5, yes ... that can be entered under software control.
> 
> But by definition, not G3 since it requires a mechanical/manual
> power switch update.  ("Mechanical OFF", or in the spec's example
> "movement of a large red switch".)

Okay, I understand that now.

Alan Stern
