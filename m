From: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Thu, 06 May 2010 12:11:50 -0700
Message-ID: <1273173110.20494.19.camel__37257.5309513651$1273173185$gmane$org@c-dwalke-linux.qualcomm.com>
References: <20100505202826.GB7450@linux.intel.com>
	<Pine.LNX.4.44L0.1005051705200.1885-100000@iolanthe.rowland.org>
	<z2ta55d774e1005051437heb584584q6afca0b4b254d5d0@mail.gmail.com>
	<20100505234755.GI29604@atomide.com>
	<20100506134015.GA23426@srcf.ucam.org>
	<20100506170151.GA30928@atomide.com>
	<20100506170956.GA28104@srcf.ucam.org>
	<20100506171453.GC30928@atomide.com>
	<1273167311.20494.13.camel@c-dwalke-linux.qualcomm.com>
	<20100506183605.GF30928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100506183605.GF30928@atomide.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Lindgren <tony@atomide.com>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-05-06 at 11:36 -0700, Tony Lindgren wrote:
> * Daniel Walker <dwalker@fifo99.com> [100506 10:30]:
> > On Thu, 2010-05-06 at 10:14 -0700, Tony Lindgren wrote:
> > > * Matthew Garrett <mjg@redhat.com> [100506 10:05]:
> > > > On Thu, May 06, 2010 at 10:01:51AM -0700, Tony Lindgren wrote:
> > > > 
> > > > > Or are you suspending constantly, tens of times per minute even if
> > > > > there's no user activity?
> > > > 
> > > > In this case you'd be repeatedly trying to suspend until the modem 
> > > > driver stopped blocking it. It's pretty much a waste.
> > > 
> > > But then the userspace knows you're getting data from the modem, and
> > > it can kick some inactivity timer that determines when to try to
> > > suspend next.
> > 
> > If the idle thread was doing the suspending then the inactivity timer by
> > it's self could block suspend. As long as the idle thread was setup to
> > check for timers. I'm sure that _isn't_ the point your trying to make.
> > It just makes gobs more sense to me that the idle thread does the
> > suspending .. Your idle, so depending on how long your idle then you
> > suspend.
> 
> The alternative logic I'm suggesting is get the GUI into idle mode as
> soon as possible, then limp along with off-while-idle or
> retention-while-idle until some timer expires, then suspend the whole
> device.

Could you elaborate on "off-while-idle" and "retention-while-idle" ? I'm
not sure I follow what you mean.

Daniel
