From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: NULL pointer dereference in swsusp_free with 3.17-rc5
Date: Tue, 23 Sep 2014 22:28 +0200
Message-ID: <1590285.IEab1jMVzk@vostro.rjw.lan>
References: <87zjdq8k7i.fsf@nemi.mork.no> <2218322.ridXK8jFtJ@vostro.rjw.lan> <878ulaxn6d.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49628 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755005AbaIWUIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Sep 2014 16:08:18 -0400
In-Reply-To: <878ulaxn6d.fsf@nemi.mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Joerg Roedel <jroedel@suse.de>
Cc: linux-pm@vger.kernel.org

On Tuesday, September 23, 2014 07:27:06 PM Bj=C3=B8rn Mork wrote:
>=20
> --=3D-=3D-=3D
> Content-Type: text/plain; charset=3Dutf-8
> Content-Transfer-Encoding: quoted-printable
>=20
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>=20
>=20
> > I would suspect one of these commits:
> >
> > 84c91b7ae07c PM / hibernate: avoid unsafe pages in e820 reserved re=
gions
> > 0f7d83e85dbd PM / Hibernate: Touch Soft Lockup Watchdog in rtree_ne=
xt_node
> > 9047eb629e5c PM / Hibernate: Remove the old memory-bitmap implement=
ation
> > 6efde38f0769 PM / Hibernate: Iterate over set bits instead of PFNs =
in sws=3D
> usp_free()
> > 3a20cb177961 PM / Hibernate: Implement position keeping in radix tr=
ee
> > 07a338236fdc PM / Hibernate: Add memory_rtree_find_bit function
> > f469f02dc6fa PM / Hibernate: Create a Radix-Tree to store memory bi=
tmap
> >
> > so I guess you can start from checking them (the topmpost one is th=
e late=3D
> st).
>=20
> Thanks.  Yes, you were correct. The bad commit is
>=20
>  6efde38f0769 PM / Hibernate: Iterate over set bits instead of PFNs i=
n swsu=3D
> sp_free()
>=20
> I have confirmed that reverting only this commit on top of a clean
> v3.17-rc6 fixes the problem.  I am attaching the context-modified rev=
ert
> patch I used.

OK, thanks!

Joerg, can you please have a look at this?


> --=3D-=3D-=3D
> Content-Type: text/x-diff
> Content-Disposition: inline;
>  filename=3D0001-Revert-PM-Hibernate-Iterate-over-set-bits-instead-of=
=2Epatch
>=20
> From 92950fd86c2f74ae17840bfc15651b6ae77e43df Mon Sep 17 00:00:00 200=
1
> From: =3D?UTF-8?q?Bj=3DC3=3DB8rn=3D20Mork?=3D <bjorn@mork.no>
> Date: Tue, 23 Sep 2014 19:18:43 +0200
> Subject: [PATCH] Revert "PM / Hibernate: Iterate over set bits instea=
d of
>  PFNs in swsusp_free()"
>=20
> This reverts commit 6efde38f07690652bf0d93f5e4f1a5f496574806.
>=20
> Conflicts:
> 	kernel/power/snapshot.c
> ---
>  kernel/power/snapshot.c |   50 ++++++++++++++-----------------------=
----------
>  1 file changed, 15 insertions(+), 35 deletions(-)
>=20
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index c4b8093c80b3..f1604d8cf489 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -725,14 +725,6 @@ static void memory_bm_clear_bit(struct memory_bi=
tmap *bm, unsigned long pfn)
>  	clear_bit(bit, addr);
>  }
> =20
> -static void memory_bm_clear_current(struct memory_bitmap *bm)
> -{
> -	int bit;
> -
> -	bit =3D max(bm->cur.node_bit - 1, 0);
> -	clear_bit(bit, bm->cur.node->data);
> -}
> -
>  static int memory_bm_test_bit(struct memory_bitmap *bm, unsigned lon=
g pfn)
>  {
>  	void *addr;
> @@ -1341,35 +1333,23 @@ static struct memory_bitmap copy_bm;
> =20
>  void swsusp_free(void)
>  {
> -	unsigned long fb_pfn, fr_pfn;
> -
> -	memory_bm_position_reset(forbidden_pages_map);
> -	memory_bm_position_reset(free_pages_map);
> -
> -loop:
> -	fr_pfn =3D memory_bm_next_pfn(free_pages_map);
> -	fb_pfn =3D memory_bm_next_pfn(forbidden_pages_map);
> -
> -	/*
> -	 * Find the next bit set in both bitmaps. This is guaranteed to
> -	 * terminate when fb_pfn =3D=3D fr_pfn =3D=3D BM_END_OF_MAP.
> -	 */
> -	do {
> -		if (fb_pfn < fr_pfn)
> -			fb_pfn =3D memory_bm_next_pfn(forbidden_pages_map);
> -		if (fr_pfn < fb_pfn)
> -			fr_pfn =3D memory_bm_next_pfn(free_pages_map);
> -	} while (fb_pfn !=3D fr_pfn);
> -
> -	if (fr_pfn !=3D BM_END_OF_MAP && pfn_valid(fr_pfn)) {
> -		struct page *page =3D pfn_to_page(fr_pfn);
> +	struct zone *zone;
> +	unsigned long pfn, max_zone_pfn;
> =20
> -		memory_bm_clear_current(forbidden_pages_map);
> -		memory_bm_clear_current(free_pages_map);
> -		__free_page(page);
> -		goto loop;
> +	for_each_populated_zone(zone) {
> +		max_zone_pfn =3D zone_end_pfn(zone);
> +		for (pfn =3D zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
> +			if (pfn_valid(pfn)) {
> +				struct page *page =3D pfn_to_page(pfn);
> +
> +				if (swsusp_page_is_forbidden(page) &&
> +				    swsusp_page_is_free(page)) {
> +					swsusp_unset_page_forbidden(page);
> +					swsusp_unset_page_free(page);
> +					__free_page(page);
> +				}
> +			}
>  	}
> -
>  	nr_copy_pages =3D 0;
>  	nr_meta_pages =3D 0;
>  	restore_pblist =3D NULL;
>=20

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
