From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 7 May 2010 10:50:30 -0700
Message-ID: <20100507175029.GG387__506.077535874461$1273254711$gmane$org@atomide.com>
References: <20100505234755.GI29604@atomide.com>
	<20100506134015.GA23426@srcf.ucam.org>
	<20100506170151.GA30928@atomide.com>
	<20100506170956.GA28104@srcf.ucam.org>
	<20100506171453.GC30928@atomide.com>
	<1273167311.20494.13.camel@c-dwalke-linux.qualcomm.com>
	<20100506183605.GF30928@atomide.com>
	<1273173110.20494.19.camel@c-dwalke-linux.qualcomm.com>
	<20100507020057.GG30928@atomide.com>
	<1273252837.3542.30.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1273252837.3542.30.camel@c-dwalke-linux.qualcomm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

* Daniel Walker <dwalker@fifo99.com> [100507 10:15]:
> On Thu, 2010-05-06 at 19:00 -0700, Tony Lindgren wrote:
> 
> > Oh some SoC devices like omap hit retention or off modes in the idle loop.
> > That brings down the idle consumption of a running system to minimal
> > levels. It's basically the same as suspending the device in every idle loop.
> > 
> > The system wakes up every few seconds or so, but that already provides
> > battery life of over ten days or so on an idle system. Of course the
> > wakeup latencies are in milliseconds then.
> 
> MSM doesn't have those power states unfortunately .. Your kind of
> suggesting what I was suggesting in that we should suspend in idle. Your
> hardware can do it easier tho since your have power states that are
> equal to suspend.

You might be able to implement suspend-while-idle with cpuidle and
a custom idle function on MSM. That is if MSM supports waking to
a timer event and some device interrupts. However, if it only wakes
to pressing some power button, then you will get missed timers
and the system won't behave in a normal way.

Maybe you could still kill -STOP the misbehaving apps, then keep the
idle system running until some timer expires, then when no activity,
echo mem > /sys/power/state?

Regards,

Tony
