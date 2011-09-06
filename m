From: Li Zefan <lizf@cn.fujitsu.com>
Subject: Re: [PATCHSET cgroup] extend threadgroup locking
Date: Tue, 06 Sep 2011 17:00:34 +0800
Message-ID: <4E65E132.9090201__19527.0499018536$1315299728$gmane$org@cn.fujitsu.com>
References: <1315159280-25032-1-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1315159280-25032-1-git-send-email-htejun@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <htejun@gmail.com>
Cc: akpm@linux-foundation.org, fweisbec@gmail.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> cgroup currently only blocks new threads from joining the target
> threadgroup during migration, and on-going migration could race
> against exec and exit leading to interesting problems - the symmetry
> between various attach methods, task exiting during method execution,
> ->exit() racing against attach methods, migrating task switching basic
> properties during exec and so on.
> 
> This patchset extends threadgroup locking such that it covers all
> operations which can alter the threadgroup - fork, exit and exec, and
> update cgroup to take advantage of it.  rwsem read ops are added to
> exit path but exec is excluded by grabbing the existing
> cred_guard_mutex from threadgroup locking helper.
> 
> This makes threadgroup locking complete and resolves cgroup issues
> stemming from the target taskset being unstable.
> 
> This patchset is on top of the current pm-freezer + "freezer: fixes &
> simplifications" patchset and contains the following four patches.
> Patch list and diffstat follow.
> 
> Thanks.
> 
>  [PATCH 1/4] cgroup: change locking order in attach_task_by_pid()
>  [PATCH 2/4] threadgroup: rename signal->threadgroup_fork_lock to
>  [PATCH 3/4] threadgroup: extend threadgroup_lock() to cover exit and
>  [PATCH 4/4] cgroup: always lock threadgroup during migration
> 

I've read through the whole patchset, and it looks good to me.

Acked-by: Li Zefan <lizf@cn.fujitsu.com>

>  include/linux/init_task.h |    9 ++----
>  include/linux/sched.h     |   58 ++++++++++++++++++++++++++++---------------
>  kernel/cgroup.c           |   62 +++++++++++++++++++++-------------------------
>  kernel/exit.c             |   16 ++++++++---
>  kernel/fork.c             |    8 ++---
>  5 files changed, 88 insertions(+), 65 deletions(-)
> 
> --
> tejun
> 
> [1] http://thread.gmane.org/gmane.linux.kernel/1187553
> 
