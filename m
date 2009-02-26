From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Wed, 25 Feb 2009 17:27:45 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902251724220.3111__40393.0533481345$1235611839$gmane$org@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200902250007.13069.rjw@sisk.pl>
	<20090224230935.GA15165@elte.hu> <200902250029.16107.rjw@sisk.pl>
	<d6200be20902251717r531c022bl4c25fcb902201188@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902251717r531c022bl4c25fcb902201188@mail.gmail.com>
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
>
> Do you plan to fix edge triggered wakeup interrupts? It still looks
> like edge triggered wakeup interrupts that occur between
> suspend_device_irqs and local_irq_disable will not cause a wakeup.

IF we ever see this as a real issue, we can either see it in the =

IRQ_PENDING flag, or we can mark such interrupts specially. So it would be =

solvable. That said, I haven't actually heard any real usage cases. Normal =

wakeup events are _not_ interrupts in the regular "device interrupt =

controller" sense.

So can you actually point to an explicit example of something where this =

is a real issue?

			Linus
