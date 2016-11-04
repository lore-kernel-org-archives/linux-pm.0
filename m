From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Fri, 4 Nov 2016 10:26:36 +0100
Message-ID: <20161104092636.GA30729@amd>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <20161104091037.GD3414@vireshk-i7>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161104091037.GD3414@vireshk-i7>
Sender: linux-acpi-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, rui.zhang@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I am really confused about where the problem is. 4.8 or 4.9 ? :)

Well, v4.8 runs at too low frequency without explanation, and v4.9
overheats. Both are a problem :-). But it starts to look like v4.9 is
the one where the real problem is.

> On 04-11-16, 09:58, Pavel Machek wrote:
> > On Fri 2016-11-04 09:38:49, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > I'm debugging overheats on v4.9-rc1... which did not seem to happen in
> > > v4.8-rc1. I'm running basically "nice make -j 3" on kernel... cpus are
> > > fully loaded.=20
> > >=20
> > > %Cpu(s):  7.5 us, 18.5 sy, 72.6 ni,  0.0 id,  0.0 wa,  0.0 hi,  1.5
> > > si,  0.0 st
> > > KiB Mem:   3087096 total,  2993076 used,    94020 free,    52900
> > > buffers
> > > KiB Swap:  1681428 total,    60900 used,  1620528 free.  1183664
> > > cached Mem
> > >=20
> > > Still, cpus don't stay on maximum frequency on v4.8-rc1. (I suspect
> > > that may be why machine does not overheat).
> >=20
> > What is worse, they go to low frequency even with "performance"
> > governor on v4.8-rc1?!
>=20
> You sure about it? How did you check it?

See the dumps below. cpuinfo_cur_freq shows 1GHz while compilation is runni=
ng.

> Also why are you testing on 4.8-rc1? And not a 4.8 stable kernel? What if=
 the
> core is already fixed upstream ?
>=20
> There is one core fix in 4.8:
>=20
> commit 899bb6642f2a ("cpufreq: skip invalid entries when searching the
> frequency")

Ok, I guess that's not it.

> > 1000000
> > 1000000
>=20
> Is this happening because of thermal capping ? That is the only reason th=
at I
> could think of where freq can change with performance governor.

How would I know if it is thermal capping? There's nothing in dmesg.

> > /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1000000
> > /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:acpi-cpufreq
> > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:performance
> > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:1000000
>=20
> And this value sort of confirms it.
>=20
> > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:1000000
> > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupported>
> > grep: /sys/devices/system/cpu/cpu0/cpufreq/stats: Is a directory
> > pavel@duo:/sys/devices/system/cpu/cpu0/cpufreq$
> >=20
> > Let me try v4.9-rc2... that works ok (cpus at the high frequency
> > during the kernel build). Unfortunately that sends my cpus to 99C
> > temperature range (and eventually forces emergency shutdown).
>=20
> Unbelievable.
>=20
> > v4.9-rc2, current policy changes without me touching it. Notice the
> > 1.47GHz below? I did not do that, it oscilates itself. Is that thermal
> > protection?=20
>=20
> Looks like to me.
>=20
> Can we verify somehow about what's the situation should look like? Perhap=
s with
> some older stable kernel? And then see if 4.8.X works fine or 4.9-rc.

I can try older kernel from Debian distribution, I guess.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgcVEwACgkQMOfwapXb+vLhsACeOUMm4SajmMz9KWPFmDxkkqmf
D/UAnjNelvunyS2/LSXBhnUnxuG2tekb
=8Oz3
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
