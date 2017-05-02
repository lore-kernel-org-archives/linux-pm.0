From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v5 0/9] Add sbs-manager with smbalert support
Date: Tue, 2 May 2017 12:24:41 +0200
Message-ID: <20170502102440.GC2382@mail.corp.redhat.com>
References: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
 <20170501090826.3wci2vzilp6ogalt@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750789AbdEBKYq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 May 2017 06:24:46 -0400
Content-Disposition: inline
In-Reply-To: <20170501090826.3wci2vzilp6ogalt@ninjato>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Phil Reid <preid@electromag.com.au>, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

Hi Wolfram,

On May 01 2017 or thereabouts, Wolfram Sang wrote:
> On Mon, May 01, 2017 at 04:49:50PM +0800, Phil Reid wrote:
> > This is another go of the sbs-manager driver using smbalert for
> > irq support from a while ago. 
> 
> Thanks for keeping at it!
> 
> Adding Benjamin Tissoires to CC, he worked lately on I2C device IRQs...
> @Benjamin: do you need the patches, too, or do you read the I2C list?

I have already been cc-ed in the v6 of the series, so I am able to
review it properly (I do not read the I2C list, but I can work around
this through patchwork).

Cheers,
Benjamin

> 
> > Enables the existing smbalert driver to be loaded via the device tree.
> > Only need to add smbus_alert interrupt to the i2c bus segement in the
> > devicetree and the core will then enable the alert driver.
> > 
> > Reorders the rquest irq call in the pca954x driver to ensure each
> > muxed i2c segment can handle service smbalerts on that segment before
> > irq's are enabled. The pca954x can't mask individual irq's routed thru
> > them.
> > 
> > Add the sbs-manager from Karl-Heinz.
> > Add the alert call back and gpio interface to allow the battery detect
> > logic in the existing sbs-battery driver to work.
> > 
> > 
> > 
> > Karl-Heinz Schneider (2):
> >   Documentation: Add sbs-manager device tree node documentation
> >   power: Adds support for Smart Battery System Manager
> > 
> > Phil Reid (7):
> >   i2c: i2c-smbus: Support threaded irqs.
> >   i2c: i2c-smbus: Add null ptr guard in smb_alert_probe
> >   i2c: i2c-smbus: add of_i2c_setup_smbus_alert
> >   i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter
> >   i2c: mux: pca954x: Call request irq after adding mux segments
> >   power: supply: sbs-battery: Add alert callback
> >   power: supply: sbs-manager: Add alert callback and battery change
> >     notification
> > 
> >  Documentation/devicetree/bindings/i2c/i2c.txt      |   4 +-
> >  .../bindings/power/supply/sbs,sbs-manager.txt      |  64 +++
> >  drivers/i2c/i2c-core.c                             |   4 +
> >  drivers/i2c/i2c-smbus.c                            |  64 ++-
> >  drivers/i2c/muxes/i2c-mux-pca954x.c                |  52 ++-
> >  drivers/power/supply/Kconfig                       |  14 +
> >  drivers/power/supply/Makefile                      |   1 +
> >  drivers/power/supply/sbs-battery.c                 |  16 +-
> >  drivers/power/supply/sbs-manager.c                 | 448 +++++++++++++++++++++
> >  include/linux/i2c-smbus.h                          |   9 +
> >  10 files changed, 637 insertions(+), 39 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
> >  create mode 100644 drivers/power/supply/sbs-manager.c
> > 
> > -- 
> > 1.8.3.1
> > 
