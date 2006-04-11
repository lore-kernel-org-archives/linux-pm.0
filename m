From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: swsusp: which page should be saved?
Date: Tue, 11 Apr 2006 15:52:04 +0800
Message-ID: <1144741924.2865.26.camel@sli10-desk.sh.intel.com>
References: <1142481207.26706.16.camel@sli10-desk.sh.intel.com>
	<20060315230846.GB2462@ucw.cz>
	<1142557935.26706.26.camel@sli10-desk.sh.intel.com>
	<20060317065937.GH2674@elf.ucw.cz>
	<1142907568.11430.16.camel@sli10-desk.sh.intel.com>
	<20060321094230.GM24523@elf.ucw.cz>
	<1144381561.16769.31.camel@sli10-desk.sh.intel.com>
	<20060411073937.GA20513@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============25803624524488633=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060411073937.GA20513@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============25803624524488633==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-04-11 at 15:39 +0800, Pavel Machek wrote:
> Hi!
> 
> > > > > Ouch and IIRC top-level pagedir or something   
> > > > > like that lives in kernel "text" -- it is in assembly and 
> > > wrongly   
> > > > > placed.  
> > > > i386 does the right thing and put the pagedir in data segment. 
> > > x86_64  
> > > > not, I think we could clean it up. 
> > >  
> > > This probably should be done, first, and gotten past Andi. 
> > We asked the question to (intel's) BIOS guys, and below is the
> result. 
> > a. BIOS reserved region/hole - no save/restore 
> > b. ACPI NVS - save/restore 
> > c. 'ACPI Data' is a little tricky. After OS boots, os can reclaim
> this 
> > region, so regard it as normal ram. But we are afraid Linux runtime 
> > module loading might use this region somewhere, so we also mark
> this 
> > region as save/restore. Anyway, this hasn't any side effect. 
> > Hopefully all BIOSes follow this rule.
> 
> This comment needs to go somewhere in source.... aha, it is there, 
> mostly, but without the "tricky" remark.
Ok, will add that one in code too.
> 
> > Pages (Reserved/ACPI NVS/ACPI Data) below 
> > end_pfn(x86_64)/max_low_pfn(i386) will be saved/restored by S4 
> > currently. We should mark 'Reserved' pages not saveable. 
> > Pages (Reserved/ACPI NVS/ACPI Data) above end_pfn/max_low_pfn 
> > will not be saved/restored by S4 currently. We should save the 
> > 'ACPI NVS/ACPI Data' pages in the highmem.
> 
> 
> 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
> > --- 
> >  
> >  linux-2.6.17-rc1-root/arch/i386/kernel/setup.c   |  101
> +++++++++++++++++++++ 
> >  linux-2.6.17-rc1-root/arch/x86_64/kernel/setup.c |   93
> +++++++++++++++++++ 
> >  linux-2.6.17-rc1-root/include/linux/suspend.h    |    1  
> >  linux-2.6.17-rc1-root/kernel/power/snapshot.c    |  107
> ++++++++++++++++++++++- 
> >  linux-2.6.17-rc1-root/kernel/power/swsusp.c      |   20 +--- 
> >  5 files changed, 308 insertions(+), 14 deletions(-) 
> >  
> > diff -puN arch/i386/kernel/setup.c~nosave_pages
> arch/i386/kernel/setup.c 
> > --- linux-2.6.17-rc1/arch/i386/kernel/setup.c~nosave_pages
> 2006-04-04 15:10:42.000000000 +0800 
> > +++ linux-2.6.17-rc1-root/arch/i386/kernel/setup.c    2006-04-06
> 09:40:02.000000000 +0800 
> > @@ -1400,6 +1401,106 @@ static void set_mca_bus(int x) 
> >  static void set_mca_bus(int x) { } 
> >  #endif 
> >   
> > +#ifdef CONFIG_SOFTWARE_SUSPEND 
> > +static void __init mark_nosave_page_range(unsigned long start,
> unsigned long end) 
> > +{ 
> > +     struct page *page; 
> > +     while (start <= end) { 
> > +             page = pfn_to_page(start); 
> > +             SetPageNosave(page); 
> > +             start ++;
> 
> I think start++ is prefered style.
ok.

> 
> > diff -puN kernel/power/snapshot.c~nosave_pages
> kernel/power/snapshot.c 
> > --- linux-2.6.17-rc1/kernel/power/snapshot.c~nosave_pages
> 2006-04-04 15:10:42.000000000 +0800 
> > +++ linux-2.6.17-rc1-root/kernel/power/snapshot.c     2006-04-05
> 14:56:56.000000000 +0800 
> > @@ -39,6 +39,85 @@ static unsigned int nr_copy_pages; 
> >  static unsigned int nr_meta_pages; 
> >  static unsigned long *buffer; 
> >   
> > +struct arch_savable_page {
> 
> I believe we use "saveable" spelling. Either use it, too, or fix the 
> other occurences.
Ok, will fix the spelling, sorry.
> 
> > +     unsigned long start_pfn; 
> > +     unsigned long end_pfn; 
> > +     struct arch_savable_page *next; 
> > +     void *data[0]; 
> > +}; 
> > +static struct arch_savable_page * arch_pages;
> 
> No space between * and arch_pages, please.
ok.
> 
> > +int swsusp_add_arch_pages(unsigned long start, unsigned long end) 
> > +{ 
> > +     struct arch_savable_page *tmp; 
> > +     unsigned int size; 
> > + 
> > +     end = end + 1; 
> > +     size = sizeof(struct arch_savable_page) + sizeof(void *) *
> (end - start); 
> > +     tmp = kzalloc(size, GFP_KERNEL);
> 
> That's potentialy quite a big allocation, no? Could we use highmem 
> (-like) per page saving?
It could be, I'll follow the per page saving of highmem.
Thanks for looking at it. I'll send it to lkml for -mm test after fixed
you mentioned.

Thanks,
Shaohua



--===============25803624524488633==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============25803624524488633==--
