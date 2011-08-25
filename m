From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/6] cgroup: introduce cgroup_taskset and use
 it in subsys->can_attach(), cancel_attach() and attach()
Date: Thu, 25 Aug 2011 10:20:49 +0200
Message-ID: <20110825082049.GC3286__1904.38218783147$1314260541$gmane$org@htj.dyndns.org>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-4-git-send-email-tj@kernel.org>
	<20110825093958.75b95bd8.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110825093958.75b95bd8.kamezawa.hiroyu@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

Hello, KAMEZAWA.

On Thu, Aug 25, 2011 at 09:39:58AM +0900, KAMEZAWA Hiroyuki wrote:
> > +Called prior to moving one or more tasks into a cgroup; if the
> > +subsystem returns an error, this will abort the attach operation.
> > +@tset contains the tasks to be attached and is guaranteed to have at
> > +least one task in it. If there are multiple, it's guaranteed that all
> > +are from the same thread group,
> 
> 
> Do this, "If there are multiple, it's guaranteed that all
> are from the same thread group ", means the 'tset' contains
> only one mm_struct ?

Yes, CLONE_THREAD requires CLONE_SIGHAND which in turn requires
CLONE_VM, so they'll all have the same mm.

> And is it guaranteed that any task in tset will not be freed while
> subsystem routine runs ?

Yeap, that one is guaranteed.  It might die but the the task_struct
itself won't be released.  However, I think it might be bette to block
task exits during migration too.

> > @@ -5460,8 +5460,9 @@ static void mem_cgroup_clear_mc(void)
> >  
> >  static int mem_cgroup_can_attach(struct cgroup_subsys *ss,
> >  				struct cgroup *cgroup,
> > -				struct task_struct *p)
> > +				struct cgroup_taskset *tset)
> >  {
> > +	struct task_struct *p = cgroup_taskset_first(tset);
> >  	int ret = 0;
> >  	struct mem_cgroup *mem = mem_cgroup_from_cont(cgroup);
> >  
> 
> Ah..hmm. I think this doesn't work as expected for memcg.
> Maybe code like this will be required.

Hmmm... the above is basically identity transformation of the existing
code.  If the above is broken, the current code is broken too.  Is it?

Thanks.

-- 
tejun
