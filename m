From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6/6] cgroup: kill subsys->can_attach_task(),
 pre_attach() and attach_task()
Date: Wed, 31 Aug 2011 09:03:13 +0200
Message-ID: <20110831070313.GA29179__45596.2140033536$1314903648$gmane$org@mtj.dyndns.org>
References: <1314312192-26885-1-git-send-email-tj@kernel.org>
	<1314312192-26885-7-git-send-email-tj@kernel.org>
	<20110830201030.GC15953@somewhere.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110830201030.GC15953@somewhere.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org, kamezawa.hiroyu@jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

Hello, Frederic.

On Tue, Aug 30, 2011 at 10:10:32PM +0200, Frederic Weisbecker wrote:
> In order to keep the fix queued in -mm (https://lkml.org/lkml/2011/8/26/262)
> the tasks that have failed to migrate should be removed from the iterator
> so that they are not included in the batch in ->attach().

I don't think that's a good approach.  It breaks the symmetry when
calling different callbacks.  What if ->can_attach() allocates
per-task resources and the task exits in the middle?  I think we
better lock down fork/exit/exec.  I'll send patches but I'm currently
moving / traveling w/ limited access to my toys so it might take some
time.

Thanks.

-- 
tejun
