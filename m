From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [linux-pm] [PATCH] hibernation should work ok with memory
	hotplug
Date: Mon, 03 Nov 2008 23:36:14 -0800
Message-ID: <1225784174.12673.547.camel@nimitz>
References: <20081029105956.GA16347@atrey.karlin.mff.cuni.cz>
	 <1225751665.12673.511.camel@nimitz> <1225771353.6755.16.camel@nigel-laptop>
	 <200811040808.36464.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754635AbYKDHg3@vger.kernel.org>
In-Reply-To: <200811040808.36464.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Matt Tolentino <matthew.e.tolentino@intel.com>, linux-pm@lists.osdl.org, Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, pavel@suse.cz, Mel Gorman <mel@skynet.ie>, Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2008-11-04 at 08:08 +0100, Rafael J. Wysocki wrote:
> A pfn always refers to specific page frame and/or struct page, so yes.
> However, in one of the nodes these pfns are sort of "invalid" (they point
> to struct pages belonging to other zones).  AFAICS.

Part of this problem is getting out of the old zone mindset.  It used to
be that there were one, two, or three zones, set up at boot, with static
ranges.  These never had holes, never changed, and were always stacked
up nice and tightly on top of one another.  It ain't that way no more.

Now, the zones are much more truly "allocation pools".  They're bunches
of memory with similar attributes and hypervisors or firmware can hand
them to the OS in very interesting ways.  This means that the attributes
that help us pool the memory together have less and less to do with
physical addresses.  A given physical address a decreasing chance of
being related to its neighbor.

-- Dave
