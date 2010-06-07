From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [TuxOnIce-devel] [SUSPECTED SPAM] Re: Proposal for a
	new algorithm for reading & writing a hibernation image.
Date: Mon, 7 Jun 2010 15:07:49 +0200
Message-ID: <201006071507.56259.Martin__46879.8233465806$1275916125$gmane$org@lichtvoll.de>
References: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
	<201006062104.55869.rjw@sisk.pl> <4C0C843D.6030008@crca.org.au>
	(sfid-20100607_101218_800330_88257A1C)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5974671091268040881=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C0C843D.6030008@crca.org.au>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============5974671091268040881==
Content-Type: multipart/signed;
  boundary="nextPart1336033.bEN4aNCQnZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1336033.bEN4aNCQnZ
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Montag 07 Juni 2010 schrieb Nigel Cunningham:
> Hi.

Hi Nigel and Rafael, hi everyone else involved,

> On 07/06/10 05:04, Rafael J. Wysocki wrote:
> > On Sunday 06 June 2010, Maxim Levitsky wrote:
> >> On Sun, 2010-06-06 at 15:57 +0200, Rafael J. Wysocki wrote:
> >>> On Sunday 06 June 2010, Maxim Levitsky wrote:
> > ...
> >=20
> >>> So how TuxOnIce helps here?
> >>=20
> >> Very simple.
> >>=20
> >> With swsusp, I can save 750MB (memory) + 250 Vram (vram)
> >> With full memory save I can save (1750 MB of memory) + 250 MB of
> >> vram....
> >=20
> > So what about being able to save 1600 MB total instead of the 2 GB
> > (which is what we're talking about in case that's not clear)?  Would
> > it be _that_ _much_ worse?
>=20
> That all depends on what is in the 400MB you discard.
>=20
> The difference is "Just as if you'd never hibernated" vs something
> closer to "Just as if you'd only just started up". We can't make
> categorical statements because it really does depend upon what you
> discard and what you want to do post-resume - that is, how useful the
> memory you discard would have been. That's always going to vary from
> case to case.

Nigel and Rafael, how about just testing it?

Whats needed to have 80% of the memory saved instead of 50%?

I think its important to go the next steps towards a better snapshot in=20
mainline kernel even when you do not agree on the complete end result yet.

What about

=2D Rafael, you review the async write patches of Nigel. If they are good,=
=20
IMHO they should go in as soon as possible.

=2D Nigel and/or Rafael, you look at whats needed to save 80% instead of 50=
%=20
of the memory and develop a patch for it


?

Then this goes into one stable kernel series and be tested in the wild.=20
And if that approach does not suffice to give a similar experience than wit=
h=20
TuxOnIce one could still look further. In that case I ask you Rafael, to=20
at least listen open-mindedly to practical experiences being told and to=20
ideas to improve the situation.

I really want to see this make some progress instead of getting stuck in=20
discussion loops again. No offence meant - you do the all the development=20
work! - but the time spent here IMHO is better spent on reviewing and=20
furtherly refining the existing patches by Nigel and Jiri and developing a=
=20
patchset for the 80% solution which should already help a lot.

Does that incremental approach sound acceptable for the time being?

IMHO *any* step forward helps!

Ciao,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart1336033.bEN4aNCQnZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwM7yUACgkQmRvqrKWZhMdjuACeNw2R/TdbnUykRgEo9JSRN/CZ
hHEAn1qBq0Pe0MX5cZ4KZZUjpGhw2ZVy
=D/Wr
-----END PGP SIGNATURE-----

--nextPart1336033.bEN4aNCQnZ--

--===============5974671091268040881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5974671091268040881==--
