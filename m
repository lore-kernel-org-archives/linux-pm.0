From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [update,
 rev. 6] Re: [PATCH 1/10] PM: Rework handling of interrupts during
 suspend-resume (rev. 5)
Date: Sat, 14 Mar 2009 08:31:00 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903140829500.29264__29972.0316812911$1237016201$gmane$org@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200903122243.27452.rjw@sisk.pl>
	<alpine.LFD.2.00.0903132052240.29264@localhost.localdomain>
	<200903132256.51522.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903132256.51522.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 13 Mar 2009, Rafael J. Wysocki wrote:
> > > +		spin_unlock_irqrestore(&desc->lock, flags);
> > 
> > Ditto
> 
> No, because of __setup_irq().

Sorry, forgot about that. Ok. Keep the locking in pm.c then.

Thanks,

	tglx
