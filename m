From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 11:19:29 +0200
Message-ID: <1176542370.7052.159.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<20070413223922.GS28264@elf.ucw.cz>
	<1176506383.5764.129.camel@localhost.localdomain>
	<200704141114.56545.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2046983702=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704141114.56545.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============2046983702==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+3WudqSa5D85VdKwhq9c"


--=-+3WudqSa5D85VdKwhq9c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-04-14 at 11:14 +0200, Rafael J. Wysocki wrote:

> > Now it does not need to be pm_ops. I'm fine with arch_pm_irq_quiesce()
> > kind of thing (or find a better name if you can, maybe
> > arch_pm_after_devices_suspend() arch_pm_before_device_wakeup() ?) and
> > have the default implementation of these just do
> > local_irq_disable/enable.
>=20
> I like this idea.

I don't really. There can possibly be multiple pm_ops for one arch, who
knows that they all need to do the same thing here? (It would probably
be true for us right now though.)

Also, all other things suspend to ram does go through pm_ops so IMHO
adding an arch hook here now would just unnecessarily complicate the
whole thing since suddenly you may need to do more than just pm_ops for
suspend to ram.

On the other hand, if doing an arch hook here and something like
CONFIG_ARCH_HAS_SUSPEND_IRQ_HOOKS would actually allow us to end this
pointless discussion, then why not.

johannes

--=-+3WudqSa5D85VdKwhq9c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGIJyh/ETPhpq3jKURAltCAKCn9V7O9GHHae076dcu5SW3ar4icACeLaLn
mWwhqDItYXGJ6Q0HN1i6ue4=
=XzYq
-----END PGP SIGNATURE-----

--=-+3WudqSa5D85VdKwhq9c--


--===============2046983702==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============2046983702==--
