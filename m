From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v11 2/8] power: add power sequence library
Date: Fri, 20 Jan 2017 11:21:27 +0100
Message-ID: <CAJZ5v0h09A2XWLEk7v9XPe+4fP7HDr6AqZzBmvBi_V5nhLoiRw@mail.gmail.com>
References: <1483596119-27508-1-git-send-email-peter.chen@nxp.com>
 <1483596119-27508-3-git-send-email-peter.chen@nxp.com> <20170107085456.w5dhm7qadqa6tc7v@kozik-lap>
 <20170110070240.GA29454@b29397-desktop> <20170120075239.GC21013@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170120075239.GC21013@b29397-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Chen <peter.chen@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <stephen.boyd@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>, Joshua Clayton <stillcompiling@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, mka@chromium.org, Alan Stern <stern@rowland.harvard.edu>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, mail@maciej.szmigiero.name, Pawel Moll <pawel.moll@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Sascha
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 20, 2017 at 8:52 AM, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Tue, Jan 10, 2017 at 03:02:41PM +0800, Peter Chen wrote:
>> On Sat, Jan 07, 2017 at 10:54:56AM +0200, Krzysztof Kozlowski wrote:
>> > On Thu, Jan 05, 2017 at 02:01:53PM +0800, Peter Chen wrote:
>> > > We have an well-known problem that the device needs to do some power
>> > > sequence before it can be recognized by related host, the typical
>> > > example like hard-wired mmc devices and usb devices.
>> > >
>> > > This power sequence is hard to be described at device tree and handled by
>> > > related host driver, so we have created a common power sequence
>> > > library to cover this requirement. The core code has supplied
>> > > some common helpers for host driver, and individual power sequence
>> > > libraries handle kinds of power sequence for devices. The pwrseq
>> > > librares always need to allocate extra instance for compatible
>> > > string match.
>> > >
>> > > pwrseq_generic is intended for general purpose of power sequence, which
>> > > handles gpios and clocks currently, and can cover other controls in
>> > > future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
>> > > if only one power sequence is needed, else call of_pwrseq_on_list
>> > > /of_pwrseq_off_list instead (eg, USB hub driver).
>> > >
>> > > For new power sequence library, it can add its compatible string
>> > > to pwrseq_of_match_table, then the pwrseq core will match it with
>> > > DT's, and choose this library at runtime.
>> > >
>> > > Signed-off-by: Peter Chen <peter.chen@nxp.com>
>> > > Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>> > > Tested-by Joshua Clayton <stillcompiling@gmail.com>
>> > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> > > Tested-by: Matthias Kaehlcke <mka@chromium.org>
>> >
>> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> > Tested on Odroid U3 (reset sequence for LAN9730):
>> > Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
>> >
>>
>> A nice ping...
>>
>
> Rafael, would you please review it? This series was discussed about
> half a year, and many people need it, I hope it can be in v4.11-rc1,
> thanks.

I'm travelling now
(http://marc.info/?l=linux-pm&m=148410629024194&w=2) and (as stated in
this message) I'll get to the patches when I'm back home.

There is a good chance for your code to go into 4.11-rc1 if the review
comments so far have been addressed.

Thanks,
Rafael
