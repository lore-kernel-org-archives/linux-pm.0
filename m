From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 01/10] cgroup: add cgroup_root_mutex
Date: Fri, 4 Nov 2011 17:38:34 +0900
Message-ID: <20111104173834.ea089a41.kamezawa.hiroyu__46904.4741163545$1320397504$gmane$org@jp.fujitsu.com>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-2-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1320191193-8110-2-git-send-email-tj@kernel.org>
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
Cc: akpm@linux-foundation.org, fweisbec@gmail.com, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, oleg@redhat.com, linux-pm@lists.linux-foundation.org, paul@paulmenage.org, kamezawa.hiroyu@Jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

On Tue,  1 Nov 2011 16:46:24 -0700
Tejun Heo <tj@kernel.org> wrote:

> cgroup wants to make threadgroup stable while modifying cgroup
> hierarchies which will introduce locking dependency on
> cred_guard_mutex from cgroup_mutex.  This unfortunately completes
> circular dependency.
> 
>  A. cgroup_mutex -> cred_guard_mutex -> s_type->i_mutex_key -> namespace_sem
>  B. namespace_sem -> cgroup_mutex
> 
> B is from cgroup_show_options() and this patch breaks it by
> introducing another mutex cgroup_root_mutex which nests inside
> cgroup_mutex and protects cgroupfs_root.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>

Thanks,
Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
