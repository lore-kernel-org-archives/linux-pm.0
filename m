From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH UPDATED 03/10] threadgroup: extend
 threadgroup_lock() to cover exit and exec
Date: Wed, 7 Dec 2011 10:22:14 -0800
Message-ID: <20111207182214.GA7610@google.com>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-4-git-send-email-tj@kernel.org>
	<20111124225054.GA14828@google.com>
	<20111125140136.GC23307@somewhere.redhat.com>
	<20111127193001.GC4266@google.com>
	<20111202162753.GA19752@somewhere.redhat.com>
	<20111205184315.GJ627@google.com>
	<20111207153046.GC13252@somewhere.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111207153046.GC13252@somewhere.redhat.com>
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

Hello, Frederic.

On Wed, Dec 07, 2011 at 04:30:54PM +0100, Frederic Weisbecker wrote:
> I don't understand what you mean. On your patches, you only process tasks
> that don't have PF_EXITING, ie: you don't include these in the flex array
> on cgroup_attach_proc(). So that still applies in my proposal.
> 
> From the exit path we would have:
> 
> 	exit_signal() {
> 		lock_threadgroup_change(task);
> 		task->flags |= PF_EXITING;
> 		lock_threadgroup(task);
> 	}
> 
> 	exit all the rest: mm, etc...
> 
> Then from cgroup_attach_proc():
> 
> 	lock_threadgroup(task);
> 	for_each_thread(task) {
> 		if (!(task->flags & PF_EXITING))
> 			include in flex array
> 	}
> 
> Am I forgetting something?

The point I was trying to make was that doing the above would make
->exit() called on dangling task of a threadgroup in rare cases.
ie. With the proposed change, after a threadgroup migration, all tasks
in the threadgroup is in the new cgroup.  No method will be called on
the old cgroup for any of the member task.  With the above change,
process migration would leave out dying tasks and ->exit() can be
called with the old cgroup.

Hmm... that said, it probably doesn't matter all that much either way.
I'll update the patchset and repost.

Thanks.

-- 
tejun
