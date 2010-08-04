From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 21:56:55 +0100
Message-ID: <20100804205654.GA4986__22831.3749227256$1280955629$gmane$org@srcf.ucam.org>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
	<20100804185520.GA2417@srcf.ucam.org>
	<201008042251.08266.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201008042251.08266.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 04, 2010 at 10:51:07PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, August 04, 2010, Matthew Garrett wrote:
> > No! And that's precisely the issue. Android's existing behaviour could 
> > be entirely implemented in the form of binary that manually triggers 
> > suspend when (a) the screen is off and (b) no userspace applications 
> > have indicated that the system shouldn't sleep, except for the wakeup 
> > event race. Imagine the following:
> > 
> > 1) The policy timeout is about to expire. No applications are holding 
> > wakelocks. The system will suspend providing nothing takes a wakelock.
> > 2) A network packet arrives indicating an incoming SIP call
> > 3) The VOIP application takes a wakelock and prevents the phone from 
> > suspending while the call is in progress
> > 
> > What stops the system going to sleep between (2) and (3)? cgroups don't, 
> > because the voip app is an otherwise untrusted application that you've 
> > just told the scheduler to ignore.
> 
> I _think_ you can use the just-merged /sys/power/wakeup_count mechanism to
> avoid the race (if pm_wakeup_event() is called at 2)).

Yes, I think that solves the problem. The only question then is whether 
it's preferable to use cgroups or suspend fully, which is pretty much up 
to the implementation. In other words, is there a reason we're still 
having this conversation? :) It'd be good to have some feedback from 
Google as to whether this satisfies their functional requirements.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
