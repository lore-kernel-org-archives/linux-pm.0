From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][PATCH 1/3] swsusp: Do not use page flags
	directly
Date: Tue, 13 Mar 2007 15:45:12 +1100
Message-ID: <45F62C58.50106@yahoo.com.au>
References: <Pine.LNX.4.64.0702160212150.21862@schroedinger.engr.sgi.com>
	<200703011633.54625.rjw@sisk.pl> <200703041450.02178.rjw@sisk.pl>
	<200703041507.45171.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703041507.45171.rjw@sisk.pl>
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
Cc: linux-mm@kvack.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.osdl.org>, Johannes Berg <johannes@sipsolutions.net>, Christoph Lameter <clameter@engr.sgi.com>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> Make swsusp stop using SetPageNosave(), SetPageNosaveFree() and friends
> directly.
> =

> This way the amount of changes made in the next patch is smaller.
> =

> ---
>  include/linux/suspend.h |   33 +++++++++++++++++++++++++++++++++
>  kernel/power/snapshot.c |   48 +++++++++++++++++++++++++----------------=
-------
>  mm/page_alloc.c         |    6 +++---
>  3 files changed, 61 insertions(+), 26 deletions(-)
> =

> Index: linux-2.6.21-rc2/include/linux/suspend.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.21-rc2.orig/include/linux/suspend.h	2007-03-02 09:05:53.000=
000000 +0100
> +++ linux-2.6.21-rc2/include/linux/suspend.h	2007-03-02 09:24:02.00000000=
0 +0100
> @@ -8,6 +8,7 @@
>  #include <linux/notifier.h>
>  #include <linux/init.h>
>  #include <linux/pm.h>
> +#include <linux/mm.h>
>  =

>  /* struct pbe is used for creating lists of pages that should be restored
>   * atomically during the resume from disk, because the page frames they =
have
> @@ -49,6 +50,38 @@ void __save_processor_state(struct saved
>  void __restore_processor_state(struct saved_context *ctxt);
>  unsigned long get_safe_page(gfp_t gfp_mask);
>  =

> +/* Page management functions for the software suspend (swsusp) */
> +
> +static inline void swsusp_set_page_forbidden(struct page *page)
> +{
> +	SetPageNosave(page);
> +}
> +
> +static inline int swsusp_page_is_forbidden(struct page *page)
> +{
> +	return PageNosave(page);
> +}
> +
> +static inline void swsusp_unset_page_forbidden(struct page *page)
> +{
> +	ClearPageNosave(page);
> +}
> +
> +static inline void swsusp_set_page_free(struct page *page)
> +{
> +	SetPageNosaveFree(page);
> +}
> +
> +static inline int swsusp_page_is_free(struct page *page)
> +{
> +	return PageNosaveFree(page);
> +}
> +
> +static inline void swsusp_unset_page_free(struct page *page)
> +{
> +	ClearPageNosaveFree(page);
> +}

Hi,

I don't have much to do with swsusp, but I really prefer that a
page flag name should tell you what the property of the page is,
rather than what this subsystem should or shouldn't do with it.

I thought the page flag names I used were pretty nice, and a big
improvement overthe current page flag names.

-- =

SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com =
