From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [linux-pm] [PATCH] hibernation should work ok with memory
	hotplug
Date: Mon, 03 Nov 2008 23:09:32 -0800
Message-ID: <1225782572.12673.540.camel@nimitz>
References: <20081029105956.GA16347@atrey.karlin.mff.cuni.cz>
	 <20081103125108.46d0639e.akpm@linux-foundation.org>
	 <1225747308.12673.486.camel@nimitz>  <200811032324.02163.rjw@sisk.pl>
	 <1225751665.12673.511.camel@nimitz> <1225771353.6755.16.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754497AbYKDHJr@vger.kernel.org>
In-Reply-To: <1225771353.6755.16.camel@nigel-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matt Tolentino <matthew.e.tolentino@intel.com>, linux-pm@lists.osdl.org, Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, pavel@suse.cz, Mel Gorman <mel@skynet.ie>, Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2008-11-04 at 15:02 +1100, Nigel Cunningham wrote:
> On Mon, 2008-11-03 at 14:34 -0800, Dave Hansen wrote:
> > A node might have a node_start_pfn=0 and a node_end_pfn=100 (and it may
> > have only one zone).  But, there may be another node with
> > node_start_pfn=10 and a node_end_pfn=20.  This loop:
> > 
> >         for_each_zone(zone) {
> >               ...
> >                 for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
> >                         if (page_is_saveable(zone, pfn))
> >                                 memory_bm_set_bit(orig_bm, pfn);
> >         }
> > 
> > will walk over the smaller node's pfn range multiple times.  Is this OK?
> > 
> > I think all you have to do to fix it is check page_zone(page) == zone
> > and skip out if they don't match.
> 
> So pfn 10 in the first node refers to the same memory as pfn 10 in the
> second node?

Sure.  But, remember that the pfns (and the entire physical address
space) is consistent across the entire system.  It's not like both nodes
have an address and the kernel only "gives" it to one of them.

There's real confusion about zone->zone_start/end_pfn, I think.  *All*
that they mean is this:

- zone_start_pfn is the lowest physical address present in the zone. 
- zone_end_pfn is the highest physical address present in the zone

That's *it*.  Those numbers imply *nothing* about the pages between
them, except that there might be 0 or more pages in there belonging to
the same zone.

"All pages in this zone lie between these two physical addresses." is
all they say.

-- Dave
