From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v7 04/10] i2c: i2c-smbus: add of_i2c_setup_smbus_alert
Date: Wed, 28 Jun 2017 14:42:37 +0200
Message-ID: <20170628124237.GE26073@mail.corp.redhat.com>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-5-git-send-email-preid@electromag.com.au>
 <20170619152744.4gtlyrwdhjbhy562@ninjato>
 <20170623121552.GM26073@mail.corp.redhat.com>
 <96160849-c1c7-afdd-8f9f-c9269f66efb2@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <96160849-c1c7-afdd-8f9f-c9269f66efb2@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Jun 28 2017 or thereabouts, Phil Reid wrote:
> > > > diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
> > > > index 19efbd1..b5261c1 100644
> > > > --- a/include/linux/i2c-smbus.h
> > > > +++ b/include/linux/i2c-smbus.h
> > > > @@ -49,4 +49,13 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
> > > >   					 struct i2c_smbus_alert_setup *setup);
> > > >   int i2c_handle_smbus_alert(struct i2c_client *ara);
> > > > +#if IS_ENABLED(CONFIG_I2C_SMBUS)
> > 
> > Can't we have:
> > #if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(*whatever OF config symbol is*)
> > 
> > Because otherwise, even if the code works from what I understand, we
> > will pull in i2c-smbus from i2c-core all the time.
> 
> Sorry I'm lost here.
> CONFIG_I2C_SMBUS looks to the be symbol that enables i2c-smbus in the makefile.
> I thought this would be enough to keep it out of the core.
> 

Assuming CONFIG_I2C_SMBUS is set, my concerns are regarding the fact
that i2c-smbus.ko will now be pulled in by i2c-core.ko no matter what.
There is nothing wrong per se in the code, just that now i2c-core
depends on i2c_smbus given that you call i2c_setup_smbus_alert() in
i2c-core. So that makes the whole point of having a separate module
for i2c-smbus moot.

If of_i2c_setup_smbus_alert() is masked by IS_ENABLED(OF), then the call
for i2c_setup_smbus_alert() will only be done with OF enabled, meaning
that i2c-smbus.ko will only be pulled in by i2c-core when OF is in use.

But maybe that is too much of thinking from my part :)

Cheers,
Benjamin
