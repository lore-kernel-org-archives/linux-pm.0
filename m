From: Daniel Phillips <phillips@phunq.net>
Subject: Re: A unresponsive file system can hang all I/O in the
	system on linux-2.6.23-rc6 (dirty_thresh problem?)
Date: Fri, 28 Sep 2007 13:24:34 -0700
Message-ID: <200709281324.35160.phillips__32088.6299865835$1191017595$gmane$org@phunq.net>
References: <92cbf19b0709272332s25684643odaade0e98cb3a1f4@mail.gmail.com>
	<20070928122628.965137f2.akpm@linux-foundation.org>
	<1191009148.6702.46.camel@heimdal.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1191009148.6702.46.camel@heimdal.trondhjem.org>
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
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Chakri n <chakriin5@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, lkml <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 28 September 2007 12:52, Trond Myklebust wrote:
> I'm not sure that the hang that is illustrated here is so special. It
> is an example of a bog-standard ext3 write, that ends up calling the
> NFS client, which is hanging. The fact that it happens to be hanging
> on the nfsd process is more or less irrelevant here: the same thing
> could happen to any other process in the case where we have an NFS
> server that is down.

Hi Trond,

Could you clarify what you meant by "calling the NFS client"?  I don't 
see any direct call in the posted backtrace.

Regards,

Daniel
