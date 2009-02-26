From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Wed, 25 Feb 2009 19:37:09 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902251935190.3111@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200902250007.13069.rjw@sisk.pl>
	<20090224230935.GA15165@elte.hu> <200902250029.16107.rjw@sisk.pl>
	<d6200be20902251717r531c022bl4c25fcb902201188@mail.gmail.com>
	<alpine.LFD.2.00.0902251724220.3111@localhost.localdomain>
	<d6200be20902251813o3ff4a065nb0a54321e27c512d@mail.gmail.com>
	<alpine.LFD.2.00.0902251848120.3111@localhost.localdomain>
	<20090226030050.GA3361@elte.hu>
	<d6200be20902251931lf563c2aw43d5266e9677e168@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902251931lf563c2aw43d5266e9677e168@mail.gmail.com>
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



On Wed, 25 Feb 2009, Arve Hj=F8nnev=E5g wrote:
> =

> That would not work without wakelocks support, since the interrupt
> could occur after suspend_late which is the last chance for the driver
> to abort sleep. (The patch also breaks my current wakelock
> implementation since I use a suspend_late hook to abort sleep, but
> this should be easy to fix)

Since this must be some very deep arch-specific thing anyway, just make =

the dang thing be a "sysdev". At that point, its "suspend" function gets =

called way later (at which point CPU interrupts are off).

> > Hm, if that solves the problem then it would be nice to have a
> > new IRQF_NO_SUSPEND flag for it, in addition to IRQF_TIMER:
> =

> I think the right fix is for any interrupt that has IRQ_WAKEUP set to
> abort suspend if it is pending. I don't know if anyone relies on these
> interrupts being dropped now though.

We could add something like that, but quite frankly, I'd hate to unless =

there is some seriously common case. If it's just an oddball hacky special =

case, it's easier to just say "hey, you have that crazy system device, you =

handle it yourself".

		Linus
