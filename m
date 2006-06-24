From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 21:16:30 +1000
Message-ID: <200606242116.35384.ncunningham@linuxmail.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<Pine.LNX.4.64.0606232029200.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1281315165=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606232029200.6483@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============1281315165==
Content-Type: multipart/signed; boundary="nextPart11194912.0hcv8tPmq4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart11194912.0hcv8tPmq4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

I've been quiet so far because I'm too busy with other things. I am reading=
=20
the discussion (if that's the right word) though.

A couple of questions about the patch:

> +static int resume_device_early(struct device * dev)
> +{
> +	int error =3D 0;
>
> +	if (dev->bus && dev->bus->resume_early) {
> +		dev_dbg(dev,"EARLY resume\n");
> +		error =3D dev->bus->resume(dev);

Should this be resume_early(dev)?

> +/*
> + * Resume the devices that have either not gone through
> + * the late suspend, or that did go through it but also
> + * went through the early resume
> + */
>  void dpm_resume(void)
>  {
>  	down(&dpm_list_sem);
> @@ -96,11 +115,9 @@ void dpm_power_up(void)
>  		struct list_head * entry =3D dpm_off_irq.next;
>  		struct device * dev =3D to_device(entry);
>
> -		get_device(dev);
>  		list_del_init(entry);
> -		list_add_tail(entry, &dpm_active);
> -		resume_device(dev);
> -		put_device(dev);
> +		list_add_tail(entry, &dpm_off);
> +		resume_device_early(dev);

No need for getting a reference on the device anymore?

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart11194912.0hcv8tPmq4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEnR8TN0y+n1M3mo0RApudAJ4okPVq6j4rh1WBfs7RfPHJxrZ09wCg0CPi
cGcWJ8wLmg4tAGo9rorx4dA=
=jtTx
-----END PGP SIGNATURE-----

--nextPart11194912.0hcv8tPmq4--

--===============1281315165==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1281315165==--
