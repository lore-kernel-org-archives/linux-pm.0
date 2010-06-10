From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH v4] pm_qos: make update_request non blocking
Date: Thu, 10 Jun 2010 09:45:25 +0200
Message-ID: <20100610094525.0449d797__599.192819982086$1276156025$gmane$org@schatten.dmk.lab>
References: <1276097381-3982-1-git-send-email-florian@mickler.org>
	<1276097832.4343.223.camel@mulgrave.site>
	<20100609180033.39d5b499@schatten.dmk.lab>
	<1276099645.4343.257.camel@mulgrave.site>
	<20100609183204.1eeca494@schatten.dmk.lab>
	<1276103149.4343.350.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276103149.4343.350.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Frederic Weisbecker <fweisbec@gmail.com>, markgross@thegnar.org, linville@tuxdriver.com, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, 09 Jun 2010 13:05:49 -0400
James Bottomley <James.Bottomley@suse.de> wrote:
> On Wed, 2010-06-09 at 18:32 +0200, Florian Mickler wrote:
> > On Wed, 09 Jun 2010 12:07:25 -0400
> > James Bottomley <James.Bottomley@suse.de> wrote:
> > > OK, so the expression of the race is that the latest notification gets
> > > lost.  If something is tracking values, you'd really like to lose the
> > > previous one (which is now irrelevant) not the latest one.  The point is
> > > there's still a race.
> > > 
> > > James
> > > 
> > 
> > Yeah, but for blocking notification it is not that bad. 
> 
> The network latency notifier uses the value to recalculate something.
> Losing the last value will mean it's using stale data.

Actually after pondering a bit, it is not stale data that gets
delivered: (Correct me if I'm wrong)

The update_notify() function determines the extreme value and then
calls the blocking_notifier_chain. 

But just before the update_notify() function get's called, the
work-structure is reset and re-queue-able. So it is possible to queue it
already even before the extreme_value in update_notify get's
determined. 

So the notified value is always the latest or there is another
notification underway.

> 
> > Doesn't using blocking notifiers mean that you need to always check
> > via pm_qos_request() to get the latest value anyways? I.e. the
> > notification is just a hint, that something changed so you can act on
> > it. But if you act (may it because of notification or because of
> > something other) then you have to get the current value anyways.
> 
> Well, the network notifier assumes the notifier value is the latest ... 
> 
> > I think there are 2 schemes of operation. The one which needs
> > atomic notifiers and where it would be bad if we lost any notification
> > and the other where it is just a way of doing some work in a timely
> > fashion but it isn't critical that it is done right away.
> > 
> > pm_qos was the second kind of operation up until now, because the
> > notifiers may have got scheduled away while blocked. 
> 
> Actually, no ... the current API preserves ordering semantics.  If a
> notifier sleeps and another change comes along, the update callsite will
> sleep on the notifier's mutex ... so ordering is always preserved.

If my above thinkings are right, then the change in semantics is only,
that now you can not determine by the number of notifications the
number of update_request-calls.

> 
> James
> 

Cheers,
Flo
