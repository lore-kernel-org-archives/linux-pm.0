From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] power: Destroy IDRs on module exit
Date: Tue, 14 Jul 2015 11:17:59 +0200
Message-ID: <1436865479.22561.2.camel@suse.com>
References: <1436865374-22027-1-git-send-email-jthumshirn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42162 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738AbbGNJTD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jul 2015 05:19:03 -0400
In-Reply-To: <1436865374-22027-1-git-send-email-jthumshirn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2015-07-14 at 11:16 +0200, Johannes Thumshirn wrote:
> Destroy IDRs on module exit, freeing the resources for
> * bq2415x_charger.c
> * ds2782_battery.c
> * ltc2941-battery-gauge.c
> 
> The drivers had to be converted to "ordinary"
> module_init()/module_exit()
> style drivers instead of using module_i2c_driver.

That is a drawback. How about adding a pointer to the idr
to "struct i2c_driver" and destroy it in generic code?

	Regards
		Oliver


