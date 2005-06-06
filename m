From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [linux-pm] Re: swsusp: Not enough free pages
Date: Mon, 6 Jun 2005 19:02:33 +0200
Message-ID: <200506061902.34304.rjw@sisk.pl>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403> <200506061439.03023.luming.yu@intel.com> <20050606103936.GA2520@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050606103936.GA2520-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, ACPI devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, 6 of June 2005 12:39, Pavel Machek wrote:
> Hi!
> 
> > > > > So far, yes. I just tried 2 times.
> > > >
> > > > always. (I check that swap dev is on)
> > > >
> > > > Sometimes, my ia32 laptop free 0 pages too.
> > > > I think we should always free some pages
> > > > from various caches.
> > >
> > > Try this hack... it is basically mm problem I don't know how to fix,
> > > but this seems to help.
> > > 								Pavel
> > 
> > Thanks Pavel, this hack works.
> > ..
> > Freeing memory...  ^Hdone (0 pages freed)
> > Freeing memory...  ^H-^Hdone (4636 pages freed)
> > Freeing memory...  ^Hdone (0 pages freed)
> > Freeing memory...  ^H-^Hdone (914 pages freed)
> > Freeing memory...  ^Hdone (0 pages freed)
> > Freezing CPUs (at 0)...ok
> > 
> > Any mm guru know how to fix this?
> 
> Andrew, can you help? It seems free_some_memory does not really free
> all reclaimable memory in recent kernels. In fact, it likes to free
> nothing on first invocations....

Actually, on (my) x86-64 it seems to work.  It frees even more memory than
I'd like it to (there's 80-90% of RAM free after it's finished). ;-)

If I had to guess, I'd say the problem is related to PAGE_SIZE != 4096.

Greets,
Rafael


> Pausing and trying few times helps, but is *very* ugly.
> 								Pavel
> 
> > > Index: kernel/power/disk.c
> > > ===================================================================
> > > --- 805a02ec2bcff3671d7b1e701bd1981ad2fa196c/kernel/power/disk.c 
> > > (mode:100644) +++
> > > ecd8559cc08319bb16a42aac06cf7d664157643a/kernel/power/disk.c  (mode:100644)
> > > @@ -88,23 +92,25 @@
> > >
> > >  static void free_some_memory(void)
> > >  {
> > > -	unsigned int i = 0;
> > > -	unsigned int tmp;
> > > -	unsigned long pages = 0;
> > > -	char *p = "-\\|/";
> > > -
> > > -	printk("Freeing memory...  ");
> > > -	while ((tmp = shrink_all_memory(10000))) {
> > > -		pages += tmp;
> > > -		printk("\b%c", p[i]);
> > > -		i++;
> > > -		if (i > 3)
> > > -			i = 0;
> > > +	int i;
> > > +	for (i=0; i<5; i++) {
> > > +		int i = 0, tmp;
> > > +		long pages = 0;
> > > +		char *p = "-\\|/";
> > > +
> > > +		printk("Freeing memory...  ");
> > > +		while ((tmp = shrink_all_memory(10000))) {
> > > +			pages += tmp;
> > > +			printk("\b%c", p[i]);
> > > +			i++;
> > > +			if (i > 3)
> > > +				i = 0;
> > > +		}
> > > +		printk("\bdone (%li pages freed)\n", pages);
> > > +		msleep_interruptible(200);
> > >  	}
> > > -	printk("\bdone (%li pages freed)\n", pages);
> > >  }
> > >
> > > -
> > >  static inline void platform_finish(void)
> > >  {
> > >  	if (pm_disk_mode == PM_DISK_PLATFORM) {
> > 
> 
> > _______________________________________________
> > linux-pm mailing list
> > linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
> > http://lists.osdl.org/mailman/listinfo/linux-pm
> 
> 
> -- 
> 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
