From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH] rtc: Set wakeup capability for I2C and SPI RTC
	drivers
Date: Thu, 27 Aug 2009 22:22:07 +0400
Message-ID: <20090827182207.GA7358__25812.5308821493$1251398999$gmane$org@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

RTC core won't allow wakeup alarms to be set if RTC devices' parent
(i.e. i2c_client or spi_device) isn't wakeup capable.

For I2C devices there is I2C_CLIENT_WAKE flag exists that we can pass
via board info, and if set, I2C core will initialize wakeup capability.
For SPI devices there is no such flag at all.

I believe that it's not platform code responsibility to allow or
disallow wakeups, instead, drivers themselves should set the capability
if a device can trigger wakeups.

That's what drivers/base/power/sysfs.c says:

 * It is the responsibility of device drivers to enable (or disable)
 * wakeup signaling as part of changing device power states, respecting
 * the policy choices provided through the driver model.

I2C and SPI RTC devices send wakeup events via interrupt lines, so we
should set the wakeup capability if IRQ is routed.

Ideally we should also check irq for wakeup capability before setting
device's capability, i.e.

	if (can_irq_wake(irq))
		device_set_wakeup_capable(&client->dev, 1);

But there is no can_irq_wake() call exist, and it is not that trivial
to implement it for all interrupts controllers and complex/cascaded
setups.

drivers/base/power/sysfs.c also covers these cases:

 * Devices may not be able to generate wakeup events from all power
 * states.  Also, the events may be ignored in some configurations;
 * for example, they might need help from other devices that aren't
 * active

So there is no guarantee that wakeup will actually work, and so I think
there is no point in being pedantic wrt checking IRQ wakeup capability.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/rtc/rtc-ds1305.c |    2 ++
 drivers/rtc/rtc-ds1307.c |    2 ++
 drivers/rtc/rtc-ds1374.c |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index 2736b11..e256c03 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -780,6 +780,8 @@ static int __devinit ds1305_probe(struct spi_device *spi)
 					spi->irq, status);
 			goto fail1;
 		}
+
+		device_set_wakeup_capable(&spi->dev, 1);
 	}
 
 	/* export NVRAM */
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 47a93c0..87097d4 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -881,6 +881,8 @@ read_rtc:
 				"unable to request IRQ!\n");
 			goto exit_irq;
 		}
+
+		device_set_wakeup_capable(&client->dev, 1);
 		set_bit(HAS_ALARM, &ds1307->flags);
 		dev_dbg(&client->dev, "got IRQ %d\n", client->irq);
 	}
diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 713f7bf..5317bbc 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -383,6 +383,8 @@ static int ds1374_probe(struct i2c_client *client,
 			dev_err(&client->dev, "unable to request IRQ\n");
 			goto out_free;
 		}
+
+		device_set_wakeup_capable(&client->dev, 1);
 	}
 
 	ds1374->rtc = rtc_device_register(client->name, &client->dev,
-- 
1.6.3.3
