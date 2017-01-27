From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] dt-bindings: power: supply: bq24735: reverse the
 polarity of ac-detect
Date: Fri, 27 Jan 2017 09:26:00 +0100
Message-ID: <20170127082600.GA19395@ulmo.ba.sec>
References: <1481804479-8711-1-git-send-email-peda@axentia.se>
 <5f5fe01a-7c7a-58f7-2171-5f6879392ea7@wwwdotorg.org>
 <c3e87e2b-5d0d-c1ff-8edf-f4a77de31c1e@axentia.se>
 <1485275073.1087.10.camel@paulk.fr>
 <c4528a3d-5ff7-8fca-6dbf-18b3792edda7@axentia.se>
 <1485425392.1113.0.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485425392.1113.0.camel@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>, Rob Herring <robh+dt@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Stephen Warren <swarren@wwwdotorg.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 11:09:52AM +0100, Paul Kocialkowski wrote:
> On 25/01/17 13:20, Peter Rosin wrote:
> > On 2017-01-24 17:24, Paul Kocialkowski wrote:
> > > Le jeudi 15 d=C3=A9cembre 2016 =C3=A0 18:50 +0100, Peter Rosin a =C3=
=A9crit :
> > > > The bindings are fine.
> > > >=C2=A0
> > > > The Tegra dts files are buggy, but the driver is also buggy, so tho=
se
> > > > two bugs cancel each other. So, the option is to either introduce
> > > > regressions by fixing the two bugs thus creating a flag day where
> > > > the kernel and dt needs to match. Or, just document what is going on
> > > > and change the bindings even if they are not wrong.
> > >=C2=A0
> > > After reading the discussion, I would rather be in favor of fixing the
> > > driver
> > > and the tegra dts files, which are both wrong.
> > >=C2=A0
> > > Keeping things as-is is very counter-intuitive: the GPIO on nyan boar=
ds is
> > > active-low and should be described as such (think of other projects, =
like
> > > U-Boot, reusing the dts). It's also very counter-intuitive to require=
 that
> > > any
> > > new board using that driver use active-low polarity in the GPIO decla=
ration
> > > when
> > > the line is really active-high.
> >=C2=A0
> > Agreed, it very counter-intuitive. I have a board w/o an invert and it
> > does look odd with active-low in the dts. It really should be active-hi=
gh.
> >=C2=A0
> > The (new) binding helps a bit though.
>=20
> Yeah, it's a solution anyway. I'm mostly worried that it means all other =
code
> (especially not in Linux) using the dts will be plagued by this, which se=
ems a
> bit unfair. I still see this as an error not being fixed.
>=20
> > > Is anyone strongly opposed to that solution? I'd really rather see th=
e issue
> > > fixed that way instead of the current proposal (this patch).
> >=C2=A0
> > It's a little bit more than a proposal since it is in linux-next. But n=
ot set
> > in stone of course.
>=20
> Oh, I thought it was still up for review when sending my previous message.
>=20
> > I personally do not care as long as it is changed before
> > hitting Linus' tree as I have no deployed devices. But docs are just th=
at.
> > Docs. Anything that worked before is going to break with the change you=
 are
> > proposing. Are you really willing to break who knows how many tegra boa=
rds?
>=20
> From my perspective, fixing counter-intuitive behaviour justifies that.
>=20
> But you're probably right to point out that others down the line will most
> likely prefer to keep the change you introduced. So I'll put it this way:
> if everyone agrees that it's okay to break support for older device-trees,
> then I'm available to craft a patch. Otherwise, let's just stick with you
> changes you got in.

I do think this case is exceptional because both the DTS and driver code
are wrong, whereas the binding is correct.

So the reasonable thing to do here is to fix the code and DTS files. The
only thing I'm still somewhat concerned about is the fallout from this.

Looking at the code it seems that the ACOK GPIO is primarily used to
report the "charger present" and "charging/discharging" status. However
that status is also used to enable or disable charging. So from what I
can tell breaking compatibility here would cause device to no longer be
able to charge, which could potentially brick users' devices.

