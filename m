From: Oliver Neukum <oneukum@suse.de>
Subject: error handling in omap_des_hw_init()
Date: Thu, 11 Sep 2014 13:26:06 +0200
Message-ID: <1410434766.4966.7.camel@linux-fkkt.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60927 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371AbaIKL0I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Sep 2014 07:26:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: joelf@ti.com
Cc: linux-pm@vger.kernel.org

Hi,

I am checking the error handling of drivers in connection
with pm_runtime_get() and related functions. It looks
to me like this driver has a harmful pm_runtime_put_noidle()
in its error handling path. Usually as a pm operation fails
it doesn't need to be done undone. Are there special circumstances
here?

	Regards
		Oliver

static int omap_des_hw_init(struct omap_des_dev *dd)
{
        int err;

        /*
         * clocks are enabled when request starts and disabled when
finished.
         * It may be long delays between requests.
         * Device might go to off mode to save power.
         */
        err = pm_runtime_get_sync(dd->dev);
        if (err < 0) {
                pm_runtime_put_noidle(dd->dev);
                dev_err(dd->dev, "%s: failed to get_sync(%d)\n",
__func__, err);
                return err;
        }


