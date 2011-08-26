From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 2/6] cgroup: improve old cgroup handling in
 cgroup_attach_proc()
Date: Fri, 26 Aug 2011 13:13:59 +0900
Message-ID: <20110826131359.096a8131.kamezawa.hiroyu__28633.0732437365$1314332542$gmane$org@jp.fujitsu.com>
References: <1314312192-26885-1-git-send-email-tj@kernel.org>
	<1314312192-26885-3-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314312192-26885-3-git-send-email-tj@kernel.org>
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
Cc: fweisbec@gmail.com, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

On Fri, 26 Aug 2011 00:43:08 +0200
Tejun Heo <tj@kernel.org> wrote:

> cgroup_attach_proc() behaves differently from cgroup_attach_task() in
> the following aspects.
> 
> * All hooks are invoked even if no task is actually being moved.
> 
> * ->can_attach_task() is called for all tasks in the group whether the
>   new cgrp is different from the current cgrp or not; however,
>   ->attach_task() is skipped if new equals new.  This makes the calls
>   asymmetric.
> 
> This patch improves old cgroup handling in cgroup_attach_proc() by
> looking up the current cgroup at the head, recording it in the flex
> array along with the task itself, and using it to remove the above two
> differences.  This will also ease further changes.
> 
> -v2: nr_todo renamed to nr_migrating_tasks as per Paul Menage's
>      suggestion.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Acked-by: Paul Menage <paul@paulmenage.org>
> Cc: Li Zefan <lizf@cn.fujitsu.com>

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
