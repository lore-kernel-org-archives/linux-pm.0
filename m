From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 07:34:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008050724110.25170__25739.1164931052$1281019887$gmane$org@asgard.lang.hm>
References: <20100803183447.0275c134@infradead.org>
	<20100804163216.GB24163@linux.vnet.ibm.com>
	<20100804163509.GA31523@srcf.ucam.org>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
	<20100804185520.GA2417@srcf.ucam.org>
	<alpine.DEB.2.00.1008041207260.6545@asgard.lang.hm>
	<20100804192115.GA2946@srcf.ucam.org>
	<alpine.DEB.2.00.1008041222280.6545@asgard.lang.hm>
	<20100804195723.GA3553@srcf.ucam.org>
	<alpine.DEB.2.00.1008041508040.6545@asgard.lang.hm>
	<20100805133811.GA20565@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100805133811.GA20565@srcf.ucam.org>
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
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 5 Aug 2010, Matthew Garrett wrote:

> On Wed, Aug 04, 2010 at 03:20:04PM -0700, david@lang.hm wrote:
>
>> similar to the current implementation, the arrival of a packet could be
>> counted as activity that keeps the system awake for a bit (your timeout)
>
> How? You're either polling in order to know whether there's network
> activity, or you're having every network packet wake up the policy
> daemon, or you've got something that looks like the kernel side of
> wakelocks.

infrequent polling (on the order of seconds or 10s of seconds) is not a 
very significant impact on your power

>>> Cell networks typically have no background traffic, for obvious reasons.
>>
>> but don't most new smartphones also connect up to wifi networks? those
>> are FAR from quiet.
>
> Wifi radio typically dwarfs your other power consumption anyway. The
> typical situation is one where you're not attached to a wifi network.

on some devices (my kindle for example) the cell network dwarfs my other 
power consumption today.

>> I'm not suggesting running all events through some central server (unless
>> you count the kernel as that server),  I'm saying that the decision that
>> the system is idle and therefor can be stopped should be able to take
>> this infomation into account, and if there's a race here, it should be a
>> race that exists everywhere else, so there should be a general solution,
>> not something specific to one use-case. (and definantly not something
>> that requires all software to be modified and trusted to implement)
>
> You're right. It's a race that exists everywhere else, and it's inherent
> unless you have some handshaking between userspace and the kernel when
> entering suspend. Which is what wakelocks provide. Nobody has proposed a
> solution that works without modifying existing code.

I think the issue is confusion between the different purposes of the 
wakelock.

as you say, I don't think anyone is opposed to the kernel being modified 
to eliminate this race. The disagreement is far more about the interface 
to userspace and userspace use of wakelocks.

the kernel implementation of this doesn't have to set a single flag, and 
it doesn't have to notify userspace directly. The kernel already produces 
many stats today and it may be appropriate for the kernel to produce some 
more.

for example, if you want to abort the suspend because there is network 
activity, you can check the packet count of your network interface, decide 
to go to sleep, setup the network interface to raise a 'wake me up' 
interrupt (because you have decided in a userspace policy that you want 
this), and then check to see if the packet count has changed. If it has, 
abort the suspend, if not continue the suspend and once you are suspended 
if the 'wake me up' interrupt is set you will wake back up.

there are probably cleaner/better ways of doing this than the simple logic 
that I'm listing, but why wouldn't the simple logic provide the correct 
result?

David Lang
