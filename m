From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
 Memory Power Management
Date: Thu, 16 Jun 2011 09:04:00 -0700
Message-ID: <1308240240.11430.115.camel__46801.8637192019$1308240439$gmane$org@nimitz>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110613134701.2b23b8d8.kamezawa.hiroyu@jp.fujitsu.com>
	<20110616042044.GA28563@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110616042044.GA28563@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ankita Garg <ankita@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, thomas.abraham@linaro.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2011-06-16 at 09:50 +0530, Ankita Garg wrote:
> - Correctly predicting memory pressure is difficult and thereby being
>   able to online the required pages at the right time could be a
>   challenge

For the sake of this discussion, let's forget about this.  There are
certainly a lot of scenarios where turning memory on/off is necessary
and useful _without_ knowing what kind of load the system is under.  "We
just shut down our huge database, and now have 99% of RAM free" is a
fine, dumb, metric.  We don't have to have magical pony memory pressure
detection as a prerequisite.

> - Memory hotplug is a heavy operation, so the overhead involved may be
>   high

I'm curious.  Why do you say this?  Could you elaborate a bit on _how_
memory hotplug is different from what you're doing here?  On powerpc, at
least, we can do memory hotplug in areas as small as 16MB.  That's _way_
smaller than what you're talking about here, and I would assume that
smaller here means less overhead.

> - Powering off memory is just one of the ways in which memory power could
>   be saved. The platform can also dynamically transition areas of memory
>   into a  content-preserving lower power state if it is not referenced
>   for a pre-defined threshold of time. In such a case, we would need a
>   mechanism to soft offline the pages - i.e, no new allocations to be
>   directed to that memory

OK...  That's fine, but I think you're avoiding the question a bit.  You
need to demonstrate that this 'regions' thing is necessary to do this,
and that we can not get by just modifying what we have now.  For
instance:

1. Have something like khugepaged try to find region-sized chunks of
   memory to free.
2. Modify the buddy allocator to be "picky" about when it lets you get 
   access to these regions.
3. Try to bunch up 'like allocations' like ZONE_MOVABLE does.

(2) could easily mean that we take the MAX_ORDER-1 buddy pages and treat
them differently.  If the page being freed is going (or trying to go) in
to a low power state, insert freed pages on to the tail, or on a special
list.  When satisfying allocations, we'd make some bit of effort to
return pages which are powered on.

-- Dave
