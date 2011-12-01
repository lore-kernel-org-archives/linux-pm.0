From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH UPDATED 03/10] threadgroup: extend
 threadgroup_lock() to cover exit and exec
Date: Thu, 1 Dec 2011 11:29:35 -0800
Message-ID: <20111201192935.GE13173@google.com>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-4-git-send-email-tj@kernel.org>
	<20111124225054.GA14828@google.com>
	<CA+55aFxq1wztMzYhKaY5RHazLBDz4pSXUgiGzTj2wA6EJcDbAw@mail.gmail.com>
	<20111127192155.GB4266@google.com>
	<20111127212558.GE4266@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111127212558.GE4266@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, fweisbec@gmail.com, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, oleg@redhat.com, linux-pm@lists.linux-foundation.org, paul@paulmenage.org, kamezawa.hiroyu@jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

Hello again, Linus.

On Sun, Nov 27, 2011 at 01:25:58PM -0800, Tejun Heo wrote:
> The problem is that cred_guard_mutex uses _interruptible/_killable
> operations and rwsem doesn't have them, so cred_guard_mutex can't be
> easily replaced with write-locking group_rwsem.
> 
> If the two locks can't be merged, under the proposed scheme, while not
> exactly pretty, both fork/exit and exec paths go through single
> locking and only the ones which want stable threadgroup need to grab
> both locks, so IMHO it is at least reasonable.
> 
> Any better ideas?

I agree that the proposed solution is rather ugly but stable
thread-group is a valid mechanism to have and cgroup can benefit a lot
from it.  I'd be happy to revamp the implementation if anyone can come
up with a better way and can add big fat comment stating that.  Until
something better comes up, would it be okay to stick with this
implementation?

Thanks.

-- 
tejun
