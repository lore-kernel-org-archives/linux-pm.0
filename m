From: Maxim <maximlevitsky@gmail.com>
Subject: Re: [3/6] 2.6.21-rc4: known regressions
Date: Wed, 28 Mar 2007 15:43:46 +0200
Message-ID: <200703281543.47049.maximlevitsky@gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <b6a2187b0703261046r46782eedv64464ceddb44bc27@mail.gmail.com> <1175065468.4017.1.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1175065468.4017.1.camel@chaos>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@lists.osdl.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Jens Axboe <jens.axboe@oracle.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wednesday 28 March 2007 09:04:28 Thomas Gleixner wrote:
> On Tue, 2007-03-27 at 01:46 +0800, Jeff Chua wrote:
> > On 3/27/07, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > > > It's related. I tested without CONFIG_HPET_TIMER, and now my X60 can
> > > > suspend and resume from RAM (s2ram). Even better, it works
> > > > with/without CONFIG_NO_HZ.
> > >
> > > Does the patch below fix the HPET_TIMER=y case ?
> > 
> > Thomas, I tried, but it didn't help. Upon resume from ram, "date"
> > still didn't advance.
> 
> Can you please issue a SysRq-Q in this situation and provide the dmesg
> output ?
> 
> Thanks,
> 
> 	tglx
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Hi,
	I almost sure Iknow why this happens,
		The problem is that both hpet clock source and hpet clockevents doesn't have a suspend/resume function
		On resume we should enable the main counter _and_ enable legacy replacement mode,
		On my system main counter in enabled, by I think by bios, but legacy replacement mode is not, so if
		a system doesn't use lapic as a tick source, but use hpet+broadcast, it will hang for sure on resume, and i tested it

		The patch below is a temporally fix, until clock-events and clocksources will get proper suspend/resume hooks:

		Regards,
			Maxim Levitsky

---

Add suspend/resume for HPET
Signed-off-by: Maxim Levitsky <maximlevisky@gmail.com>

---

diff --git a/arch/i386/kernel/hpet.c b/arch/i386/kernel/hpet.c
index 0fd9fba..a1ec79e 100644
--- a/arch/i386/kernel/hpet.c
+++ b/arch/i386/kernel/hpet.c
@@ -152,6 +152,16 @@ static void hpet_set_mode(enum clock_event_mode mode,
 	unsigned long cfg, cmp, now;
 	uint64_t delta;
 
+
+	if ( mode != CLOCK_EVT_MODE_UNUSED && mode != CLOCK_EVT_MODE_SHUTDOWN)
+	{
+		unsigned long cfg = hpet_readl(HPET_CFG);
+		cfg |= HPET_CFG_ENABLE | HPET_CFG_LEGACY;
+		hpet_writel(cfg, HPET_CFG);
+		
+	}
+		
+
 	switch(mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		delta = ((uint64_t)(NSEC_PER_SEC/HZ)) * hpet_clockevent.mult;

