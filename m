From: Joerg Roedel <jroedel@suse.de>
Subject: Re: NULL pointer dereference in swsusp_free with 3.17-rc5
Date: Wed, 24 Sep 2014 11:51:11 +0200
Message-ID: <20140924095111.GC10438@suse.de>
References: <87zjdq8k7i.fsf@nemi.mork.no>
 <2218322.ridXK8jFtJ@vostro.rjw.lan>
 <878ulaxn6d.fsf@nemi.mork.no>
 <1435748.4Qh6HZyMEY@vostro.rjw.lan>
 <87vbodihrd.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60048 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbaIXJvO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Sep 2014 05:51:14 -0400
Content-Disposition: inline
In-Reply-To: <87vbodihrd.fsf@nemi.mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Wed, Sep 24, 2014 at 09:45:26AM +0200, Bj=F8rn Mork wrote:
> >> Thanks.  Yes, you were correct. The bad commit is
> >>=20
> >>  6efde38f0769 PM / Hibernate: Iterate over set bits instead of PFN=
s in swsu=3D
> >> sp_free()
> >>=20
> >> I have confirmed that reverting only this commit on top of a clean
> >> v3.17-rc6 fixes the problem.  I am attaching the context-modified =
revert
> >> patch I used.

This is weird, because ...

> >
> > Instead of reverting the commit, can you please check if adding an =
"if (page)"
> > check around=20
> >
> > 		memory_bm_clear_current(forbidden_pages_map);
> > 		memory_bm_clear_current(free_pages_map);
> > 		__free_page(page);
> >
> > in swsusp_free() makes the NULL pointer deref go away?
>=20
> Tested.  But on a hunch, I also added this just to be sure:
>=20
>=20
> @@ -1343,7 +1343,15 @@ void swsusp_free(void)
>  {
>         unsigned long fb_pfn, fr_pfn;
> =20
> +WARN_ON(!forbidden_pages_map);
> +if (!forbidden_pages_map)
> +       return;
> +
>         memory_bm_position_reset(forbidden_pages_map);
> +WARN_ON(!free_pages_map);
> +if (!free_pages_map)
> +       return;
> +
>         memory_bm_position_reset(free_pages_map);

=2E.. the old code did not check for a valid forbidden_pages_map and
free_pages_map either, so it should crash there too.


	Joerg

