From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 7 May 2010 14:25:56 -0700
Message-ID: <20100507212556.GQ387__18948.2715483338$1273267623$gmane$org@atomide.com>
References: <20100507182824.GA25198@srcf.ucam.org>
	<20100507184333.GL387@atomide.com>
	<20100507184621.GA25978@srcf.ucam.org>
	<1273259186.3542.93.camel@c-dwalke-linux.qualcomm.com>
	<20100507192837.GM387@atomide.com>
	<20100507193353.GA27175@srcf.ucam.org>
	<20100507195548.GN387@atomide.com>
	<20100507202859.GA27328@srcf.ucam.org>
	<20100507205329.GP387@atomide.com>
	<20100507210304.GA28701@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100507210304.GA28701@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

* Matthew Garrett <mjg@redhat.com> [100507 13:58]:
> On Fri, May 07, 2010 at 01:53:29PM -0700, Tony Lindgren wrote:
> 
> > So for example, if I leave ping running in a a terminal, do you
> > have some way of preventing that from eating the battery?
> 
> It depends on policy. If all network packets generate wakeup events then 
> no, that will carry on eating battery. If ICMP doesn't generate a wakeup 
> event then the process won't be run.
> 
> > Do you just suspend the whole system anyways at some point,
> > or do you have some other trick?
> 
> If nothing's holding any suspend blocks then the system will enter 
> suspend. If the packet generates a wakeup then the kernel would block 
> suspend until userspace has had the opportunity to do so. Once userspace 
> has handled the packet then it could release the block and the system 
> will immediately transition back into suspend.

OK, then what would I need to do to keep that ping running if I wanted to?

> Here's a different example. A process is waiting for a keypress, but 
> because it's badly written it's also drawing to the screen at 60 frames 
> per second and preventing the system from every going to idle. How do 
> you quiesce the system while still ensuring that the keypress will be 
> delivered to the application?

I guess it depends. If it's a game and I'm waiting to hit the fire
button, then I don't want the system to suspend!

It's starting to sound like you're really using suspend blocks
to "certify" that the app is safe to keep running.

Maybe it could be done with some kind of process flag instead that
would tell "this process is safe to keep running from timer point of view"
and if that flag is not set, then assume it's OK to stop the process
at any point?

Regards,

Tony
