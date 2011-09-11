From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] freezer: fix
	wait_event_freezable/__thaw_task races
Date: Sun, 11 Sep 2011 10:54:31 +0900
Message-ID: <20110911015431.GK29319__298.960813279514$1315706185$gmane$org@htj.dyndns.org>
References: <20110905023315.GB9807@htj.dyndns.org>
	<20110905162012.GA4445@redhat.com>
	<20110906032846.GA18425@mtj.dyndns.org>
	<20110906151836.GA15568@redhat.com>
	<20110906152539.GA16899@redhat.com>
	<20110906155332.GF18425@mtj.dyndns.org>
	<20110907182156.GA13909@redhat.com>
	<20110907182217.GB13909@redhat.com>
	<20110908010530.GD3987@mtj.dyndns.org>
	<20110908175926.GA26986@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110908175926.GA26986@redhat.com>
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

On Thu, Sep 08, 2011 at 07:59:26PM +0200, Oleg Nesterov wrote:
> > Indeed, nice catch.  This one actually is pretty dangerous.  We
> > probably want to make a separate fix for this and backport it to
> > -stable?
> 
> And I forgot to mention that wait_event_freezable_timeout() doesn't
> handle -ERESTARTSYS at all.
> 
> But I don't think -stable needs this fix. According to grep, nobody
> check the returned value, and none of the callers plays with signals.

Ah, no user, okay.

> > Yeap, with freezable_with_signal gone, this looks correct & simpler to
> > me
> 
> I don't really understand this... set_freezable_with_signal() has a
> lot of problems, yes... But even if it wasn't removed this fix makes
> sense anyway, afaics.
> 
> If freezable_with_signal caller does wait_event_freezable_timeout(),
> __retval becomes -ERESTARTSYS after freeze_task(). The next iteration
> will return 0 with the KERN_ERR message from schedule_timeout().

Hmmm... but with the change, if a kthread gets TIF_SIGPENDING from
freezer and then thawed, it would not enter try_to_freeze() and thus
won't clear TIF_SIGPENDING.  The original code was racy too but the
window would be much larger afterwards.  Anyways, this doesn't matter
anymore.

> > but it would be nice if you can sprinkle some documentation while
> > at it. :)
> 
> But they already have the comment ;) What can I add?

Proper /** - */ comment w/ return value documentation? :P

Thanks.

-- 
tejun
