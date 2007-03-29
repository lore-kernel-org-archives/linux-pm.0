From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Thu, 29 Mar 2007 19:51:17 +0200
Message-ID: <20070329175117.GA5521@elte.hu>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<460BBD1B.4040308@ru.mvista.com>
	<200703291531.18253.maximlevitsky@gmail.com>
	<200703291546.48996.maximlevitsky@gmail.com>
	<Pine.LNX.4.64.0703290949060.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703290949060.6730@woody.linux-foundation.org>
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
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, jgarzik@pobox.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Btw, what about arch/x86_64/kernel/hpet.c?

at least wrt. suspend/resume it should be fine, because in =

arch/x86_64/kernel/time.c it does this upon resume:

 static int timer_resume(struct sys_device *dev)
 {
         if (hpet_address)
                 hpet_reenable();
         else
                 i8254_timer_resume();

[ barring the issue that mixing two pieces of hardware like this in a =

  single resume function is wrong - all timer hardware should be =

  separated like we did it for i386. I've got 64-bit clockevents code in =

  -rt which does this separation. ]

> That thing seems totally broken. Lookie here:
> =

>   arch/x86_64/kernel/hpet.c:irqreturn_t hpet_rtc_interrupt(int irq, void =
*dev_id, struct pt_regs *regs)
>   drivers/char/rtc.c:extern irqreturn_t hpet_rtc_interrupt(int irq, void =
*dev_id);
> =

> anybody see a problem? The x86-64 version doesn't seem to be very well =

> maintained. Is there some fundamental reason why this file isn't =

> shared across architectures?

there's no fundamental reason. x86_64 COW-ed hpet_timer.c and =

time_hpet.c years ago and drifted off into different areas.
They should be unified: more power to arch/x86/ ;-)

	Ingo
