From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [linux-pm] [PATCH] hibernation should work ok with memory
	hotplug
Date: Mon, 03 Nov 2008 23:53:44 -0800
Message-ID: <1225785224.12673.564.camel@nimitz>
References: <20081029105956.GA16347@atrey.karlin.mff.cuni.cz>
	 <20081103125108.46d0639e.akpm@linux-foundation.org>
	 <1225747308.12673.486.camel@nimitz>  <200811032324.02163.rjw@sisk.pl>
	 <1225751665.12673.511.camel@nimitz> <1225771353.6755.16.camel@nigel-laptop>
	 <1225782572.12673.540.camel@nimitz> <1225783837.6755.33.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754736AbYKDHyA@vger.kernel.org>
In-Reply-To: <1225783837.6755.33.camel@nigel-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matt Tolentino <matthew.e.tolentino@intel.com>, linux-pm@lists.osdl.org, Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, pavel@suse.cz, Mel Gorman <mel@skynet.ie>, Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2008-11-04 at 18:30 +1100, Nigel Cunningham wrote:
> One other question, if I may. Would you please explain (or point me to
> an explanation) of PHYS_PFN_OFFSET/ARCH_PFN_OFFSET? I've been dealing
> occasionally with people wanting to have hibernation on arm, and I don't
> really get the concept or the implementation (particularly when it comes
> to trying to do the sort of iterating over zones and pfns that was being
> discussed in previous messages in this thread.

First of all, I think PHYS_PFN_OFFSET is truly an arch-dependent
construct.  It only appears in arm an avr32.  I'll tell you only how
ARCH_PFN_OFFSET looks to me.  My guess is that those two arches need to
reconcile themselves and start using ARCH_PFN_OFFSET instead.

In the old days, we only had memory that started at physical address 0x0
and went up to some larger address.  We allocated a mem_map[] of 'struct
pages' in one big chunk, one for each address.  mem_map[0] was for
physical address 0x0 and mem_map[1] was for 0x1000, mem_map[2] was for
0x2000 and so on...

If a machine didn't have a physical address 0x0, we allocated mem_map[]
for it anyway and just wasted that entry.  What ARCH_PFN_OFFSET does is
let us bias the mem_map[] structure so that mem_map[0] does not
represent 0x0.

If ARCH_PFN_OFFSET is 1, then mem_map[0] actually represents the
physical address 0x1000.  If it is 2, then mem_map[0] represents
physical addr 0x2000.  ARCH_PFN_OFFSET means that the first physical
address on the machine is at ARCH_PFN_OFFSET*PAGE_SIZE.  We bias all
lookups into the mem_map[] so that we don't waste space in it.  There
will never be a zone_start_pfn lower than ARCH_PFN_OFFSET, for instance.

What does that mean for walking zones?  Nothing.  It only has meaning
for how we allocate and do lookups into the mem_map[].  But, since
everyone uses pfn_to_page() and friends, you don't ever see this.

I'm curious why you think you need to be concerned with it.

-- Dave
