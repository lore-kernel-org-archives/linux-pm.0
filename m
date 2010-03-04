From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Is it supposed to be ok to call del_gendisk while
	userspace is frozen?
Date: Thu, 4 Mar 2010 01:23:13 +0100
Message-ID: <201003040123.13617.rjw__8327.89010969481$1267662196$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1003031720530.1380-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003031720530.1380-100000@iolanthe.rowland.org>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 03 March 2010, Alan Stern wrote:
> On Wed, 3 Mar 2010, Pavel Machek wrote:
> 
> > Hi!
> > 
> > > > > The reason for freezing those tasks is to avoid writebacks at random
> > > > > times during a system sleep transition, when the underlying device may
> > > > > already be suspended, right?
> > > > 
> > > > It is also there to avoid inconsistency between in-filesystem data and
> > > > snapshot in hibernation image.
> > > 
> > > A good point, although in this case I think it won't matter.  Writing
> > > out a dirty page twice (once right after taking the snapshot and then
> > > again after resuming from hibernation) will leave the disk in a correct
> > > state.
> > 
> > No, I don't think so. Have you considered all the various journalling
> > systems?
> > 
> > Definitely not in presence of I/O errors. Commit block can only be
> > written after previous blocks are successfully writen to the journal.
> > 
> > So lets see:
> > 
> > <snapshot>
> > 
> > Write previous block, write commit block, write more blocks
> > 
> > <hibernation powerdown, restart>
> > 
> > Error writing previous block (block now contains garbage), leading to
> > kernel panic
> > 
> > <restart>
> > 
> > journalling assumptions broken: commit block is there, but previous
> > blocks are not intact. Data loss.
> > 
> > ...and that was the first I could think about. Lets not do
> >  this. Barriers were invented for a reason.
> 
> Very well.  Then we still need a solution to the original problem:  
> Devices sometimes need to be unregistered during resume, but
> del_gendisk() blocks on the writeback thread, which is frozen until
> after the resume finishes.  How do you suggest this be fixed?

I thought about thawing the writeback thread earlier in such cases.

Would that makes sense / is it doable at all?

Rafael
