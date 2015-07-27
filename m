From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
Date: Mon, 27 Jul 2015 08:44:07 +0530
Message-ID: <20150727031407.GH19944@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <2910042.ys2zsBBKt2@amdc1976>
 <20150709051845.GM1805@linux>
 <9723014.v9tt0Yn4CZ@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32841 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbbG0DOM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jul 2015 23:14:12 -0400
Received: by padck2 with SMTP id ck2so43641411pad.0
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2015 20:14:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9723014.v9tt0Yn4CZ@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 24-07-15, 20:02, Bartlomiej Zolnierkiewicz wrote:
> There is also a minor issue with of_init_opp_table() documentation
> (the function can now return -EINVAL in some cases).  Except these
> two things the patch looks fine and once it is fixed you can add:
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Fixed the documentation issue as:

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index c4ca176061b8..3ad93a7e76e5 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -1144,6 +1144,7 @@ static int _of_init_opp_table_v1(struct device *dev)
  * -ENODEV     when 'operating-points' property is not found or is invalid data
  *             in device node.
  * -ENODATA    when empty 'operating-points' property is found
+ * -EINVAL     when invalid entries are found in opp-v2 table
  */
 int of_init_opp_table(struct device *dev)
 {


Please give your reviewed-by again as I wouldn't be fixing the u32
type issue for now and wasn't sure if you will give your RBY without
that :)

-- 
viresh
