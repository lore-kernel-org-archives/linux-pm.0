From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] iio: misc: add support for GPIO power switches
Date: Fri, 30 Dec 2016 14:05:48 +0100
Message-ID: <CACRpkdbjbtFwwQCdR3krWG0P4UMhWySTTkzqZFBZ6EGXPS=k8g@mail.gmail.com>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
 <1481494905-18037-3-git-send-email-bgolaszewski@baylibre.com>
 <CACRpkdZ7JrNfCKPuuCmkZd_7+NV0QLUN8ZMukFA0TcqS9SYXcQ@mail.gmail.com> <20161229162919.j2ej2cyeuoqnxykf@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161229162919.j2ej2cyeuoqnxykf@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Lia
List-Id: linux-pm@vger.kernel.org

n Thu, Dec 29, 2016 at 5:29 PM, Sebastian Reichel <sre@kernel.org> wrote:
> On Wed, Dec 28, 2016 at 01:50:17PM +0100, Linus Walleij wrote:
>> On Sun, Dec 11, 2016 at 11:21 PM, Bartosz Golaszewski
>> <bgolaszewski@baylibre.com> wrote:
>>
>> > Some power-measuring ADCs work together with power load switches which
>> > allow to power-cycle measured devices.
>> >
>> > An example use case would be measuring the power consumption of a
>> > development board during boot using a power monitor such as TI INA226
>> > and power-cycling the board remotely using a TPS229* power switch.
>> >
>> > Add an iio driver for simple GPIO power switches and expose a sysfs
>> > attribute allowing to toggle their state.
>> >
>> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> I don't get this, isn't this doing the same as
>> drivers/power/reset/gpio-poweroff.c
>> ?
>>
>> With the only difference that the latter uses the standard syscall
>> from pm_power_off to reboot the system instead of some random
>> sysfs file.
>
> As far as I understand it, the TPS229 is used by Barzosz to poweroff
> a remote system. The gpio-poweroff driver is used to poweroff the
> local system.

Thanks yeah I understood this from the context of later patches.

Well if such a property is used it should be the property of the remote
system per se, and the remote system should then also be desribed in
DT, not half-described by dangling references at random nodes.

So this needs to be re-architected to either describe the remote system
in DT and handle it in the kernel, or handle it all from userspace if it
is a one-off non-product thing.

Yours,
Linus Walleij