Then again, I'm not sure how the hardware works exactly. If the device
will still function with an empty battery but with a charger connected,
and I suspect it will, then users would still be able to hook up their
chargers, which they eventually have to do anyway, to boot and update
the DTB to fix this.

Now as for the amount of users concerned: I see this charger used only
on Tegra boards. Of those I don't think Venice2 and Tegra132 Norrin have
ever been available outside NVIDIA, so I don't think we'd have to
concern ourselves with them. Even if somebody was still using them
they'd have to be developers that would likely start out by copying new
kernel *and* DTB to the device.

Nyan-based devices, on the other hand, are fairly popular. I suspect
that not many actually run upstream kernels on them, and those that do
will certainly know how to update the DTS along with the kernel.

> > Or do you somehow know that *all* tegra users will always update their =
kernel
> > and dtb in sync, so that regressions will not happen?
>=20
> Frankly I've never understood why kernel maintainers expect this is not t=
he
> case, and this is quite frequently a pain when trying to address issues s=
uch as
> this one. While I reckon that device-trees shouldn't be tied to the kerne=
l in
> particular (both are independent), I think it's fair to except that users=
 use
> device-trees matching the release date of the kernel.
>=20
> It's usually accepted that projects have dependencies on certain versions=
 of
> libraries and explicitly do not support older versions of these. It would=
 be
> nice to adopt the same attitude towards device-tree. These are my 2 cents=
 on the
> issue, of course this isn't up for me to decide.

I think the primary reason for requiring backwards-compatibility is that
the DTB could be stored in a read-only location. So if there is no way
to upgrade the DTB it's fairly natural that we can't ever break ABI with
it.

Anyway, I think I've captured in full above what the potential fallout
=66rom this break would be. Essentially things will continue to work as-is
but if users end up not updating their DTB along with the kernel their
battery will drain. The fix for this would be to update the DTB, which
on Nyan boards can be easily done along with the kernel.

The advantages would be that other boards and OSes wouldn't have to deal
with a trivial logical error that was made a long time ago.

Rob, any chance you could grant an exception under the above
circumstances?

Thierry

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliLBBUACgkQ3SOs138+
s6H8ug/8DEvun4yDnViAfU8vV6YksYtU1yWzNAJpi7d2tU9rNb0WRYm4TFQYJF3r
1lCoQe43oSqyRPxcjXYaKmUyKwUbo67FmtPgsa1umseazByobTrF+f5hKLsaNQZU
o9hSsHx7yseJCtwjTkxFMouSk2y4N53Wy5V669jCAelFkVrxMY9mWZs6BgdabHOz
vsig87uIk8Xdp7FDn77+5hvoACGeZq9ssVELZfyHkxfaksA6VOnJ+rPJJFlDdZrx
xmUhG9IJpROpBG8F/T9CyEXmdjo9EN614QXH+dJVTz9XkITVDg9bqxbfn52kiEtp
n7Yssk/tejTPlcKMI5sgHrn0cHvvKGMwqmQZuKWkiCGoe1OSs1Niz/h660OPrQDA
5a8j7s/9GWM15zm5b0qry5ujqsdvqU2OG25OUDtQnNhe7/JZg5vV1T6pe3M3KQHU
p3NAjE+/h+hczBUmfV6jBswYAA6A/PvUNhtuPfW7razA0jkAO2Df3tDpyC/U74Vw
wQgYat5UdZnwqweBe7oSy09bFlhfgCF3egtKdGW6DLJbRaMU7LMyWidrGrVB7NYa
3/jLtY58dPRJEuiFQkKx5bgOsnDnnGW+gZwPjZXU5k3+/TUMIUKDhNJhGVGrzk3F
YEE2hNnFsE0fBu9KWKm42Nx2efe1ylbEmyP2mALJhfbre4Mfq2M=
=kIvl
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
