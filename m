From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Fix __pfn_to_page(pfn) for
	CONFIG_DISCONTIGMEM=y
Date: Sun, 9 Nov 2008 12:37:36 +0100
Message-ID: <20081109113736.GE6094__20191.5137855851$1226230777$gmane$org@elf.ucw.cz>
References: <200811081353.34442.rjw@sisk.pl>
	<20081108125952.GB21405@elf.ucw.cz>
	<200811081412.21736.rjw@sisk.pl>
	<20081108215458.1799896b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081108215458.1799896b.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat 2008-11-08 21:54:58, Andrew Morton wrote:
> On Sat, 8 Nov 2008 14:12:21 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Saturday, 8 of November 2008, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > This would be good to have in .28 IMO.
> > > 
> > > Actually, this makes sense even for .27-stable, AFAICT.
> > 
> > Yes, it does, but it has to be merged first. :-)
> 
> It applies to 2.6.26 (at least).  Is there no need for it in kernels
> earlier than 2.6.27.x?

It would be nice to fix it there, too. (OTOH that config never worked
and we did not see huge pile of complains, so I guess the world would
not fall down if it was not in 2.6.26...)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
