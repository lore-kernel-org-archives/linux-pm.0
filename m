From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Wed, 26 Apr 2006 08:30:51 +1000
Message-ID: <200604260830.57866.nigel@suspend2.net>
References: <200604242355.08111.rjw@sisk.pl> <200604260021.08888.rjw@sisk.pl>
	<20060425222526.GG6379@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============34297731530274245=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060425222526.GG6379@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============34297731530274245==
Content-Type: multipart/signed; boundary="nextPart3177110.UtBlh3quKl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3177110.UtBlh3quKl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI.

On Wednesday 26 April 2006 08:25, Pavel Machek wrote:
> Hi!
>
> > > It does apply to all of the LRU pages. This is what I've been doing f=
or
> > > years now. The only corner case I've come across is XFS. It still wan=
ts
> > > to write data even when there's nothing to do and it's threads are
> > > frozen (IIRC - haven't looked at it for a while). I got around that by
> > > freezing bdevs when freezing processes.
> >
> > This means if we freeze bdevs, we'll be able to save all of the LRU
> > pages, except for the pages mapped by the current task, without copying=
=2E=20
> > I think we can try to do this, but we'll need a patch to freeze bdevs f=
or
> > this purpose. ;-)
>
> ...adding more dependencies to how vm/blockdevs work. I'd say current
> code is complex enough...

You assume too much. This is just using existing code.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart3177110.UtBlh3quKl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETqMhN0y+n1M3mo0RAr9tAJ9ifhv4Uj4nSLzTcsuMHnDIJjzeCgCg3zIB
RImCXPYDKkoYy7h2vbDBwg4=
=hDS7
-----END PGP SIGNATURE-----

--nextPart3177110.UtBlh3quKl--

--===============34297731530274245==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============34297731530274245==--
