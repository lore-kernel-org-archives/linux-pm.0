From: Daniel Borkmann <danborkmann@googlemail.com>
Subject: Re: [suspend/resume] Re: userspace notification from
	module
Date: Sun, 03 Jan 2010 10:30:19 +0100
Message-ID: <4B4063AB.7080401__25138.5260293775$1262619346$gmane$org@gmail.com>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001022201.04281.rjw@sisk.pl>
	<7cf4f51f.5fc2a5cd.4b3fc3ad.c849c@o2.pl>
	<201001030029.22449.rjw@sisk.pl>
	<65e5aef6.33251eb4.4b3fecf4.a2f99@o2.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5864581087423634562=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <65e5aef6.33251eb4.4b3fecf4.a2f99@o2.pl>
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
To: =?UTF-8?B?QmFydMWCb21pZWogWmltb8WE?= <uzi18@o2.pl>
Cc: Andy Walls <awalls@radix.net>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============5864581087423634562==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6BF2C4CEF03E3F232970A04E"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6BF2C4CEF03E3F232970A04E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Bart=C5=82omiej Zimo=C5=84 wrote:
> Dnia 3 stycznia 2010 0:29 "Rafael J. Wysocki" <rjw@sisk.pl> napisa=C5=82=
(a):
>>> Thanks for Your answare.
>>> Some points of my idea:
>>> - don't think everyone want to use pm-utils (didn't say it is bad)
>> That certainly is true, but I think these people won't have a problem =
setting
>> up their suspend scripts to trigger the notification anyway. :-)
>>
>=20
> But it means almoust always create dbus interface and send message by s=
cript.
> For what? only to know if system going resume or suspend?

Hmm.. dbus looks like a bit too much overhead for me, just to bring this
information to your process, there should be an easier way to do this.

> Abosulutly no!
> It's so primitive module and even with different api it could be easy t=
o adept.
> Next if it can't be in kernel source tree for someone could be very use=
full.
>=20
> This module could only sends bool/ioctl - system resumed.
>=20
>> At least, that requires some more discussion, so please tell us why yo=
u need
>> the kernel to notify the user space about suspend/hibernation.  IOW, w=
hat's the
>> final purpose of this?  [Added some CCs.]
>=20
> Yes, it is only first step.
> Have created different point of view, not all linux boxes are desktops/=
laptops.
> What about embedeed solutions?
> Why app must implement all other to know about resume/suspend?
> Why not open file and know this easily?

I actually don't like the idea to put such information into a file
either. Anyways, if you'd have a thread polling for these file contents,
I think a thread that does netlink comunication (from the userspace
side) would be the better soultion. Then, your module takes care to
broadcast the message to the registered clients.

Have a look at:

http://www.linuxjournal.com/article/7356

> What about this discusion:
> http://lists.freedesktop.org/archives/devkit-devel/2009-December/000617=
=2Ehtml
>=20
> I will perform some tests to know what amount of time is usualy needed =
to disconnect
> nicely client or something.

Actually I think this is what signals are there for and bringing this
information via signals would have least overhead, problem is that this
is not POSIX compliant, but may be you could have a try at this?!

Regards,
Daniel


--------------enig6BF2C4CEF03E3F232970A04E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAktAY6sACgkQ5AxJm1m3CC8LqgCghUm4z5R70BmvlVBDXeMl6h/r
HzUAoIIj09mSDBBklpgRKUd4w8U6DNbx
=ne8m
-----END PGP SIGNATURE-----

--------------enig6BF2C4CEF03E3F232970A04E--

--===============5864581087423634562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5864581087423634562==--
