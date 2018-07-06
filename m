From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2] power: vexpress: fix corruption in notifier
 registration
Date: Fri, 6 Jul 2018 16:33:16 +0200
Message-ID: <20180706143316.s3ai5jpbhqjmbrmc@earth.universe>
References: <1529322007-4637-1-git-send-email-sudeep.holla@arm.com>
 <1529337272-11799-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5193216256073476777=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1529337272-11799-1-git-send-email-sudeep.holla@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--===============5193216256073476777==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tbp5wmsfoxyyydep"
Content-Disposition: inline


--tbp5wmsfoxyyydep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 18, 2018 at 04:54:32PM +0100, Sudeep Holla wrote:
> Vexpress platforms provide two different restart handlers: SYS_REBOOT
> that restart the entire system, while DB_RESET only restarts the
> daughter board containing the CPU. DB_RESET is overridden by SYS_REBOOT
> if it exists.
>=20
> notifier_chain_register used in register_restart_handler by design
> relies on notifiers to be registered once only, however vexpress restart
> notifier can get registered twice. When this happen it corrupts list
> of notifiers, as result some notifiers can be not called on proper
> event, traverse on list can be cycled forever, and second unregister
> can access already freed memory.
>=20
> So far, since this was the only restart handler in the system, no issue
> was observed even if the same notifier was registered twice. However
> commit 6c5c0d48b686 ("watchdog: sp805: add restart handler") added
> support for SP805 restart handlers and since the system under test
> contains two vexpress restart and two SP805 watchdog instances, it was
> observed that during the boot traversing the restart handler list looped
> forever as there's a cycle in that list resulting in boot hang.
>=20
> This patch fixes the issues by ensuring that the notifier is installed
> only once.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Thanks, added Fixes: tag and queued to power-supply-fixes.

-- Sebastian

>  drivers/power/reset/vexpress-poweroff.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> v1->v2:
> 	- Updated changelog wordings as suggested by Lorenzo
> 	- Dropped unnecessary error variable initialisation on stack
>=20
> diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/rese=
t/vexpress-poweroff.c
> index 102f95a09460..e9e749f87517 100644
> --- a/drivers/power/reset/vexpress-poweroff.c
> +++ b/drivers/power/reset/vexpress-poweroff.c
> @@ -35,6 +35,7 @@ static void vexpress_reset_do(struct device *dev, const=
 char *what)
>  }
>=20
>  static struct device *vexpress_power_off_device;
> +static atomic_t vexpress_restart_nb_refcnt =3D ATOMIC_INIT(0);
>=20
>  static void vexpress_power_off(void)
>  {
> @@ -99,10 +100,13 @@ static int _vexpress_register_restart_handler(struct=
 device *dev)
>  	int err;
>=20
>  	vexpress_restart_device =3D dev;
> -	err =3D register_restart_handler(&vexpress_restart_nb);
> -	if (err) {
> -		dev_err(dev, "cannot register restart handler (err=3D%d)\n", err);
> -		return err;
> +	if (atomic_inc_return(&vexpress_restart_nb_refcnt) =3D=3D 1) {
> +		err =3D register_restart_handler(&vexpress_restart_nb);
> +		if (err) {
> +			dev_err(dev, "cannot register restart handler (err=3D%d)\n", err);
> +			atomic_dec(&vexpress_restart_nb_refcnt);
> +			return err;
> +		}
>  	}
>  	device_create_file(dev, &dev_attr_active);
>=20
> --
> 2.7.4
>=20

--tbp5wmsfoxyyydep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/fawACgkQ2O7X88g7
+pr28g/+Ir2JNbRQXJcCQ/SUQ15ir11JHlEtB5XjBh0pru+876lXp3vVsLA+F3Jg
A9XP0V+MUQET2xp/t2M85wL1pD800bCpo2HU2DsctAWzNRzSnEwzjgCbh4QA/1C9
uKdH4XzbxzR8s00AYXbFWG9kIHqZvJUGdfnJeu2HJZS1P4G5ZbTvF26BXkYIj0NK
aCfcvSMTNnHAsWTuBFMcpAG5tSHd7ClRsQacdbjfWARujhljbYz2bU3O0x3YUJqE
dnfrufqcQpZU22QZgN1WItJoe892yJUfp9Tl3mxDOsNUtfkSx4NP7mlNwrBt9seU
6sNXPFep3xu4lh63MVe89GyDyG/rCFtEJxZzPYaempjbu8/VNIAFu3OLEW2ffZIJ
87a/CgbHpUKZdww2PAEmk4lGN+30+8jRjqhJNAeFiy2PQ/R1yjINsP2gDD0uYlOQ
/g/Z2ysXJzGMJQW1s+i3f6M5w+uW3JFgJhTtEhVhUfO//lh+N4x83/9N5zaeOVkY
Y+ASE+uTLvrjKlJZPq7KmDzqB0DyZiVGUrKDPdgpN9VlV/3Pv3ni+RciZw/MdPK4
clfXdIDyx6vvpnxZiZcc4EUMUj28p8W1B+AqZi3jKbHGlrndHmqIkzcSv1n3DjAI
D+srvNmbqDmojSU0towAMIb02XhS01fOoZBh3uybWdP3saEr8wc=
=Smz/
-----END PGP SIGNATURE-----

--tbp5wmsfoxyyydep--


--===============5193216256073476777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5193216256073476777==--
