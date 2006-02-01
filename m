From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [RFC][PATCH -mm][Experimental] swsusp: freeze
	userspace processes first
Date: Wed, 1 Feb 2006 21:18:59 +1000
Message-ID: <200602012119.07233.nigel@suspend2.net>
References: <200602010141.53974.rjw@sisk.pl> <20060201105505.GB2879@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============82944708097561515=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060201105505.GB2879@elf.ucw.cz>
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
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============82944708097561515==
Content-Type: multipart/signed; boundary="nextPart2016756.lQPU2cOqjn";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2016756.lQPU2cOqjn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 01 February 2006 20:55, Pavel Machek wrote:
> Hi!
>
> > This is an experimantal patch aimed at the "unable to freeze processes
> > under load" problem.
> >
> > On my box the 2.6.16-rc1-mm4 kernel with this patch applied survives the
> > "dd if=3D/dev/hda of=3D/dev/null" test.
>
> What filesystem? ext2 vs. ext3 is very different. I can fix ext2 by
> just upping the timeout. ext3 is harder, because of the journalling
> thread. Maybe I'll take the sledgehammer approach and just freeze all
> the user tasks first... I tried to do the "small" approach and just
> fix the journalling code...
>
> I'm not sure what problem the usermodehelper code is trying to
> solve... why are usermodehelpers special?

This is related to the 'Hotplug events during sleep transition' thread from=
=20
the PM list from December.

Regards,

Nigel


=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2016756.lQPU2cOqjn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4JkrN0y+n1M3mo0RAqbpAKDJHqT4PgcVDrmbqmc/Fz99V8+6gQCfXk/t
czl4s8FpMoctC+MlWgZSCyo=
=4xd6
-----END PGP SIGNATURE-----

--nextPart2016756.lQPU2cOqjn--

--===============82944708097561515==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============82944708097561515==--
