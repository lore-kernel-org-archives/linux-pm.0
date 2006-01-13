From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Fri, 13 Jan 2006 20:53:37 +0100
Message-ID: <200601132053.43085.ioe-lkml@rameria.de>
References: <200601122241.07363.rjw@sisk.pl>
	<20060112220940.GA10088@elf.ucw.cz>
	<200601130031.34624.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============43965124834248304=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200601130031.34624.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-kernel@vger.kernel.org
Cc: Linux PM <linux-pm@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============43965124834248304==
Content-Type: multipart/signed; boundary="nextPart1178421.APgeozDvNR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1178421.APgeozDvNR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Friday 13 January 2006 00:31, Rafael J. Wysocki wrote:
> On Thursday, 12 January 2006 23:09, Pavel Machek wrote:
> > > +SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swap (the las=
t argument
> > > +	should be a pointer to an unsigned int variable that will contain
> > > +	the result if the call is successful)
> >=20
> > Is this good idea? It will overflow on 32-bit systems. Ammount of
> > available swap can be >4GB. [Or maybe it is in something else than
> > bytes, then you need to specify it.]
>=20
> It returns the number of pages.  Well, it should be written explicitly,
> so I'll fix that.

Please always talk to the kernel in bytes. Pagesize is only a kernel
internal unit. Sth. like off64_t is fine.


Regards

Ingo Oeser


--nextPart1178421.APgeozDvNR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDyAVHU56oYWuOrkARAqalAJ9h4PHCadTL5Xdq+VKWHsXSl83EpQCgpKG9
5LlCZ4b0IeyN+PuwMsVlJm4=
=H5YZ
-----END PGP SIGNATURE-----

--nextPart1178421.APgeozDvNR--

--===============43965124834248304==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============43965124834248304==--
