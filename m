From: Mandeep Singh Baines <msb@chromium.org>
Subject: Re: [PATCH 1/6] mm/page_alloc: use appropriate printk
 priority level
Date: Wed, 26 Jan 2011 20:22:28 -0800
Message-ID: <20110127042228.GX8008__18812.4079410501$1296144584$gmane$org@google.com>
References: <20110125235700.GR8008@google.com>
	<1296084570-31453-2-git-send-email-msb@chromium.org>
	<4D40BD00.1090408@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4D40BD00.1090408@bluewatersys.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: Mandeep Singh Baines <msb@chromium.org>, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Ryan Mallon (ryan@bluewatersys.com) wrote:
> On 01/27/2011 12:29 PM, Mandeep Singh Baines wrote:
> > printk()s without a priority level default to KERN_WARNING. To reduce
> > noise at KERN_WARNING, this patch set the priority level appriopriately
> > for unleveled printks()s. This should be useful to folks that look at
> > dmesg warnings closely.
> > 
> > Signed-off-by: Mandeep Singh Baines <msb@chromium.org>
> > ---
> 
> > @@ -4700,33 +4700,36 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
> >  	find_zone_movable_pfns_for_nodes(zone_movable_pfn);
> >  
> >  	/* Print out the zone ranges */
> > -	printk("Zone PFN ranges:\n");
> > +	printk(KERN_INFO "Zone PFN ranges:\n");
> >  	for (i = 0; i < MAX_NR_ZONES; i++) {
> >  		if (i == ZONE_MOVABLE)
> >  			continue;
> > -		printk("  %-8s ", zone_names[i]);
> > +		printk(KERN_INFO "  %-8s ", zone_names[i]);
> >  		if (arch_zone_lowest_possible_pfn[i] ==
> >  				arch_zone_highest_possible_pfn[i])
> >  			printk("empty\n");
> 
> Should be printk(KERN_CONT ... (or pr_cont).
> 
> >  		else
> > -			printk("%0#10lx -> %0#10lx\n",
> > +			printk(KERN_INFO "%0#10lx -> %0#10lx\n",
> >  				arch_zone_lowest_possible_pfn[i],
> >  				arch_zone_highest_possible_pfn[i]);
> 
> The printk above doesn't have a trailing newline so this should be
> printk(KERN_CONT ...
> 
> There are a couple of other places in this patch series that also need
> to be fixed in a similar manner.
> 

D'oh. Good catch;)

The KERN_INFO here was unintentional. I had intended to leave it out.
The code I was looking at as a reference was just omitting KERN_ for
continuations. But I take it that the convention is to use KERN_CONT.
I'll fixup the patch series to use that.

I tried to use pr_ wherever the file was already using it or where I was
changing all printk()s. For files with many printk()s I just continued
using printk() to keep the patch small and also to avoid mixing printk
with pr_. However, if it is preferrable, I'm happy to replace all printk()s
with pr_ in the files I touch in the series.

> ~Ryan
> 
> -- 
> Bluewater Systems Ltd - ARM Technology Solution Centre
> 
> Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
> ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
> http://www.bluewatersys.com	New Zealand
> Phone: +64 3 3779127		Freecall: Australia 1800 148 751
> Fax:   +64 3 3779135			  USA 1800 261 2934
