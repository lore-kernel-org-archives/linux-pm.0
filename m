From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Thu, 26 Feb 2009 20:43:12 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902262039320.3111@localhost.localdomain>
References: <Pine.LNX.4.44L0.0902262211090.22001-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902262211090.22001-100000@netrider.rowland.org>
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



On Thu, 26 Feb 2009, Alan Stern wrote:
> 
> What you're missing is that the embedded world is quite a large one.  

I'm gpoing to give you one more clue, and if you don't stop sending out 
these IDIOTIC emails, I'm going to put you into my killfile.

Got it?

So listen up:
 - the number of ARM chips sold doesn't matter one F*CKING WHIT.
 - You need to add ONE SINGLE "sysdev" entry for ARM to take care of this 
   FOR EVERY DAMN SINGLE ONE.
 - Your inane whining about this AFTER I HAVE TOLD YOU MULTIPLE TIMES HOW 
   TO DO IT, AND AFTER I HAVE TOLD YOU THAT IT'S A SPECIAL CASE, IS 
   F*CKING IRRITATING.

Got it?

I _grepped_ for that enable_irq_wake() use. It looks like it's only used 
on ARM and maybe BF. Add the five lines of code (just cut and paste them 
from my earlier email) to your architecture already, AND STOP WHINING.

It's not a generic case. It's not a problem. You can damn well fix it in 
the ONE SINGLE ARCHITECTURE (or maybe two) that cares. I've told you how.

Why is it so damn hard for you to just accept? 

			Linus
