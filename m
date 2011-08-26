From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 3/6] cgroup: introduce cgroup_taskset and use
 it in subsys->can_attach(), cancel_attach() and attach()
Date: Fri, 26 Aug 2011 13:16:14 +0900
Message-ID: <20110826131614.bf9b73c6.kamezawa.hiroyu__3053.25399754128$1314332683$gmane$org@jp.fujitsu.com>
References: <1314312192-26885-1-git-send-email-tj@kernel.org>
	<1314312192-26885-4-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314312192-26885-4-git-send-email-tj@kernel.org>
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
Cc: fweisbec@gmail.com, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

On Fri, 26 Aug 2011 00:43:09 +0200
Tejun Heo <tj@kernel.org> wrote:

> Currently, there's no way to pass multiple tasks to cgroup_subsys
> methods necessitating the need for separate per-process and per-task
> methods.  This patch introduces cgroup_taskset which can be used to
> pass multiple tasks and their associated cgroups to cgroup_subsys
> methods.
> 
> Three methods - can_attach(), cancel_attach() and attach() - are
> converted to use cgroup_taskset.  This unifies passed parameters so
> that all methods have access to all information.  Conversions in this
> patchset are identical and don't introduce any behavior change.
> 
> -v2: documentation updated as per Paul Menage's suggestion.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Acked-by: Paul Menage <paul@paulmenage.org>
> Cc: Li Zefan <lizf@cn.fujitsu.com>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>
> Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Cc: James Morris <jmorris@namei.org>

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
