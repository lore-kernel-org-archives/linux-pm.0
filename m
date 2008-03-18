From: Pavel Machek <pavel@suse.cz>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
	hibernation	patchset against -rc6)
Date: Wed, 19 Mar 2008 00:20:38 +0100
Message-ID: <20080318232037.GA1670@elf.ucw.cz>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
	<20080318130642.GA1609@elf.ucw.cz>
	<20080318130710.GB1609@elf.ucw.cz>
	<alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tue 2008-03-18 10:31:28, Linus Torvalds wrote:
> 
> 
> On Tue, 18 Mar 2008, Pavel Machek wrote:
> >
> > On Tue 2008-03-18 14:06:42, Pavel Machek wrote:
> > > 
> > > Confirmed, suspend slowness is in 2.6.25-rc6, too. It takes 15 seconds
> > > to suspend/resume, while 2.6.24 takes 9. Thinkpad x60.
> > 
> > IIRC 2.6.25-rc5 was "fast".
> 
> Can you bisect it? There's only 343 commits between -rc5 and -rc6, so it 
> should not take too long to check which commit it is. Even if it should 
> take 9 reboots to bisect it entirely, going just five or six will likely 
> narrow it down sufficiently that we can probably guess fairly well what 
> it's about.

Slowdown is fixed by this patch:


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e7e197e..caf873c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -129,7 +129,6 @@ static struct acpi_ec {
 	struct mutex lock;
 	wait_queue_head_t wait;
 	struct list_head list;
-	atomic_t irq_count;
 	u8 handlers_installed;
 } *boot_ec, *first_ec;
 
@@ -182,8 +181,6 @@ static int acpi_ec_wait(struct acpi_ec *
 {
 	int ret = 0;
 
-	atomic_set(&ec->irq_count, 0);
-
 	if (unlikely(event == ACPI_EC_EVENT_OBF_1 &&
 		     test_bit(EC_FLAGS_NO_OBF1_GPE, &ec->flags)))
 		force_poll = 1;
@@ -230,7 +227,6 @@ static int acpi_ec_wait(struct acpi_ec *
 		while (time_before(jiffies, delay)) {
 			if (acpi_ec_check_status(ec, event))
 				goto end;
-			msleep(5);
 		}
 	}
 	pr_err(PREFIX "acpi_ec_wait timeout,"
@@ -533,13 +529,6 @@ static u32 acpi_ec_gpe_handler(void *dat
 	struct acpi_ec *ec = data;
 
 	pr_debug(PREFIX "~~~> interrupt\n");
-	atomic_inc(&ec->irq_count);
-	if (atomic_read(&ec->irq_count) > 5) {
-		pr_err(PREFIX "GPE storm detected, disabling EC GPE\n");
-		acpi_disable_gpe(NULL, ec->gpe, ACPI_ISR);
-		clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-		return ACPI_INTERRUPT_HANDLED;
-	}
 	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags))
 		wake_up(&ec->wait);
@@ -954,7 +943,11 @@ int __init acpi_ec_ecdt_probe(void)
 		boot_ec->command_addr = ecdt_ptr->control.address;
 		boot_ec->data_addr = ecdt_ptr->data.address;
 		boot_ec->gpe = ecdt_ptr->gpe;
-		boot_ec->handle = ACPI_ROOT_OBJECT;
+		if (ACPI_FAILURE(acpi_get_handle(NULL, ecdt_ptr->id,
+				&boot_ec->handle))) {
+			pr_info("Failed to locate handle for boot EC\n");
+			boot_ec->handle = ACPI_ROOT_OBJECT;
+		}
 	} else {
 		/* This workaround is needed only on some broken machines,
 		 * which require early EC, but fail to provide ECDT */

...so it seems to be "hello, Alexey!"

commit 2c81ce4c9c37b910210f2640c28e98a0c398dc26
tree e46ccf30836014d115e72791263697585f7943f6
parent 2f44bbb495dd3e6d0209eff2257438ab9c570e5b
author Alexey Starikovskiy <astarikovskiy@suse.de> Tue, 11 Mar 2008
13:30:00 -0400
committer Len Brown <len.brown@intel.com> Tue, 11 Mar 2008 13:30:00
-0400

    ACPI: EC: Handle IRQ storm on Acer laptops

    On some Acer systems, the HW fails to clear the GPE source,
    causing an interrupt storm.

    So in EC interrupt mode, we count how many interrupts we
    receive when waiting.  If we get more than 5, we give
    up on interrupt mode and revert to polling mode.

    Also, for polling mode to work on Acers, we need
    to insert a delay.

    Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>



								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/
