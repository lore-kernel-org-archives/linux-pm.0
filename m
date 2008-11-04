From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [linux-pm] [PATCH] hibernation should work ok with memory
	hotplug
Date: Tue, 04 Nov 2008 07:39:42 -0800
Message-ID: <1225813182.12673.587.camel@nimitz>
References: <20081029105956.GA16347@atrey.karlin.mff.cuni.cz>
	 <200811040954.34969.rjw@sisk.pl> <1225812111.12673.577.camel@nimitz>
	 <200811041635.49932.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755810AbYKDPkR@vger.kernel.org>
In-Reply-To: <200811041635.49932.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Matt Tolentino <matthew.e.tolentino@intel.com>, linux-pm@lists.osdl.org, Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, pavel@suse.cz, Mel Gorman <mel@skynet.ie>, Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2008-11-04 at 16:35 +0100, Rafael J. Wysocki wrote:
> On Tuesday, 4 of November 2008, Dave Hansen wrote:
> > On Tue, 2008-11-04 at 09:54 +0100, Rafael J. Wysocki wrote:
> > > To handle this, I need to know two things:
> > > 1) what changes of the zones are possible due to memory hotplugging
> > > (i.e.    can they grow, shring, change boundaries etc.)
> > 
> > All of the above. 
> 
> OK
> 
> If I allocate a page frame corresponding to specific pfn, is it guaranteed to
> be associated with the same pfn in future?

Page allocation is different.  Since you hold a reference to a page, it
can not be removed until you release that reference.  That's why every
normal alloc_pages() user in the kernel doesn't have to worry about
memory hotplug.

> > Why walk zones instead of pgdats? 
> 
> This is a historical thing rather than anything else.  I think we could switch
> to pgdats, but that would require a code rewrite that's likely to introduce
> bugs, while our image-creating code is really well tested and doesn't change
> very often.

OK, fair enough.  I just wanted you to know that there are options other
than zones.

-- Dave
