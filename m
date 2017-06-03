From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 3/8] thermal: intel_bxt_pmic_thermal: Use first level
 PMIC thermal irq
Date: Sat, 3 Jun 2017 20:32:59 +0300
Message-ID: <CAHp75VdQyCMzTyPVkbfr6teEugxEmKuDOe5Qk51bDvoNjTay+w@mail.gmail.com>
References: <cover.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170531070225.bymdhhpclidwwtpt@dell> <3e58ab749a67cce5c956ef13db8563fb0a8bc190.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75Vd5uPmz-0uyPcwYaqyGZhC7caHWj5PbfMJTzSQ6G+1o3w@mail.gmail.com> <CAENHMvOzo0e5gs+DzK3ZNL7BbenhpZZCCbmT5kAjpWq-679UOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:32997 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdFCRdB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jun 2017 13:33:01 -0400
In-Reply-To: <CAENHMvOzo0e5gs+DzK3ZNL7BbenhpZZCCbmT5kAjpWq-679UOQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "dvhart@infradead.org" <dvhart@infradead.org>, "Zhang, Rui" <rui.zhang@intel.com>, Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andy@infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>

On Sat, Jun 3, 2017 at 8:28 PM, Sathyanarayanan Kuppuswamy Natarajan
<sathyaosid@gmail.com> wrote:
> Hi,
>
> On Sat, Jun 3, 2017 at 6:00 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Thu, Jun 1, 2017 at 1:37 AM,
>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>
>>> PMIC mfd driver only exports first level irq for thermal device.
>>> But currently we are reading the irqs from the second level irq
>>> chip, So this patch fixes this issue by adding support to use
>>> first level PMIC thermal irq.
>>>
>>
>> Shouldn't be this squashed to patch 2?
>
> There is no compilation dependency between patch 2 and 3. But they are
> functionally dependent.
>
> Should we squash functionally dependent patches too ?

Let's assume we applied patches 1 and 2, does it mean the regression
to the existing behaviour?

(For example, device worked improperly in some cases -> stopped
working completely)

-- 
With Best Regards,
Andy Shevchenko
