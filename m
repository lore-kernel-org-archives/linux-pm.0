From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/10] PM: Rework handling of interrupts
 during suspend-resume (rev. 5)
Date: Wed, 11 Mar 2009 22:35:53 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903112234530.29264__31567.4966238022$1236807652$gmane$org@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200903111036.02482.rjw@sisk.pl>
	<alpine.LFD.2.00.0903111106450.29264@localhost.localdomain>
	<200903112215.02445.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903112215.02445.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wed, 11 Mar 2009, Rafael J. Wysocki wrote:
> On Wednesday 11 March 2009, Thomas Gleixner wrote:
> > > +			desc->status |= IRQ_SUSPENDED;
> > 
> >   This flag needs to be checked in __enable_irq().
> 
> [I overlooked this comment, sorry.]
> 
> Why does it?

To catch abuse and callers of enable_irq() when this flag is set.

Thanks,

	tglx
