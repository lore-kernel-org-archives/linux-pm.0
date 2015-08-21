From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Fri, 21 Aug 2015 10:28:23 +0800
Message-ID: <CAMz4kuKnCWr-J8g=PCt5M8PnoDU9i7X2Ev8d9iVdk9xYVu2GLA@mail.gmail.com>
References: <cover.1439519412.git.baolin.wang@linaro.org>
	<f3bfd04bc157e97e2d0632b7ed2452f366f66488.1439519413.git.baolin.wang@linaro.org>
	<063D6719AE5E284EB5DD2968C1650D6D1CB803F4@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB803F4@AcuExch.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Laight <David.Laight@aculab.com>
Cc: "balbi@ti.com" <balbi@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "sojka@merica.cz" <sojka@merica.cz>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lee.jones@linaro.org" <lee.jone>
List-Id: linux-pm@vger.kernel.org

On 20 August 2015 at 17:02, David Laight <David.Laight@aculab.com> wrote:
> From: Baolin Wang
>> Sent: 14 August 2015 10:48
>> +/* In miliamps */
>
> Spelling police: "milliamps"
>

Hi David,

I'll correct it in next patch series. Thanks for your comments.

>> +static unsigned int wm831x_usb_limits[] = {
>> +     0,
>> +     2,
>> +     100,
>> +     500,
>> +     900,
>> +     1500,
>> +     1800,
>> +     550,
>> +};
>
>         David
>



-- 
Baolin.wang
Best Regards
