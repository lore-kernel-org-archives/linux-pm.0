From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [linux-pm] Re: swsusp: Not enough free pages
Date: Wed, 8 Jun 2005 17:02:52 +0200
Message-ID: <200506081702.53349.rjw@sisk.pl>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403> <20050606215815.GO2230@elf.ucw.cz> <200506071239.10125.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506071239.10125.rjw-KKrjLPT3xs0@public.gmane.org>
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
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, ACPI devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, 7 of June 2005 12:39, Rafael J. Wysocki wrote: 
> On Monday, 6 of June 2005 23:58, Pavel Machek wrote:
> > Hi!
> > 
> > > > No, I see it on i386, too. Try patch below; if it frees some after
> > > > first pass, you have that problem, too.
> > > 
> > > I've run it once and the result is this:
> > > 
> > > Freeing memory... done (75876 pages freed)
> > > Freeing memory... done (1536 pages freed)
> > > Freeing memory... done (0 pages freed)
> > > Freeing memory... done (1792 pages freed)
> > > Freeing memory... done (0 pages freed)
> > > 
> > > It does free some pages after the first pass, but this is only a small fraction
> > > of all pages freed.  I wouldn't call it a bad result ...
> > 
> > Well, it still did not free all memory it should have freed, and you
> > were lucky.
> 
> This is a reproducible behavior.  Here goes the result for another suspend:
> 
> Freeing memory... done (136611 pages freed)
> Freeing memory... done (200 pages freed)
> Freeing memory... done (128 pages freed)
> Freeing memory... done (0 pages freed)
> Freeing memory... done (2353 pages freed)
> 
> and it is always like that.  It usually frees more than 100000 pages
> in the first pass and about 5% more in the next passes together.
> 
> > Apparently for some people it does not that well (and that 
> > includes me, I see 0 in first pass quite often).
> 
> On 2.6.12-rc3+ I have never seen 0 in the first pass.  In fact, with X running
> I have never seen less than 60000. :-)
> 
> Perhaps there's a bug that does not hit x86-64 for some reason.  I'll try to
> run it on my second box later today and see what happens.

This is the worst result from the second box:

Freeing memory...  done (54641 pages freed)
Freeing memory...  done (0 pages freed)
Freeing memory...  done (5120 pages freed)
Freeing memory...  done (1952 pages freed)
Freeing memory...  done (2304 pages freed)

Still, there are 5x more pages freed in the first pass (80% of RAM was
empty anyway before suspend), and usually it is 10-20x more or so.

AFAICT, on x86-64 shrink_all_memory(10000) is good enough.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
