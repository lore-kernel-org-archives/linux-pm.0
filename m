From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][PATCH 2/3] swsusp: Do not use page flags
Date: Tue, 13 Mar 2007 15:47:14 +1100
Message-ID: <45F62CD2.5030103@yahoo.com.au>
References: <Pine.LNX.4.64.0702160212150.21862@schroedinger.engr.sgi.com>
	<200703011633.54625.rjw@sisk.pl> <200703041450.02178.rjw@sisk.pl>
	<200703041507.57122.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703041507.57122.rjw@sisk.pl>
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

>  }
>  =

>  /**
> + *	This structure represents a range of page frames the contents of which
> + *	should not be saved during the suspend.
> + */
> +
> +struct nosave_region {
> +	struct list_head list;
> +	unsigned long start_pfn;
> +	unsigned long end_pfn;
> +};
> +
> +static LIST_HEAD(nosave_regions);
> +
> +/**
> + *	register_nosave_region - register a range of page frames the contents
> + *	of which should not be saved during the suspend (to be used in the ea=
rly
> + *	initializatoion code)
> + */
> +
> +void __init
> +register_nosave_region(unsigned long start_pfn, unsigned long end_pfn)
> +{
> +	struct nosave_region *region;
> +
> +	if (start_pfn >=3D end_pfn)
> +		return;
> +
> +	if (!list_empty(&nosave_regions)) {
> +		/* Try to extend the previous region (they should be sorted) */
> +		region =3D list_entry(nosave_regions.prev,
> +					struct nosave_region, list);
> +		if (region->end_pfn =3D=3D start_pfn) {
> +			region->end_pfn =3D end_pfn;
> +			goto Report;
> +		}
> +	}
> +	/* This allocation cannot fail */
> +	region =3D alloc_bootmem_low(sizeof(struct nosave_region));
> +	region->start_pfn =3D start_pfn;
> +	region->end_pfn =3D end_pfn;
> +	list_add_tail(&region->list, &nosave_regions);
> + Report:
> +	printk("swsusp: Registered nosave memory region: %016lx - %016lx\n",
> +		start_pfn << PAGE_SHIFT, end_pfn << PAGE_SHIFT);
> +}


I wonder why you reimplemented this and put it in snapshot.c, rather than
use my version which was nicely in its own file, had appropriate locking,
etc.?

-- =

SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com =
