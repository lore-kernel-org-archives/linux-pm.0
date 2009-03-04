From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 4 Mar 2009 01:47:01 +0100
Message-ID: <20090304004701.GB6280__18684.7808807672$1236130022$gmane$org@elf.ucw.cz>
References: <200902192215.18365.rjw@sisk.pl> <200902282353.39763.rjw@sisk.pl>
	<d6200be20902281606g1c5db332r9970931d7080717f@mail.gmail.com>
	<200903011020.53130.rjw@sisk.pl>
	<d6200be20903021722y7f085482o66f6dee8c4004acd@mail.gmail.com>
	<20090303135143.GA5060@elf.ucw.cz>
	<d6200be20903031606k338168d2g2f012965a197fe5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20903031606k338168d2g2f012965a197fe5c@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue 2009-03-03 16:06:02, Arve Hj?nnev?g wrote:
> On Tue, Mar 3, 2009 at 5:51 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> >> > Not ignoring, but considering them as insufficient. =A0And since =
they've already
> >> >> > been considered as insufficient, there's no point repeating them =
over and over
> >> >> > again. =A0That doesn't make them any better.
> >> >>
> >> >> The problem is that what you consider insufficient is what allows us
> >> >> to ship a product.
> >> >
> >> > This doesn't matter a whit, because the mainline kernel is not just =
your
> >> > product.
> >>
> >> Unless you are saying that changes in the mainline kernel does not
> >> need be usable in practice, then it does matter. If we remove the
> >> feature that allows us to interact with existing code, it will take
> >> much longer before it is usable by anyone.
> >
> > Well, taking longer before "being usable" is good tradeoff if it means
> > "we get cleaner/actually correct system in mainline sooner".
> =

> I think this could go either way. If the system is usable, it may get
> more use from developers that know how to improve a specific subsystem
> to not use timeouts. Or, it may be considered good enough, and nobody
> bothers coming up with a correct solution. I think the latter is what
> you are worried will happen.

Yep.

> >> I submitted them three weeks ago. I'll submit a new set after I rename
> >> the api (presumably to suspend_block(er)) but I would like more
> >> agreement on the timeout issue first.
> >
> > I do believe that everyone (including you :-) agrees that timeouts are
> > ugly hack. So just reorder the series so they come at the end.
> =

> No, I think many uses of timeouts are a ugly hack, not all, but OK I
> will try to move timeout support to a separate patch.

Thanks.

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
