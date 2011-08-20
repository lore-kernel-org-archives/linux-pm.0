From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 07/16] freezer: don't distinguish nosig tasks
	on thaw
Date: Sat, 20 Aug 2011 10:10:10 +0200
Message-ID: <20110820081010.GI20085__26361.9472542361$1313827893$gmane$org@htj.dyndns.org>
References: <1313763382-12341-1-git-send-email-tj@kernel.org>
	<1313763382-12341-8-git-send-email-tj@kernel.org>
	<201108192314.53010.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108192314.53010.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: paul@paulmenage.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, arnd@arndb.de, oleg@redhat.com
List-Id: linux-pm@vger.kernel.org

Hello, Rafael.

On Fri, Aug 19, 2011 at 11:14:52PM +0200, Rafael J. Wysocki wrote:
> On Friday, August 19, 2011, Tejun Heo wrote:
> > There's no point in thawing nosig tasks before others.  There's no
> > ordering requirement between the two groups on thaw, which the staged
> > thawing can't guarantee anyway.  Simplify thaw_processes() by removing
> > the distinction and collapsing thaw_tasks() into thaw_processes().
> > This will help further updates to freezer.
> 
> I'm not sure if I like this patch.
> 
> Right now there are no ordering requirements between the two groups
> of processes, but if we decide to freeze filesystems on suspend,
> we'll need to thaw them between nosig and sig I suppose.

Hmmm... I'm not really following.  How does staged wake up affect
thawing filesystems?  Staged freezing makes sense as a crude way to
define dependency during freezing - ie. userland and freezable tasks
can't have dependency in their own groups but the former can depend on
the latter on the way to refrigerator.

However, during thawing, it doesn't make any difference regardless of
what was frozen when and how they depend on each other.  They might as
well have cyclic dependency and waking them in any order wouldn't make
any difference.  The task which dependes on another task to do
something would simply block until that task wakes up and resolves the
dependency; moreover, performing staged wakeups doesn't really
guarantee execution order.  It's different from staged freezing in
that way - staged thawing doesn't have the synchronization phase
between the two stages.  Tasks which were woken up earlier can easily
start executing after tasks which were woken up later.

The only guaranteed effect of staged wakeups is that tasks in the
earlier group would have had its ->state set to TASK_RUNNING before
the tasks of the second group.  This again is a moot point because

* __refrigerator() restores task->state afterwards overwriting the
  TASK_RUNNING once the task starts executing (in unknown order).
  This is fundamentally broken and should be fixed so that task is
  left in TASK_RUNNING when leaving the refrigerator.

* However, if you leave it at TASK_RUNNING, it doesn't make any
  difference w.r.t. synchronization.  The only way task->state can
  participate in synchronization is through wake_up() - ie. through
  other tasks setting its state to TASK_RUNNING, so if the
  refrigerator leaves tast state at TASK_RUNNING on return, it can't
  hinder any synchronization.

So, AFAICS, no matter which way it's looked at, it just doesn't make
any difference.

Thanks.

-- 
tejun
