From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Fri, 27 Feb 2009 12:30:33 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902271221360.3111__35808.4864369177$1235766803$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0902270948540.2926-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902270948540.2926-100000@iolanthe.rowland.org>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Fri, 27 Feb 2009, Alan Stern wrote:
> 
> Perhaps these aren't all the sort of usage you're talking about, but I
> bet most of them are.  It certainly looks like more than just ARM.  
> Maybe not all that much more, but definitely more.  And the number will
> only grow in the future.

Are you really sure? Because it can't be x86. I'm pretty sure that that is 
simply not how x86 wake events _work_ - they're not interrupts.

And that's the big point that people seem to be missing here: the whole 
"wake up interrupt" thing is not some generic model in the first place. I 
strongly suspect that it literally only works on certain architectures.

In other words, I'm getting damn tired of people who CLEARLY DON'T EVEN 
KNOW HOW THE HARDWARE WORKS arguing over this.

Here's another hint: that whole "enable_irq_wake()" - have you possibly 
spent even five seconds to look at what it actually does? I bet you 
haven't. Because what it does is to call the irq controller "set_wake" 
function.

Now, grep for that. Whay do you find? Like maybe ARM and BlackFin? Oh, and 
I note one MIPS platform.

The point is, that whole "irq wake" really is system dependent. We can do 
helper functions for it, but anybody who thinks it's anything "generic" is 
totally mistaken.

In other words, making it a sysdev thing is the CORRECT thing to do. It 
really is not just "here's how you work around something". It really is 
"this is how the hardware FUNDAMENTALLY WORKS".

Please, stop arguing. At least argue only after you understand what the 
physical hardware actyally does. 

			Linus
