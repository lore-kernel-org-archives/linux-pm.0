From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4 1/2] PM / Core: suspend_again callback for
	suspend_ops.
Date: Wed, 18 May 2011 22:20:21 +0200
Message-ID: <201105182220.21512.rjw__47615.3118689128$1305750030$gmane$org@sisk.pl>
References: <20110512061928.GB2460@localhost.ucw.cz>
	<201105172240.46970.rjw@sisk.pl>
	<BANLkTim6ygf9JN2k1ZnW5kLwvUggDBJyNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTim6ygf9JN2k1ZnW5kLwvUggDBJyNA@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: myungjoo.ham@gmail.com
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, May 18, 2011, MyungJoo Ham wrote:
> 2011/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Tuesday, May 17, 2011, MyungJoo Ham wrote:
> []
> >> -static int suspend_enter(suspend_state_t state)
> >> +static int suspend_enter(suspend_state_t state, bool *wakeup_pending)
> >
> > You don't need to use the wakeup_pending argument at all.  I think you
> > shouldn't use it even, because in theory there may be a wakeup event after
> > you've called pm_wakeup_pending() in suspend_enter() and in that case
> > you should break the loop too.
> 
> In the case where:
> - at the first instance of suspend_enter, pm_wakeup_pending() returns false.
> - after suspend_ops->enter(state), the pm_wakeup_pending() "wants" to
> return true.
> - however, suspend_again forces to loop again.
> - then, at the second instance of suspend_enter, pm_wakeup_pending()
> returns true.
> - the suspend_again's loop breaks.
> 
> Although it did not break the loop at the first while, it breaks
> without calling suspend_ops->enter again anyway.
> 
> []
> >
> > So I would simply call pm_wakeup_pending() here again.
> >
> 
> Besides, if we simply call pm_wakeup_pending() again at there, the
> loop will NOT break with pm_wakeup_pending() is true at the first call
> inside of suspend_enter(). The function pm_wakeup_pending() clears out
> the pending wakeup at each call;

Ah, that's correct, sorry.

Thanks,
Rafael
