From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH UPDATED 03/10] threadgroup: extend
 threadgroup_lock() to cover exit and exec
Date: Mon, 5 Dec 2011 10:43:15 -0800
Message-ID: <20111205184315.GJ627__6000.67776763371$1323110619$gmane$org@google.com>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-4-git-send-email-tj@kernel.org>
	<20111124225054.GA14828@google.com>
	<20111125140136.GC23307@somewhere.redhat.com>
	<20111127193001.GC4266@google.com>
	<20111202162753.GA19752@somewhere.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111202162753.GA19752@somewhere.redhat.com>
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

On Fri, Dec 02, 2011 at 05:28:03PM +0100, Frederic Weisbecker wrote:
> But I don't think it's very useful to protect against irq_exit_thread(),
> what happens there is purely of internal irq interest.
> 
> Then right after, PF_EXITING is set before any interesting change.
> Isn't it possible to simply lock this flag setting? IIRC, as soon
> as the PF_EXITING flag is set, you ignore the task for attachment.

I think that's technically possible but it does introduce another
class of tasks - the dying ones.  e.g. If a task has PF_EXITING set
and the containing process is migrating, we'll have to migrate all
tasks but the dying one and cgroup ->exit callbacks can be called on
the lonely task after the migration is complete.  It's kinda messy and
if someone makes a wrong assumption there, the bug is gonna be even
more difficult to reproduce / track down than now.  Yes, smaller scope
locking is nicer but I would like to avoid api weirdities like that.

Thanks.

-- 
tejun
