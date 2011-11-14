From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 08/10] cgroup: don't use
 subsys->can_attach_task() or ->attach_task()
Date: Tue, 15 Nov 2011 00:54:10 +0100
Message-ID: <20111114235405.GJ9446__31342.7180437886$1321314877$gmane$org@somewhere>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-9-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1320191193-8110-9-git-send-email-tj@kernel.org>
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
Cc: akpm@linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, containers@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, oleg@redhat.com, linux-pm@lists.linux-foundation.org, James Morris <jmorris@namei.org>, paul@paulmenage.org, kamezawa.hiroyu@Jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 01, 2011 at 04:46:31PM -0700, Tejun Heo wrote:
> Now that subsys->can_attach() and attach() take @tset instead of
> @task, they can handle per-task operations.  Convert
> ->can_attach_task() and ->attach_task() users to use ->can_attach()
> and attach() instead.  Most converions are straight-forward.
> Noteworthy changes are,
> 
> * In cgroup_freezer, remove unnecessary NULL assignments to unused
>   methods.  It's useless and very prone to get out of sync, which
>   already happened.
> 
> * In cpuset, PF_THREAD_BOUND test is checked for each task.  This
>   doesn't make any practical difference but is conceptually cleaner.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Paul Menage <paul@paulmenage.org>
> Cc: Li Zefan <lizf@cn.fujitsu.com>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>
> Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Peter Zijlstra <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <fweisbec@gmail.com>
