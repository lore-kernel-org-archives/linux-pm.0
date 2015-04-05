From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 5/6] staging: board: Add support for devices with
 complex dependencies
Date: Sun, 5 Apr 2015 11:00:56 +0200
Message-ID: <CAMuHMdWsc=2QvKfpYmN=M6As_KWENW2nhSqa8ajkZrQFe+dCPw@mail.gmail.com>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
 <34835209.cQQp4PEGGk@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <34835209.cQQp4PEGGk@avalon>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: driverdevel <devel@driverdev.osuosl.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Magnus Damm <damm+renesas@opensource.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Laurent,

On Sat, Apr 4, 2015 at 2:46 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> +     for (i = 0; i < dev->ngpios; i++)
>> +             gpio_request_one(dev->gpios[i].gpio, dev->gpios[i].flags,
>> +                              pdev->name);
>
> Aren't GPIO numbers dynamic too in DT-based systems ? Beside, shouldn't it be

Apparently not, as the old legacy number still works, and it doesn't work
without.

> the responsibility of the drievr to request the GPIOs it needs ?

As far as I understand it, on Armadillo this is used more for platform
configuration than for device configuration, as it affects multiple devices
(the comment says DBGMD/LCDC0/FSIA MUX).

I guess I could use a "gpio-hog" subnode in DT instead, but then we're already
implementing the conversion to DT ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
