From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: lockdep report in hibernate code
Date: Thu, 25 Oct 2007 15:31:19 +0200
Message-ID: <1193319079.6092.22.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0710231750370.21581-100000@netrider.rowland.org>
	<200710240018.02655.rjw@sisk.pl>
	<1193215220.4097.8.camel@johannes.berg>
	<20071024215715.GA9524@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2665315587980091079=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071024215715.GA9524@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============2665315587980091079==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-aGaGjdSmRD4B0EZ2xykA"


--=-aGaGjdSmRD4B0EZ2xykA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-24 at 14:57 -0700, Greg KH wrote:
> On Wed, Oct 24, 2007 at 10:40:20AM +0200, Johannes Berg wrote:
> > On Wed, 2007-10-24 at 00:18 +0200, Rafael J. Wysocki wrote:
> >=20
> > > Yes, which is what I think is happening in this particular case.  Mor=
e
> > > precisely, we get pm_mutex while holding a buffer mutex, so lockdep i=
s warning
> > > when we get another buffer mutex afterwards.
> >=20
> > Precisely. That's why I copied Greg on the second mail :) It seems that
> > sysfs already uses nested locks, but that only protects against lockdep
> > reporting a false positive for nested locks, not this case.
>=20
> Ok, I'm confused, where is the sysfs issue here?

We have two paths here:

 (a) sysfs write -> lock buffer -> call power management code=20
     -> lock pm_mutex
 (b) boot code -> power management boot -> lock pm_mutex
     -> use name_to_dev_t() -> call sysfs -> lock buffer

As you can see, lockdep rightfully complains about a possible deadlock
scenario although of course (b) only happens once at boot at a time
where (a) cannot happen. And now we're wondering how to fix it.

johannes

--=-aGaGjdSmRD4B0EZ2xykA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARyCapqVg1VMiehFYAQIFLA//Wj8P2aXRjpnQIvKVA1A9VrkNTXlI40qo
chQBH4rWtxwBEX15uweuu0NhKKf091aS9yxtW4jjLF/M8rvYE47ta4ZPMt6zJ9X3
hSLE6MQaGcrZFkIU9zw8K0fXv5TWmRCRmdJtNaDTjljR8+VRnLfJ/lhfmbCDwaSc
+guRKdhCLZs8yPZAurfqaaa4DcbbD2TVOq+ZP33tf8yuYdfgNBlbP/PjsW6z7JBy
5+uZf0DMdjc6VW2ASbPz4FVY1Bk+02EV324dKd7gYuXDo4JyUWsAK2i8e9dOFwRV
LYVLWxbZfyqOSZ+0c1jVq1VRe8AlfmpjVIy2vBWzmYwvz8z7iXWJw1L7NnXCXHcM
CthM4oQpzyQ7pTZmFDv/6uM5GPSxgLyefKGF508v+uwAfBx8bzk9bbACAIPVWDxK
AReKFiiHMZjOPTqOtVrm3u95w4jzihdm2eNu2kVC45YrQ+fXhwnr26H/ubgRK7Ng
rTBbcqGmdo/wCK79E8wEPR9LrjPgsdpsl1IVyIjVLd24RijXe4fssGzC0LzQdjvL
RuxgbkXoHWcW/fP4md4WTMwHelwZEHjTt4KE4U5eqE2yO+A0uOto24pNxyxdU4DM
pC7xkqLklk79pc2m2SNDJDcSMVZzWFlEuoraJZmq1/UkAmWsgIjsiubLWLZ1VbG/
dGMIzD+PQ4Q=
=AvzH
-----END PGP SIGNATURE-----

--=-aGaGjdSmRD4B0EZ2xykA--


--===============2665315587980091079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2665315587980091079==--
