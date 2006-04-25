From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Wed, 26 Apr 2006 06:28:35 +1000
Message-ID: <200604260628.41003.nigel@suspend2.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200604250911.54951.david-b@pacbell.net>
	<200604252056.56534.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============10398706518480161=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604252056.56534.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============10398706518480161==
Content-Type: multipart/signed; boundary="nextPart5538800.lTngAySedz";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5538800.lTngAySedz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 26 April 2006 04:56, Rafael J. Wysocki wrote:
> You're saying that (9) is wrong, so could you please suggest what to do
> instead of it?

'scuse me for butting in, but here's my suggested modified version:

> Well, suppose we have a modular driver that's not loaded before resume.
> Then it goes like that (approximately):
> (1) We activate swsusp which calls .suspend() for all devices including o=
ur
> driver (this is a real suspend).
> (2) swsusp snapshots the system and creates the image.
> (3) swsusp calls .resume() for all devices in order to be able to save the
> image (.resume() for our driver is also called which is OK).
> (4) swsusp turns off the system.
> (5) (some time later) We start a new kernel and tell it to resume.
> (6) It activates swsusp which reads the image.
> (7) (without your change) swsusp calls .suspend() for all device drivers
> that are present at that time, but our driver is not there, so its
> .suspend() _won't_ be called.  [Of course with your change .suspend() won=
't
> be called for any driver.]

We also make a list that is safely available after the atomic restore of=20
drivers that have had .suspend methods called.

> (8) swsusp restores the image.

(9) suspend to disk calls .resume() for each device that is found in the li=
st=20
generated above, thereby excluding our problem driver. Drivers which are=20
present but not in the list above (such as the problem driver) have a=20
different routine called, perhaps the normal initialisation one?

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart5538800.lTngAySedz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEToZ4N0y+n1M3mo0RAsMMAKDUA26dh6LW+P+kaxeISHJbYGfk3ACeKI1d
fvOLAT05tqP5hlVfh9F9ols=
=5cub
-----END PGP SIGNATURE-----

--nextPart5538800.lTngAySedz--

--===============10398706518480161==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============10398706518480161==--
