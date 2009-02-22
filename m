From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH 0/2] Rework disabling of interrupts
	during	suspend-resume
Date: Sun, 22 Feb 2009 19:18:41 +0100
Message-ID: <20090222181841.GA17895__18491.8436025784$1235326877$gmane$org@elte.hu>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0902221007150.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0902221007150.3111@localhost.localdomain>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


> +	.flags 		= IRQF_DISABLED | IRQF_NOBALANCING, IRQF_TIMER,
> +	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_IRQPOLL, IRQF_TIMER,
> +	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_IRQPOLL, IRQF_TIMER,

s/, IRQF_TIMER/ | IRQF_TIMER

i guess.

	Ingo
