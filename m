From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 4/6] drivers: firmware: psci: Fix non-PMIC wake-up if
 SYSTEM_SUSPEND cuts power
Date: Tue, 21 Feb 2017 17:36:38 +0100
Message-ID: <CAMuHMdX24ONBOovb26epZpKJV1w64NbEhr_Rex=NDPe4e0frmQ@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-5-git-send-email-geert+renesas@glider.be> <20170221110730.GF5021@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170221110730.GF5021@amd>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Pavel,

On Tue, Feb 21, 2017 at 12:07 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2017-02-20 21:33:27, Geert Uytterhoeven wrote:
>> Nothing in the PSCI specification requires the SoC to remain powered and
>> to support wake-up sources when suspended using SYSTEM_SUSPEND.
>> If the firmware implements the PSCI SYSTEM_SUSPEND operation by cutting
>> power to the SoC, the only possibly wake-up sources are thus the ones
>> connected to the PMIC.
>>
>> Document and add support for an "arm,psci-system-suspend-is-power-down"
>> DT property, so Linux uses a different suspend method when other wake-up
>> sources (e.g. wake on LAN, UART or GPIO) are enabled.
>
> Should we make PSCI return that information? (At least in next
> specification version?)

That's a possible solution.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
