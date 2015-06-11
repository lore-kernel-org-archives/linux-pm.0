From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Thu, 11 Jun 2015 10:15:04 +0200
Message-ID: <CACRpkdYyvXVm=UBVH9Lwp8nQbuxQL07MLspNfQSHtc-yT2C_0g@mail.gmail.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
	<CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>
	<CAAObsKCP-C+TY8Wkk6bQzxZeGYL9X01trtjxfaYp--ZnH07C+w@mail.gmail.com>
	<CACRpkdZuSj+S2x1yz6n5PgcRK=3ZCcq_To124b2Y+Oj54aydpg@mail.gmail.com>
	<CAAObsKD97nEARO5eZYA2g8+z_MrazBy-m8PV_kSyj19ya72mAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <CAAObsKD97nEARO5eZYA2g8+z_MrazBy-m8PV_kSyj19ya72mAw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, dmaengine@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Grant Likely <grant.likely@linaro.org>, Alexander Holler <holler@ahsoftware.de>, Dan Williams <dan.j.williams@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.o>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 10, 2015 at 12:19 PM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> On 10 June 2015 at 09:30, Linus Walleij <linus.walleij@linaro.org> wrote:

>> regulator_get(...) -> not available, so:
>> - identify target regulator provider - this will need instrumentation
>> - probe it
>>
>> It then turns out the regulator driver is on the i2c bus, so we
>> need to probe the i2c driver:
>> - identify target i2c host for the regulator driver - this will need
>>   instrumentation
>> - probe the i2c host driver
>>
>> i2c host comes out, probes the regulator driver, regulator driver
>> probes and then the regulator_get() call returns.
>
> Hmm, if I understand correctly what you say, this is exactly what this
> particular series does:
>
> regulator_get -> of_platform_device_ensure -> probe() on the platform
> device that encloses the requested device node (i2c host) -> i2c slave
> gets probed and the regulator registered -> regulator_get returns the
> requested resource

Yes. But only for device tree.

> The downside I'm currently looking at is that an explicit dependency
> graph would be useful to have for other purposes. For example to print
> a neat warning when a dependency cannot be fulfilled. Or to refuse to
> unbind a device which other devices depend on, or to automatically
> unbind the devices that depend on it, or to print a warning if a
> device is hotplugged off and other devices depend on it.

Unbind/remove() calls are the inverse usually yes.

But also the [runtime] power up/down sequences for the
devices tend to depend on a similar ordering or mostly
the same. (Mentioned this before I think.)

>> This requires instrumentation on anything providing a resource
>> to another driver like those I mentioned and a lot of overhead
>> infrastructure, but I think it's the right approach. However I don't
>> know if I would ever be able to pull that off myself, I know talk
>> is cheap and I should show the code instead.
>
> Yeah, if you can give it a second look and say if it matches what you
> wrote above, it would be very much appreciated.

Yes you are right. But what about ACPI, board files,
Simple Firmware and future hardware description languages...

Yours,
Linus Walleij
