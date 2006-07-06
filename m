From: Dave Jones <davej@redhat.com>
Subject: Re: memcpy() in swsusp (was: Re: [PATCH 2/2] Fix console
	handling during suspend/resume)
Date: Thu, 6 Jul 2006 17:01:01 -0400
Message-ID: <20060706210101.GU13168@redhat.com>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200607060719.44915.david-b@pacbell.net>
	<200607061626.53761.rjw@sisk.pl>
	<200607061344.43314.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200607061344.43314.david-b@pacbell.net>
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

On Thu, Jul 06, 2006 at 01:44:42PM -0700, David Brownell wrote:
 > =

 > > > Of course it needs fixing ... it's a bug, also a regression.
 > > > =

 > > > My question is where to fix...
 > > =

 > > Well, I meant replacing the memcpy() in copy_data_pages with an open c=
oded
 > > copying loop.  That should be enough to fix the problem.
 > =

 > One like this?  Yes, it works.  The slower speed shouldn't be
 > much of an issue here.  (Though I'm glad that something in RC1
 > has gotten rid of that slowdown in reading/writing snapshots.)

Why not just use __memcpy instead? Which should be safe on all archs
to do the simplest possible memcpy.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/kernel/power/snapshot.c~	2006-07-06 16:56:11.000000000 -0400
+++ linux-2.6/kernel/power/snapshot.c	2006-07-06 16:59:11.000000000 -0400
@@ -230,8 +230,9 @@ static void copy_data_pages(struct pbe *
 				page =3D pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				BUG_ON(!pbe);
 				pbe->orig_address =3D (unsigned long)page_address(page);
-				/* copy_page is not usable for copying task structs. */
-				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
+				/* copy_page is not usable for copying task structs.
+				 * neither is memcpy on some cpus */
+				__memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
 				pbe =3D pbe->next;
 			}
 		}
-- =

http://www.codemonkey.org.uk
