From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 6/6] cgroup: kill subsys->can_attach_task(),
 pre_attach() and attach_task()
Date: Wed, 31 Aug 2011 15:42:24 +0200
Message-ID: <20110831134220.GB20598__20454.239115543$1314913316$gmane$org@somewhere>
References: <1314312192-26885-1-git-send-email-tj@kernel.org>
	<1314312192-26885-7-git-send-email-tj@kernel.org>
	<20110830201030.GC15953@somewhere.redhat.com>
	<20110831070313.GA29179@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110831070313.GA29179@mtj.dyndns.org>
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
Cc: containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org, kamezawa.hiroyu@jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 31, 2011 at 09:03:13AM +0200, Tejun Heo wrote:
> Hello, Frederic.
> 
> On Tue, Aug 30, 2011 at 10:10:32PM +0200, Frederic Weisbecker wrote:
> > In order to keep the fix queued in -mm (https://lkml.org/lkml/2011/8/26/262)
> > the tasks that have failed to migrate should be removed from the iterator
> > so that they are not included in the batch in ->attach().
> 
> I don't think that's a good approach.  It breaks the symmetry when
> calling different callbacks.  What if ->can_attach() allocates
> per-task resources and the task exits in the middle?  I think we
> better lock down fork/exit/exec.  I'll send patches but I'm currently
> moving / traveling w/ limited access to my toys so it might take some
> time.

My task counter subsystem patchset brings a cancel_attach_task() callback
that cancels can_attach_task() effects.

I thought that rebased on top of your patch it's going to be merged inside
cancel_attach() but OTOH we can't cancel the effect of failed migration
on a thread that way.

May be we need to keep a cancel_attach_task() just for that purpose?
