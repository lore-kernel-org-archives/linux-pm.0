From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: swsusp: Not enough free pages
Date: Mon, 6 Jun 2005 19:14:17 +0200
Message-ID: <20050606171417.GB2230@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403>
	<200506061439.03023.luming.yu@intel.com>
	<20050606103936.GA2520@elf.ucw.cz> <200506061902.34304.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============44774466843761762=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200506061902.34304.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI devel <acpi-devel@lists.sourceforge.net>, linux-pm@lists.osdl.org, Linux Kernel List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
List-Id: linux-pm@vger.kernel.org

--===============44774466843761762==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > > > So far, yes. I just tried 2 times.
> > > > >
> > > > > always. (I check that swap dev is on)
> > > > >
> > > > > Sometimes, my ia32 laptop free 0 pages too.
> > > > > I think we should always free some pages
> > > > > from various caches.
> > > >
> > > > Try this hack... it is basically mm problem I don't know how to fix,
> > > > but this seems to help.
> > > > 								Pavel
> > > 
> > > Thanks Pavel, this hack works.
> > > ..
> > > Freeing memory...  ^Hdone (0 pages freed)
> > > Freeing memory...  ^H-^Hdone (4636 pages freed)
> > > Freeing memory...  ^Hdone (0 pages freed)
> > > Freeing memory...  ^H-^Hdone (914 pages freed)
> > > Freeing memory...  ^Hdone (0 pages freed)
> > > Freezing CPUs (at 0)...ok
> > > 
> > > Any mm guru know how to fix this?
> > 
> > Andrew, can you help? It seems free_some_memory does not really free
> > all reclaimable memory in recent kernels. In fact, it likes to free
> > nothing on first invocations....
> 
> Actually, on (my) x86-64 it seems to work.  It frees even more memory than
> I'd like it to (there's 80-90% of RAM free after it's finished). ;-)
> 
> If I had to guess, I'd say the problem is related to PAGE_SIZE !=
>4096.

No, I see it on i386, too. Try patch below; if it frees some after
first pass, you have that problem, too.

								Pavel

> > > > Index: kernel/power/disk.c
> > > > ===================================================================
> > > > --- 805a02ec2bcff3671d7b1e701bd1981ad2fa196c/kernel/power/disk.c 
> > > > (mode:100644) +++
> > > > ecd8559cc08319bb16a42aac06cf7d664157643a/kernel/power/disk.c  (mode:100644)
> > > > @@ -88,23 +92,25 @@
> > > >
> > > >  static void free_some_memory(void)
> > > >  {
> > > > -	unsigned int i = 0;
> > > > -	unsigned int tmp;
> > > > -	unsigned long pages = 0;
> > > > -	char *p = "-\\|/";
> > > > -
> > > > -	printk("Freeing memory...  ");
> > > > -	while ((tmp = shrink_all_memory(10000))) {
> > > > -		pages += tmp;
> > > > -		printk("\b%c", p[i]);
> > > > -		i++;
> > > > -		if (i > 3)
> > > > -			i = 0;
> > > > +	int i;
> > > > +	for (i=0; i<5; i++) {
> > > > +		int i = 0, tmp;
> > > > +		long pages = 0;
> > > > +		char *p = "-\\|/";
> > > > +
> > > > +		printk("Freeing memory...  ");
> > > > +		while ((tmp = shrink_all_memory(10000))) {
> > > > +			pages += tmp;
> > > > +			printk("\b%c", p[i]);
> > > > +			i++;
> > > > +			if (i > 3)
> > > > +				i = 0;
> > > > +		}
> > > > +		printk("\bdone (%li pages freed)\n", pages);
> > > > +		msleep_interruptible(200);
> > > >  	}
> > > > -	printk("\bdone (%li pages freed)\n", pages);
> > > >  }
> > > >
> > > > -
> > > >  static inline void platform_finish(void)
> > > >  {
> > > >  	if (pm_disk_mode == PM_DISK_PLATFORM) {
> > > 
> > 
> > > _______________________________________________
> > > linux-pm mailing list
> > > linux-pm@lists.osdl.org
> > > http://lists.osdl.org/mailman/listinfo/linux-pm
> > 
> > 
> > -- 
> > 
> 

-- 

--===============44774466843761762==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============44774466843761762==--
