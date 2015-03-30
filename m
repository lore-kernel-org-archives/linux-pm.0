From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFP] LPC thermal track
Date: Mon, 30 Mar 2015 13:51:04 -0700
Message-ID: <20150330205057.GA5545@localhost.localdomain>
References: <20150327000245.GA29752@developer.hsd1.ca.comcast.net>
 <55154361.90302@arm.com>
 <1427742677.23036.145.camel@spandruv-DESK3.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34802 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbbC3UvI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2015 16:51:08 -0400
Received: by pactp5 with SMTP id tp5so11533059pac.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2015 13:51:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1427742677.23036.145.camel@spandruv-DESK3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>, Javi Merino <Javi.Merino@arm.com>, "cyndis@lakka.kapsi.fi" <cyndis@lakka.kapsi.fi>, Kapileshwar Singh <Kapileshwar.Singh@arm.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "wxt@rock-chips.com" <wxt@rock-chips.com>, Punit Agrawal <punit.agrawal@arm.com>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Srinivas,

On Mon, Mar 30, 2015 at 12:11:17PM -0700, Srinivas Pandruvada wrote:
> On Fri, 2015-03-27 at 11:47 +0000, Punit Agrawal wrote:=20
> > Hi Eduardo,
> >=20
> > Thanks for proposing a thermal micro-conference. It would be good to=20
> > discuss the direction things are heading with regards to thermal in lin=
ux.
> >=20
> > On 27/03/15 00:02, Eduardo Valentin wrote:
> > > Hello all,
> > >
> > > I've created a proposal for a thermal microconference track on the LPC
> > > 2015 [1]. The basic idea is to get thermal developers together and
> > > discuss the thermal role within the Linux environment, from kernel and
> > > userspace perspective.
> > >
> > > A initial proposal for the topics to be discussed are:
> > > . Closed loop control governors
> > > . Sensor API
> > > . Thermal class: split of temperature sensor device and thermal driver
> > > . Improvements on OF-thermal
> > > . Devfreq vs. clock cooling
> > > . Power model based policies
> > > . User space tools
> > > . User space governors
> > >
> > > If you have interest, or if you have ideas on how to improve the
> > > framework, reply to this email and add it to the wiki.
> What about
> Some enhancement in thermal zone user space I/F for user space thermal
> controllers
> - Better support for virtual temperature sensors which depends on other
> sensors.=20
> - Support for Linux IIO style scale and offset in thermal zone
> temperature calculation.
> - /dev interface for pushing thermal samples instead of raw read of
> temperature to improve performances and push sample instead of pull from
> user space.

Can you please add these topics to the wiki?

Would you be able to attend LPC and give a talk about your thoughts?

BR,

Eduardo Valentin

>=20
> Thanks,
> Srinivas=20
> > >
> >=20
> > I'd like to propose -
> >=20
> > . Co-ordination among cooling-devices in the system
> >=20
> > In workloads that involve multiple devices such as camera+CPUs+image=20
> > singal processor or camera+video encoding, etc. often there are=20
> > dependencies across multiple devices' performance states to achieve=20
> > minimum acceptable performance (24fps HD encode for example). When=20
> > thermally constrained it would help to have some mechanisms to=20
> > co-ordinate their performance control. The power allocator governor=20
> > attempts to solve some of these problems but it would be good to have a=
=20
> > wider discussion on enabling more scenarios.
> >=20
> >=20
> > > Add your name in the list of participants as well. Also, if you feel
> > > like giving a talk on the topic, let's add it to the topic list.
> > >
> >=20
> > Done.
> >=20
> > Cheers,
> > Punit
> >=20
> > > Currently I am simple checking what would be the level of interest to
> > > have this topic as a LPC microconference.
> > >
> > > BR,
> > >
> > > Eduardo Valentin
> > >
> > >
> > > [1] - http://wiki.linuxplumbersconf.org/2015:thermal
> > >
> >=20
>=20
>=20

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVGbcxAAoJEMLUO4d9pOJWgH8H/iV4N1R2bJTXIpMIN333JCCZ
woLFp1dUXMdQTcjaOJI8eVqvSYcABiBiE3gO99/LeZMozduHZ0kOwZrR1dsSAagG
/luw33dsp8ImdUWckvSgn6v5/GApsiLiAX1/V7NJ9MIekiC0lDdyUGgT36Oli2FM
Nh05WgEVdQUpC2F/QJcBb6nuiWucLARjUbptwAD2nPi4ADk8pp2+Ixi60q5ANVJ6
j0efz2f0xFI+bNGUrWY5mlbGHI5dCeFOuBehcmWPLxGTbKUqwRriwF0xAz1d8iC8
xYvQ8KQRsGp6OYn6kHPRDVeXac77ekoJwDhut/bcmKDUeIxY/ScAP8wuFP7ZV+g=
=dS7O
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
