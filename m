From: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Subject: Re: [GIT PULL] ACPI and power management fixes for v3.11-rc4
Date: Sat, 03 Aug 2013 20:08:06 +0400
Message-ID: <1375546086.1988.2.camel@ThinkPad-X230.localdomain>
References: <2052880.bHfzt6NKt5@vostro.rjw.lan>
	 <6100577.WGRZRabKGy@vostro.rjw.lan>
	 <CAMP44s1Knox3oVt3-ePkDHxa2uNQAFVFRwmVTATNknWA46b_Uw@mail.gmail.com>
	 <1963015.Y2AObmEn2f@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1963015.Y2AObmEn2f@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2013-08-03 at 13:54 +0200, Rafael J. Wysocki wrote:
> On Friday, August 02, 2013 08:48:09 PM Felipe Contreras wrote:
> > On Fri, Aug 2, 2013 at 5:21 PM, Rafael J. Wysocki <rjw@sisk.pl> wro=
te:
> > > On Friday, August 02, 2013 04:31:37 PM Felipe Contreras wrote:
> > >> On Fri, Aug 2, 2013 at 4:21 PM, Rafael J. Wysocki <rjw@sisk.pl> =
wrote:
> > >> > On Friday, August 02, 2013 02:12:49 PM Felipe Contreras wrote:
> > >>
> > >> >> You forgot this patch:
> > >> >>
> > >> >> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.=
git/commit/?h=3Dlinux-next&id=3D3706231332d57072e0e2c0e59975443f3f18e67=
3
> > >> >>
> > >> >> Or do you think it's fine to boot these machines into a black=
 screen?
> > >> >
> > >> > Seriously, what's wrong with you?!
> > >> >
> > >> > I didn't forget about it, I just didn't include it into this p=
articular
> > >> > pull request.
> > >> >
> > >> > And I'm not even sure I will push it for 3.11, because I prefe=
r to revert
> > >> > efaa14c for 3.11 if that's necessary to make your broken box w=
ork as before.
> > >>
> > >> The issue happens in more than just "my broken box", and yes,
> > >> reverting that patch would help (in more than just my box), in t=
he
> > >> sense that at least Linux won't boot into a black screen.
> > >>
> > >> But the backlight control still wouldn't work, as it hasn't work=
ed
> > >> since v3.7, possibly in many ASUS laptops, for that you need mor=
e than
> > >> just reverting efaa14c.
> > >
> > > Yes, last time it worked in 3.6 and in particular it doesn't work=
 in 3.10.
> > > My current goal is bring things back to the 3.10 state first, pos=
sibly without
> > > introducing any new problems, because we're kind of late in the c=
ycle.
> > > That's better done by reverting stuff known to have introduced pr=
oblems in
> > > the first place and not by doing things that may introduce more o=
f them.
> > >
> > > And your blacklisting patch has potential to introduce problems. =
 Your goal is
> > > to bring backlight control to the 3.6 state on that particular ma=
chine, but
> > > the blacklist is done at the *system* level and very well may aff=
ect more
> > > things than just backlight.  You may not see any problems resulti=
ng from it
> > > and you may not care even if there are some, but other users of i=
t may use
> > > different user space, for example, and may see problems that you'=
re not seeing.
> > >
> > > That's why I'd very much prefer to do the revert at this point.
> >=20
> > Yes, that's fine, either the revert, or the patch I mentioned, or
> > something else, but something has to be done, and it was better to =
do
> > it in v3.11-rc4 than in v3.11-rc5, because that change itself can
> > cause further problems.
>=20
> A revert can be done in -rc5 just fine.  If we don't have a working f=
ix this
> week, I'll do the revert.
>=20
> > >> > Well, perhaps I just won't push it at all so that you actually=
 can go and
> > >> > complain to Linus about that ...
> > >>
> > >> That is very responsible from you. Screw the users, right?
> > >
> > > No, that's not my goal, sorry for disappointing you.
> > >
> > > The problem is that I'm not really convinced about the validity o=
f the
> > > blacklisting approach to begin with.  As I said, the blacklisting=
 is done
> > > on the system level and the goal is to work around backlight cont=
rol problems.
> > > That sounds like a sledgehammer approach to me, which I don't rea=
lly like.
> > > If the blacklisting was more targeted, done at the video driver l=
evel etc.,
> > > I wouldn't really have any concerns about it, but that's not the =
case.
> > >
> > > And since people evidently could live for over 6 months with the =
backlight
> > > control problems, maybe they'll survive some more time still and =
allow us to
> > > find a better approach?
> >=20
> > They probably can survive without Linux at all, that doesn't mean w=
e
> > are doing our job.
> >=20
> > Let's do a though experiment, let's say you are right, and they can
> > survive the 6 months it would take you to find the "perfect" soluti=
on,
> > say in v3.13. What's wrong with having a partial solution in v3.12?=
 If
> > the blacklisting doesn't work properly (there's absolutely no evide=
nce
> > for that), then you revert it on v3.12.1.
> >=20
> > What's wrong with that approach?
>=20
> If the blacklisting leads to problems, they may not be reported in th=
e 3.12
> time frame, but much later.  For example because people won't realize=
 that
> the problems are caused by the blacklisting until much much later.  A=
nd then
> we'll be in a spot where whatever we do will break things for someone=
=2E
>=20
> And we had situations like that in the past, which is the source of m=
y concern.
> You obviously don't have that experience, or you won't be so eager to=
 inflict
> the blacklisting on everyone.
>=20
> Anyway, as you know, but conveniently don't mention, I asked some exp=
erienced
> people for opinions about that.  If they agree with you, we will add =
the
> blacklist.  If they don't, we won't add it.
>=20
> Rafael
>=20
I am opposed to this patch. On ThinkPad X230 I had problems with it.
=46elipe, come over to dark side. They have cookies.
--=20
Igor Gnatenko
=46edora release 19 (Schr=C3=B6dinger=E2=80=99s Cat)
Linux 3.10.4-300.fc19.x86_64

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
