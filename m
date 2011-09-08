From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/1] freezer: fix
	wait_event_freezable/__thaw_task races
Date: Thu, 8 Sep 2011 19:59:26 +0200
Message-ID: <20110908175926.GA26986__48127.2308774807$1315506105$gmane$org@redhat.com>
References: <20110904184626.GA30101@redhat.com>
	<20110905023315.GB9807@htj.dyndns.org>
	<20110905162012.GA4445@redhat.com>
	<20110906032846.GA18425@mtj.dyndns.org>
	<20110906151836.GA15568@redhat.com>
	<20110906152539.GA16899@redhat.com>
	<20110906155332.GF18425@mtj.dyndns.org>
	<20110907182156.GA13909@redhat.com>
	<20110907182217.GB13909@redhat.com>
	<20110908010530.GD3987@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110908010530.GD3987@mtj.dyndns.org>
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
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 09/08, Tejun Heo wrote:
>
> Hello,
>
> On Wed, Sep 07, 2011 at 08:22:17PM +0200, Oleg Nesterov wrote:
> > wait_event_freezable() and wait_event_freezable_timeout() stop
> > the waiting if try_to_freeze() fails. This is not right, we can
> > race with __thaw_task() and in this case
> >
> > 	- wait_event_freezable() returns the wrong ERESTARTSYS
> >
> > 	- wait_event_freezable_timeout() can return the positive
> > 	  value while condition == F
>
> Indeed, nice catch.  This one actually is pretty dangerous.  We
> probably want to make a separate fix for this and backport it to
> -stable?

And I forgot to mention that wait_event_freezable_timeout() doesn't
handle -ERESTARTSYS at all.

But I don't think -stable needs this fix. According to grep, nobody
check the returned value, and none of the callers plays with signals.

> > Change the code to always check __retval/condition before return.
> >
> > Note: with or without this patch the timeout logic looks strange,
> > probably we should recalc timeout if try_to_freeze() returns T.
> >
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>
> Yeap, with freezable_with_signal gone, this looks correct & simpler to
> me

I don't really understand this... set_freezable_with_signal() has a
lot of problems, yes... But even if it wasn't removed this fix makes
sense anyway, afaics.

If freezable_with_signal caller does wait_event_freezable_timeout(),
__retval becomes -ERESTARTSYS after freeze_task(). The next iteration
will return 0 with the KERN_ERR message from schedule_timeout().

> but it would be nice if you can sprinkle some documentation while
> at it. :)

But they already have the comment ;) What can I add?

Oleg.
