From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] One more power management fix for 2.6.37
Date: Tue, 9 Nov 2010 16:49:49 -0800
Message-ID: <AANLkTik3ufjfFRKk6Yu39h-E314+ds0iAy1dfFoZSeVN__37029.6000656255$1289350289$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1011041045350.2522-100000@netrider.rowland.org>
	<201011100039.17689.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011100039.17689.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 9, 2010 at 3:39 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> So, what about the patch below?

I think it looks saner, but I also think that it would be saner yet to
have a separate list entirely, and *not* do this crazy "move things
back and forth between 'dpm_list'" thing.

So I would seriously suggest that the design should aim for each
suspend event to move things between two lists, and as devices go
through the suspend phases, they'd move to/from lists that also
indicate which suspend level they are at.

So why not introduce a new list called "dpm_list_suspended", and in
"dpm_suspend_noirq()" you move devices one at a time from the
"dpm_list" to the "dmp_list_suspended".

And then in "dpm_resume_noirq()" you move them back.

Wouldn't that be nice?

(Optimally, you'd have separate lists for "active", "suspended", and
"irq-suspended")

But regardless, your patch does seem to at least match what we
currently do in the regular suspend/resume code (ie the
non-irq's-disabled case). So I don't mind it. I just think that it
would be cleaner to not take things off one list only to put them back
on the same list again.

In particular, _if_ device add events can happen concurrently with
this, I don't understand how that would maintain the depth-first order
of the list. In contrast, if you do it with separate lists, then you
know that if a device is on the "suspended" list, then it by
definition has to be "after" all devices that are on the non-suspended
list, since you cannot have a non-suspended device that depends on a
suspended one.

So having separate lists with state should also be very sensible from
a device topology standpoint - while doing that "list_splice()" back
on the same list is _not_ at all obviously correct from a topological
standpoint (I'm not sure I'm explaining this well).

                 Linus
