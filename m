From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] apm-emulation: notify about all
	suspend	events, not just	apm invoked ones
Date: Fri, 21 Mar 2008 15:18:31 +0100
Message-ID: <1206109111.16475.172.camel@johannes.berg>
References: <1205707065.1614.5.camel@johannes.berg>
	<20080321132924.GD5331@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8234774755657972076=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080321132924.GD5331@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Stephen Rothwell <sfr@linuxcare.com>
List-Id: linux-pm@vger.kernel.org


--===============8234774755657972076==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OeJBQfTUD8ZFNlTmjwPu"


--=-OeJBQfTUD8ZFNlTmjwPu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> > This revamps the apm-emulation code to get suspend notifications
> > regardless of what way pm_suspend() was invoked, whether via the
> > apm ioctl or via /sys/power/state. Also do some code cleanup and
> > add comments while at it.
>=20
> Does this actually change user-kernel ABI?

Not ABI, but there is a change in behaviour (which is the whole point of
this patch). Previously, tools using /sys/power/state would live in one
sandbox and tools using APM in another, not knowing about each other but
both influencing the system suspend state. This makes them actually know
about each other by making the APM emulation indicate all system sleep
events, even those done via /sys/power/state and not the APM emulation
itself.


> > +enum apm_suspend_state {
> > +	SUSPEND_NONE,

> These are not passed to userspace, are they?

No, they're just for the internal state machine.

johannes

--=-OeJBQfTUD8ZFNlTmjwPu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR+PDtqVg1VMiehFYAQJW8xAAk1k6ToV+97K8CSsymj9ra0Hjm1hk+yT8
sSenwFa76nOFnFCnDM9XE3xM6tlxtkyV+FLroesBTAv7f5BTtzGb3W4tX9UhjlUx
m+pEj/6A+UXcP0iSQlgXVv7Xd8AanUCTegKze1+baYr5eK7v5osCwxf8UCFEeEeg
aqNE/AJcBaprPfBi3M/ilRjkd7jdoQ5X1OuXE0/P97XRZQOhFeVXu1CXjZ7nv82Z
mHwm1u04jkk7naoiezeeAP4gIV6qsW1c2RkwE1zp/9nNEVMsDxUWSb8B/asGkm/a
l9M5BMrITSoCtJH/YbPhpaohGz619G6dj7GFFvKcNxYe8I435e1WMjSSYvTVPSfM
II46UAq19zGIG5uOBNdzIyBFeA/WmiU1ZUs18oGruQEXydhgidxYMdHw2rGgk0iP
NxZUqccsQFQxQfz4iznl0sheggUMR0D9JXOPjAo/SmcvO6R6x6SeQievcDn35iFV
jNhvKr+IlzDE9AfvaFFEv4/z13QBtb5VZBMaeV/tCRSVm5xdzkRKev7kLVTDN+Sd
O3d0w3nNeHj0YRQz43KMTIgS144T59k/5lC7cW2czbCVdcu8AqZkbSK+oxDjOtfG
weh7I/VGhhmrDv5P8QciRullCOJNrM1rWlvI62d88YU+Jpm/tOv7q38UuIJ+MlF/
WI/1ypMolco=
=HGJZ
-----END PGP SIGNATURE-----

--=-OeJBQfTUD8ZFNlTmjwPu--


--===============8234774755657972076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8234774755657972076==--
