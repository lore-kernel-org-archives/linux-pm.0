From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/2] iio: misc: add support for GPIO power switches
Date: Fri, 30 Dec 2016 15:15:30 +0000
Message-ID: <0c3511be-6a3c-f65c-c562-1c4b9318acb1@kernel.org>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
 <1481494905-18037-3-git-send-email-bgolaszewski@baylibre.com>
 <CACRpkdZ7JrNfCKPuuCmkZd_7+NV0QLUN8ZMukFA0TcqS9SYXcQ@mail.gmail.com>
 <20161229162919.j2ej2cyeuoqnxykf@earth>
 <CACRpkdbjbtFwwQCdR3krWG0P4UMhWySTTkzqZFBZ6EGXPS=k8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbjbtFwwQCdR3krWG0P4UMhWySTTkzqZFBZ6EGXPS=k8g@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 30/12/16 13:05, Linus Walleij wrote:
> n Thu, Dec 29, 2016 at 5:29 PM, Sebastian Reichel <sre@kernel.org> wrote:
>> On Wed, Dec 28, 2016 at 01:50:17PM +0100, Linus Walleij wrote:
>>> On Sun, Dec 11, 2016 at 11:21 PM, Bartosz Golaszewski
>>> <bgolaszewski@baylibre.com> wrote:
>>>
>>>> Some power-measuring ADCs work together with power load switches which
>>>> allow to power-cycle measured devices.
>>>>
>>>> An example use case would be measuring the power consumption of a
>>>> development board during boot using a power monitor such as TI INA226
>>>> and power-cycling the board remotely using a TPS229* power switch.
>>>>
>>>> Add an iio driver for simple GPIO power switches and expose a sysfs
>>>> attribute allowing to toggle their state.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> I don't get this, isn't this doing the same as
>>> drivers/power/reset/gpio-poweroff.c
>>> ?
>>>
>>> With the only difference that the latter uses the standard syscall
>>> from pm_power_off to reboot the system instead of some random
>>> sysfs file.
>>
>> As far as I understand it, the TPS229 is used by Barzosz to poweroff
>> a remote system. The gpio-poweroff driver is used to poweroff the
>> local system.
> 
> Thanks yeah I understood this from the context of later patches.
> 
> Well if such a property is used it should be the property of the remote
> system per se, and the remote system should then also be desribed in
> DT, not half-described by dangling references at random nodes.
> 
> So this needs to be re-architected to either describe the remote system
> in DT and handle it in the kernel, or handle it all from userspace if it
> is a one-off non-product thing.
I'm not sure this is always true (though it might be here).  There is always
a need to describe the edge of the known world.  Be it that we have
an accelerometer - ultimately we could describe the device generating the
acceleration but we have no way of knowing what it is or what it will do..

What we have here is a rather simple case, but what about an I/O bank on
a PLC.  Obviously we can handle that as a bunch of GPIOs but if we know
more about it we should have means to describe that.  Say we know they are
always driving relays, we should be able to describe that additional known
stuff. Relays have characteristics such as bounce times etc that if described
would allow us to do the relevant filtering on inputs to handle this.

Here the fact it is a power supply switch should be describable.  Hard to
get right in a generic way though so in cases like this perhaps you
are right and it should just be left undescribed and handled in userspace.

Anyhow, here I think leaving it as a gpio interface is probably the way to
go, but I'm not sure that will always be the case.

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

