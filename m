From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v7 05/10] i2c: core: call of_i2c_setup_smbus_alert in
 i2c_register_adapter
Date: Wed, 28 Jun 2017 14:45:49 +0200
Message-ID: <20170628124549.GF26073@mail.corp.redhat.com>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-6-git-send-email-preid@electromag.com.au>
 <20170619152811.svoxmxybyoy6l4hc@ninjato>
 <20170623121923.GN26073@mail.corp.redhat.com>
 <367a1a1d-afdb-8895-8216-ae3c18e16fc8@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbdF1MqA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Jun 2017 08:46:00 -0400
Content-Disposition: inline
In-Reply-To: <367a1a1d-afdb-8895-8216-ae3c18e16fc8@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Jun 28 2017 or thereabouts, Phil Reid wrote:
> On 23/06/2017 20:19, Benjamin Tissoires wrote:
> > On Jun 19 2017 or thereabouts, Wolfram Sang wrote:
> > > On Thu, Jun 15, 2017 at 09:59:33PM +0800, Phil Reid wrote:
> > > > Add a call to of_i2c_setup_smbus_alert when a i2c adapter is registered
> > > > so the the smbalert driver can be registered.
> > > > 
> > > > Signed-off-by: Phil Reid <preid@electromag.com.au>
> > > 
> > > CCing Benjamin
> > > 
> > > > ---
> > > >   drivers/i2c/i2c-core.c | 4 ++++
> > > >   1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > > > index d2402bb..626471b 100644
> > > > --- a/drivers/i2c/i2c-core.c
> > > > +++ b/drivers/i2c/i2c-core.c
> > > > @@ -40,6 +40,7 @@
> > > >   #include <linux/gpio.h>
> > > >   #include <linux/hardirq.h>
> > > >   #include <linux/i2c.h>
> > > > +#include <linux/i2c-smbus.h>
> > > >   #include <linux/idr.h>
> > > >   #include <linux/init.h>
> > > >   #include <linux/irqflags.h>
> > > > @@ -2045,6 +2046,9 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
> > > >   		dev_warn(&adap->dev,
> > > >   			 "Failed to create compatibility class link\n");
> > > >   #endif
> > > > +	res = of_i2c_setup_smbus_alert(adap);
> > > > +	if (res)
> > > > +		goto out_list;
> > 
> > See my concerns in patch 4/10.
> > 
> > In addition, shouldn't this be placed before device_register() for the
> > least? pm_runtime_enable() would require a matching pm_runtime_disable(),
> > and device_register() some unregistering behavior too.
> > 
> 
> G'day Ben,
> 
> Thanks for the review.
> Yes this makes sense. I tried having it before the device_register and I get an error
> about a kobject not being initialised in the a call from of_i2c_setup_smbus_alert.
> 
> Having a look at what I'm doing in of_i2c_setup_smbus_alert now I'm not sure there's
> a need to bail out on an error now. Originally I was registering the irq in the setup call.
> Which need to handle probe defer. Now this should be handled in the alert probe call.
> 
> WDYR?

Well, of_i2c_setup_smbus_alert() returns an error code, so it has to be
accounted for. If the error is not a reason to fail, you should at least
shout some error messages and act accordingly.

However, looking at of_i2c_setup_smbus_alert() again, I wonder if we
should not split it in 2: one part that checks for the OF flag presence
and bail out early if an error is encountered (before device
registration), and one part once the device is registered that calls
i2c_setup_smbus_alert(). In case of a failure here, we need to
unregister the adapter because we don't have all the elements at hands
(assuming we consider that smbus-alert should be mandatory).

Cheers,
Benjamin
