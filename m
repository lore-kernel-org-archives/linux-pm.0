From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH UPDATED 03/10] threadgroup: extend
 threadgroup_lock() to cover exit and exec
Date: Fri, 2 Dec 2011 17:28:03 +0100
Message-ID: <20111202162753.GA19752@somewhere.redhat.com>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-4-git-send-email-tj@kernel.org>
	<20111124225054.GA14828@google.com>
	<20111125140136.GC23307@somewhere.redhat.com>
	<20111127193001.GC4266@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111127193001.GC4266@google.com>
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
Cc: akpm@linux-foundation.org, paul@paulmenage.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, oleg@redhat.com, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, containers@lists.linux-foundation.org, kamezawa.hiroyu@Jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

On Sun, Nov 27, 2011 at 11:30:01AM -0800, Tejun Heo wrote:
> Hello, Frederic.
> 
> On Fri, Nov 25, 2011 at 03:01:39PM +0100, Frederic Weisbecker wrote:
> > > +	/*
> > > +	 * @tsk's threadgroup is going through changes - lock out users
> > > +	 * which expect stable threadgroup.  Do this before actually
> > > +	 * starting tearing down @tsk so that locked threadgroup has either
> > > +	 * alive or dead tasks, not something inbetween.
> > > +	 */
> > > +	threadgroup_change_begin(tsk);
> > > +
> > 
> > I still wonder why there is a so big coverage of this lock. I mean
> > why is it called right before exit_irq_thread() and released so late.
> > All we want is to lock cgroup_exit() I think, after which tasks can't be
> > migrated.
> 
> That way, cgroup plugins never see tasks in the process of
> deconstruction.  Its ->mm, ->sighand, ->signal and so on either don't
> exist or continue to exist across all cgroup callbacks.  It's simpler
> and safer (especially as bugs in this area would only be visible when
> migration and exit race), and if we're gonna synchronize exit path at
> all, there isn't anything to lose by excluding the whole thing.

Fine.

But I don't think it's very useful to protect against irq_exit_thread(),
what happens there is purely of internal irq interest.

Then right after, PF_EXITING is set before any interesting change.
Isn't it possible to simply lock this flag setting? IIRC, as soon
as the PF_EXITING flag is set, you ignore the task for attachment.
