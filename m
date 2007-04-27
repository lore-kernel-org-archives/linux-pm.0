From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Fri, 27 Apr 2007 16:49:51 +0200
Message-ID: <1177685391.3565.22.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0704271008540.3430-100000@iolanthe.rowland.org>
	<1177684764.3565.20.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6242769109834517123=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177684764.3565.20.camel@johannes.berg>
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
Cc: Nick Piggin <npiggin@suse.de>, Pavel Machek <pavel@ucw.cz>, Mike Galbraith <efault@gmx.de>, Kernel development list <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, suspend2-devel@lists.suspend2.net, linux-pm <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============6242769109834517123==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-d3dVFZWUqqs8GQ5o4eJI"


--=-d3dVFZWUqqs8GQ5o4eJI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 16:39 +0200, Johannes Berg wrote:

> Good point. Though if we go for passing the interrupt-enable setting as
> an argument then many drivers will have the same
> "if (irqs_disabled()) return" code. Hm. I guess passing it isn't even
> strictly necessary.

Eh, the point I actually wanted to make is that many drivers don't care
for the irqs disabled case and would have to add code to exclude it.

johannes

--=-d3dVFZWUqqs8GQ5o4eJI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMg2P/ETPhpq3jKURAlFSAKC58IY4REN7J4Z2orFc3GjSOD7AfACbBJ1i
3SsunRItONabcfep2bqhFZM=
=V/xn
-----END PGP SIGNATURE-----

--=-d3dVFZWUqqs8GQ5o4eJI--


--===============6242769109834517123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6242769109834517123==--
