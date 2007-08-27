From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] trivial: fix typo in comment in
	drivers/base/power/suspend.c
Date: Mon, 27 Aug 2007 18:45:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0708271841150.5705@poirot.grange>
References: <Pine.LNX.4.60.0708260131080.3809@poirot.grange>
	<20070827100203.GC1972@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070827100203.GC1972@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, trivial@kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

---

On Mon, 27 Aug 2007, Pavel Machek wrote:

> On Sun 2007-08-26 01:40:24, Guennadi Liakhovetski wrote:
> > Hi
> > 
> > trying to understand when suspend_late gets called, I just wasn't quite 
> > sure if I got the following points right:
> > 
> > 1. seems to be a typo in the comment above 
> > drivers/base/power/suspend.c::device_power_down() - the function walks the 
> > dpm_off list and not the dpm_off_irq list, as claimed in the comment
> 
> Can you send the diff to akpm?

I think the trivial address should be more appropriate:-)

Thanks
Guennadi

diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index 26df9b2..8fed79e 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -167,7 +167,7 @@ EXPORT_SYMBOL_GPL(device_suspend);
  *	device_power_down - Shut down special devices.
  *	@state:		Power state to enter.
  *
- *	Walk the dpm_off_irq list, calling ->power_down() for each device that
+ *	Walk the dpm_off list, calling ->power_down() for each device that
  *	couldn't power down the device with interrupts enabled. When we're
  *	done, power down system devices.
  */
