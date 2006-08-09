From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 0/5] swsusp: Fix handling of highmem
Date: Wed, 9 Aug 2006 11:52:49 +0200
Message-ID: <200608091152.49094.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux PM <linux-pm@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

Currently swsusp handles highmem in a simplistic way, by trying to store a
copy of each saveable highmem page in the "normal" memory before creating
the suspend image.  These copies are then copied once again before saving,
because they are treated as any other non-highmem pages with data.  For this
reason, to save one highmem page swsusp needs two free pages in the "normal"
memory, so on a system with high memory it is practically impossible to cre=
ate
a suspend image above 400 kilobytes.  Moreover, if there's much more highmem
than the "normal" memory in the system, it may be impossible to suspend at =
all
due to the lack of space for saving non-freeable highmem pages.

This limitation may be overcome in a satisfactory way if swsusp does its be=
st
to store the copies of saveable highmem pages in the highmem itself.  Howev=
er,
for this purpose swsusp has to be taught to use pfns, or (struct page *)
pointers, instead of kernel virtual addresses to identify memory pages.
Yet, if this is to be implemented, we can also attack the minor problem that
the current swsusp's internal data structure, the list of page backup entri=
es
(aka PBEs), is not very efficient as far as the memory usage is concerned.

This issue can be addressed by replacing the list of PBEs with a pair of
memory bitmaps.  Still, to remove the list of PBEs completely, we would
have to make some complicated modifications to the architecture-dependent
parts of the code which would be quite undesirable.  However, we can use
the observation that memory is only a limiting resource during the suspend
phase of the suspend-resume cycle, because during the resume phase
many image pages may be loaded directly to their "original" page frames, so
we don't need to keep a copy of each of them in the memory.  Thus the list =
of
PBEs may be used safely in the last part of the resume phase without limitt=
ing
the amount of memory we can use.

The following series of patches introduces the memory bitmap data structure,
makes swsusp use it to store its internal information and implements the
improved handling of saveable highmem pages.

Comments welcome.

Greetings,
Rafael
