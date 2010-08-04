From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 20:57:23 +0100
Message-ID: <20100804195723.GA3553__36620.8587344319$1280951912$gmane$org@srcf.ucam.org>
References: <20100802011006.GS2470@linux.vnet.ibm.com>
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
	<20100803183447.0275c134@infradead.org>
	<20100804163216.GB24163@linux.vnet.ibm.com>
	<20100804163509.GA31523@srcf.ucam.org>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
	<20100804185520.GA2417@srcf.ucam.org>
	<alpine.DEB.2.00.1008041207260.6545@asgard.lang.hm>
	<20100804192115.GA2946@srcf.ucam.org>
	<alpine.DEB.2.00.1008041222280.6545@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1008041222280.6545@asgard.lang.hm>
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

On Wed, Aug 04, 2010 at 12:29:36PM -0700, david@lang.hm wrote:

> why would you trust it to take a wakelock, but not trust it the rest of  
> the time?

Because I trust that when the application author says "I explicitly need 
the machine to stay awake" that they mean it, whereas I don't trust the 
application author to write an application that avoids consuming 
background CPU. The distinction is pretty important.

> in my proposal I'm saying that if you would trust the application to take 
> a wakelock, you instead trust it to be sane in the rest of it's power  
> activity (avoiding polling, etc) and so you consider it for sleep  
> decisions.

When we say "trust", we're not using the same meaning as we do with 
security. Yes, it's possible that an application that can block suspend 
will do so at inopportune times. But given that blocking suspend is an 
explicit act it's much more likely that the developer will only use it 
in reasonable ways, while it's still entirely plausible that the 
application will generate unnecessary wakeups. Pretending otherwise is 
unrealistic. I recently had to fix the fact that the kernel IPMI layer 
would generate a constant 1000 wakeups a second even if it had an 
interrupt-driven controller or was entirely idle.

>> The second is that the incoming network packet causes
>> the kernel to take a wakelock that will be released once userspace has
>> processed the network packet. This ensures that at least one wakelock is
>> held for the entire relevant period of time.
>
> how do you determine that userspace has processed the network packet so  
> that the kernel can release the wakelock (or is this one of the cases  
> where there is a timer related to the wakelock)

The current implementation uses a timer, but Rafael's implementation 
should allow userspace to explicitly acknowledge it.

> two things here,
>
> on the dirty networks that I see as common, refusing to sleep if network  
> packets are arriving will mean that you never go to sleep.

Cell networks typically have no background traffic, for obvious reasons.

> secondly, nothing stops the code doing the idle/suspend decision from  
> considering network activity. I would be surprised if there weren't  
> already options to support this today.

If you proxy every potential wakeup event through some central server 
then this becomes much easier, but it's also a performance hit. The 
alternative is that you poll for network activity, but that's a power 
hit.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
