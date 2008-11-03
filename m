From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH] hibernation should work ok with memory hotplug
Date: Mon, 03 Nov 2008 15:10:19 -0800
Message-ID: <1225753819.12673.518.camel@nimitz>
References: <20081029105956.GA16347@atrey.karlin.mff.cuni.cz>
	 <200811032324.02163.rjw@sisk.pl> <1225751665.12673.511.camel@nimitz>
	 <200811040005.12418.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756295AbYKCXKy@vger.kernel.org>
In-Reply-To: <200811040005.12418.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, pavel@suse.cz, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org, Matt Tolentino <matthew.e.tolentino@intel.com>, Dave Hansen <haveblue@us.ibm.com>, linux-mm@kvack.org, Mel Gorman <mel@skynet.ie>, Andy Whitcroft <apw@shadowen.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2008-11-04 at 00:05 +0100, Rafael J. Wysocki wrote:
> On Monday, 3 of November 2008, Dave Hansen wrote:
> > But, as I think about it, there is another issue that we need to
> > address, CONFIG_NODES_SPAN_OTHER_NODES.
> > 
> > A node might have a node_start_pfn=0 and a node_end_pfn=100 (and it may
> > have only one zone).  But, there may be another node with
> > node_start_pfn=10 and a node_end_pfn=20.  This loop:
> > 
> >         for_each_zone(zone) {
> > 		...
> >                 for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
> >                         if (page_is_saveable(zone, pfn))
> >                                 memory_bm_set_bit(orig_bm, pfn);
> >         }
> > 
> > will walk over the smaller node's pfn range multiple times.  Is this OK?
> 
> Hm, well, I'm not really sure at the moment.
> 
> Does it mean that, in your example, the pfns 10 to 20 from the first node
> refer to the same page frames that are referred to by the pfns from the
> second node?

Maybe using pfns didn't make for a good example.  I could have used
physical addresses as well.

All that I'm saying is that nodes (and zones) can span other nodes (and
zones).  This means that the address ranges making up that node can
overlap with the address ranges of another node.  This doesn't mean that
*each* node has those address ranges.  Each individual address can only
be in one node.

Since zone *ranges* overlap, you can't tell to which zone a page belongs
simply from its address.  You need to ask the 'struct page'.

> > I think all you have to do to fix it is check page_zone(page) == zone
> > and skip out if they don't match.
> 
> Well, probably.  I need to know exactly what's the relationship between pfns,
> pages and physical page frames in that case.

1 pfn == 1 'struct page' == 1 physical page

The only exception to that is that we may have more 'struct pages' than
we have actual physical memory due to rounding and so forth.

-- Dave
