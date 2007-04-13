From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 23:45:48 +0200
Message-ID: <1176500749.7052.127.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704131347.30001.rjw@sisk.pl>
	<1176470819.7052.108.camel@johannes.berg>
	<200704132243.59618.rjw@sisk.pl> <20070413205837.GG28264@elf.ucw.cz>
	<1176498368.7052.117.camel@johannes.berg>
	<20070413211232.GJ28264@elf.ucw.cz>
	<1176499086.7052.124.camel@johannes.berg>
	<20070413213349.GL28264@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0658692971=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070413213349.GL28264@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============0658692971==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wtrUE/ucYRflfVQTqFaE"


--=-wtrUE/ucYRflfVQTqFaE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-13 at 23:33 +0200, Pavel Machek wrote:

> Still, swsusp shuts down the devices:
>=20
>         if ((error =3D arch_prepare_suspend()))
>                 return error;
>=20
>         local_irq_disable();
>         /* At this point, device_suspend() has been called, but *not*
>          * device_power_down(). We *must* device_power_down() now.
>          * Otherwise, drivers for some devices (e.g. interrupt
> controllers)
>          * become desynchronized with the actual state of the hardware
>          * at resume time, and evil weirdness ensues.
>          */
>         if ((error =3D device_power_down(PMSG_FREEZE))) {
>                 printk(KERN_ERR "Some devices failed to power down, abort=
ing suspend\n");
>                 goto Enable_irqs;
>         }
>=20
> This local_irq_disable() is very similar to the one you are doing in
> suspend-to-RAM. According to your description, it needs to play with
> the decrementor, too. But I'd really prefer not to have pm_ops call
> here -- exactly because swsusp has nothing to do with pm_ops in
> shutdown mode.

Right. But we don't actually care because we just power down, we don't
have to put the CPU into a proper state.

johannes

--=-wtrUE/ucYRflfVQTqFaE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGH/oM/ETPhpq3jKURAgM/AJ91rmd5mLZC7hVwWzARggXS/odYogCeIG9H
A6BS28/i5PBfLjviWsgmFYk=
=j5B7
-----END PGP SIGNATURE-----

--=-wtrUE/ucYRflfVQTqFaE--


--===============0658692971==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0658692971==--
