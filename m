From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH UPDATED AGAIN 03/10] threadgroup: extend
 threadgroup_lock() to cover exit and exec
Date: Mon, 12 Dec 2011 17:33:34 -0800
Message-ID: <20111213013334.GC25802__8825.02228855646$1323740039$gmane$org@google.com>
References: <1320191193-8110-4-git-send-email-tj@kernel.org>
	<20111124225054.GA14828@google.com>
	<20111125140136.GC23307@somewhere.redhat.com>
	<20111127193001.GC4266@google.com>
	<20111202162753.GA19752@somewhere.redhat.com>
	<20111205184315.GJ627@google.com>
	<20111207153046.GC13252@somewhere.redhat.com>
	<20111207182214.GA7610@google.com>
	<20111208205055.GB12108@google.com>
	<20111209234246.GC27173@somewhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111209234246.GC27173@somewhere>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: akpm@linux-foundation.org, paul@paulmenage.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, oleg@redhat.com, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, containers@lists.linux-foundation.org, kamezawa.hiroyu@Jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

Hello,

On Sat, Dec 10, 2011 at 12:42:53AM +0100, Frederic Weisbecker wrote:
> > Okay, narrowed exit path protection down to setting of PF_EXITING
> > itself.  ->exit() on dangling tasks is a bit weird but I don't think
> > it's too bad.  Frederic, are you okay with this version?
> 
> Yeah that new scheme that only protects PF_EXITING may look a bit
> strange. But I think we are fine. With rcu list traversal, it should
> be safe even if a group member is concurrently dropped from the list (in that
> case all we check if its PF_EXITING then we give up). And we may
> have a concurrent ->exit() but that should be fine too.
> 
> Thanks!
> 
> Acked-by: Frederic Weisbecker <fweisbec@gmail.com>

Awesome, adding Acked-by, putting it on top of pm-freezer and pushing
it out to linux-next.

Thank you.

-- 
tejun
