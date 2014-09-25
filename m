From: Joerg Roedel <jroedel@suse.de>
Subject: Re: NULL pointer dereference in swsusp_free with 3.17-rc5
Date: Thu, 25 Sep 2014 11:13:18 +0200
Message-ID: <20140925091318.GA4269@suse.de>
References: <87zjdq8k7i.fsf@nemi.mork.no>
 <20140924095111.GC10438@suse.de>
 <87vbodiaq9.fsf@nemi.mork.no>
 <19091504.rBv2mCrhao@vostro.rjw.lan>
 <87egv0i2sl.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33814 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603AbaIYJNW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Sep 2014 05:13:22 -0400
Content-Disposition: inline
In-Reply-To: <87egv0i2sl.fsf@nemi.mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Thu, Sep 25, 2014 at 09:20:58AM +0200, Bj=F8rn Mork wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>=20
> > I've decided to go with a revert for 3.17, as we don't seem to have=
 an immediate
> > fix and the final 3.17 may be as close as this Sunday.  So I'm goin=
g to send my
> > final pull request for 3.17 to Linus tomorrow or early on Friday.
>=20
> Sounds safest to me, FWIW.

Yes, sorry for the delay, I am still fighting with my cold and couldn't
get around to send a fix sooner :/

> For the next round of this, I think the only missing part was some te=
st
> like
>=20
>         if (!forbidden_pages_map || !free_pages_map)
>            goto return_without_freeing_anything;

Right, this is pretty much the fix. Can you please test the attached
patch?

> And BTW, I believe it would be useful if at least one more person in =
the
> world tested hibernation between each release ;-)

Well, I tested these patches on at least 4 or 5 different hardware
configurations. I also know of other people testing hibernation with -r=
c
kernels, but this is the first report of this issue I have seen. I
wonder what it different in your setup so that you trigger this bug.

Anyway, it would be great if you could test the patch below :)

Thanks,

	Joerg

=46rom fe599eff60cfbfbb1f894dc476ee28f38aef954b Mon Sep 17 00:00:00 200=
1
=46rom: Joerg Roedel <jroedel@suse.de>
Date: Thu, 25 Sep 2014 11:04:40 +0200
Subject: [PATCH] PM: Hibernate: Fix NULL pointer access in swsusp_free

The optimized version of swsusp_free does not check the
bitmap pointers anymore, which may cause a NULL pointer
dereference and a kernel crash. Fix it by adding the checks
and bail out if one of them is NULL.

Reported-by: Bj=F8rn Mork <bjorn@mork.no>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 kernel/power/snapshot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index c4b8093..791a618 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1343,6 +1343,9 @@ void swsusp_free(void)
 {
 	unsigned long fb_pfn, fr_pfn;
=20
+	if (!forbidden_pages_map || !free_pages_map)
+		goto out;
+
 	memory_bm_position_reset(forbidden_pages_map);
 	memory_bm_position_reset(free_pages_map);
=20
@@ -1370,6 +1373,7 @@ loop:
 		goto loop;
 	}
=20
+out:
 	nr_copy_pages =3D 0;
 	nr_meta_pages =3D 0;
 	restore_pblist =3D NULL;
--=20
1.8.4.5

