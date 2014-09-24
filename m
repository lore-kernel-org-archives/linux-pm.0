From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: NULL pointer dereference in swsusp_free with 3.17-rc5
Date: Thu, 25 Sep 2014 01:44:12 +0200
Message-ID: <19091504.rBv2mCrhao@vostro.rjw.lan>
References: <87zjdq8k7i.fsf@nemi.mork.no> <20140924095111.GC10438@suse.de> <87vbodiaq9.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51815 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750793AbaIXXYY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Sep 2014 19:24:24 -0400
In-Reply-To: <87vbodiaq9.fsf@nemi.mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Joerg Roedel <jroedel@suse.de>, linux-pm@vger.kernel.org

On Wednesday, September 24, 2014 12:17:18 PM Bj=C3=B8rn Mork wrote:
> Joerg Roedel <jroedel@suse.de> writes:
>=20
> >> @@ -1343,7 +1343,15 @@ void swsusp_free(void)
> >>  {
> >>         unsigned long fb_pfn, fr_pfn;
> >> =20
> >> +WARN_ON(!forbidden_pages_map);
> >> +if (!forbidden_pages_map)
> >> +       return;
> >> +
> >>         memory_bm_position_reset(forbidden_pages_map);
> >> +WARN_ON(!free_pages_map);
> >> +if (!free_pages_map)
> >> +       return;
> >> +
> >>         memory_bm_position_reset(free_pages_map);
> >
> > ... the old code did not check for a valid forbidden_pages_map and
> > free_pages_map either, so it should crash there too.
>=20
> Well, it did test AFAICS...  The 3.16 code is
>=20
> int swsusp_page_is_forbidden(struct page *page)
> {
>         return forbidden_pages_map ?
>                 memory_bm_test_bit(forbidden_pages_map, page_to_pfn(p=
age)) : 0;
> }
>=20
> ..
>=20
> void swsusp_free(void)
> {
> ..
>                                 if (swsusp_page_is_forbidden(page) &&
>                                     swsusp_page_is_free(page)) {
>                                         swsusp_unset_page_forbidden(p=
age);
>                                         swsusp_unset_page_free(page);
>                                         __free_page(page);
>                                 }
>=20
>=20
>=20
>=20
>=20

OK

I've decided to go with a revert for 3.17, as we don't seem to have an =
immediate
fix and the final 3.17 may be as close as this Sunday.  So I'm going to=
 send my
final pull request for 3.17 to Linus tomorrow or early on Friday.

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
