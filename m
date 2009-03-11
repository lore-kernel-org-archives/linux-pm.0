From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/10] PM: Rework handling of interrupts
	during suspend-resume (rev. 5)
Date: Wed, 11 Mar 2009 23:13:36 +0100
Message-ID: <200903112313.37628.rjw__26807.5342676186$1236810067$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0903112251150.29264@localhost.localdomain>
	<alpine.LFD.2.00.0903111459210.32478@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0903111459210.32478@localhost.localdomain>
Content-Disposition: inline
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
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wednesday 11 March 2009, Linus Torvalds wrote:
> 
> On Wed, 11 Mar 2009, Thomas Gleixner wrote:
> > 
> > I'm not worried about nested ones.
> 
> Then you shouldn't be worried about IRQ_SUSPENDED at all, since that one 
> increments the disabled depth count.
> 
> So _all_ disable/enable_irq calls will by definition be nested inside 
> IRQ_SUSPENDED. 

Still, if there's an unbalanced irq_enable() between suspend_device_irqs()
and resume_device_irqs(), we'll not detect it immediately, but only in
resume_device_irqs().  It would be better if the unbalanced call failed in that
case IMHO.

Rafael
