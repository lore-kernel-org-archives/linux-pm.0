From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Fix __pfn_to_page(pfn) for
	CONFIG_DISCONTIGMEM=y
Date: Sat, 8 Nov 2008 14:12:21 +0100
Message-ID: <200811081412.21736.rjw__27517.5605588176$1226149843$gmane$org@sisk.pl>
References: <200811081353.34442.rjw@sisk.pl>
	<20081108125952.GB21405@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081108125952.GB21405@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 8 of November 2008, Pavel Machek wrote:
> Hi!
> 
> > This would be good to have in .28 IMO.
> 
> Actually, this makes sense even for .27-stable, AFAICT.

Yes, it does, but it has to be merged first. :-)

> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: Fix __pfn_to_page(pfn) for CONFIG_DISCONTIGMEM=y
> > 
> > Fix macro __pfn_to_page(pfn) so that it doesn't evaluate its
> > argument twice in the CONFIG_DISCONTIGMEM=y case, because 'pfn' may
> > be a result of a funtion call having side effects.
> 
> function call?

Oh, I mean __pfn_to_page(a_function(something)), where a_function() does more
than just computing the result.
 
> > For example, the hibernation code applies pfn_to_page(pfn) to the
> > result of a function returning the pfn corresponding to the next set
> > bit in a bitmap and the current bit position is modified on each
> > call.  This leads to "interesting" failures for CONFIG_DISCONTIGMEM=y
> > due to the current behavior of __pfn_to_page(pfn).
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Cc: Pavel Machek <pavel@suse.cz>
> 
> Acked-by: Pavel Machek <pavel@suse.cz>
> 
> 
> >  include/asm-generic/memory_model.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-2.6/include/asm-generic/memory_model.h
> > ===================================================================
> > --- linux-2.6.orig/include/asm-generic/memory_model.h
> > +++ linux-2.6/include/asm-generic/memory_model.h
> > @@ -34,7 +34,7 @@
> >  
> >  #define __pfn_to_page(pfn)			\
> >  ({	unsigned long __pfn = (pfn);		\
> > -	unsigned long __nid = arch_pfn_to_nid(pfn);  \
> > +	unsigned long __nid = arch_pfn_to_nid(__pfn);  \
> >  	NODE_DATA(__nid)->node_mem_map + arch_local_page_offset(__pfn, __nid);\
> >  })

Thanks,
Rafael
