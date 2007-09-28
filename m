From: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: A unresponsive file system can hang all I/O in the
	system on linux-2.6.23-rc6 (dirty_thresh problem?)
Date: Fri, 28 Sep 2007 16:32:18 -0400
Message-ID: <1191011538.6702.59.camel__25715.4285129674$1191011620$gmane$org@heimdal.trondhjem.org>
References: <92cbf19b0709272332s25684643odaade0e98cb3a1f4@mail.gmail.com>
	<20070927235034.ae7bd73d.akpm@linux-foundation.org>
	<1190998853.6702.17.camel@heimdal.trondhjem.org>
	<20070928114930.2c201324.akpm@linux-foundation.org>
	<1191006971.6702.25.camel@heimdal.trondhjem.org>
	<20070928122628.965137f2.akpm@linux-foundation.org>
	<1191009148.6702.46.camel@heimdal.trondhjem.org>
	<20070928131012.4a03c53e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070928131012.4a03c53e.akpm@linux-foundation.org>
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
Cc: nfs@lists.sourceforge.net, linux-pm@lists.linux-foundation.org, chakriin5@gmail.com, linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-09-28 at 13:10 -0700, Andrew Morton wrote:
> On Fri, 28 Sep 2007 15:52:28 -0400
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > On Fri, 2007-09-28 at 12:26 -0700, Andrew Morton wrote:
> > > On Fri, 28 Sep 2007 15:16:11 -0400 Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > > > Looking back, they were getting caught up in
> > > > balance_dirty_pages_ratelimited() and friends. See the attached
> > > > example...
> > > 
> > > that one is nfs-on-loopback, which is a special case, isn't it?
> > 
> > I'm not sure that the hang that is illustrated here is so special. It is
> > an example of a bog-standard ext3 write, that ends up calling the NFS
> > client, which is hanging. The fact that it happens to be hanging on the
> > nfsd process is more or less irrelevant here: the same thing could
> > happen to any other process in the case where we have an NFS server that
> > is down.
> 
> hm, so ext3 got stuck in nfs via __alloc_pages direct reclaim?
> 
> We should be able to fix that by marking the backing device as
> write-congested.  That'll have small race windows, but it should be a 99.9%
> fix?

No. The problem would rather appear to be that we're doing
per-backing_dev writeback (if I read sync_sb_inodes() correctly), but
we're measuring variables which are global to the VM. The backing device
that we are selecting may not be writing out any dirty pages, in which
case, we're just spinning in balance_dirty_pages_ratelimited().

Should we therefore perhaps be looking at adding per-backing_dev stats
too?

Trond
