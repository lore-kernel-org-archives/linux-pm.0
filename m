From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH v3] dt-bindings: power: supply: bq24735: reverse the
 polarity of ac-detect
Date: Thu, 26 Jan 2017 11:09:52 +0100
Message-ID: <1485425392.1113.0.camel@paulk.fr>
References: <1481804479-8711-1-git-send-email-peda@axentia.se>
         <5f5fe01a-7c7a-58f7-2171-5f6879392ea7@wwwdotorg.org>
         <c3e87e2b-5d0d-c1ff-8edf-f4a77de31c1e@axentia.se>
         <1485275073.1087.10.camel@paulk.fr>
         <c4528a3d-5ff7-8fca-6dbf-18b3792edda7@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/+1SxhgS20g9RA9lNJUJ"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c4528a3d-5ff7-8fca-6dbf-18b3792edda7-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--=-/+1SxhgS20g9RA9lNJUJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 25/01/17 13:20, Peter Rosin wrote:
> On 2017-01-24 17:24, Paul Kocialkowski wrote:
> > Le jeudi 15 d=C3=A9cembre 2016 =C3=A0 18:50 +0100, Peter Rosin a =C3=A9=
crit :
> > > The bindings are fine.
> > >=C2=A0
> > > The Tegra dts files are buggy, but the driver is also buggy, so those
> > > two bugs cancel each other. So, the option is to either introduce
> > > regressions by fixing the two bugs thus creating a flag day where
> > > the kernel and dt needs to match. Or, just document what is going on
> > > and change the bindings even if they are not wrong.
> >=C2=A0
> > After reading the discussion, I would rather be in favor of fixing the
> > driver
> > and the tegra dts files, which are both wrong.
> >=C2=A0
> > Keeping things as-is is very counter-intuitive: the GPIO on nyan boards=
 is
> > active-low and should be described as such (think of other projects, li=
ke
> > U-Boot, reusing the dts). It's also very counter-intuitive to require t=
hat
> > any
> > new board using that driver use active-low polarity in the GPIO declara=
tion
> > when
> > the line is really active-high.
>=C2=A0
> Agreed, it very counter-intuitive. I have a board w/o an invert and it
> does look odd with active-low in the dts. It really should be active-high=
.
>=C2=A0
> The (new) binding helps a bit though.

Yeah, it's a solution anyway. I'm mostly worried that it means all other co=
de
(especially not in Linux) using the dts will be plagued by this, which seem=
s a
bit unfair. I still see this as an error not being fixed.

> > Is anyone strongly opposed to that solution? I'd really rather see the =
issue
> > fixed that way instead of the current proposal (this patch).
>=C2=A0
> It's a little bit more than a proposal since it is in linux-next. But not=
 set
> in stone of course.

Oh, I thought it was still up for review when sending my previous message.

> I personally do not care as long as it is changed before
> hitting Linus' tree as I have no deployed devices. But docs are just that=
.
> Docs. Anything that worked before is going to break with the change you a=
re
> proposing. Are you really willing to break who knows how many tegra board=
s?

=46rom my perspective, fixing counter-intuitive behaviour justifies that.

But you're probably right to point out that others down the line will most
likely prefer to keep the change you introduced. So I'll put it this way:
if everyone agrees that it's okay to break support for older device-trees,
then I'm available to craft a patch. Otherwise, let's just stick with you
changes you got in.

> Or do you somehow know that *all* tegra users will always update their ke=
rnel
> and dtb in sync, so that regressions will not happen?

Frankly I've never understood why kernel maintainers expect this is not the
case, and this is quite frequently a pain when trying to address issues suc=
h as
this one. While I reckon that device-trees shouldn't be tied to the kernel =
in
particular (both are independent), I think it's fair to except that users u=
se
device-trees matching the release date of the kernel.

It's usually accepted that projects have dependencies on certain versions o=
f
libraries and explicitly do not support older versions of these. It would b=
e
nice to adopt the same attitude towards device-tree. These are my 2 cents o=
n the
issue, of course this isn't up for me to decide.

> > I'd also be happy to implement and test that solution on nyans, as I've=
 done
> > other bq24735-related work for nyans recently.
>=C2=A0
> Changing this is trivial. Testing that the change does what it is suppose=
d to
> is not the main obstacle...

Right. Note that I'll be testing your bq24735 patches on nyans soon, so per=
haps
I'll have an upcoming series in case I spot any regression.

Cheers!

--=20
Paul Kocialkowski, developer of free digital technology at the lower levels

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-/+1SxhgS20g9RA9lNJUJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAliJyvEACgkQhP3B6o/u
lQyhOg/5AeP+Bv5pSGYcql1Jk0yGIo1NDZDZukGTKfwwTg37KIYkPZUb4ZlSArCv
SFn5fKGmKs81SQamQCB4gcTrn5xVmUNY9H0/V5gABwzsAcBoJ2X8Wf7qqS1c0Ohe
0hQE3lT+9A+3iEhi1xo9PaM1SiBeoA5wn/XzMrdz5m/lupEZLKEycPyW7tVQnT7F
niBc9ewsv+tVOskVG8vBLBZ8dQW7qUrPycgLVk9BmxHJqZYhAsLiLtrsnv1iup9S
qM0NmWOYR6dHW+HYrLLmD3iovrtvwZwYlkENQDR+E6mPXSlgxnimZJD0GKh/Nj8c
ddTNYLqhY9Q9E1o2IQKsEjEiuRJ9iosrM0BCkG6AV7oE3Bz5h4MOxxpRIi9e57ws
XMLrf5xD/vuqPW3xGF9sWnoeW5zR0Twzj3jaFRGUNY+RbsmQjS2EAz3iYcM6qhbf
5qh7zkHyg7shGmUb5cBvoxa7qIpRSihh8oJ6/qddfEAmix312hW8zYjCY/qe+ELY
3V4/Bl/cUjmG7MKCLSXhShMV257rWMvtnFwn+4UEsUWZxkNiHx3RrlDDwIQ8jMB6
SbfAJJvoGUjdgk+wk9GYBZ6GTlyNtPdI1nLrp57rUTYkVAnCxIw1DbeQiNjK8buG
mzcLuB9260josdmw4Wj1F4T/edwAxLdfkyTWNS1dyvtRE3bFVZ8=
=TBCe
-----END PGP SIGNATURE-----

--=-/+1SxhgS20g9RA9lNJUJ--
