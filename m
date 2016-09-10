From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC/RFT][PATCH v2 3/7] PM / sleep: Make async suspend/resume of
 devices use device links
Date: Sat, 10 Sep 2016 15:31:45 +0200
Message-ID: <20160910133145.GA29744@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <7606779.dc8E4l7vTo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:49609 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753911AbcIJNbk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2016 09:31:40 -0400
Content-Disposition: inline
In-Reply-To: <7606779.dc8E4l7vTo@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Thu, Sep 08, 2016 at 11:28:33PM +0200, Rafael J. Wysocki wrote:
> Make the device suspend/resume part of the core system
> suspend/resume code use device links to ensure that supplier
> and consumer devices will be suspended and resumed in the right
> order in case of async suspend/resume.
> 
> The idea, roughly, is to use dpm_wait() to wait for all consumers
> before a supplier device suspend and to wait for all suppliers
> before a consumer device resume.

For devices with a parent/child relationship, if the child does not
utilize direct_complete, the parent is not allowed to utilize it
either and is runtime resumed upon system sleep.

Don't we need the same for supplier/consumer relationships?

The code enforcing this is in __device_suspend() and looks like this:

	if (parent) {
		spin_lock_irq(&parent->power.lock);

		dev->parent->power.direct_complete = false;
		if (dev->power.wakeup_path
		    && !dev->parent->power.ignore_children)
			dev->parent->power.wakeup_path = true;

		spin_unlock_irq(&parent->power.lock);
	}

I guess we need to iterate over the suppliers here and execute
the block for each of them.

Thanks,

Lukas
