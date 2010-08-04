From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 22:51:07 +0200
Message-ID: <201008042251.08266.rjw__6037.0716885247$1280955425$gmane$org@sisk.pl>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
	<20100804185520.GA2417@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100804185520.GA2417@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, Arve@smtp1.linux-foundation.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 04, 2010, Matthew Garrett wrote:
> On Wed, Aug 04, 2010 at 11:30:44AM -0700, david@lang.hm wrote:
> > a couple days ago I made the suggestion to put non-privilaged tasks in a  
> > cgroup so that the idle/suspend decision code could ignore acitivity  
> > caused by this cgroup.
> >
> > in the second version wakeup events would be 'activity' that would be  
> > counted and therefor the system would not be idle. As for the race with  
> > suspending and new things happening, wouldn't that be handled the same 
> > way that it is in a normal linux box?
> 
> No! And that's precisely the issue. Android's existing behaviour could 
> be entirely implemented in the form of binary that manually triggers 
> suspend when (a) the screen is off and (b) no userspace applications 
> have indicated that the system shouldn't sleep, except for the wakeup 
> event race. Imagine the following:
> 
> 1) The policy timeout is about to expire. No applications are holding 
> wakelocks. The system will suspend providing nothing takes a wakelock.
> 2) A network packet arrives indicating an incoming SIP call
> 3) The VOIP application takes a wakelock and prevents the phone from 
> suspending while the call is in progress
> 
> What stops the system going to sleep between (2) and (3)? cgroups don't, 
> because the voip app is an otherwise untrusted application that you've 
> just told the scheduler to ignore.

I _think_ you can use the just-merged /sys/power/wakeup_count mechanism to
avoid the race (if pm_wakeup_event() is called at 2)).

Thanks,
Rafael
