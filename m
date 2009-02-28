From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Sat, 28 Feb 2009 09:03:20 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902280856270.3111@localhost.localdomain>
References: <Pine.LNX.4.44L0.0902270948540.2926-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0902271221360.3111@localhost.localdomain>
	<d6200be20902271954q16697282ia056d4f40ab49184@mail.gmail.com>
	<200902281106.41793.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902281106.41793.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Sat, 28 Feb 2009, Rafael J. Wysocki wrote:
> 
> Still, if Linus agrees, I can put the loop suggested by him directly into
> sysdev_suspend().  Linus?

I don't much care - it's going to be a no-op on architectures that don't 
have that kind of "turn an interrupt into a wakeup event" capability. So 
it's not going to break for things like x86, and it's not like going over 
the irq list one more time is going to be so expensive as to be 
noticeable, even if that architecture doesn't ever get any advantage of 
it.

However - my main worry is that we will notice that different 
architectures (and possibly even different platforms _within_ the same 
architecture - depending on which kind of interrupt/pm controller they 
have) will want to do different things, and actually do something to the 
interrupt controller itself too at that point.

But we can certainly try starting out with just the generic "if a wakeup 
interrupt is pending, sysdev_suspend() returns an error immediately".

			Linus
