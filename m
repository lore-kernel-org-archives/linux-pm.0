From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 01/10] dont copy pages that arent RAM
Date: Mon, 05 Feb 2007 19:30:28 +0100
Message-ID: <20070205185835.337746000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=dont-copy-non-ram-pages.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

Pages that aren't RAM obviously cannot be saved during suspend-to-disk
so skip them.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Pavel Machek requested this be put into -mm for some more
testing although he says it seems fine.

--- mb-wireless.orig/kernel/power/snapshot.c	2007-02-05 14:24:06.894526864 =
+0100
+++ mb-wireless/kernel/power/snapshot.c	2007-02-05 14:24:36.544526864 +0100
@@ -686,6 +686,8 @@ static struct page *saveable_page(unsign
 =

 	if (PageReserved(page) && pfn_is_nosave(pfn))
 		return NULL;
+	if (!page_is_ram(pfn))
+		return NULL;
 =

 	return page;
 }

--
