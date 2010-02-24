From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Is it supposed to be ok to call del_gendisk
	while	userspace is frozen?
Date: Wed, 24 Feb 2010 20:12:13 +0100
Message-ID: <20100224191213.GH1025__8083.94241980768$1267038858$gmane$org@kernel.dk>
References: <20100223221635.GP1025@kernel.dk>
	<Pine.LNX.4.44L0.1002241051470.2436-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1002241051470.2436-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 24 2010, Alan Stern wrote:
> On Tue, 23 Feb 2010, Jens Axboe wrote:
> 
> > > > And that's back to the question of whether or not that is a nice thing to
> > > > do. It seems a bit dirty, but otoh where else to do it. Perhaps just
> > > > using the kblockd to postpone the del_gendisk() to out-of-resume context
> > > > would be the best approach.
> > > 
> > > That would involve a layering violation, wouldn't it?  Either the 
> > > driver would have to interface with kblockd directly, or else 
> > > del_gendisk() would need to know whether the writeback task was frozen.
> > > 
> > > On the whole, I think it's best for the block layer to retain full
> > > control over its own tasks and requirements.
> > 
> > You would export such functionality - del_gendisk_deferred(), or
> > something like that. The kblockd suggestion was implementation detail,
> > not something the driver would concern itself with. It's not exactly
> > picture perfect, but it could be used from eg resume context where the
> > device isn't fully live yet.
> 
> Hmm.  There's still no way for the driver to know whether or not the
> writeback task is frozen when it wants to call del_gendisk().  It
> would have to defer _all_ such calls.  And all hot-pluggable block
> drivers would have to do this -- would that be acceptable?

I was assuming it knew it was being called from a critical location,
like from resume. I guess the callback just iterates the bus devices and
calls the device remove, so that doesn't quite work without other
changes.

> How about plugging the request queue instead of freezing the writeback 
> task?  Would that work?  It should be easy enough for a driver to 
> unplug the queue before unregistering its device from within a resume 
> method.

We have specific methods for either freezing of stopping or starting the
queue, perhaps those would be appropriate for suspend/resume actions. It
effectively prevents the queueing function from being called. If there
are dirty pages for the device, then it would not help though, as you
would still get stuck waiting for that IO to complete.

-- 
Jens Axboe
