From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: A unresponsive file system can hang all I/O in the
	system on linux-2.6.23-rc6 (dirty_thresh problem?)
Date: Sat, 29 Sep 2007 16:43:55 +0200
Message-ID: <1191077035.18147.118.camel__10595.6492633142$1191077369$gmane$org@lappy>
References: <92cbf19b0709272332s25684643odaade0e98cb3a1f4@mail.gmail.com>
	<391063897.19256@ustc.edu.cn> <1191066481.18147.115.camel@lappy>
	<391068925.28146@ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <391068925.28146@ustc.edu.cn>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Fengguang Wu <wfg@mail.ustc.edu.cn>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org, Chakri n <chakriin5@gmail.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Krzysztof Oledzki <olel@ans.pl>
List-Id: linux-pm@vger.kernel.org


On Sat, 2007-09-29 at 20:28 +0800, Fengguang Wu wrote:
> On Sat, Sep 29, 2007 at 01:48:01PM +0200, Peter Zijlstra wrote:

> > On the patch itself, not sure if it would have been enough. As soon as
> > there is a single dirty inode on the list one would get caught in the
> > same problem as before.
> 
> That should not be a problem.  Normally the few new dirty inodes will
> be all cleaned in one go and there are no more dirty inodes left(at
> least for a moment). Hmm, I guess the new 'break' should be moved
> immediately after writeback_inodes()...
> 
> > That is, if NFS_dirty+NFS_unstable+NFS_writeback > dirty_limit this
> > break won't fix it.
> 
> In fact this patch exactly targets at this condition.
> When NFS* < dirty_limit, Chakri won't see the lockup at all.
> The problem was, there are only two 'break's in the loop, and neither
> one evaluates to true for his dd command.

Yeah indeed, when put in the loop, after writeback_inodes() it makes
sense.

No idea what I was thinking, must be one of those days... :-/
