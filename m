From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 5/7] USB: of: fix root-hub device-tree node handling
Date: Tue, 6 Jun 2017 17:44:37 +0200
Message-ID: <20170606154437.GK15860@localhost>
References: <20170530162554.26159-1-johan@kernel.org>
 <20170530162554.26159-6-johan@kernel.org>
 <20170605045103.GB20014@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34814 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdFFPoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jun 2017 11:44:39 -0400
Content-Disposition: inline
In-Reply-To: <20170605045103.GB20014@b29397-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@freescale.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 05, 2017 at 12:51:04PM +0800, Peter Chen wrote:
> On Tue, May 30, 2017 at 06:25:52PM +0200, Johan Hovold wrote:
> > In an attempt to work around a pinmux over-allocation issue in driver
> > core, commit dc5878abf49c ("usb: core: move root hub's device node
> > assignment after it is added to bus") moved the device-tree node
> > assignment until after the root hub had been registered.
> > 
> > This not only makes the device-tree node unavailable to the usb driver
> > during probe, but also prevents the of_node from being linked to in
> > sysfs and causes a race with user-space for the (recently added) devspec
> > attribute.
> > 
> > Use the new device_set_of_node_from_dev() helper to reuse the node of
> > the sysdev device, something which now prevents driver core from trying
> > to reclaim any pinctrl pins during probe.
> > 
> > Fixes: dc5878abf49c ("usb: core: move root hub's device node assignment after it is added to bus")
> > Fixes: 51fa91475e43 ("usb/core: Added devspec sysfs entry for devices behind the usb hub")
> > Signed-off-by: Johan Hovold <johan@kernel.org>

> I am OK with it, but I suggest adding it for new rc1 since it is based
> on the 1st patch which is a bug-fix. If this one is really needed for
> stable tree in future, you can cherry-pick it.

I agree, and didn't intent for this one to go into 4.12-rc. Let's see
how Greg wants to handle this. I'll add some comments to the cover
letter in v2.

Thanks,
Johan
