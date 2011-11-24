From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 03/10] threadgroup: extend threadgroup_lock()
 to cover exit and exec
Date: Thu, 24 Nov 2011 13:22:33 -0800
Message-ID: <20111124212233.GC6735@google.com>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-4-git-send-email-tj@kernel.org>
	<20111113164426.GB9446@somewhere>
	<20111121215839.GL25776@google.com>
	<20111123140139.GB10669@somewhere.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111123140139.GB10669@somewhere.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: akpm@linux-foundation.org, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, oleg@redhat.com, linux-pm@lists.linux-foundation.org, paul@paulmenage.org, kamezawa.hiroyu@Jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

Hello, Frederic.

On Wed, Nov 23, 2011 at 03:02:05PM +0100, Frederic Weisbecker wrote:
> This:
> 
>  static inline void threadgroup_lock(struct task_struct *tsk)                                                                
>  {                                                                                                                           
> +       /* exec uses exit for de-threading, grab cred_guard_mutex first */                                                   
> +       mutex_lock(&tsk->signal->cred_guard_mutex);                                                                          
>         down_write(&tsk->signal->group_rwsem);
> 
> is really not obvious.
> 
> Just point out we want to synchronize against the leader, pid and the sighand
> that may change concurrently.

Sure thing.  Will beef up the comments.

> > > Also note this is currently protected by the tasklist readlock. Cred
> > > guard mutex is certainly better, I just don't remember if you remove
> > > the tasklist lock in a further patch.
> > 
> > I don't remove tasklist_lock.
> 
> I believe you can do it after using the cred guard mutex. That needs to
> be double checked though. I think it was mostly there to keep while_each_thread()
> stable non-racy against leader change. cred_guard_mutex should handle that
> now.

Yes, probably, but I still don't think removing that is a good idea.
We're walking tasklist in a rather cold path, IMHO it's better to keep
the locking obvious.

> > So, to me, what seems more important is how to make it easier for each
> > cgroup client instead of what's the minimal that's necessary right
> > now.
> > 
> > Heh, did I make any sense? :)
> 
> Yep, fine for me :)
> Just wanted to ensure I (and others) understood and identified well the issues
> and the fixes.

Yeap, fair enough.  Will update the patches, repost and push them
through cgroup/for-3.3, and move onto other pending patchsets.

Thank you.

-- 
tejun
