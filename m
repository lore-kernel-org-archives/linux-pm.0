From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/8] lib/string: introduce match_string() helper
Date: Thu, 7 Jan 2016 15:07:43 +0200
Message-ID: <20160107130743.GA9935@kuha.fi.intel.com>
References: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5188 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020AbcAGNHr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 Jan 2016 08:07:47 -0500
Content-Disposition: inline
In-Reply-To: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On Thu, Jan 07, 2016 at 02:06:01PM +0200, Andy Shevchenko wrote:
> >From time to time we have to match a string in an array. Make a simple helper
> for that purpose.

Cool! If you make v2 out of these, could you patch the following while
at it:

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index e6ec125..a391c81 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -64,18 +64,15 @@ EXPORT_SYMBOL_GPL(usb_speed_string);
 enum usb_device_speed usb_get_maximum_speed(struct device *dev)
 {
        const char *maximum_speed;
-       int err;
-       int i;
+       int ret;
 
-       err = device_property_read_string(dev, "maximum-speed", &maximum_speed);
-       if (err < 0)
+       ret = device_property_read_string(dev, "maximum-speed", &maximum_speed);
+       if (ret < 0)
                return USB_SPEED_UNKNOWN;
 
-       for (i = 0; i < ARRAY_SIZE(speed_names); i++)
-               if (strcmp(maximum_speed, speed_names[i]) == 0)
-                       return i;
+       ret = match_string(speed_names, ARRAY_SIZE(speed_names), maximum_speed);
 
-       return USB_SPEED_UNKNOWN;
+       return (ret < 0) ? USB_SPEED_UNKNOWN : ret;
 }
 EXPORT_SYMBOL_GPL(usb_get_maximum_speed);
 
@@ -109,13 +106,11 @@ static const char *const usb_dr_modes[] = {
 
 static enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)
 {
-       int i;
+       int ret;
 
-       for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
-               if (!strcmp(usb_dr_modes[i], str))
-                       return i;
+       ret = match_string(usb_dr_modes, ARRAY_SIZE(usb_dr_modes), str);
 
-       return USB_DR_MODE_UNKNOWN;
+       return (ret < 0) ? USB_DR_MODE_UNKNOWN : ret;
 }
 
 enum usb_dr_mode usb_get_dr_mode(struct device *dev)


Thanks,

-- 
heikki
