From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Wed, 25 Feb 2009 19:31:51 -0800
Message-ID: <d6200be20902251931lf563c2aw43d5266e9677e168__39170.5208145597$1235619264$gmane$org@mail.gmail.com>
References: <200902221837.49396.rjw@sisk.pl> <200902250007.13069.rjw@sisk.pl>
	<20090224230935.GA15165@elte.hu> <200902250029.16107.rjw@sisk.pl>
	<d6200be20902251717r531c022bl4c25fcb902201188@mail.gmail.com>
	<alpine.LFD.2.00.0902251724220.3111@localhost.localdomain>
	<d6200be20902251813o3ff4a065nb0a54321e27c512d@mail.gmail.com>
	<alpine.LFD.2.00.0902251848120.3111@localhost.localdomain>
	<20090226030050.GA3361@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090226030050.GA3361@elte.hu>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 25, 2009 at 7:00 PM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>>
>>
>> On Wed, 25 Feb 2009, Arve Hj=F8nnev=E5g wrote:
>> >
>> > On the msm platform the keyboard driver currently leave the interrupts
>> > enabled when suspended. If the interrupt handler is called, we use a
>> > wakelock to abort suspend (without wakelocks you would need to set a
>> > flag and abort in suspend_late instead). If the interrupt occurs after
>> > local_irq_disable, it will still be pending when we get to the suspend
>> > enter hook and suspend will be aborted there.
>> >
>> > As far as I can tell, this change breaks this. If you press a key at
>> > the right time, it will be ignored.
>>
>> Is the irq on a private non-shared interrupt line? If so, you
>> could just mark it as IRQF_TIMER, and the irq disable logic
>> won't touch it.

That would not work without wakelocks support, since the interrupt
could occur after suspend_late which is the last chance for the driver
to abort sleep. (The patch also breaks my current wakelock
implementation since I use a suspend_late hook to abort sleep, but
this should be easy to fix)

> Hm, if that solves the problem then it would be nice to have a
> new IRQF_NO_SUSPEND flag for it, in addition to IRQF_TIMER:

I think the right fix is for any interrupt that has IRQ_WAKEUP set to
abort suspend if it is pending. I don't know if anyone relies on these
interrupts being dropped now though.

-- =

Arve Hj=F8nnev=E5g
