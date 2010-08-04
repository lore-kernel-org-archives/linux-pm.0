From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 19:55:20 +0100
Message-ID: <20100804185520.GA2417__8692.83961733363$1280948246$gmane$org@srcf.ucam.org>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
	<20100803183447.0275c134@infradead.org>
	<20100804163216.GB24163@linux.vnet.ibm.com>
	<20100804163509.GA31523@srcf.ucam.org>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 04, 2010 at 11:30:44AM -0700, david@lang.hm wrote:
> a couple days ago I made the suggestion to put non-privilaged tasks in a  
> cgroup so that the idle/suspend decision code could ignore acitivity  
> caused by this cgroup.
>
> in the second version wakeup events would be 'activity' that would be  
> counted and therefor the system would not be idle. As for the race with  
> suspending and new things happening, wouldn't that be handled the same 
> way that it is in a normal linux box?

No! And that's precisely the issue. Android's existing behaviour could 
be entirely implemented in the form of binary that manually triggers 
suspend when (a) the screen is off and (b) no userspace applications 
have indicated that the system shouldn't sleep, except for the wakeup 
event race. Imagine the following:

1) The policy timeout is about to expire. No applications are holding 
wakelocks. The system will suspend providing nothing takes a wakelock.
2) A network packet arrives indicating an incoming SIP call
3) The VOIP application takes a wakelock and prevents the phone from 
suspending while the call is in progress

What stops the system going to sleep between (2) and (3)? cgroups don't, 
because the voip app is an otherwise untrusted application that you've 
just told the scheduler to ignore.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
