From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Mon, 27 Sep 2010 22:00:49 +0200
Message-ID: <201009272200.49330.rjw__19704.4248845943$1285617818$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1009270955080.1751-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009270955080.1751-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Partha Basak <p-basak2@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, September 27, 2010, Alan Stern wrote:
> On Fri, 24 Sep 2010, Rafael J. Wysocki wrote:
> 
> > On Friday, September 24, 2010, Kevin Hilman wrote:
> > > Alan Stern <stern@rowland.harvard.edu> writes:
> > > 
> > > > On Thu, 23 Sep 2010, Kevin Hilman wrote:
> > ...
> > > >
> > > > You're trying to fight the runtime-PM design instead of using it as it 
> > > > was intended.  We already have an API for starting a resume from 
> > > > interrupt context, and that's what you should use.
> > > 
> > > It may seem like I'm trying to fight the design, but I'm actually trying
> > > to find ways to use it.  I want to use the API (and we're using it
> > > successfully in most of our drivers now.)  The problem is only in a few
> > > of these corner cases where using it introduces significant changes from
> > > previous behavior like introducing long, unbounded windows for missed
> > > interrupts.
> > 
> > This really sounds to me like you need _noirq() runtime PM callbacks
> > and some framework around them.
> > 
> > I'm not fundamentally against that, but it will require some time to introduce,
> > if we decide that it's really necessary.
> > 
> > I need to think a bit more about that, thanks for the example.
> 
> How about adding another flag to the dev_pm_info structure, to indicate 
> that the runtime callbacks may be called in interrupt context?
> 
> Maybe that will lead to problems I haven't thought of.  But if it seems 
> okay to you, I can code it up easily enough.

Hmm.  I was thinking about adding a new RPM_ flag for that, like RPM_FASTPATH,
telling the PM core to assume the callbacks will not sleep and that the call
might be from interrupt handler.

Thanks,
Rafael
