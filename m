From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 02/10] threadgroup: rename
 signal->threadgroup_fork_lock to ->group_rwsem
Date: Fri, 4 Nov 2011 17:40:32 +0900
Message-ID: <20111104174032.e0c4fc11.kamezawa.hiroyu__39514.2999630936$1320397429$gmane$org@jp.fujitsu.com>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-3-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1320191193-8110-3-git-send-email-tj@kernel.org>
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

On Tue,  1 Nov 2011 16:46:25 -0700
Tejun Heo <tj@kernel.org> wrote:

> Make the following renames to prepare for extension of threadgroup
> locking.
> 
> * s/signal->threadgroup_fork_lock/signal->group_rwsem/
> * s/threadgroup_fork_read_lock()/threadgroup_change_begin()/
> * s/threadgroup_fork_read_unlock()/threadgroup_change_done()/

I personally like begin <-> end to see relationship.

> * s/threadgroup_fork_write_lock()/threadgroup_lock()/
> * s/threadgroup_fork_write_unlock()/threadgroup_unlock()/
> 
> This patch doesn't cause any behavior change.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Paul Menage <paul@paulmenage.org>
> Cc: Li Zefan <lizf@cn.fujitsu.com>

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
