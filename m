From: "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>
Subject: Re: [PATCH v6 3/3] eeprom: at24: enable runtime pm support
Date: Tue, 3 Oct 2017 16:51:09 +0300
Message-ID: <20171003135109.v7ch7oc4fvjwzl7w@valkosipuli.retiisi.org.uk>
References: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
 <1504520928-5191-4-git-send-email-divagar.mohandass@intel.com>
 <6F87890CF0F5204F892DEA1EF0D77A5972FC1278@FMSMSX114.amr.corp.intel.com>
 <CAAFQd5DUNHJ7fqWy5iD_fb=TBUqGy3AQ3uGXr-TdQ5v39f_hsw@mail.gmail.com>
 <20170920084519.asyfjxo6upt36woz@valkosipuli.retiisi.org.uk>
 <CAAFQd5B65bJHsZkMgtjGgyd3btuoWzJwYQRQb5j2kSaefxCZ7Q@mail.gmail.com>
 <20170920093222.yzfw2ctrupep5iqx@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:50142 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751719AbdJCNvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2017 09:51:13 -0400
Content-Disposition: inline
In-Reply-To: <20170920093222.yzfw2ctrupep5iqx@valkosipuli.retiisi.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: "Mani, Rajmohan" <rajmohan.mani@intel.com>, "Mohandass, Divagar" <divagar.mohandass@intel.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mika.westerberg@linux.intel.com, linux-pm@vger.kernel.org

Hi Tomasz,

On Wed, Sep 20, 2017 at 12:32:22PM +0300, sakari.ailus@iki.fi wrote:
> > >> >> @@ -743,11 +770,17 @@ static int at24_probe(struct i2c_client *client, const
> > >> >> struct i2c_device_id *id)
> > >> >>
> > >> >>       i2c_set_clientdata(client, at24);
> > >> >>
> > >> >> +     /* enable runtime pm */
> > >> >> +     pm_runtime_get_noresume(&client->dev);
> > >> >> +     pm_runtime_set_active(&client->dev);
> > >> >> +     pm_runtime_enable(&client->dev);
> > >>
> > >> Do we need this get_noresume/set_active dance? I remember it was for
> > >> some reason needed for PCI devices, but I don't see why for I2C
> > >> anything else than just pm_runtime_enable() would be necessary.
> > >
> > > You specifically do not need (all) this for PCI devices, but AFAIU for I涎
> > > devices you do. The runtime PM status of a device is disabled by default
> > > and the use count is zero, but on ACPI based systems the device is still
> > > powered on.
> > 
> > Okay, so _get_noresume() and _set_active() would do the thing for ACPI
> > indeed, but not sure about other platforms. Perhaps _enable(),
> > _get_sync() would be more general?
> 
> What I ended up doing in e.g. the smiapp driver was to explicitly power the
> device on first and then enable runtime PM. (See
> drivers/media/i2c/smiapp/smiapp-core.c .) This approach works even if
> CONFIG_PM is disabled, both on DT and ACPI.

pm_runtime_get_noresume() + pm_runtime_put() can be replaced by a single
pm_runtime_idle() call (where pm_runtime_put() was). pm_runtime_enable() is
required to enable runtime PM for a device.

pm_runtime_allow() may be omitted but then to make the runtime PM framework
to make the power state transitions this needs to be configured from the
user space --- which I don't think is intended.

Cc linux-pm, too.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
