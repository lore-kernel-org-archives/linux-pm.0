From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Make it possible to avoid wakeup events
 from being lost
Date: Sat, 26 Jun 2010 23:06:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006262254060.28065-100000__19381.6041959964$1277608071$gmane$org@netrider.rowland.org>
References: <323677.5124.qm@web180313.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <323677.5124.qm@web180313.mail.gq1.yahoo.com>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 26 Jun 2010, David Brownell wrote:

> > > basically, I think the notion of counting wakeup
> > > events seems dubious on common hardware, ...
> > I disagree.=A0
> > =

> > The "counting" isn't meant as a way of keeping track of the absolute
> > number of these events.=A0 It's more like a technique  for seeing how m=
any
> > remain outstanding at any time.
> =

> But if you can't count them with any
> reliability, you can't know *that* either... so
> there must be a a problem with that model.

Why do you say we can't count them with any reliability?

Or, let's put it another way: You'll grant that we can count _some_ set
of events.  Given that, you'll probably also grant that we can keep
track of their number reliably enough to know when the count has
dropped to 0.  Then this becomes a question of how closely does the set
of events we can count match up with the set of "wakeup" events?

In fact, it doesn't have to match up perfectly.  There may be a few
wakeup events where we don't really care if one of them occurs while
the system is going to sleep and the sleep isn't delayed or aborted.  =

(Although by definition this is never _supposed_ to happen, there may
be cases where we just don't care.)  The other possibility is
relatively harmless too: an event that wouldn't wake up a sleeping
system nevertheless can delay or abort a suspend-in-progress.

So overall I don't see a problem with this.  Do you have any especially
pernicious failure modes in mind?

Alan Stern
