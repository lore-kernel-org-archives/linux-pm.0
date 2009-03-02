From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 1/4] PM: Rework handling of interrupts
 during suspend-resume (rev. 4)
Date: Mon, 2 Mar 2009 15:32:52 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0903021530200.3111@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200903012324.39327.rjw@sisk.pl>
	<d6200be20903021501x4ad710fbr834b11b8a6647d2c@mail.gmail.com>
	<200903030013.02805.rjw@sisk.pl>
	<d6200be20903021518r48fe6fb2vd07e9dedc4f5ff44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20903021518r48fe6fb2vd07e9dedc4f5ff44@mail.gmail.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 2 Mar 2009, Arve Hj=F8nnev=E5g wrote:
>
> > enable_irq() clears IRQ_SUSPENDED. =A0This has already been discussed b=
tw.
> =

> I'm if I missed that discussion, but enable_irq cannot know who is
> calling it and therefore cannot know if IRQ_SUSPENDED should be
> cleared.

Sure it can. =


If IRQ_SUSPENDED is not set, then clearing it is a no-op, so that's fine.

If IRQ_SUSPENDED _is_ set, then that means that we're after the =

suspend_late() sequence and before the resume_early() sequence, and no =

device driver is possibly called in between, so they'd sure better not be =

doing anything that does an enable_irq().

IOW, we know who the caller is, simply because there can be no other valid =

caller!

			Linus
