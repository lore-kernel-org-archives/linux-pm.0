From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/5] thermal: simplify getting .driver_data
Date: Sun, 21 Oct 2018 22:00:47 +0200
Message-ID: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

I got tired of fixing this in Renesas drivers manually, so I took the big
hammer. Remove this cumbersome code pattern which got copy-pasted too much
already:

-	struct platform_device *pdev = to_platform_device(dev);
-	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
+	struct ep93xx_keypad *keypad = dev_get_drvdata(dev);

A branch, tested by buildbot, can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git coccinelle/get_drvdata

I have been asked if it couldn't be done for dev_set_drvdata as well. I checked
it and did not find one occasion where it could be simplified like this. Not
much of a surprise because driver_data is usually set in probe() functions
which access struct platform_device in many other ways.

I am open for other comments, suggestions, too, of course.

Here is the cocci-script I created:

@@
struct device* d;
identifier pdev;
expression *ptr;
@@
(
-	struct platform_device *pdev = to_platform_device(d);
|
-	struct platform_device *pdev;
	...
-	pdev = to_platform_device(d);
)
	<... when != pdev
-	&pdev->dev
+	d
	...>

	ptr =
-	platform_get_drvdata(pdev)
+	dev_get_drvdata(d)

	<... when != pdev
-	&pdev->dev
+	d
	...>

Kind regards,

   Wolfram


Wolfram Sang (5):
  thermal: int340x_thermal: int3400_thermal: simplify getting
    .driver_data
  thermal: rockchip_thermal: simplify getting .driver_data
  thermal: spear_thermal: simplify getting .driver_data
  thermal: st: st_thermal: simplify getting .driver_data
  thermal: zx2967_thermal: simplify getting .driver_data

 drivers/thermal/int340x_thermal/int3400_thermal.c | 9 +++------
 drivers/thermal/rockchip_thermal.c                | 8 +++-----
 drivers/thermal/spear_thermal.c                   | 8 +++-----
 drivers/thermal/st/st_thermal.c                   | 6 ++----
 drivers/thermal/zx2967_thermal.c                  | 6 ++----
 5 files changed, 13 insertions(+), 24 deletions(-)

-- 
2.19.0
