From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm] PM: Change ordering of suspend
	and resume code
Date: Sun, 26 Nov 2006 22:31:50 +0100
Message-ID: <20061126213150.GA13648@elf.ucw.cz>
References: <200611252210.58203.rjw@sisk.pl>
	<20061126074400.GA12479@elf.ucw.cz>
	<200611261108.30532.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200611261108.30532.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.osdl.org>, seife@suse.de
List-Id: linux-pm@vger.kernel.org

Hi!

> > > SMP boxes (especially on i386 ones), please do so and tell me if there are
> > > any problems.
> > > 
> > > The last patch is untested.
> > 
> > I guess I should fix s2ram enough that it works for you... What is the
> > primary notebook you are using?
> 
> HPC nx6325.  Someone has reported he's managed to get s2ram working on it,
> but it looks like his machine is slightly different to this one ...

Is there some way to identify your model? Can you post s2ram strings?
Stefan, do you think we could get machine similar-enough to Rafael's?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
