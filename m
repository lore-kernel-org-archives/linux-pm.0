From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: suspend2 merge (was Re: [Suspend2-devel] Re: CFS and
	suspend2: hang in atomic copy)
Date: Fri, 27 Apr 2007 14:07:03 +0200
Message-ID: <1177675623.6024.5.camel__46196.3265472606$1177676302$gmane$org@johannes.berg>
References: <20070425072350.GA6866@ucw.cz> <200704271218.07120.rjw@sisk.pl>
	<1177669179.7828.53.camel@johannes.berg>
	<200704271409.56687.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8756725908545647798=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704271409.56687.rjw@sisk.pl>
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
Cc: Nick Piggin <npiggin@suse.de>, Nigel Cunningham <nigel@nigel.suspend2.net>, Ingo Molnar <mingo@elte.hu>, Pavel Machek <pavel@ucw.cz>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>, suspend2-devel@lists.suspend2.net, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============8756725908545647798==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Duv+W3zEEh/Xf3CK2V7z"


--=-Duv+W3zEEh/Xf3CK2V7z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 14:09 +0200, Rafael J. Wysocki wrote:

> Yes.  Still, I'd like to rework your patch to deal with ACPI without
> introducing hibernate_ops .  I'm going to do this later today if you don'=
t
> mind. :-)

Not at all :) That's why I actually sent it out instead of just saying
"well I give up it breaks user.c"

johannes

--=-Duv+W3zEEh/Xf3CK2V7z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMedm/ETPhpq3jKURAmzgAJ0UPtMWRQqszy3TTebsAdowYCdonwCgmww1
M7AKOJZXkosQfpUASSO4HWI=
=TE+E
-----END PGP SIGNATURE-----

--=-Duv+W3zEEh/Xf3CK2V7z--


--===============8756725908545647798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8756725908545647798==--
