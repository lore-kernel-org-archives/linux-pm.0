From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/2] Rework disabling of interrupts
 during suspend-resume
Date: Sun, 22 Feb 2009 10:25:26 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902221024500.3111@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0902221007150.3111@localhost.localdomain>
	<20090222181841.GA17895@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090222181841.GA17895@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org



On Sun, 22 Feb 2009, Ingo Molnar wrote:

> 
> > +	.flags 		= IRQF_DISABLED | IRQF_NOBALANCING, IRQF_TIMER,
> > +	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_IRQPOLL, IRQF_TIMER,
> > +	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_IRQPOLL, IRQF_TIMER,
> 
> s/, IRQF_TIMER/ | IRQF_TIMER
> 
> i guess.

Oops yes. I got one of them right. I guess that's the same one I happened 
to compile in my config. Duh.

		Linus
