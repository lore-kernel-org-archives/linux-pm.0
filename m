From: Pavel Machek <pavel@suse.cz>
Subject: Re: Re: swsusp: Not enough free pages
Date: Wed, 8 Jun 2005 18:27:28 +0200
Message-ID: <20050608162728.GA3969@openzaurus.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403>
	<20050606215815.GO2230@elf.ucw.cz> <200506071239.10125.rjw@sisk.pl>
	<200506081702.53349.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============054525069330883413=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200506081702.53349.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@zip.com.au>, linux-pm@lists.osdl.org, ACPI devel <acpi-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============054525069330883413==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > > No, I see it on i386, too. Try patch below; if it frees some after
> > > > > first pass, you have that problem, too.
> > > > 
> > > > I've run it once and the result is this:
> > > > 
> > > > Freeing memory... done (75876 pages freed)
> > > > Freeing memory... done (1536 pages freed)
> > > > Freeing memory... done (0 pages freed)
> > > > Freeing memory... done (1792 pages freed)
> > > > Freeing memory... done (0 pages freed)
> > > > 
> > > > It does free some pages after the first pass, but this is only a small fraction
> > > > of all pages freed.  I wouldn't call it a bad result ...
> > > 
> > > Well, it still did not free all memory it should have freed, and you
> > > were lucky.
> > 
> > This is a reproducible behavior.  Here goes the result for another suspend:
> > 
> > Freeing memory... done (136611 pages freed)
> > Freeing memory... done (200 pages freed)
> > Freeing memory... done (128 pages freed)
> > Freeing memory... done (0 pages freed)
> > Freeing memory... done (2353 pages freed)
> > 
> > and it is always like that.  It usually frees more than 100000 pages
> > in the first pass and about 5% more in the next passes together.
> > 
> > > Apparently for some people it does not that well (and that 
> > > includes me, I see 0 in first pass quite often).
> > 
> > On 2.6.12-rc3+ I have never seen 0 in the first pass.  In fact, with X running
> > I have never seen less than 60000. :-)
> > 
> > Perhaps there's a bug that does not hit x86-64 for some reason.  I'll try to
> > run it on my second box later today and see what happens.
> 
> This is the worst result from the second box:
> 
> Freeing memory...  done (54641 pages freed)
> Freeing memory...  done (0 pages freed)
> Freeing memory...  done (5120 pages freed)
> Freeing memory...  done (1952 pages freed)
> Freeing memory...  done (2304 pages freed)
> 
> Still, there are 5x more pages freed in the first pass (80% of RAM was
> empty anyway before suspend), and usually it is 10-20x more or so.

I have seen 0 freed on i386 machine with preempt -rc6-mm1, today...
Something is definitely wrong there.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============054525069330883413==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============054525069330883413==--
