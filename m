From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6/6] freezer: kill unused
	set_freezable_with_signal()
Date: Tue, 6 Sep 2011 12:28:55 +0900
Message-ID: <20110906032846.GA18425__1326.5099646107$1315279854$gmane$org@mtj.dyndns.org>
References: <1314988070-12244-1-git-send-email-tj@kernel.org>
	<1314988070-12244-7-git-send-email-tj@kernel.org>
	<20110904184626.GA30101@redhat.com>
	<20110905023315.GB9807@htj.dyndns.org>
	<20110905162012.GA4445@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110905162012.GA4445@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Mon, Sep 05, 2011 at 06:20:12PM +0200, Oleg Nesterov wrote:
> Perhaps it is correct... Just I do not understand what it should do.
> I thought it is "wait_for_event && do_not_block_freezer". And at first
> glance the code looks as if it tries to do this. Say, in the "likely"
> case we restart wait_event_interruptible() after refrigerator().
> 
> But this looks racy. Suppose that freezing() is already false when
> try_to_freeze() or __refrigerator() is called. Say, cgroup_freezer does
> freeze_task() + __thaw_task(). Why it returns -ERESTARTSYS in this case?

It may return -ERESTARTSYS when not strictly necessary but given that
it's supposed to trigger restart anyway I don't think it's actually
broken (it doesn't break the contract of the wait).  Another thing to
note is that kthread freezing via cgroup is almost fundamentally
broken.  With the removal of freezable_with_signal, this shouldn't be
an issue anymore although cgroup_freezer still needs to be fixed to
account for kthreads for xstate transitions (it currently triggers
BUG_ON).

> And if it can be used by the userspace thread, then we should probably
> do recalc_sigpending() somewhere, otherwise wait_event_freezable() will
> always return -ERESTARTSYS after __refrigerator().

Thankfully, currently, all the few users are kthreads.  I don't think
it makes sense for userland tasks at all.  Interruptible sleeps for
userland tasks necessiate the ability to return to signal delivery
path and restart or abort the current operation.  There's no point in
using wait_event_freezable() instead of wait_event_interruptible().

Thanks.

-- 
tejun
