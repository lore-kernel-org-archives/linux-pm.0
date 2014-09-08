From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/8 v2] leds: add device tree bindings for register bit LEDs
Date: Mon, 8 Sep 2014 13:25:51 +0200
Message-ID: <CACRpkdarXzrprA=1=oT-1K8X3y-QPH+gkteHCpZDcCA3pBZMOQ@mail.gmail.com>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
	<1409659354-23553-3-git-send-email-linus.walleij@linaro.org>
	<5686741.QjIvGO0Jfo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <5686741.QjIvGO0Jfo@wuerfel>
Sender: linux-leds-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 2, 2014 at 2:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 02 September 2014 14:02:28 Linus Walleij wrote:
>> +LED sub-node properties:
>> +
>> +Required properties:
>> +- compatible : must be "register-bit-led"
>> +- offset : register offset to the register controlling this LED
>> +- mask : bit mask for the bit controlling this LED in the register
>> +  typically 0x01, 0x02, 0x04 ...
>>
>
> How does the driver know whether to do byte or word sized accesses?

Like with all other bindings based on
Documentation/devicetree/bindings/mfd/syscon.txt
it is implicit that the access size is 32 bit words. Just grep
for syscon in the bindings and you will see none define the access
width.

If this should be fixed, the parent syscon binding should be
altered to cover access width for all children as this is a property
of the entire register range.

So for example:

gpr: iomuxc-gpr@020e0000 {
        compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
        reg = <0x020e0000 0x38>;
        register-width = <32>;
        register-valid = <32>;
        register-stride = <4>;
};

So as to indicate that this register range is made up of 32 bit
words, all 32 bits are valid in each word, and the stride between
words i 4 bytes (i.e. tightly packed).

As mentioned by Rob, the "syscon" driver should be renamed
"register-range" and "syscon" deprecated as binding, as it is
Linux terminology.

I guess this adds up to the conclusion that the "syscon" binding
was badly reviewed and merged, and now we're suffering from it.

----

Not that anyone should care when reviewing device tree bindings,
but as it happens, the Linux driver
drivers/mfd/syscon.c
explicitly assumes all sycons are 32bit:

static struct regmap_config syscon_regmap_config = {
        .reg_bits = 32,
        .val_bits = 32,
        .reg_stride = 4,
};

If one happens to work on Linux (we would never assume such a
thing, but if one by infinitesimal chance would still happen to do that)
we can leave a note in this posting that the syscon driver would need to
be altered to marshall it's regmap differently on stumbling onto this
new property.

Yours,
Linus Walleij
