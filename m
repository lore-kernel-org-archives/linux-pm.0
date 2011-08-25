From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/6] cgroup: don't use
 subsys->can_attach_task() or ->attach_task()
Date: Thu, 25 Aug 2011 11:12:28 +0200
Message-ID: <20110825091228.GF3286__26950.1134207987$1314263707$gmane$org@htj.dyndns.org>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-5-git-send-email-tj@kernel.org>
	<CALdu-PCc2RzedXubReF9huamL6W+5qGCfXNNvqS2yUk3QTHRng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALdu-PCc2RzedXubReF9huamL6W+5qGCfXNNvqS2yUk3QTHRng@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Menage <paul@paulmenage.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, containers@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>, linux-pm@lists.linux-foundation.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

Hello, Paul.

On Thu, Aug 25, 2011 at 02:07:35AM -0700, Paul Menage wrote:
> Doesn't the other part of this patch set, that avoids calling the
> *attach() methods for tasks that aren't moving, eliminate the need for
> the usage of skip_cgrp here (and elsewhere)? When do we actually need
> to pass a non-NULL skip_cgrp to cgroup_taskset_for_each()?

If any task is moving ->*attach() should be called.  Whether the @tset
passed in should contain tasks which aren't changing cgroups is
debatable.  The operation is guaranteed to be for an entire thread
group and it makes sense to make at least the leader always available
even if it's not moving.  Given that the operation is defined to be
per-thread-group, I think it's better to pass in the whole thread
group with an easy way to skip the ones which aren't moving.  For
example, memcg seems to need to find the mm->owner and it's possible
that the mm->owner might not be changing cgroups.

Thanks.

-- 
tejun
