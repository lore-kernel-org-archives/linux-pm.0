From: Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
Subject: Re: [PATCH v5 3/8] thermal: intel_bxt_pmic_thermal: Use first level
 PMIC thermal irq
Date: Sat, 3 Jun 2017 10:53:09 -0700
Message-ID: <CAENHMvMF8yOsezMRSYp+4TsVTD9Nnbfm8LJWuX7YccbSL+bsGQ@mail.gmail.com>
References: <cover.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170531070225.bymdhhpclidwwtpt@dell> <3e58ab749a67cce5c956ef13db8563fb0a8bc190.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75Vd5uPmz-0uyPcwYaqyGZhC7caHWj5PbfMJTzSQ6G+1o3w@mail.gmail.com>
 <CAENHMvOzo0e5gs+DzK3ZNL7BbenhpZZCCbmT5kAjpWq-679UOQ@mail.gmail.com> <CAHp75VdQyCMzTyPVkbfr6teEugxEmKuDOe5Qk51bDvoNjTay+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdQyCMzTyPVkbfr6teEugxEmKuDOe5Qk51bDvoNjTay+w@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "dvhart@infradead.org" <dvhart@infradead.org>, "Zhang, Rui" <rui.zhang@intel.com>, Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andy@infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sat, Jun 3, 2017 at 10:32 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Jun 3, 2017 at 8:28 PM, Sathyanarayanan Kuppuswamy Natarajan
> <sathyaosid@gmail.com> wrote:
>> Hi,
>>
>> On Sat, Jun 3, 2017 at 6:00 AM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Thu, Jun 1, 2017 at 1:37 AM,
>>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>
>>>> PMIC mfd driver only exports first level irq for thermal device.
>>>> But currently we are reading the irqs from the second level irq
>>>> chip, So this patch fixes this issue by adding support to use
>>>> first level PMIC thermal irq.
>>>>
>>>
>>> Shouldn't be this squashed to patch 2?
>>
>> There is no compilation dependency between patch 2 and 3. But they are
>> functionally dependent.
>>
>> Should we squash functionally dependent patches too ?
>
> Let's assume we applied patches 1 and 2, does it mean the regression
> to the existing behaviour?

Yes, Just applying patch 1 & 2 and not apply patch 3 will create
regression in thermal driver.

Since there is no compilation dependency between patch 2 & 3 and they
are from two different domains, I submitted them separately to make it
easier for review.



>
> (For example, device worked improperly in some cases -> stopped
> working completely)
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
Sathya
