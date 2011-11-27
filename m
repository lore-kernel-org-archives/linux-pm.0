From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH UPDATED 03/10] threadgroup: extend
 threadgroup_lock() to cover exit and exec
Date: Sun, 27 Nov 2011 13:25:58 -0800
Message-ID: <20111127212558.GE4266__38472.0167298385$1322429181$gmane$org@google.com>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-4-git-send-email-tj@kernel.org>
	<20111124225054.GA14828@google.com>
	<CA+55aFxq1wztMzYhKaY5RHazLBDz4pSXUgiGzTj2wA6EJcDbAw@mail.gmail.com>
	<20111127192155.GB4266@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111127192155.GB4266@google.com>
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

Hello, Linus.

On Sun, Nov 27, 2011 at 11:21:55AM -0800, Tejun Heo wrote:
> On Thu, Nov 24, 2011 at 08:02:18PM -0800, Linus Torvalds wrote:
> >  - do you even *need* two separate locks at all? If you extend the
> > threadgroup_fork_lock to cover exec/exit too (and rename it), then why
> > does that separate cred_guard_mutex make sense at all?
> 
> That was mostly choosing the path of least resistance as both locks
> already existed and exec exclusion was added later on, but yeah there
> isn't much to lose by merging those two locks (do_exit nesting inside
> exec will need some care tho).  I'll try to unify the two locks.

Hmmm... I tried this but it seems more difficult than originally
expected.  The biggest obstacle is that we don't have _interruptible
and _killable rwsem ops.

As proposed, what we have is,

* fork and exit paths are read-protected by group_rwsem.  ie. forks
  and exits don't block each other.

* exec path is protected by cred_guard_mutex.  cred_guard_mutex also
  synchronizes parallel exec attempts.  (It's probably better to
  rename it to exec_mutex)

* thread_group_lock() makes the thread group stable by write-locking
  group_rwsem and grabbing cred_guard_mutex.  The former excludes
  forks and exits and the latter exec.

group_rwsem and cred_guard_mutex can be merged by,

* fork and exit paths read-lock group_rwsem as it currently does.

* exec path write-locks group_rwsem.  Note that it'll need to unlock
  in de_thread() while waiting for other threads to exit as exit path
  can't proceed while group_rwsem is write-locked.
  prepare_bprm_creds() should be updated to check signal_pending()
  after acquiring group_rwsem.

  This introduces synchronization between exec and fork/exit paths,
  but I don't think this is something we need to worry about as both
  fork-exec and exit-exec scalabilities don't matter.

* thread_group_lock() write-locks group_rwsem.

The problem is that cred_guard_mutex uses _interruptible/_killable
operations and rwsem doesn't have them, so cred_guard_mutex can't be
easily replaced with write-locking group_rwsem.

If the two locks can't be merged, under the proposed scheme, while not
exactly pretty, both fork/exit and exec paths go through single
locking and only the ones which want stable threadgroup need to grab
both locks, so IMHO it is at least reasonable.

Any better ideas?

Thanks.

-- 
tejun
