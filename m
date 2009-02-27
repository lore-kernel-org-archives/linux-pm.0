From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Thu, 26 Feb 2009 16:27:29 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902261620370.3111__12817.6866950982$1235694711$gmane$org@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0902261404580.3111@localhost.localdomain>
	<d6200be20902261430w19ea3e6fye014f8443d9ab5ca@mail.gmail.com>
	<200902270010.38291.rjw@sisk.pl>
	<d6200be20902261600t7531568ekd9a7aa9215f53263@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902261600t7531568ekd9a7aa9215f53263@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 26 Feb 2009, Arve Hj=F8nnev=E5g wrote:
> =

> How many sysdevs use interrupts?
> =

> I found may drivers in the mainline kernel that use enable_irq_wake,
> but I did not see any that handle this race condition.

The _only_ driver that does enable_irq_wake() on x86 is the cmos timer =

driver, and even there it actually doesn't use irq_wake, but ACPI. Why? =

Because I don't think irq wakeup even _works_ on x86.

So the whole enable_irq_wake is largely some embedded ARM platform issue, =

and a very special case, and doesn't exist anywhere else.

Maybe I'm missing something, but it's definitely not the normal case.

		Linus
