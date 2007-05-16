From: Marcus Better <marcus@better.se>
Subject: Re: Re: 2.6.22-rc1 suspend to RAM problem
Date: Wed, 16 May 2007 15:39:54 +0200
Message-ID: <200705161539.58185.marcus@better.se>
References: <f2evir$8n1$1@sea.gmane.org> <f2f02b$a47$1@sea.gmane.org>
	<200705161534.42740.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5119822562847573365=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705161534.42740.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============5119822562847573365==
Content-Type: multipart/signed; boundary="nextPart4992484.bMD3UXgK8U";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4992484.bMD3UXgK8U
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Rafael J. Wysocki wrote:
> Please revert it.  It's a debug-only patch and it fiddles with too many
> things.
>
> Does the hibernation work with it, BTW?

Yes, that's why I left it in place. Will remove and try again.

Thanks,

Marcus

--nextPart4992484.bMD3UXgK8U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGSwmuXjXn6TzcAQkRAhLqAJ9sDDe00hv98n5PzWvurhMjeauIlwCgofez
lfHqObvfGBxsQo+pobGrLKc=
=OhnN
-----END PGP SIGNATURE-----

--nextPart4992484.bMD3UXgK8U--

--===============5119822562847573365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5119822562847573365==--
