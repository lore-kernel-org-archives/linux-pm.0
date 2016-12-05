From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3 1/3] ARM: da850: fix infinite loop in clk_set_rate()
Date: Mon, 5 Dec 2016 16:11:01 +0530
Message-ID: <124074bb-b062-ad91-8cb9-a3cf34d3b011@ti.com>
References: <1480932549-30811-1-git-send-email-bgolaszewski@baylibre.com>
 <1480932549-30811-2-git-send-email-bgolaszewski@baylibre.com>
 <689efaa1-d8d9-6937-5880-3ed7a1401268@ti.com>
 <CAMpxmJUYksWf-p3KMYZ_oxKWELit6MwAWd7i__6sQY0-_nKOyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMpxmJUYksWf-p3KMYZ_oxKWELit6MwAWd7i__6sQY0-_nKOyA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-pm <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 05 December 2016 04:02 PM, Bartosz Golaszewski wrote:
> 2016-12-05 11:15 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
>> On Monday 05 December 2016 03:39 PM, Bartosz Golaszewski wrote:
>>> The aemif clock is added twice to the lookup table in da850.c. This
>>> breaks the children list of pll0_sysclk3 as we're using the same list
>>> links in struct clk. When calling clk_set_rate(), we get stuck in
>>> propagate_rate().
>>>
>>> Create a separate clock for nand, inheriting the rate of the aemif
>>> clock and retrieve it in the davinci_nand module.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>  arch/arm/mach-davinci/da850.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>>> index e770c97..c008e5e 100644
>>> --- a/arch/arm/mach-davinci/da850.c
>>> +++ b/arch/arm/mach-davinci/da850.c
>>> @@ -367,6 +367,11 @@ static struct clk aemif_clk = {
>>>       .flags          = ALWAYS_ENABLED,
>>>  };
>>>
>>> +static struct clk aemif_nand_clk = {
>>> +     .name           = "nand",
>>> +     .parent         = &aemif_clk,
>>> +};
>>> +
>>>  static struct clk usb11_clk = {
>>>       .name           = "usb11",
>>>       .parent         = &pll0_sysclk4,
>>> @@ -537,7 +542,7 @@ static struct clk_lookup da850_clks[] = {
>>>       CLK("da830-mmc.0",      NULL,           &mmcsd0_clk),
>>>       CLK("da830-mmc.1",      NULL,           &mmcsd1_clk),
>>>       CLK("ti-aemif",         NULL,           &aemif_clk),
>>> -     CLK(NULL,               "aemif",        &aemif_clk),
>>> +     CLK(NULL,               "aemif",        &aemif_nand_clk),
>>
>> Why use a NULL device name here? Same question was asked on v2
> 
> Eek, sorry, I missed that.

For next version, can you also add a comment on top of 'struct clk
aemif_nand_clk' explaining why its needed?

Thanks,
Sekhar
