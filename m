From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Mon, 26 Jun 2006 09:56:29 +1000
Message-ID: <200606260956.33991.ncunningham@linuxmail.org>
References: <Pine.LNX.4.44L0.0606241220100.19990-100000@netrider.rowland.org>
	<Pine.LNX.4.64.0606241518380.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0885957244=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606241518380.6483@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============0885957244==
Content-Type: multipart/signed; boundary="nextPart1553719.Shf4F2lK8u";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1553719.Shf4F2lK8u
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

I'll try again....

On Sunday 25 June 2006 08:28, Linus Torvalds wrote:
> +static int resume_device_early(struct device * dev)
> +{
> +	int error = 0;
> +
> +	TRACE_DEVICE(dev);
> +	TRACE_RESUME(0);
> +	if (dev->bus && dev->bus->resume_early) {
> +		dev_dbg(dev,"EARLY resume\n");
> +		error = dev->bus->resume(dev);

s/resume/resume_early/

> +	}
> +	TRACE_RESUME(error);
> +	return error;
> +}

Regards,

Nigel

--nextPart1553719.Shf4F2lK8u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEnyKxN0y+n1M3mo0RAldEAKDxCvTW77qeztMV8Gm1UmmRVBgClACgsy5N
n7t74Rj7cikMYc/RWrzRkBM=
=X7f/
-----END PGP SIGNATURE-----

--nextPart1553719.Shf4F2lK8u--

--===============0885957244==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0885957244==--
