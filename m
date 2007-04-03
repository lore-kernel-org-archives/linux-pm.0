From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21-rc5: swsusp: Not enough free memory
Date: Tue, 3 Apr 2007 12:50:06 +0200
Message-ID: <200704031250.07307.rjw@sisk.pl>
References: <460B6E4B.3060004@gmail.com> <200704022318.28451.rjw@sisk.pl>
	<46120449.7070302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46120449.7070302@gmail.com>
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

On Tuesday, 3 April 2007 09:37, Jiri Slaby wrote:
> Rafael J. Wysocki napsal(a):
> > On Monday, 2 April 2007 10:24, Jiri Slaby wrote:
> >> Rafael J. Wysocki napsal(a):
> >>>>> On Thursday, 29 March 2007 09:44, Jiri Slaby wrote:
> >>>>>> swsusp: critical section:
> >>>>>> swsusp: Need to copy 131380 pages
> >>>>>> swsusp: Not enough free memory
> >>>>>> Error -12 suspending
> >>>>>> Enabling non-boot CPUs ...
> >>> As a workaround, you can try to change the initial image size so that=
 it's
> >>> smaller than a half of the RAM size.  If that works, I'd like to send=
 you a
> >>> debug patch, if you don't mind. :-)
> >> Yes, post it.
> > =

> > Appended.  Please send me the dmesg output from after a failing suspend
> > (or in case it doesn't fail, from after the first one).
> =

> It doesn't fail, here is the output:

Okay, so I think the appended patch is needed.  Could you please revert the
debug one, apply the appended one instead and see if it helps?

> Shrinking memory...  Normal pages needed: 135122
> Highmem pages needed: 0
> Normal pages needed: 132256
> Highmem pages needed: 0
> Normal pages needed: 8271
> Highmem pages needed: 0
> Pages needed (total): 8271
> Normal pages needed: 119657
> Highmem pages needed: 0
> Normal pages needed: 116791
> Highmem pages needed: 0
> Normal pages needed: 18446744073709528969
> Highmem pages needed: 0
> Pages needed (total): 18446744073709528969
> =

> Heh :), tmp is signed, this is -22647, I guess.

Yup.

> done (15505 pages freed)
> Freed 62020 kbytes in 0.16 seconds (387.62 MB/s)
> =

> Complete dmesg may be obtained here:
> http://www.fi.muni.cz/~xslaby/sklad/dmesg.swsusp

Thanks for testing.

Greetings,
Rafael

---
 kernel/power/swsusp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.21-rc5/kernel/power/swsusp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21-rc5.orig/kernel/power/swsusp.c
+++ linux-2.6.21-rc5/kernel/power/swsusp.c
@@ -229,13 +229,13 @@ int swsusp_shrink_memory(void)
 		size +=3D highmem_size;
 		for_each_zone (zone)
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
 =
