From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: A unresponsive file system can hang all I/O in the
 system on linux-2.6.23-rc6 (dirty_thresh problem?)
Date: Fri, 28 Sep 2007 11:49:30 -0700
Message-ID: <20070928114930.2c201324.akpm__24178.4638063566$1191005450$gmane$org@linux-foundation.org>
References: <92cbf19b0709272332s25684643odaade0e98cb3a1f4@mail.gmail.com>
	<20070927235034.ae7bd73d.akpm@linux-foundation.org>
	<1190998853.6702.17.camel@heimdal.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1190998853.6702.17.camel@heimdal.trondhjem.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-pm <linux-pm@lists.linux-foundation.org>, Chakri n <chakriin5@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 Sep 2007 13:00:53 -0400 Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> On Thu, 2007-09-27 at 23:50 -0700, Andrew Morton wrote:
> 
> > Actually we perhaps could address this at the VFS level in another way. 
> > Processes which are writing to the dead NFS server will eventually block in
> > balance_dirty_pages() once they've exceeded the memory limits and will
> > remain blocked until the server wakes up - that's the behaviour we want.
> > 
> > What we _don't_ want to happen is for other processes which are writing to
> > other, non-dead devices to get collaterally blocked.  We have patches which
> > might fix that queued for 2.6.24.  Peter?
> 
> Do these patches also cause the memory reclaimers to steer clear of
> devices that are congested (and stop waiting on a congested device if
> they see that it remains congested for a long period of time)? Most of
> the collateral blocking I see tends to happen in memory allocation...
> 

No, they don't attempt to do that, but I suspect they put in place
infrastructure which could be used to improve direct-reclaimer latency.  In
the throttle_vm_writeout() path, at least.

Do you know where the stalls are occurring?  throttle_vm_writeout(), or via
direct calls to congestion_wait() from page_alloc.c and vmscan.c?  (running
sysrq-w five or ten times will probably be enough to determine this)
