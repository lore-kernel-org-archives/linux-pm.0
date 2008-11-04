From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH] hibernation should work ok with memory hotplug
Date: Mon, 03 Nov 2008 16:52:47 -0800
Message-ID: <1225759967.12673.521.camel@nimitz>
References: <20081029105956.GA16347@atrey.karlin.mff.cuni.cz>
	 <200811040005.12418.rjw@sisk.pl> <1225753819.12673.518.camel@nimitz>
	 <200811040129.35335.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755812AbYKDAxS@vger.kernel.org>
In-Reply-To: <200811040129.35335.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, pavel@suse.cz, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org, Matt Tolentino <matthew.e.tolentino@intel.com>, Dave Hansen <haveblue@us.ibm.com>, linux-mm@kvack.org, Mel Gorman <mel@skynet.ie>, Andy Whitcroft <apw@shadowen.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2008-11-04 at 01:29 +0100, Rafael J. Wysocki wrote:
> > Since zone *ranges* overlap, you can't tell to which zone a page belongs
> > simply from its address.  You need to ask the 'struct page'.
> 
> Understood.
> 
> This means that some zones may contain some ranges of pfns that correspond
> to struct pages in another zone, correct?

Yup, that's correct.

The patch looks good to me.

-- Dave
