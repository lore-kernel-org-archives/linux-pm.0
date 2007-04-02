From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21-rc5: swsusp: Not enough free memory
Date: Mon, 2 Apr 2007 23:18:27 +0200
Message-ID: <200704022318.28451.rjw@sisk.pl>
References: <460B6E4B.3060004@gmail.com> <200704012123.54797.rjw@sisk.pl>
	<4610BDD7.5070201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4610BDD7.5070201@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-pm@lists.osdl.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 2 April 2007 10:24, Jiri Slaby wrote:
> Rafael J. Wysocki napsal(a):
> >>> On Thursday, 29 March 2007 09:44, Jiri Slaby wrote:
> >>>> swsusp: critical section:
> >>>> swsusp: Need to copy 131380 pages
> >>>> swsusp: Not enough free memory
> >>>> Error -12 suspending
> >>>> Enabling non-boot CPUs ...
> =

> > As a workaround, you can try to change the initial image size so that i=
t's
> > smaller than a half of the RAM size.  If that works, I'd like to send y=
ou a
> > debug patch, if you don't mind. :-)
> =

> Yes, post it.

Appended.  Please send me the dmesg output from after a failing suspend
(or in case it doesn't fail, from after the first one).

> # cat /sys/power/image_size
> 524288000
> # echo disk >/sys/power/state
> error
> # echo disk >/sys/power/state
> error
> # echo $((400*1024*1024)) > /sys/power/image_size
> # echo disk >/sys/power/state
> ok
> # dmesg|grep Memory:
> Memory: 1027160k/1048256k available (2559k kernel code, 20348k reserved,
> 1114k data, 188k init)
> =

> I don't undestand it too much, but can't be shared video memory involved
> somehow?

No, I don't think so.  There probably is a bug in swsusp_shrink_memory().

Greetings,
Rafael

---
---
 kernel/power/snapshot.c |    2 +-
 kernel/power/swsusp.c   |   10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

Index: linux-2.6.21-rc5/kernel/power/snapshot.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21-rc5.orig/kernel/power/snapshot.c
+++ linux-2.6.21-rc5/kernel/power/snapshot.c
@@ -1093,7 +1093,7 @@ static int enough_free_mem(unsigned int =

 	}
 =

 	nr_pages +=3D count_pages_for_highmem(nr_highmem);
-	pr_debug("swsusp: Normal pages needed: %u + %u + %u, available pages: %u\=
n",
+	printk("swsusp: Normal pages needed: %u + %u + %u, available pages: %u\n",
 		nr_pages, PAGES_FOR_IO, meta, free);
 =

 	return free > nr_pages + PAGES_FOR_IO + meta;
Index: linux-2.6.21-rc5/kernel/power/swsusp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21-rc5.orig/kernel/power/swsusp.c
+++ linux-2.6.21-rc5/kernel/power/swsusp.c
@@ -227,22 +227,26 @@ int swsusp_shrink_memory(void)
 		size =3D count_data_pages() + PAGES_FOR_IO;
 		tmp =3D size;
 		size +=3D highmem_size;
-		for_each_zone (zone)
+		for_each_zone (zone) {
+			printk("Normal pages needed: %lu\n", tmp);
+			printk("Highmem pages needed: %lu\n", highmem_size);
 			if (populated_zone(zone)) {
+				tmp +=3D snapshot_additional_pages(zone);
 				if (is_highmem(zone)) {
 					highmem_size -=3D
 					zone_page_state(zone, NR_FREE_PAGES);
 				} else {
 					tmp -=3D zone_page_state(zone, NR_FREE_PAGES);
 					tmp +=3D zone->lowmem_reserve[ZONE_NORMAL];
-					tmp +=3D snapshot_additional_pages(zone);
 				}
 			}
+		}
 =

 		if (highmem_size < 0)
 			highmem_size =3D 0;
 =

 		tmp +=3D highmem_size;
+		printk("Pages needed (total): %lu\n", tmp);
 		if (tmp > 0) {
 			tmp =3D __shrink_memory(tmp);
 			if (!tmp)
@@ -252,7 +256,7 @@ int swsusp_shrink_memory(void)
 			tmp =3D __shrink_memory(size - (image_size / PAGE_SIZE));
 			pages +=3D tmp;
 		}
-		printk("\b%c", p[i++%4]);
+		/*printk("\b%c", p[i++%4]);*/
 	} while (tmp > 0);
 	do_gettimeofday(&stop);
 	printk("\bdone (%lu pages freed)\n", pages);
