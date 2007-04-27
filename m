From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [RFC/PATCH 1/2] swsusp: preserve boot-time
	printk output after resume
Date: Fri, 27 Apr 2007 16:32:30 +0200
Message-ID: <1177684350.3565.13.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0704271002060.3430-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6558632109429195733=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0704271002060.3430-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org, nigel@nigel.suspend2.net, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============6558632109429195733==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/+f05GRCAUr7yb3d64Ib"


--=-/+f05GRCAUr7yb3d64Ib
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 10:03 -0400, Alan Stern wrote:

> Consider this: Add a debugfs file containing a binary value.  If the valu=
e=20
> is on then preserve the boot dmesg buffer.  If the value is off, don't=20
> preserve it -- overwrite the buffer pointers with values saved in the=20
> image.

Or just add a debugfs file containing the printk buffer from before? I'd
think it's only useful for debugging anyway.

johannes

--=-/+f05GRCAUr7yb3d64Ib
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMgl9/ETPhpq3jKURAhsXAKCJw0U5bWIYiFjZPqaAT9eJnCtbDgCfe/Ob
MSBD2PKMtOHzL+PDgmMH4DQ=
=Sy5O
-----END PGP SIGNATURE-----

--=-/+f05GRCAUr7yb3d64Ib--


--===============6558632109429195733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6558632109429195733==--
