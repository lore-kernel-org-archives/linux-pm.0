From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 20:21:15 +0100
Message-ID: <20100804192115.GA2946__14424.8739503839$1280949794$gmane$org@srcf.ucam.org>
References: <20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
	<20100803183447.0275c134@infradead.org>
	<20100804163216.GB24163@linux.vnet.ibm.com>
	<20100804163509.GA31523@srcf.ucam.org>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
	<20100804185520.GA2417@srcf.ucam.org>
	<alpine.DEB.2.00.1008041207260.6545@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1008041207260.6545@asgard.lang.hm>
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

On Wed, Aug 04, 2010 at 12:15:59PM -0700, david@lang.hm wrote:
> On Wed, 4 Aug 2010, Matthew Garrett wrote:
>> No! And that's precisely the issue. Android's existing behaviour could
>> be entirely implemented in the form of binary that manually triggers
>> suspend when (a) the screen is off and (b) no userspace applications
>> have indicated that the system shouldn't sleep, except for the wakeup
>> event race. Imagine the following:
>>
>> 1) The policy timeout is about to expire. No applications are holding
>> wakelocks. The system will suspend providing nothing takes a wakelock.
>> 2) A network packet arrives indicating an incoming SIP call
>> 3) The VOIP application takes a wakelock and prevents the phone from
>> suspending while the call is in progress
>>
>> What stops the system going to sleep between (2) and (3)? cgroups don't,
>> because the voip app is an otherwise untrusted application that you've
>> just told the scheduler to ignore.
>
> Even in the current implementation (wakelocks), Since the VOIP 
> application isn't allowed to take a wakelock, wouldn't the system go to 
> sleep immediatly anyway, even if the application gets the packet and 
> starts the call? What would ever raise the wakelock to keep the phone 
> from sleeping in the middle of the call?

There's two parts of that. The first is that the voip application is 
allowed to take a wakelock - but that doesn't mean that you trust it the 
rest of the time.The second is that the incoming network packet causes 
the kernel to take a wakelock that will be released once userspace has 
processed the network packet. This ensures that at least one wakelock is 
held for the entire relevant period of time.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
