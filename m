From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v2 6/7] PM / runtime: Use device links
Date: Wed, 14 Sep 2016 03:19:01 +0200
Message-ID: <11278470.eJh5IF8LiU@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <20160912094758.GA517@wunner.de> <3547725.ADiAblWZvU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59204 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751420AbcINBMy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 21:12:54 -0400
In-Reply-To: <3547725.ADiAblWZvU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Monday, September 12, 2016 03:57:02 PM Rafael J. Wysocki wrote:
> On Monday, September 12, 2016 11:47:58 AM Lukas Wunner wrote:
> > On Thu, Sep 08, 2016 at 11:30:26PM +0200, Rafael J. Wysocki wrote:
> > > Modify the runtime PM framework to use device links to ensure that
> > > supplier devices will not be suspended if any of their consumer
> > > devices are active.
> > 
> > I think it's inconsistent to runtime resume/suspend suppliers in
> > __rpm_callback() whereas the parent is treated in rpm_suspend()
> > and rpm_resume().
> 
> The reason why I did that this way is the rollback needed in case of
> errors and that led to duplicated code if done elsewhere.
> 
> > Instead I'd suggest to amend struct dev_pm_ops with:
> > 	atomic_t		consumer_count;
> > 
> > Amend rpm_check_suspend_allowed() with:
> > 	else if (atomic_read(&dev->power.consumer_count) > 0)
> > 		retval = -EBUSY;
> 
> That is a good idea, though (from the first look at least).

No, I actually don't like it.

Suppliers are not parents and even the separate counter we have for
parents is somewhat artificial.

For parents it may be argued that they are always there, so handling them
in a special way is justified, but for suppliers I really don't see why
adding a new counter would be better.

Thanks,
Rafael

