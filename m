From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 07/10] cgroup: introduce cgroup_taskset and
 use it in subsys->can_attach(), cancel_attach() and attach()
Date: Mon, 14 Nov 2011 22:16:17 +0100
Message-ID: <20111114211611.GI9446__35719.1815892749$1321305398$gmane$org@somewhere>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-8-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1320191193-8110-8-git-send-email-tj@kernel.org>
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
Cc: akpm@linux-foundation.org, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, oleg@redhat.com, linux-pm@lists.linux-foundation.org, James Morris <jmorris@namei.org>, paul@paulmenage.org, kamezawa.hiroyu@Jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 01, 2011 at 04:46:30PM -0700, Tejun Heo wrote:
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
> Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Cc: Li Zefan <lizf@cn.fujitsu.com>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>
> Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Cc: James Morris <jmorris@namei.org>

Reviewed-by: Frederic Weisbecker <fweisbec@gmail.com>
