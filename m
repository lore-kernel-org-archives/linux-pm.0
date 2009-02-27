From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Thu, 26 Feb 2009 22:20:27 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902262211090.22001-100000__14393.6914195821$1235705085$gmane$org@netrider.rowland.org>
References: <alpine.LFD.2.00.0902261620370.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0902261620370.3111@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Thu, 26 Feb 2009, Linus Torvalds wrote:

> The _only_ driver that does enable_irq_wake() on x86 is the cmos timer 
> driver, and even there it actually doesn't use irq_wake, but ACPI. Why? 
> Because I don't think irq wakeup even _works_ on x86.
> 
> So the whole enable_irq_wake is largely some embedded ARM platform issue, 
> and a very special case, and doesn't exist anywhere else.
> 
> Maybe I'm missing something, but it's definitely not the normal case.

What you're missing is that the embedded world is quite a large one.  
As any member of CELF will tell you, there are lots more embedded
systems around than there are desktop/laptop computers.  (I admit, I
don't know what the ratio is if you restrict your attention to systems
running Linux.)  We can't afford to regard them as second-class
citizens.

Plenty of embedded systems use normal interrupts from GPIO lines as 
wakeup sources.  Don't discount the need for this just because desktop 
systems don't use them that way.  It may not be "normal" in the 
circles you're accustomed to, but it _is_ normal elsewhere.

Alan Stern
