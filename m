From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCHSET] cgroup: introduce cgroup_taskset and
 consolidate subsys methods
Date: Wed, 24 Aug 2011 03:14:30 +0200
Message-ID: <20110824011428.GC23979__33363.6478441351$1314148529$gmane$org@somewhere>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1314138000-2049-1-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 24, 2011 at 12:19:54AM +0200, Tejun Heo wrote:
> Hello,
> 
> cgroup has grown quite some number of subsys methods.  Some of them
> are overlapping, inconsistent with each other and called under
> different conditions depending on whether they're called for a single
> task or whole process.  Unfortunately, these callbacks are complicated
> and incomplete at the same time.
> 
> * ->attach_task() is called after migration for task attach but before
>   for process.
> 
> * Ditto for ->pre_attach().
> 
> * ->can_attach_task() is called for every task in the thread group but
>   ->attach_task() skips the ones which don't actually change cgroups.
> 
> * Task attach becomes noop if the task isn't actually moving.  Process
>   attach is always performed.
> 
> * ->attach_task() doesn't (or at least aren't supposed to) have access
>   to the old cgroup.
> 
> * During cancel, there's no way to access the affected tasks.
> 
> This patchset introduces cgroup_taskset along with some accessors and
> iterator, updates methods to use it, consolidates usages and drops
> superflous methods.
> 
> It contains the following six patches.
> 
>  0001-cgroup-subsys-attach_task-should-be-called-after-mig.patch
>  0002-cgroup-improve-old-cgroup-handling-in-cgroup_attach_.patch
>  0003-cgroup-introduce-cgroup_taskset-and-use-it-in-subsys.patch
>  0004-cgroup-don-t-use-subsys-can_attach_task-or-attach_ta.patch
>  0005-cgroup-cpuset-don-t-use-ss-pre_attach.patch
>  0006-cgroup-kill-subsys-can_attach_task-pre_attach-and-at.patch

I don't understand the point on patches 3,4,5,6

Why pushing the task iterations down to the subsystems?
