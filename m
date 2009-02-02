From: Uli Luckas <u.luckas@road.de>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Mon, 2 Feb 2009 11:42:11 +0100
Message-ID: <200902021142.15092.u.luckas@road.de>
References: <Pine.LNX.4.44L0.0901311049260.6305-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6327898493061229784=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0901311049260.6305-100000@netrider.rowland.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: swetland@google.com, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

--===============6327898493061229784==
Content-Type: multipart/signed;
  boundary="nextPart2109473.Z4Jp7yPoIk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2109473.Z4Jp7yPoIk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday, 31. January 2009, Alan Stern wrote:
> > Also, consider the case where the user presses the power button to go
> > to sleep. Before this sleep request has finished a phone call comes
> > in. The driver gets an interrupt, enqueues the message and locks a
> > wakelock to make sure user-space gets a chance to process the message.
> > If we ignore this wakelock, the phone will either not ring at all, or
> > it will ring later when the device wakes up for some other reason.
>
> For situations like this, the driver can simply refuse to suspend. =A0You
> don't need to use a wakelock.
>
> In fact, if you did use a wakelock the behavior would be very strange. =A0
> The user presses the power button, an instant later a call comes in,
> the device doesn't go to sleep, the user answers the call, and as soon
> as he hangs up (perhaps 10 minutes later) the wakelock is released and
> the device immediately goes to sleep! =A0Not what the user would expect.
Hi Alan,
we have had a (userspace) wake-lock implementation on our handyPC devices f=
or=20
a couple of years now. So maybe I can shed some light.

The above quote underlines pretty well, where Arve's and your ideas of=20
eraly-suspend and wake-locks diverge. And why you are missunderstanding eac=
h=20
other.
Arve is always talking about "blanking the screen" because that's what the=
=20
users sees. From the user's perspective the device is "suspended" as soon a=
s=20
his user interfaces vanishes. That's probably also why his notions=20
of "suspend" and "wake" are not alway following a strict definition.=20
If the device stays blanked while the user has his 10 min phone conversatio=
n,=20
then he won't even notice wether the device suspends or not after the call.=
=20
This is the idea. The user does not care for anything they can't see.

Arve is not talking about a laptop that needs to sleep befor it's ventilati=
on=20
slot are covered. He is talking about a phone that could well do with only=
=20
blanking it's screen. Except it want's to save battery when ever possible.


Uli

=2D-=20

=2D------ ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien

--nextPart2109473.Z4Jp7yPoIk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmGzgMACgkQG/Gdq+fBSQu3KQCcDRrC3RHSJicym5QOZs3NBXYZ
BWQAnjs7pJ4o1oBOgOk0LI2hBNq79e7j
=/uK+
-----END PGP SIGNATURE-----

--nextPart2109473.Z4Jp7yPoIk--

--===============6327898493061229784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6327898493061229784==--
