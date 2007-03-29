From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Thu, 29 Mar 2007 09:53:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703290949060.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<460BBD1B.4040308@ru.mvista.com>
	<200703291531.18253.maximlevitsky@gmail.com>
	<200703291546.48996.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703291546.48996.maximlevitsky@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, jgarzik@pobox.com, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Thu, 29 Mar 2007, Maxim Levitsky wrote:
>
> Subject: Add suspend/resume for HPET
>
> This adds support of suspend/resume on i386 for HPET
>
> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> =

> ---
>  arch/i386/kernel/hpet.c |   68 +++++++++++++++++++++++++++++++++++++++++=
++++++

Btw, what about arch/x86_64/kernel/hpet.c?

That thing seems totally broken. Lookie here:

  arch/x86_64/kernel/hpet.c:irqreturn_t hpet_rtc_interrupt(int irq, void *d=
ev_id, struct pt_regs *regs)
  drivers/char/rtc.c:extern irqreturn_t hpet_rtc_interrupt(int irq, void *d=
ev_id);

anybody see a problem? The x86-64 version doesn't seem to be very well =

maintained. Is there some fundamental reason why this file isn't shared =

across architectures?

			Linus
