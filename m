From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/4] Raspberry Pi power domains
Date: Thu, 17 Dec 2015 22:08:33 +0100
Message-ID: <CAPDyKFokMdtcwG=0cDP3zKnnLrAxKDGWffWouvyVK0r53nxktg@mail.gmail.com>
References: <1450215622-27394-1-git-send-email-eric@anholt.net>
	<CAPDyKFp=ykY4dFTxeq+et6z5ek-UYGnBOFG7Po0pSUL7jSYc8g@mail.gmail.com>
	<878u4sx5gs.fsf@eliezer.anholt.net>
	<2899341.Os5E8ounKE@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2899341.Os5E8ounKE@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Anholt <eric@anholt.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-rpi-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>
List-Id: linux-pm@vger.kernel.org

On 17 December 2015 at 21:11, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 17 December 2015 11:03:47 Eric Anholt wrote:
>> >>
>> >>  .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt |  47 ++++
>> >>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 +
>> >>  arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
>> >>  arch/arm/mach-bcm/Kconfig                          |  10 +
>> >>  arch/arm/mach-bcm/Makefile                         |   1 +
>> >>  arch/arm/mach-bcm/raspberrypi-power.c              | 247 +++++++++++++++++++++
>> >>  include/dt-bindings/arm/raspberrypi-power.h        |  41 ++++
>> >>  include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
>> >>  8 files changed, 360 insertions(+), 1 deletion(-)
>> >>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
>> >>  create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
>> >>  create mode 100644 include/dt-bindings/arm/raspberrypi-power.h
>> >>
>> >> --
>> >> 2.6.2
>> >>
>> >
>> > Besides a nitpick for patch2, I would also reverse the order of patch3
>> > and patch2. DT docs should go in before the actual parsing of the new
>> > bindings/compatibles.
>> >
>> > Anyway, for the hole series, you may add my:
>> >
>> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Would your tree be pulling the series (since it's power domains), or
>> should I (since it's SOC stuff)?
>>
>
> All of the above files go through the arm-soc tree by default.

That should work as I don't see any other dependency, unless
Eric/Alexander think there is.

Kind regards
Uffe
