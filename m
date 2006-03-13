From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: Re: standby to disk transition
Date: Mon, 13 Mar 2006 23:55:00 +1000
Message-ID: <200603132355.08318.nigel@suspend2.net>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<20060313083037.GA3495@elf.ucw.cz>
	<20060313084811.GC20569@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============53012128382210277=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060313084811.GC20569@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: linux-pm@osdl.org, "Victor Porton, , , " <porton@ex-code.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============53012128382210277==
Content-Type: multipart/signed; boundary="nextPart1473316.NT34QdfbFH";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1473316.NT34QdfbFH
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 13 March 2006 18:48, Adam Belay wrote:
> On Mon, Mar 13, 2006 at 09:30:38AM +0100, Pavel Machek wrote:
> > On Po 13-03-06 07:34:36, Victor Porton,,, wrote:
> > > There should be something such which would cause (after user
> > > specified timeout, e.g. a hour) automatically switch the
> > > system from standby to suspend to disk (or suspend to mem).
> >
> > ....
> >
> > > Or as a possible alternative, we could suspend SIMULTANEOUSLY
> > > to disk and to mem (with switching into suspend-to-disk by
> > > timeout), to have both quick restoration and automatically
> > > fully turning it off.
> >
> > Yep, it would be nice.
> >
> > Does that mean you are working on it and will send me a patch? Do you
> > want help coding?
> > 							Pavel
>
> The simultaneous idea sounds very similar to the idea Nigel had around a
> year ago.  It may have been implemented to some degree.

Yes, it's been implemented for ages, and works fine.

> The timeout feature could be done using the ACPI alarm interface, but
> there's no reliable way of knowing how long the system can remain in a
> suspend state on the x86 mobile platform, so waking up at the right time
> would be tricky if not impossible.

I'd like this too. I think, though, that the interval should be configurabl=
e.=20
No one knows how long a battery will last better than the person who owns t=
he=20
laptop and has learnt from experience that on this computer 4% is where the=
=20
computer switches off but on the other computer, you can run it down to 2%.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1473316.NT34QdfbFH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEFXm8N0y+n1M3mo0RAojyAJ43scof5uMylpKTH7IBEOxBHVSnMwCffz0i
vyqdxGiSA5FjB4vZApRr6Sk=
=RTcg
-----END PGP SIGNATURE-----

--nextPart1473316.NT34QdfbFH--

--===============53012128382210277==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============53012128382210277==--
