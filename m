From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Sun, 1 Mar 2009 10:20:51 +0100
Message-ID: <200903011020.53130.rjw__8417.58351675725$1235899492$gmane$org@sisk.pl>
References: <200902192215.18365.rjw@sisk.pl> <200902282353.39763.rjw@sisk.pl>
	<d6200be20902281606g1c5db332r9970931d7080717f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902281606g1c5db332r9970931d7080717f@mail.gmail.com>
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
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 01 March 2009, Arve Hj=F8nnev=E5g wrote:
> On Sat, Feb 28, 2009 at 2:53 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> >> What you are talking about here is mostly an optimization of the
> >> >> wakelock api. You have removed timeout support and made each wakelo=
ck
> >> >> reference counted.
> >> >
> >> > I also removed the arbitrary number of wakelocks (I really _hate_ th=
e name,
> >> > can we please stop using it from now on?).
> >>
> >> What do you mean by this? You removed the struct wake_lock?
> >
> > Basically, yes.
> =

> Why is this better? If you move the stats into devices and tasks, this
> may take up more space than adding an object to the structures or
> tasks that you are protecting.

OK, this is a valid point as long as we're going to use the stats in the
original form (which I'm not sure we want).

Still, as far as the number of "locks" one process can take is limited, it's
fine.

> >> >> I do provide an option to turn off the wakelock stats, which makes
> >> >> wake_lock/unlock significantly faster, but we never run with wakelo=
ck
> >> >> stats off. Also, it pushes timeout handling to the drivers. I know =
may
> >> >> of you don't like timeout support, but ignoring the problem is not a
> >> >> solution. If each driver that needs timeouts uses its own timer, th=
en
> >> >> you will often wakeup from idle just to unlock a wakelock that will
> >> >> not trigger suspend. This wakeup is a thousand times as costly on t=
he
> >> >> msm platform as a wakelock/unlock pair (with wakelock stats enabled=
).
> >> >
> >> > Well, at least a couple of people told you that the timeouts are har=
dly
> >> > acceptable and they told you why.  Please stop repeating the same ar=
guments you
> >> > have given already for a couple of times.  They're not convincing.
> >>
> >> And you keep ignoring them.
> >
> > Not ignoring, but considering them as insufficient.  And since they've =
already
> > been considered as insufficient, there's no point repeating them over a=
nd over
> > again.  That doesn't make them any better.
> =

> The problem is that what you consider insufficient is what allows us
> to ship a product.

This doesn't matter a whit, because the mainline kernel is not just your
product.

By the same rule you could say that every working vendor driver is worth
merging into the mainline kernel, which clearly is not the case.

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
> > is whether we want this code in the mainline kernel.  For now, the answ=
er is
> > "no, we don't".  Moreover, since you're the one who wants the code to be
> > merged, it's your burden to make it acceptable for us.  However you're =
going
> > to do it is up to you, but certainly trying to force your current code =
on us
> > is not going to work.
> =

> I don't think I am the only one who want this code in the mainline
> kernel. Many people want to use the android platform, and support in
> the mainline kernel would be beneficial to some of them. I made many
> requested changes to my code that provides no benefit to us, but I
> have not made any changes that breaks our own use.

OK, please resubmit the patches, then.

> > BTW, I think you handled the thing wrong.  If I were you, I wouldn't ev=
en try
> > to push the code as you did.  I would instead make it as simple as reas=
onably
> > possible so that the basic idea was clear and understandable to everyon=
e.
> > Then, if there were any doubts with respect to the basic idea, I'd try =
to
> > clarify them and I'd consider modifying the code to address objections.
> > I'd only try to add more features after the basic idea had been accepte=
d.
> =

> The basic concept was developed long before android was a public project.

Please refer to the Ben's message for a good answer to this.

Thanks,
Rafael
