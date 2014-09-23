From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: NULL pointer dereference in swsusp_free with 3.17-rc5
Date: Tue, 23 Sep 2014 23:20:09 +0200
Message-ID: <1435748.4Qh6HZyMEY@vostro.rjw.lan>
References: <87zjdq8k7i.fsf@nemi.mork.no> <2218322.ridXK8jFtJ@vostro.rjw.lan> <878ulaxn6d.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58306 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754575AbaIWVAW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Sep 2014 17:00:22 -0400
In-Reply-To: <878ulaxn6d.fsf@nemi.mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: linux-pm@vger.kernel.org, Joerg Roedel <jroedel@suse.de>

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

Instead of reverting the commit, can you please check if adding an "if =
(page)"
check around=20

		memory_bm_clear_current(forbidden_pages_map);
		memory_bm_clear_current(free_pages_map);
		__free_page(page);

in swsusp_free() makes the NULL pointer deref go away?

Rafael

