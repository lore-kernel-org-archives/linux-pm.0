From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 03/10] threadgroup: extend threadgroup_lock()
 to cover exit and exec
Date: Sun, 13 Nov 2011 17:44:32 +0100
Message-ID: <20111113164426.GB9446__36308.5173107267$1321202693$gmane$org@somewhere>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-4-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1320191193-8110-4-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linux-foundation.org, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, oleg@redhat.com, linux-pm@lists.linux-foundation.org, paul@paulmenage.org, kamezawa.hiroyu@Jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 01, 2011 at 04:46:26PM -0700, Tejun Heo wrote:
> threadgroup_lock() protected only protected against new addition to
> the threadgroup, which was inherently somewhat incomplete and
> problematic for its only user cgroup.  On-going migration could race
> against exec and exit leading to interesting problems - the symmetry
> between various attach methods, task exiting during method execution,
> ->exit() racing against attach methods, migrating task switching basic
> properties during exec and so on.
> 
> This patch extends threadgroup_lock() such that it protects against
> all three threadgroup altering operations - fork, exit and exec.  For
> exit, threadgroup_change_begin/end() calls are added to exit path.
> For exec, threadgroup_[un]lock() are updated to also grab and release
> cred_guard_mutex.
> 
> With this change, threadgroup_lock() guarantees that the target
> threadgroup will remain stable - no new task will be added, no new
> PF_EXITING will be set and exec won't happen.
> 
> The next patch will update cgroup so that it can take full advantage
> of this change.

I don't want to nitpick really, but IMHO the races involved in exit and exec
are too different, specific and complicated on their own to be solved in a
single one patch. This should be split in two things.

The specific problems and their fix need to be described more in detail
in the changelog because the issues are very tricky.

The exec case:

IIUC, the race in exec is about the group leader that can be changed
to become the exec'ing thread, making while_each_thread() unsafe.
We also have other things happening there like all the other threads
in the group that get killed, but that should be handled by the threadgroup_change_begin()
you put in the exit path.
The old leader is also killed but release_task() -> __unhash_process() is called
for it manually from the exec path. However this thread too should be covered by your
synchronisation in exit().

So after your protection in the exit path, the only thing to protect against in exec
is that group_leader that can change concurrently. But I may be missing something in the picture.
Also note this is currently protected by the tasklist readlock. Cred guard mutex is
certainly better, I just don't remember if you remove the tasklist lock in a
further patch.

The exit case:

There the issue is about racing against cgroup_exit() where the task can be
assigned to the root cgroup. Is this really a problem in fact? I don't know
if subsystems care about that. Perhaps some of them are buggy in that
regard. At least the task counter handles that and it needs a
->cancel_attach_task() for this purpose in the case the migration fails due to exit.
Not sure about others. A real synchronization against exit is less error prone for sure.
In the end that's probably a win.
