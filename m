From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/6] PM / Hibernate: Create a Radix-Tree to store
 memory bitmap
Date: Tue, 22 Jul 2014 01:05:30 +0200
Message-ID: <20140721230530.GB7019@amd.pavel.ucw.cz>
References: <1405938422-21900-1-git-send-email-joro@8bytes.org>
 <1405938422-21900-2-git-send-email-joro@8bytes.org>
 <20140721223637.GU30979@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53924 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbaGUXFc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 19:05:32 -0400
Content-Disposition: inline
In-Reply-To: <20140721223637.GU30979@8bytes.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>

On Tue 2014-07-22 00:36:37, Joerg Roedel wrote:
> Pavel,
> 
> On Mon, Jul 21, 2014 at 12:26:57PM +0200, Joerg Roedel wrote:
> >  unsigned int snapshot_additional_pages(struct zone *zone)
> >  {
> > +	unsigned int rtree, nodes;
> >  	unsigned int res;
> >  
> >  	res = DIV_ROUND_UP(zone->spanned_pages, BM_BITS_PER_BLOCK);
> >  	res += DIV_ROUND_UP(res * sizeof(struct bm_block),
> >  			    LINKED_PAGE_DATA_SIZE);
> > -	return 2 * res;
> > +	rtree = nodes = DIV_ROUND_UP(zone->spanned_pages, BM_BITS_PER_BLOCK);
> > +	rtree += DIV_ROUND_UP(rtree * sizeof(struct rtree_node),
> > +			      LINKED_PAGE_DATA_SIZE);
> > +	while (nodes > 1) {
> > +		nodes = DIV_ROUND_UP(nodes, BM_ENTRIES_PER_LEVEL);
> > +		rtree += nodes;
> > +	}
> > +
> > +	return 2 * (res + rtree);
> >  }
> 
> Since you asked in another mail if I took the new data structure size
> requirements into account, here is the code I added for this
> computation.

Yep, thanks, I found it in the meantime.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
