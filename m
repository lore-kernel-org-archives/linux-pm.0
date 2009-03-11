From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/10] PM: Rework handling of interrupts
 during suspend-resume (rev. 5)
Date: Wed, 11 Mar 2009 15:01:11 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903111459210.32478@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200903112215.02445.rjw@sisk.pl>
	<alpine.LFD.2.00.0903112234530.29264@localhost.localdomain>
	<200903112250.10572.rjw@sisk.pl>
	<alpine.LFD.2.00.0903112251150.29264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0903112251150.29264@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Wed, 11 Mar 2009, Thomas Gleixner wrote:
> 
> I'm not worried about nested ones.

Then you shouldn't be worried about IRQ_SUSPENDED at all, since that one 
increments the disabled depth count.

So _all_ disable/enable_irq calls will by definition be nested inside 
IRQ_SUSPENDED. 

		Linus
