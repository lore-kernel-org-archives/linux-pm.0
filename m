From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [linux-pm] [PATCH] hibernation should work ok with memory
	hotplug
Date: Tue, 04 Nov 2008 18:30:37 +1100
Message-ID: <1225783837.6755.33.camel@nigel-laptop>
References: <20081029105956.GA16347@atrey.karlin.mff.cuni.cz>
	 <20081103125108.46d0639e.akpm@linux-foundation.org>
	 <1225747308.12673.486.camel@nimitz>  <200811032324.02163.rjw@sisk.pl>
	 <1225751665.12673.511.camel@nimitz> <1225771353.6755.16.camel@nigel-laptop>
	 <1225782572.12673.540.camel@nimitz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754072AbYKDHay@vger.kernel.org>
In-Reply-To: <1225782572.12673.540.camel@nimitz>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matt Tolentino <matthew.e.tolentino@intel.com>, linux-pm@lists.osdl.org, Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, pavel@suse.cz, Mel Gorman <mel@skynet.ie>, Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi.

On Mon, 2008-11-03 at 23:09 -0800, Dave Hansen wrote:
> > So pfn 10 in the first node refers to the same memory as pfn 10 in the
> > second node?
> 
> Sure.  But, remember that the pfns (and the entire physical address
> space) is consistent across the entire system.  It's not like both nodes
> have an address and the kernel only "gives" it to one of them.
> 
> There's real confusion about zone->zone_start/end_pfn, I think.  *All*
> that they mean is this:
> 
> - zone_start_pfn is the lowest physical address present in the zone. 
> - zone_end_pfn is the highest physical address present in the zone
> 
> That's *it*.  Those numbers imply *nothing* about the pages between
> them, except that there might be 0 or more pages in there belonging to
> the same zone.
> 
> "All pages in this zone lie between these two physical addresses." is
> all they say.

Okay. Thanks (and to Rafael).

One other question, if I may. Would you please explain (or point me to
an explanation) of PHYS_PFN_OFFSET/ARCH_PFN_OFFSET? I've been dealing
occasionally with people wanting to have hibernation on arm, and I don't
really get the concept or the implementation (particularly when it comes
to trying to do the sort of iterating over zones and pfns that was being
discussed in previous messages in this thread.

Regards,

Nigel
