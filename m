From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Fix __pfn_to_page(pfn) for
	CONFIG_DISCONTIGMEM=y
Date: Sun, 9 Nov 2008 14:17:53 +0100
Message-ID: <200811091417.53663.rjw__27398.2984050692$1226236628$gmane$org@sisk.pl>
References: <200811081353.34442.rjw@sisk.pl>
	<20081108215458.1799896b.akpm@linux-foundation.org>
	<20081109113736.GE6094@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081109113736.GE6094@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 9 of November 2008, Pavel Machek wrote:
> On Sat 2008-11-08 21:54:58, Andrew Morton wrote:
> > On Sat, 8 Nov 2008 14:12:21 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > On Saturday, 8 of November 2008, Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > > This would be good to have in .28 IMO.
> > > > 
> > > > Actually, this makes sense even for .27-stable, AFAICT.
> > > 
> > > Yes, it does, but it has to be merged first. :-)
> > 
> > It applies to 2.6.26 (at least).  Is there no need for it in kernels
> > earlier than 2.6.27.x?
> 
> It would be nice to fix it there, too. (OTOH that config never worked
> and we did not see huge pile of complains, so I guess the world would
> not fall down if it was not in 2.6.26...)

Yes, it's a bug, so it would be nice to fix it.  Still, the practical meaning
of the fix would be minimal in 2.6.26 and earlier kernels IMO.

Thanks,
Rafael
