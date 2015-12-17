From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] PM / sleep: define inline functions
Date: Thu, 17 Dec 2015 11:12:38 -0800
Message-ID: <8760zwx521.fsf@eliezer.anholt.net>
References: <1450266099-4352-1-git-send-email-sudipm.mukherjee@gmail.com> <87wpsdrjni.fsf@eliezer.anholt.net> <6732607.IpmkEPKP2k@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:45299 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbbLQTMn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2015 14:12:43 -0500
In-Reply-To: <6732607.IpmkEPKP2k@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Wednesday, December 16, 2015 04:41:37 PM Eric Anholt wrote:
>>=20
>> --=3D-=3D-=3D
>> Content-Type: text/plain
>>=20
>> Sudip Mukherjee <sudipm.mukherjee@gmail.com> writes:
>>=20
>> > If CONFIG_PM_SLEEP is not defined then the functions are defined as
>> > NULL. And as a result we are getting build failure with
>> > alpha allmodconfig with the error:
>> >
>> > drivers/gpu/drm/vc4/vc4_v3d.c: In function 'vc4_v3d_set_power':
>> > include/linux/stddef.h:7:14: error: called object is not a function or=
 function pointer
>> >  #define NULL ((void *)0)
>> >               ^
>> > include/linux/pm.h:776:30: note: in expansion of macro 'NULL'
>> >  #define pm_generic_poweroff  NULL
>> >                               ^
>> > drivers/gpu/drm/vc4/vc4_v3d.c:157:10: note: in expansion of macro 'pm_=
generic_poweroff'
>> >    return pm_generic_poweroff(&vc4->v3d->pdev->dev);
>> >           ^
>> > include/linux/stddef.h:7:14: error: called object is not a function or=
 function pointer
>> >  #define NULL ((void *)0)
>> >               ^
>> > include/linux/pm.h:764:28: note: in expansion of macro 'NULL'
>> >  #define pm_generic_resume  NULL
>> >                             ^
>> > drivers/gpu/drm/vc4/vc4_v3d.c:159:10: note: in expansion of macro 'pm_=
generic_resume'
>> >    return pm_generic_resume(&vc4->v3d->pdev->dev);
>> >           ^
>> >
>> > Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
>> > Cc: Eric Anholt <eric@anholt.net>
>> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
>>=20
>> I'm happy with this solution, and would also be willing to just depend
>> on the config option as well.  Whatever people prefer.
>
> These functions are intended to be used as PM callbacks rather than to be
> called directly from code that doesn't depend on PM_SLEEP, so I'd prefer
> all code calling them directly to depend on the config option.

Actually, I should have probably checked what the right way to do this
is.

I'm using these functions for reset when the device gets wedged.  Before
swapping to using a generic power domain, I was just sending the command
through the firmware driver to turn the GPU off and back on.  The genpd
wraps my firmware driver's interface, so what is the best way to force
my domain (I assert I'm the only consumer of it) off and back on again?

If this is the best interface, then I do need to just depend on
CONFIG_PM_SLEEP in Kconfig.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWcwkmAAoJELXWKTbR/J7oWk0P/jq3rL3QT1PIrcuXH5k0GsR2
WH/j779qbaqIfDXkxyz2xCNY6Fa7I3O8CDK0KW+xTDWvmIhDWsx5zCqSnshpL7qG
Wob47KT399yOquTfK/OD93JAbewUoiK9UCIYHrww1CUKo2zz94aLbMwA09MrGi2Z
BZGDoOEks+AVgnZwAhSjW3HhHc8CE94z4oVnHu8jyWX+NcJw9yNuYerpE9IaS4Aw
PFfSyeEOvNjn7aXKu3d/WkuqWN5zlsSE3i357oOSMH87PFod1M4QPRPB8xGOFg6X
NaZhvpw/4dQaTlxn6t0N09rdpkXXyNtAJp9TnLfhNPEtVz5Z6LM6xIgsHFuETZSY
YnGiVox1UyVkll9+SSlV4YvDBu9UMMLqBq7LIyQpOqBd+ZsT+WzxtEUbIxuVVAOF
YXjrfdruF3OhfLh/zZw4OK0mooTzRIVpYlIIaS8Xhch6XXIvGHk/l4fPu0gPYKRL
UWVo7j7GSdtZymN5r9I0sswgdnFunNpQWTb4NcNJ/P6+nxNVrkrAwC/rE/RqDYF8
zHRtxfXob36oIBEgfXdfKI0E7nFnPgJSgV9RJWBI6Kno59n8qWVJ7TeG8VPXz9Dm
ecW2sj5bNDdgR4blXzIE0cbMSLcQUFomj1fHh2hVqwLBwmvRBnVf3XUU6wmBfUYT
YHt4M16M2pFM8nCb8ksu
=uj6T
-----END PGP SIGNATURE-----
--=-=-=--
