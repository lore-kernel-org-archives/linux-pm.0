From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Wed, 24 Feb 2010 10:59:05 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002241051470.2436-100000__18452.7060403072$1267027306$gmane$org@iolanthe.rowland.org>
References: <20100223221635.GP1025@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100223221635.GP1025@kernel.dk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Feb 2010, Jens Axboe wrote:

> > > And that's back to the question of whether or not that is a nice thing to
> > > do. It seems a bit dirty, but otoh where else to do it. Perhaps just
> > > using the kblockd to postpone the del_gendisk() to out-of-resume context
> > > would be the best approach.
> > 
> > That would involve a layering violation, wouldn't it?  Either the 
> > driver would have to interface with kblockd directly, or else 
> > del_gendisk() would need to know whether the writeback task was frozen.
> > 
> > On the whole, I think it's best for the block layer to retain full
> > control over its own tasks and requirements.
> 
> You would export such functionality - del_gendisk_deferred(), or
> something like that. The kblockd suggestion was implementation detail,
> not something the driver would concern itself with. It's not exactly
> picture perfect, but it could be used from eg resume context where the
> device isn't fully live yet.

Hmm.  There's still no way for the driver to know whether or not the
writeback task is frozen when it wants to call del_gendisk().  It
would have to defer _all_ such calls.  And all hot-pluggable block
drivers would have to do this -- would that be acceptable?

How about plugging the request queue instead of freezing the writeback 
task?  Would that work?  It should be easy enough for a driver to 
unplug the queue before unregistering its device from within a resume 
method.

Alan Stern
