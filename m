From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 2/2 -mm] kexec based hibernation: kexec
	restore
Date: Wed, 29 Aug 2007 17:15:08 +0200
Message-ID: <20070829151508.GA11179__8112.99803103811$1188400644$gmane$org@atrey.karlin.mff.cuni.cz>
References: <1188177296.3247.38.camel@caritas-dev.intel.com>
	<20070827213134.GE3398@elf.ucw.cz>
	<1188263677.2050.8.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1188263677.2050.8.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

> On Mon, 2007-08-27 at 23:31 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > This patch adds writing support for /dev/oldmem. This is used to
> > > restore the memory contents of hibernated system.
> > > 
> > > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > 
> > > +ssize_t write_oldmem_page(unsigned long pfn, const char *buf,
> > > +			  size_t csize, unsigned long offset, int userbuf)
> > 
> > Hmm, int userbuf is only ever set to one... Does it make sense to have
> > write_oldmem_page in the separate file? The onl user is mem.c, perhaps
> > it should go there?
> > 
> 
> write_oldmem_page is kept to be consistent with copy_oldmem_page as much
> as possible. The userbuf is used by copy_oldmem_page too, and
> write_oldmem_page is in the same file as copy_oldmem_page. I think the
> consistence between them is reasonable.
> 
> And the copy_oldmem_page/write_oldmem_page is considered to be
> architecture dependent. Now, there are different implementations for
> copy_oldmem_page on different architectures. So I think the
> copy_oldmem_page/write_oldmem_page should be kept in separate file
> instead of go mem.c.

I thought it may have something to do with consistency. ACK on that
one. Perhaps it should be pushed to akpm?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
