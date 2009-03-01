From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 2 Mar 2009 00:08:30 +0100
Message-ID: <20090301230830.GF1961__27542.6655695357$1235948887$gmane$org@elf.ucw.cz>
References: <200902192215.18365.rjw@sisk.pl> <200902281118.14595.rjw@sisk.pl>
	<d6200be20902281357r2d3a0075q77055c1781f174d7@mail.gmail.com>
	<200902282353.39763.rjw@sisk.pl>
	<d6200be20902281606g1c5db332r9970931d7080717f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902281606g1c5db332r9970931d7080717f@mail.gmail.com>
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

Hi!

> >> > I do realize that you consider your current solution as the best thi=
ng since
> >> > the sliced bread, but please accept the fact that the other people t=
hink
> >> > differently.
> >>
> >> I certainly do not think my current solution is the best, it is very
> >> invasive. I do however think your proposed solution is worse. The only
> >> proposed alternative that we could actually ship a product on today is
> >> to not use suspend at all.
> >
> > Well, I'm sure your code is useful for the Android platform, but the qu=
estion
> > is whether we want this code in the mainline kernel. =A0For now, the an=
swer is
> > "no, we don't". =A0Moreover, since you're the one who wants the code to=
 be
> > merged, it's your burden to make it acceptable for us. =A0However you'r=
e going
> > to do it is up to you, but certainly trying to force your current code =
on us
> > is not going to work.
> =

> I don't think I am the only one who want this code in the mainline
> kernel. Many people want to use the android platform, and support in
> the mainline kernel would be beneficial to some of them. I made many
> requested changes to my code that provides no benefit to us, but I
> have not made any changes that breaks our own use.

No, you are not the only one. OTOH... that can't be used as an
argument to get it into kernel "as is".

Yes, I'd like to see it in but yes, I understand and agree with (most)
Rafaels's concerns.

> > BTW, I think you handled the thing wrong. =A0If I were you, I wouldn't =
even try
> > to push the code as you did. =A0I would instead make it as simple as re=
asonably
> > possible so that the basic idea was clear and understandable to everyon=
e.
> > Then, if there were any doubts with respect to the basic idea, I'd try =
to
> > clarify them and I'd consider modifying the code to address objections.
> > I'd only try to add more features after the basic idea had been accepte=
d.
> =

> The basic concept was developed long before android was a public project.

That's not our fault... =

									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
