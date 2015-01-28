From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 3/5] drivers: bus: Add Simple Power-Managed Bus DT
 Bindings
Date: Wed, 28 Jan 2015 16:38:55 +0100
Message-ID: <CAMuHMdXUQESzCggb6FsDQStVtCHgTCCKo7veXSdUTZcB9OAd_w@mail.gmail.com>
References: <1422288977-20353-1-git-send-email-geert+renesas@glider.be>
 <1422288977-20353-4-git-send-email-geert+renesas@glider.be>
 <20150127181727.GO17721@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150127181727.GO17721@leverpostej>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Kumar Gala <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infr>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Tue, Jan 27, 2015 at 7:17 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
>> @@ -0,0 +1,41 @@
>> +Simple Power-Managed Bus
>> +========================
>> +
>> +A Simple Power-Managed Bus is a transparent bus that doesn't need a real
>> +driver, as it's typically initialized by the boot loader.
>> +
>> +However, its bus controller is part of a PM domain, or under the control of a
>> +functional clock.  Hence, the bus controller's PM domain and/or clock must be
>> +enabled for child devices connected to the bus (either on-SoC or externally)
>> +to function.
>> +
>> +The bindings for the Simple Power-Managed Bus extend the bindings for
>> +"simple-bus", as specified in ePAPR.
>
> I would note that "simple-pm-bus" follows the "simple-bus" set of
> properties, but is not an extension of "simple-bus".

OK.

> For the reasons I mentioned previously, I don't think that any
> "simple-pm-bus" should be "simple-bus" compatible (and I believe we
> should document that requirement below).

>> +Required properties:
>> +  - compatible: Must contain at least "simple-pm-bus".

So you think I should add 'and must not contain "simple-bus"'?

>> +             It's recommended to let this be preceded by one or more
>> +             vendor-specific compatible values.
>> +  - #address-cells, #size-cells, ranges: Must describe the mapping between
>> +             parent address and child address spaces.
>> +
>> +Optional platform-specific properties for clock or PM domain control (at least
>> +one of them is required):
>> +  - clocks: Must contain a reference to the functional clock(s),
>
> I'm a little worried about the clocks. What are the expectations on
> their configuration?

The clocks are highly platform-dependent. Hence the exact expectations
belong in the binding documentation for the clock provider (and possibly
the PM domain provider, too).

> I don't see how we can generally rely on the clock configuration being
> correct unless the input clocks only have on/off controls, and the OS
> doesn't see any of the parent clock tree it could potentially change the
> configuration of (beyond on/off).

This is indeed not about generic programmable clock generators, but about
clocks that are used solely to start/stop a hardware module by (un)gating
a functional clock.

> Otherwise we're relying on implicit behaviour elsewhere in Linux (which
> _will_ break over time), and this ends up not being usable by anything
> else.
>
> I'm coming to the opinion that while we might be able to have common
> driver in Linux, we can't have a common "simple-pm-bus" binding because
> it implicitly assumes too much about the OS behaviour.

If the bus controller is clocked from a generic programmable clock generator,
it would need its own driver to configure e.g. the clock frequency, which
could need more information from DT. This is not covered by "simple-pm-bus".

Thanks for your comments!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
