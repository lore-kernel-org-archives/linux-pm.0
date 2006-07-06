From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: memcpy() in swsusp (was: Re: [PATCH 2/2] Fix console
	handling during suspend/resume)
Date: Thu, 6 Jul 2006 22:35:16 +0200
Message-ID: <200607062235.16749.rjw@sisk.pl>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200607060719.44915.david-b@pacbell.net>
	<200607061626.53761.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607061626.53761.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 06 July 2006 16:26, Rafael J. Wysocki wrote:
> On Thursday 06 July 2006 16:19, David Brownell wrote:
> > =

> > > > > > I have seen that before: Atomic snapshot used fpu copy in some =
wrong
> > > > > > variants. Symptom was exactly that -- elevated preempt count --
> > > > > > because fpu copy routine elevated it, then copied the task stru=
ct.
> > > > > >
> > > > > > But I thought we solved that problem...?
> > > > >
> > > > > We did. We don't use memcpy for precisely that reason. 3DNOW memc=
py was one
> > > > > of the problem children. This would be a different creature thoug=
h,
> > > > > wouldn't it?
> > > > =

> > > > Hmm. Aparently we had a parting of ways on this at some point. Memc=
py is being =

> > > > used by swsusp, and it has been used since before 2.6.12-rc1. (This=
 is when =

> > > > doing the atomic copy, not resuming).
> > =

> > And it could well be that's when this bug appeared.  It's on an Athlon,
> > so that theory checks out as well as possible short of a patch.
> > =

> > =

> > > Do you mean the one in copy_data_pages()?  Indeed, that may be a prob=
lem if
> > > the MMU-based memcpy is used.
> > > =

> > > Pavel, should we fix this?
> > =

> > Of course it needs fixing ... it's a bug, also a regression.
> > =

> > My question is where to fix... swsusp_arch_resume() seems most
> > correct, albeit messy.  There's unfortunately no exact parallel
> > on the resume side to where the bug was inserted.  Those of us
> > who avoid hacking asm code might prefer restore_processor_state().
> =

> Well, I meant replacing the memcpy() in copy_data_pages with an open coded
> copying loop.  That should be enough to fix the problem.

To be more specific, could you please check if the appended patch (tested
on x86_64) helps?

Rafael


 kernel/power/snapshot.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6.17-mm6/kernel/power/snapshot.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17-mm6.orig/kernel/power/snapshot.c
+++ linux-2.6.17-mm6/kernel/power/snapshot.c
@@ -227,11 +227,17 @@ static void copy_data_pages(struct pbe *
 		for (zone_pfn =3D 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 			if (saveable(zone, &zone_pfn)) {
 				struct page *page;
+				long *src, *dst;
+				int n;
+
 				page =3D pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				BUG_ON(!pbe);
 				pbe->orig_address =3D (unsigned long)page_address(page);
-				/* copy_page is not usable for copying task structs. */
-				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
+				/* copy_page and memcpy are not usable for copying task structs. */
+				dst =3D (long *)pbe->address;
+				src =3D (long *)pbe->orig_address;
+				for (n =3D PAGE_SIZE / sizeof(long); n; n--)
+					*dst++ =3D *src++;
 				pbe =3D pbe->next;
 			}
 		}
