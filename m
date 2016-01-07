From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/8] lib/string: introduce match_string() helper
Date: Thu, 7 Jan 2016 15:24:11 +0200
Message-ID: <20160107132411.GB9935@kuha.fi.intel.com>
References: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20160107130743.GA9935@kuha.fi.intel.com>
 <1452172320.30729.409.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12560 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbcAGN0X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 Jan 2016 08:26:23 -0500
Content-Disposition: inline
In-Reply-To: <1452172320.30729.409.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 07, 2016 at 03:12:00PM +0200, Andy Shevchenko wrote:
> On Thu, 2016-01-07 at 15:07 +0200, Heikki Krogerus wrote:
> > On Thu, Jan 07, 2016 at 02:06:01PM +0200, Andy Shevchenko wrote:
> > > > From time to time we have to match a string in an array. Make a
> > > > simple helper
> > > for that purpose.
> > 
> > Cool! If you make v2 out of these, could you patch the following
> > while
> > at it:
> 
> Yes, please, format as a usual patch and share with me. I will include
> in v3 (actually I missed the numbering here, it should be v2 already).

Sure thing. Here's the patch.

-- 
heikki

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-usb-common-convert-to-use-match_string-helper.patch"

>From 86d8e9fda3f6a0679c9350d950f44ca2c9bec8ce Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Thu, 7 Jan 2016 15:22:14 +0200
Subject: [PATCH] usb: common: convert to use match_string() helper

The new helper returns index of the mathing string in an array. We would use it
here.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/common/common.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index e6ec125..677b3f0 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -64,18 +64,15 @@ EXPORT_SYMBOL_GPL(usb_speed_string);
 enum usb_device_speed usb_get_maximum_speed(struct device *dev)
 {
 	const char *maximum_speed;
-	int err;
-	int i;
+	int ret;
 
-	err = device_property_read_string(dev, "maximum-speed", &maximum_speed);
-	if (err < 0)
+	ret = device_property_read_string(dev, "maximum-speed", &maximum_speed);
+	if (ret < 0)
 		return USB_SPEED_UNKNOWN;
 
-	for (i = 0; i < ARRAY_SIZE(speed_names); i++)
-		if (strcmp(maximum_speed, speed_names[i]) == 0)
-			return i;
+	ret = match_string(speed_names, ARRAY_SIZE(speed_names), maximum_speed);
 
-	return USB_SPEED_UNKNOWN;
+	return (ret < 0) ? USB_SPEED_UNKNOWN : ret;
 }
 EXPORT_SYMBOL_GPL(usb_get_maximum_speed);
 
@@ -109,13 +106,10 @@ static const char *const usb_dr_modes[] = {
 
 static enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
-		if (!strcmp(usb_dr_modes[i], str))
-			return i;
+	int ret;
 
-	return USB_DR_MODE_UNKNOWN;
+	ret = match_string(usb_dr_modes, ARRAY_SIZE(usb_dr_modes), str);
+	return (ret < 0) ? USB_DR_MODE_UNKNOWN : ret;
 }
 
 enum usb_dr_mode usb_get_dr_mode(struct device *dev)
-- 
2.6.4


--0F1p//8PRICkK4MW--
