From: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
Subject: [PATCH 0/2] imx: Fix power-up on RTC alarm
Date: Tue,  7 Feb 2017 14:54:12 +0200
Message-ID: <1486472054-4367-1-git-send-email-guy.shapiro@mobi-wize.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBCNJ5VGR4ANRBG4I47CAKGQERHYBZRQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Cc: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Currently, the syscon-poweroff driver cleans the alarm enable bit during power
off. This behaviour makes it impossible to wake up the device using the RTC.

The first patch adds a mask option to the syscon-poweroff driver. It uses the
method suggested by Sebastian Reichel [0] to maintain compatibility with the
old binding.

The second patch update the device trees for the snvs component users.
Although I believe this should work on all the modified devices, I had only
imx6ul to test with.

Making the wake-up alarm work may require applying another patch [1], already
accepted to the rtc-snvs driver. 

Thanks,
Guy.

[0] http://www.spinics.net/lists/devicetree/msg161527.html
[1] https://patchwork.ozlabs.org/patch/721155/

Guy Shapiro (2):
  power: reset: syscon-poweroff: add a mask property
  ARM: dts: imx: update snvs-poweroff mask

 .../bindings/power/reset/syscon-poweroff.txt          | 11 +++++++++--
 arch/arm/boot/dts/imx6qdl.dtsi                        |  1 +
 arch/arm/boot/dts/imx6sl.dtsi                         |  1 +
 arch/arm/boot/dts/imx6sx.dtsi                         |  1 +
 arch/arm/boot/dts/imx6ul.dtsi                         |  1 +
 arch/arm/boot/dts/imx7s.dtsi                          |  1 +
 drivers/power/reset/syscon-poweroff.c                 | 19 ++++++++++++++++---
 7 files changed, 30 insertions(+), 5 deletions(-)

-- 
2.1.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
