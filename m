From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v6 3/3] eeprom: at24: enable runtime pm support
Date: Tue, 10 Oct 2017 12:55:45 +0900
Message-ID: <CAAFQd5CF5SOsPw9=t-XDj1ey0YV-+M04xzQLAjZEQjecOyYUdw@mail.gmail.com>
References: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
 <1504520928-5191-4-git-send-email-divagar.mohandass@intel.com>
 <6F87890CF0F5204F892DEA1EF0D77A5972FC1278@FMSMSX114.amr.corp.intel.com>
 <CAAFQd5DUNHJ7fqWy5iD_fb=TBUqGy3AQ3uGXr-TdQ5v39f_hsw@mail.gmail.com>
 <20170920084519.asyfjxo6upt36woz@valkosipuli.retiisi.org.uk>
 <CAAFQd5B65bJHsZkMgtjGgyd3btuoWzJwYQRQb5j2kSaefxCZ7Q@mail.gmail.com>
 <20170920093222.yzfw2ctrupep5iqx@valkosipuli.retiisi.org.uk>
 <20171003135109.v7ch7oc4fvjwzl7w@valkosipuli.retiisi.org.uk> <7B8CE47BD58441468D2BB13285B50E6031DF530B@BGSMSX107.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7B8CE47BD58441468D2BB13285B50E6031DF530B@BGSMSX107.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Mohandass, Divagar" <divagar.mohandass@intel.com>
Cc: "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>, "Mani, Rajmohan" <rajmohan.mani@intel.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 9, 2017 at 12:14 PM, Mohandass, Divagar
<divagar.mohandass@intel.com> wrote:
> Hi Tomasz,
>
>>-----Original Message-----
>>From: sakari.ailus@iki.fi [mailto:sakari.ailus@iki.fi]
>>Sent: Tuesday, October 03, 2017 7:21 PM
>>To: Tomasz Figa <tfiga@chromium.org>
>>Cc: Mani, Rajmohan <rajmohan.mani@intel.com>; Mohandass, Divagar
>><divagar.mohandass@intel.com>; robh+dt@kernel.org;
>>mark.rutland@arm.com; wsa@the-dreams.de; devicetree@vger.kernel.org;
>>linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org;
>>mika.westerberg@linux.intel.com; linux-pm@vger.kernel.org
>>Subject: Re: [PATCH v6 3/3] eeprom: at24: enable runtime pm support
>>
>>Hi Tomasz,
>>
>>On Wed, Sep 20, 2017 at 12:32:22PM +0300, sakari.ailus@iki.fi wrote:
>>> > >> >> @@ -743,11 +770,17 @@ static int at24_probe(struct i2c_client
>>> > >> >> *client, const struct i2c_device_id *id)
>>> > >> >>
>>> > >> >>       i2c_set_clientdata(client, at24);
>>> > >> >>
>>> > >> >> +     /* enable runtime pm */
>>> > >> >> +     pm_runtime_get_noresume(&client->dev);
>>> > >> >> +     pm_runtime_set_active(&client->dev);
>>> > >> >> +     pm_runtime_enable(&client->dev);
>>> > >>
>>> > >> Do we need this get_noresume/set_active dance? I remember it was
>>> > >> for some reason needed for PCI devices, but I don't see why for
>>> > >> I2C anything else than just pm_runtime_enable() would be necessary=
.
>>> > >
>>> > > You specifically do not need (all) this for PCI devices, but AFAIU
>>> > > for I=E6=B6=8E
>>> > > devices you do. The runtime PM status of a device is disabled by
>>> > > default and the use count is zero, but on ACPI based systems the
>>> > > device is still powered on.
>>> >
>>> > Okay, so _get_noresume() and _set_active() would do the thing for
>>> > ACPI indeed, but not sure about other platforms. Perhaps _enable(),
>>> > _get_sync() would be more general?
>>>
>>> What I ended up doing in e.g. the smiapp driver was to explicitly
>>> power the device on first and then enable runtime PM. (See
>>> drivers/media/i2c/smiapp/smiapp-core.c .) This approach works even if
>>> CONFIG_PM is disabled, both on DT and ACPI.
>>
>>pm_runtime_get_noresume() + pm_runtime_put() can be replaced by a single
>>pm_runtime_idle() call (where pm_runtime_put() was). pm_runtime_enable()
>>is required to enable runtime PM for a device.
>
> Verified the change suggested by Sakari.
> Let me know I can send a updated patch version with this change.

Okay, looks like Sakari confirmed that the driver should work fine
without callbacks, so please go ahead. Thanks for patience.

Best regards,
Tomasz
