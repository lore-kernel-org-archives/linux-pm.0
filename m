From: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [linux-pm] OOPS: divide error while s2dsk (2.6.20-rc1-mm1)
Date: Mon, 18 Dec 2006 17:18:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64N.0612181716110.10074@attu4.cs.washington.edu>
References: <4586797B.3080007@gmail.com> <200612181646.23292.rjw@sisk.pl>
 <4586C99C.9020606@gmail.com> <200612182338.24843.rjw@sisk.pl>
 <20061218151710.32ceba0d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932606AbWLSBSk@vger.kernel.org>
In-Reply-To: <20061218151710.32ceba0d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jiri Slaby <jirislaby@gmail.com>, linux-pm@lists.osdl.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, 18 Dec 2006, Andrew Morton wrote:

> diff -puN mm/vmscan.c~shrink_all_memory-fix-lru_pages-handling mm/vmscan.c
> --- a/mm/vmscan.c~shrink_all_memory-fix-lru_pages-handling
> +++ a/mm/vmscan.c
> @@ -1484,6 +1484,16 @@ static unsigned long shrink_all_zones(un
>  	return ret;
>  }
>  
> +static unsigned long count_lru_pages(void)
> +{
> +	struct zone *zone;
> +	unsigned long ret = 0;
> +
> +	for_each_zone(zone);
> +		ret += zone->nr_active + zone->nr_inactive;
> +	return ret;
> +}
> +
>  /*
>   * Try to free `nr_pages' of memory, system-wide, and return the number of
>   * freed pages.

There's an extra semicolon there that results in only the final zone being 
used.

		David
