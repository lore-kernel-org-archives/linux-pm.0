From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFP] LPC thermal track
Date: Fri, 27 Mar 2015 11:02:47 -0400
Message-ID: <20150327150245.GA29938@developer.hsd1.ca.comcast.net>
References: <20150327000245.GA29752@developer.hsd1.ca.comcast.net>
 <55154361.90302@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36709 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbbC0PCu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2015 11:02:50 -0400
Received: by padcy3 with SMTP id cy3so98053443pad.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2015 08:02:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55154361.90302@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>, Javi Merino <Javi.Merino@arm.com>, "cyndis@lakka.kapsi.fi" <cyndis@lakka.kapsi.fi>, Kapileshwar Singh <Kapileshwar.Singh@arm.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "wxt@rock-chips.com" <wxt@rock-chips.com>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Punit,

On Fri, Mar 27, 2015 at 11:47:45AM +0000, Punit Agrawal wrote:
> Hi Eduardo,
>=20
> Thanks for proposing a thermal micro-conference. It would be good to=20
> discuss the direction things are heading with regards to thermal in linux.
>=20

Great!

Let's see if we can get enough entropy to get it approved.

> On 27/03/15 00:02, Eduardo Valentin wrote:
> > Hello all,
> >
> > I've created a proposal for a thermal microconference track on the LPC
> > 2015 [1]. The basic idea is to get thermal developers together and
> > discuss the thermal role within the Linux environment, from kernel and
> > userspace perspective.
> >
> > A initial proposal for the topics to be discussed are:
> > . Closed loop control governors
> > . Sensor API
> > . Thermal class: split of temperature sensor device and thermal driver
> > . Improvements on OF-thermal
> > . Devfreq vs. clock cooling
> > . Power model based policies
> > . User space tools
> > . User space governors
> >
> > If you have interest, or if you have ideas on how to improve the
> > framework, reply to this email and add it to the wiki.
> >
>=20
> I'd like to propose -
>=20
> . Co-ordination among cooling-devices in the system
>=20
> In workloads that involve multiple devices such as camera+CPUs+image=20
> singal processor or camera+video encoding, etc. often there are=20
> dependencies across multiple devices' performance states to achieve=20
> minimum acceptable performance (24fps HD encode for example). When=20
> thermally constrained it would help to have some mechanisms to=20
> co-ordinate their performance control. The power allocator governor=20
> attempts to solve some of these problems but it would be good to have a=
=20
> wider discussion on enabling more scenarios.
>=20

Sounds good to me. It would be interesting to see if plumbing is
required in the framework itself.

>=20
> > Add your name in the list of participants as well. Also, if you feel
> > like giving a talk on the topic, let's add it to the topic list.
> >
>=20
> Done.
>=20

Can you please also add you name as presenter of this topic?

> Cheers,
> Punit
>=20
> > Currently I am simple checking what would be the level of interest to
> > have this topic as a LPC microconference.
> >
> > BR,
> >
> > Eduardo Valentin
> >
> >
> > [1] - http://wiki.linuxplumbersconf.org/2015:thermal
> >
>=20

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVFXENAAoJEMLUO4d9pOJWMucIAJhArk/Q0grsPnSG71ViJ0Fu
ILO7BzT+OaZhscx5bQDAVv7NVmn0kX+Jca6PhyWy5vESOyafsgiOtuG0ax8ZVxl0
7mV/rApUTC7giPN5BUWBmrEB1MVCfJUnclpSNa3LekwAdPwDb8HPfT8hCgfkoWb1
HXwLGBD/4cz8z4xMJcV6DljTK5O77MX10mDVNUYZ8vNmagsloDQdhD6rIes9ce0G
IqlPIvWMCyZBt7/4Tdx0amF5LgQQI8h+hJLNwW1FfXlQ6vJtVGwmDzdaB6jgUJhP
7ujXGm56TiX7kwrC3mMh9anSn2w9/t4OKXyV3OsLGFzCeo3QfJaCnQwui4GgQIk=
=XO8N
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
