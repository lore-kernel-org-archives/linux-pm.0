From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Thu, 26 Feb 2009 14:30:22 -0800
Message-ID: <d6200be20902261430w19ea3e6fye014f8443d9ab5ca__13566.6593713269$1235687585$gmane$org@mail.gmail.com>
References: <200902221837.49396.rjw@sisk.pl> <200902261050.50531.rjw@sisk.pl>
	<d6200be20902261234i5a3896fo78a7f56d16a247c7@mail.gmail.com>
	<200902262258.55835.rjw@sisk.pl>
	<alpine.LFD.2.00.0902261404580.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0902261404580.3111@localhost.localdomain>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 26, 2009 at 2:10 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 26 Feb 2009, Rafael J. Wysocki wrote:
>>
>> Well, how exactly the $subject patch does cause this problem to happen?
>
> Rafael, the problem is that if an interrupt happens while it's disabled -
> but before the CPU has actually turned all interrupts off - the CPU will
> ACK the interrupt (but just set a flag for it being PENDING), so now the
> chipset logic around it will not see it as pending any more, so now the
> chipset won't auto-wake the CPU immediately (or more likely, it won't
> even suspend it).
>
> It's trivial to fix multiple ways, so I wouldn't worry. The most trivial
> way is to just have some sysdev drievr code simply do something like
>
> =A0static int sysdev_suspend()
> =A0{
> =A0 =A0 =A0 =A0for_each_irq(irq,desc) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!(desc->flags & IRQF_WAKE))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (desc->flags & IRQ_PENDING)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> and that should automatically mean that if any irq is pending, the suspend
> will fail and we'll immediately wake up again.
>
> It looks trivial, and I don't understand why Arve can't just do the sysdev
> thing.

I can. My point is that the patch breaks our existing code. If anyone
else uses edge triggered wakeup interrupt it may break from them as
well. The main question if this should be fixed separately for every
platform that needs it, or if pending wakeup interrupts should always
abort sleep.

-- =

Arve Hj=F8nnev=E5g
