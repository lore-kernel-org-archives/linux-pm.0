From: Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: PM/hibernate swapfile regression
Date: Tue, 21 Jul 2009 23:46:57 +0200
Message-ID: <20090721214657.GA27605__19612.0950895876$1248220952$gmane$org@cmpxchg.org>
References: <20090714135453.GA26976@osiris.boeblingen.de.ibm.com>
	<20090720132456.GA29023@osiris.boeblingen.de.ibm.com>
	<4A659D75.3050004@tuffmail.co.uk> <200907212257.21878.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200907212257.21878.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Arnd Schneider <arnd@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-fsdevel@vger.kernel.org, Hans-Joachim Picht <hans@linux.vnet.ibm.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 21, 2009 at 10:57:21PM +0200, Rafael J. Wysocki wrote:
> On Tuesday 21 July 2009, Alan Jenkins wrote:
> > From 643014ec079610a8b01dfd78c6949c1e8727195b Mon Sep 17 00:00:00 2001
> > From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > Date: Tue, 21 Jul 2009 10:17:30 +0100
> > Subject: [PATCH] PM/hibernate: replace bdget call with bdcopy (simple atomic_inc of i_count)
> > 
> > Create bdcopy().  This function copies an existing reference to a
> > block_device.  It is safe to call from any context.
> > 
> > Hibernation code wishes to copy a reference to the active swap device.
> > Right now it calls bdget() under a spinlock, but this is wrong because
> > bdget() can sleep.  It doesn't need a full bdget() because we already
> > hold a reference to active swap devices (and the spinlock protects
> > against swapoff).
> > 
> > Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > CC: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/block_dev.c     |    8 ++++++++
> >  include/linux/fs.h |    1 +
> >  mm/swapfile.c      |    4 ++--
> >  3 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index 3a6d4fb..0b04974 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -564,6 +564,14 @@ struct block_device *bdget(dev_t dev)
> >  
> >  EXPORT_SYMBOL(bdget);
> >  
> > +struct block_device *bdcopy(struct block_device *bdev)
> > +{
> > +	atomic_inc(&bdev->bd_inode->i_count);
> > +	return bdev;
> > +}
> 
> Hmm.  If you defined bdcopy() as static inline directly in mm/swapfile.c,
> the patch would be slightly simpler.

Please don't do that.

This helper seems to be generic enough to live next to the rest of the
bd interface, don't you think?  swapfile.c is a mess already...

	Hannes
