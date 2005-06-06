From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: swsusp: Not enough free pages
Date: Mon, 6 Jun 2005 23:46:08 +0200
Message-ID: <200506062346.09503.rjw@sisk.pl>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403>
	<200506061902.34304.rjw@sisk.pl> <20050606171417.GB2230@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050606171417.GB2230@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI devel <acpi-devel@lists.sourceforge.net>, linux-pm@lists.osdl.org, Linux Kernel List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, 6 of June 2005 19:14, Pavel Machek wrote:
> Hi!
> 
> > > > > > > So far, yes. I just tried 2 times.
> > > > > >
> > > > > > always. (I check that swap dev is on)
> > > > > >
> > > > > > Sometimes, my ia32 laptop free 0 pages too.
> > > > > > I think we should always free some pages
> > > > > > from various caches.
> > > > >
> > > > > Try this hack... it is basically mm problem I don't know how to fix,
> > > > > but this seems to help.
> > > > > 								Pavel
> > > > 
> > > > Thanks Pavel, this hack works.
> > > > ..
> > > > Freeing memory...  ^Hdone (0 pages freed)
> > > > Freeing memory...  ^H-^Hdone (4636 pages freed)
> > > > Freeing memory...  ^Hdone (0 pages freed)
> > > > Freeing memory...  ^H-^Hdone (914 pages freed)
> > > > Freeing memory...  ^Hdone (0 pages freed)
> > > > Freezing CPUs (at 0)...ok
> > > > 
> > > > Any mm guru know how to fix this?
> > > 
> > > Andrew, can you help? It seems free_some_memory does not really free
> > > all reclaimable memory in recent kernels. In fact, it likes to free
> > > nothing on first invocations....
> > 
> > Actually, on (my) x86-64 it seems to work.  It frees even more memory than
> > I'd like it to (there's 80-90% of RAM free after it's finished). ;-)
> > 
> > If I had to guess, I'd say the problem is related to PAGE_SIZE !=
> >4096.
> 
> No, I see it on i386, too. Try patch below; if it frees some after
> first pass, you have that problem, too.

I've run it once and the result is this:

Freeing memory... done (75876 pages freed)
Freeing memory... done (1536 pages freed)
Freeing memory... done (0 pages freed)
Freeing memory... done (1792 pages freed)
Freeing memory... done (0 pages freed)

It does free some pages after the first pass, but this is only a small fraction
of all pages freed.  I wouldn't call it a bad result ...

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
