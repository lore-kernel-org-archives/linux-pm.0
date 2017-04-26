From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 5/8] gpio: gpio-wcove: use first level PMIC GPIO irq
Date: Wed, 26 Apr 2017 18:40:55 +0300
Message-ID: <CAHp75Vd486wZ=bmBL4e41r5VufhWqz_O_4g=P9dgR69EOTtxZQ@mail.gmail.com>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <cd9ddab845e471758b5553fcdc060d6eecd24e93.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CACRpkdYD8SiTDL1Bc4ordyi4E2fPSRpgbKY_DPd76oQYhXe11A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYD8SiTDL1Bc4ordyi4E2fPSRpgbKY_DPd76oQYhXe11A@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andy@infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 24, 2017 at 4:17 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Apr 15, 2017 at 1:25 AM,
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> PMIC mfd driver only exports first level irq for GPIO device.
>> But currently we are reading the irqs from the second level irq
>> chip, So this patch fixes this issue by adding support to use
>> first level PMIC GPIO irq.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I guess this gets merged into MFD because of dependencies?

Yes.

> If it compiles on its own and doesn't cause regressions I can
> merged it into the GPIO tree.

I guess it will break something if put it separately.

-- 
With Best Regards,
Andy Shevchenko
