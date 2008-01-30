From: Pavel Machek <pavel@ucw.cz>
Subject: Re: sleepy linux self-test
Date: Thu, 31 Jan 2008 00:26:06 +0100
Message-ID: <20080130232606.GB5937@elf.ucw.cz>
References: <20080130131748.GA3796@elf.ucw.cz> <20080130193626.GA15384@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763390AbYA3X0G@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080130193626.GA15384@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > This version should work, at least it did not fail in my testing. It 
> > does one test 5 second after bootup, then periodically once per 500 
> > seconds. Different parameters are trivial to tweak.
> 
> the x86.git qa mix produced this spontaneous reboot failure:

Is it reproducible, or it just happened randomly once during shutdown?

Did it work on at least few machines?

> [   18.387888] Calling initcall 0xC0135EA8: test_sleep+0x0/0x1c()
> [   18.394189] Auto sleep: Now 1201724894
> [   18.395892] BUG: unable to handle kernel NULL pointer dereference at 00000160
> [   18.405792] IP: [<c0501b1b>] cmos_set_alarm+0xb/0x201
> [   18.411891] *pde = 00000000
>  [ spontaneous reboot ]
> 
> config attached. Do you need any more info than this? Should i try to 
> debug this?

Can you try this? I forgot that you can rmmod rtc-cmos, too...
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c.

								Pavel

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 5bbdb70..15050cd 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -402,6 +402,8 @@ int set_alarm(int length)
 	unsigned long now, alarm;
 	struct rtc_wkalrm alm;
 
+	if (!pc_rtc_device)
+		return -EFAULT;
 	retval = cmos_read_time(pc_rtc_device, &alm.time);
 	if (retval < 0) {
 		printk("Auto sleep: can't get time?\n");
@@ -590,6 +592,7 @@ static void __exit cmos_do_remove(struct
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 	struct resource *ports;
 
+	pc_rtc_device = NULL;
 	cmos_do_shutdown();
 
 	if (is_valid_irq(cmos->irq))
diff --git a/kernel/power/sleepy.c b/kernel/power/sleepy.c
index b8b2de3..222d22d 100644
--- a/kernel/power/sleepy.c
+++ b/kernel/power/sleepy.c
@@ -31,7 +31,8 @@ int ksleepyd(void *data)
 {
 	msleep(5000);
 	while (1) {
-		set_alarm(5);
+		if (set_alarm(5))
+			return -EFAULT;
 		pm_suspend(PM_SUSPEND_MEM);
 		msleep(500000);
 	}

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
