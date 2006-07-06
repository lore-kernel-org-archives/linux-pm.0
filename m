From: David Brownell <david-b@pacbell.net>
Subject: Re: memcpy() in swsusp (was: Re: [PATCH 2/2] Fix console
	handling during suspend/resume)
Date: Thu, 6 Jul 2006 13:44:42 -0700
Message-ID: <200607061344.43314.david-b@pacbell.net>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200607060719.44915.david-b@pacbell.net>
	<200607061626.53761.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7YXrECZgXmtCdD4"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607061626.53761.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_7YXrECZgXmtCdD4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> > Of course it needs fixing ... it's a bug, also a regression.
> > 
> > My question is where to fix...
> 
> Well, I meant replacing the memcpy() in copy_data_pages with an open coded
> copying loop.  That should be enough to fix the problem.

One like this?  Yes, it works.  The slower speed shouldn't be
much of an issue here.  (Though I'm glad that something in RC1
has gotten rid of that slowdown in reading/writing snapshots.)

- Dave



--Boundary-00=_7YXrECZgXmtCdD4
Content-Type: text/x-diff;
  charset="us-ascii";
  name="k7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="k7.patch"

On some cpus memcpy() is not appropriate for copying task structs, any more
than copy_page().  For example, on Athlons it uses 3dnow acceleration, which
causes the snapshotted task struct to have the wrong preempt count on resume.

This just replaces the swsusp snapshot memcpy() with an inlined always-safe
version so that hibernation works again on K7 and various other cpus where
such acceleration is used.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/kernel/power/snapshot.c
===================================================================
--- g26.orig/kernel/power/snapshot.c	2006-07-03 10:45:30.000000000 -0700
+++ g26/kernel/power/snapshot.c	2006-07-06 09:33:07.000000000 -0700
@@ -227,11 +227,19 @@ static void copy_data_pages(struct pbe *
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 			if (saveable(zone, &zone_pfn)) {
 				struct page *page;
+				u8 *src, *dest, *last;
+
 				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				BUG_ON(!pbe);
 				pbe->orig_address = (unsigned long)page_address(page);
-				/* copy_page is not usable for copying task structs. */
-				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
+				/* copy_page is not usable for copying task
+				 * structs; neither is memcpy on some cpus.
+				 */
+				dest = (u8 *)pbe->address;
+				last = dest + PAGE_SIZE;
+				src = (u8 *)pbe->orig_address;
+				while (dest != last)
+					*dest++ = *src++;
 				pbe = pbe->next;
 			}
 		}

--Boundary-00=_7YXrECZgXmtCdD4
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_7YXrECZgXmtCdD4--
