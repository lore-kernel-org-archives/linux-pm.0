From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 27 Feb 2009 15:07:14 +0100
Message-ID: <200902271507.14747.u.luckas@road.de>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902131749.57728.u.luckas@road.de>
	<20090227131807.GA1482@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8750649905656630640=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090227131807.GA1482@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: "swetland@google.com" <swetland@google.com>, linux-pm@lists.linux-foundation.org, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

--===============8750649905656630640==
Content-Type: multipart/signed;
  boundary="nextPart1914900.WxF7tQ4TXP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1914900.WxF7tQ4TXP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday, 27. February 2009, Pavel Machek wrote:
> On Fri 2009-02-13 17:49:57, Uli Luckas wrote:
> > On Friday, 13. February 2009, Matthew Garrett wrote:
> > > Userland ABI would then be a single /dev/inhibit_suspend,
> > > with the counter being bumped each time an application opens it. It'll
> > > automatically be dropped if the application exits without cleaning up.
> > >
> > > This seems simpler and also avoids any arguments about the naming
> > > scheme. What am I missing?
> >
> > Opening and closing an fd sounds like a lot of overhead. Taking and
> > releasing locks if going to be a called with very highg frequency. I'd =
go
> > for an ioctl.
>
> Ehm?
>
> And introduce nasty interface, and probably slower too since open() is
> time-critical and ioctl() is not? Or do you have benchmarks?
> 								Pavel

No, just specualting as open() needs to do a directory lookup. It also need=
s=20
to do book keeping. I'd be surprised if open was faster then ioctl.

On the otherhand if you consider ioctl nasty, maybe write() is an option?

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

--nextPart1914900.WxF7tQ4TXP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmn85IACgkQG/Gdq+fBSQvfRQCgn7CQVkpFSa12F0t57tzFpYPl
Z2QAn1Bj684+rtBK93Fn3KNZ9aJgosP8
=xyj3
-----END PGP SIGNATURE-----

--nextPart1914900.WxF7tQ4TXP--

--===============8750649905656630640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8750649905656630640==--
