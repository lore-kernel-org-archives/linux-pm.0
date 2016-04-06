From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v9 1/4] gadget: Introduce the usb charger framework
Date: Wed, 06 Apr 2016 11:05:26 +0300
Message-ID: <87shyz2md5.fsf@intel.com>
References: <cover.1459494743.git.baolin.wang@linaro.org> <6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org> <20160406072513.GB21101@shlinux2.ap.freescale.net> <87vb3v2nm8.fsf@intel.com> <20160406074310.GC21101@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61010 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754146AbcDFIH1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Apr 2016 04:07:27 -0400
In-Reply-To: <20160406074310.GC21101@shlinux2.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Peter Chen <hzpeterchen@gmail.com> writes:
> On Wed, Apr 06, 2016 at 10:38:23AM +0300, Felipe Balbi wrote:
>> Peter Chen <hzpeterchen@gmail.com> writes:
>> > On Fri, Apr 01, 2016 at 03:21:49PM +0800, Baolin Wang wrote:
>> >  +
>> >> +static struct attribute *usb_charger_attrs[] =3D {
>> >> +	&dev_attr_sdp_current.attr,
>> >> +	&dev_attr_dcp_current.attr,
>> >> +	&dev_attr_cdp_current.attr,
>> >> +	&dev_attr_aca_current.attr,
>> >> +	&dev_attr_charger_type.attr,
>> >> +	&dev_attr_charger_state.attr,
>> >> +	NULL
>> >> +};
>> >
>> > The user may only care about current limit, type and state, why they
>> > need to care what type's current limit, it is the usb charger
>> > framework handles, the framework judge the current according to
>> > charger type and USB state (connect/configured/suspended).
>>=20
>> it might be useful if we want to know that $this charger doesn't really
>> give us as much current as it advertises.
>>=20
>
> As my understanding, the current limit is dynamic value, it should
> report the value the charger supports now, eg, it connects SDP, but
> the host is suspended now, then the value should be 2mA.

yes, and that's the limit. Now consider we connect to DCP or CDP and
limit is 2000mA but we're charging at 1000mA ;-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBMNHAAoJEIaOsuA1yqRE5KEP/3XxCRWhhmWq0ycGzpn7h4zP
lE6bR6Uhf2TjPKHHEv9XjW9uuX0w6hJ9J1WoPqqcBXIVZw8E+GiTv66+t8/3Q1+j
4hGEg3pY397DAjK7qrBnGQ2fKKsYSE61E3EIcV9DXkEiJr7+4NYeDR+Lk/8Mlbs9
tuDEf6zjK9sFzbeHR+wT1UHWSZs2ZW+N3ArhJgVac/b8upCSHPAUwjOlFqgNqrGc
8o5NleLITdhElNNrr7tMLYd5dpRbaO9lDon0wLldjokG2k7n7WgUb0kj6+7luz3a
p/KRJG8unXTDrFipEPm7Fp+80ZRhzz8GWHIkejNAyE2voakm1jGrh+/Iz9CVo3wf
mJczP63HquLo7Ke17TbKegvCGYQCFLTkcXAUjyLXpVFhTNzvM9Ch6ntj3HUts5Gl
v3PPGfuPgx/LBZuuLG+uWIFwSHLV29p0dq7IbLbLcywLrT927DQfcq+dBCBDNl3O
Y0daLrpapDNmLbE3D95NuEPzyE4eaTuFBTfDYiY+xqbNkGlPeQwhOGVBhVSi9cd/
s0+84AtjLSc6EAhB0GZ2B8KwVC8ZAOw+JD0greUzcOgxS4tVexQjQYiVxNFP4Rmm
D8knIarkWtVBvEgLyo/cql4w+hmqyGIW0301bRJcy0AvVAgF5lb62OzIROnTvP/z
O7bWsx+/qnw7jrc8S5DL
=bCbQ
-----END PGP SIGNATURE-----
--=-=-=--
