From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 1/1]: Thaws refrigerated bdi flusher threads
	before	invoking kthread_stop on them
Date: Wed, 11 Nov 2009 20:37:20 +0100
Message-ID: <20091111193719.GR8742__46382.9217631885$1257968309$gmane$org@kernel.dk>
References: <1257928216.15415.57.camel@boson>
	<20091111103444.GD26423@elf.ucw.cz>
	<200911111230.58479.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911111230.58479.rjw@sisk.pl>
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
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 11 2009, Rafael J. Wysocki wrote:
> On Wednesday 11 November 2009, Pavel Machek wrote:
> > On Wed 2009-11-11 14:00:16, Romit Dasgupta wrote:
> > > Kicks out frozen bdi flusher task out of the refrigerator when the flusher task
> > > needs to exit.
> > 
> > 
> > > Signed-off-by: Romit Dasgupta <romit@ti.com>
> > 
> > Ok, its slightly "interesting", but better than modifying common
> > code. Looks ok to me.
> > 
> > ACK.
> 
> Agreed.
> 
> Jens, any objections?

Nope, looks fine to me. Though I'd probably prefer just doing an
unconditional PF_FROZEN clear.

/*
 * Force unfreeze of the bdi threads before stopping it, since otherwise
 * it would never exit if it is stuck in the refrigerator.
 */
list_for_each_entry(wb, &bdi->wb_list, list) {
	wb->task->flags &= ~PF_FROZEN;
	kthread_stop(wb->task);
}

And the comment too, it's not enough to stuff this into the commit.

-- 
Jens Axboe
