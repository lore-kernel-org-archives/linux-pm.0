From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Thu, 29 Mar 2007 19:28:41 +0200
Message-ID: <200703291928.42122.maximlevitsky@gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <200703291546.48996.maximlevitsky@gmail.com> <Pine.LNX.4.64.0703290949060.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0703290949060.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Jeff Chua <jeff.chua.linux@gmail.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@lists.osdl.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Jens Axboe <jens.axboe@oracle.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
List-Id: linux-pm@vger.kernel.org

On Thursday 29 March 2007 18:53:37 Linus Torvalds wrote:
> 
> On Thu, 29 Mar 2007, Maxim Levitsky wrote:
> >
> > Subject: Add suspend/resume for HPET
> >
> > This adds support of suspend/resume on i386 for HPET
> >
> > Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> > 
> > ---
> >  arch/i386/kernel/hpet.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++
> 
> Btw, what about arch/x86_64/kernel/hpet.c?
> 
> That thing seems totally broken. Lookie here:
> 
>   arch/x86_64/kernel/hpet.c:irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
>   drivers/char/rtc.c:extern irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id);
> 
> anybody see a problem? The x86-64 version doesn't seem to be very well 
> maintained. Is there some fundamental reason why this file isn't shared 
> across architectures?
> 
> 			Linus
> 

Hi,
	I agree with that, there seems to be lot of code duplication between i386 and x86_64.
	By the way, x86_64 does take care of suspend/resume for hpet, it is done by 

	linux-2.6/arch/x86_64/kernel/time.c:timer_resume(struct sys_device *dev):
		hpet_reenable()


	on i386 PIT driver goes out of way when HPET is detected
	So it seems that there is lot of work to do to remove redundant code.


	Best regards,
		Maxim Levitsky
