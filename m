From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Tue, 21 Jun 2016 19:29:44 +0800
Message-ID: <CAMz4ku+t66t+E3dCysfE9yNkKRCYwv7mXpJs4ShGbZWSZO_B9g@mail.gmail.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org>
 <87bn2uomzd.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87bn2uomzd.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 21 June 2016 at 18:27, Felipe Balbi <balbi@kernel.org> wrote:
>
> Hi,
>
> Baolin Wang <baolin.wang@linaro.org> writes:
>> For supporting the usb charger, it adds the usb_charger_init() and
>> usb_charger_exit() functions for usb charger initialization and exit.
>>
>> It will report to the usb charger when the gadget state is changed,
>> then the usb charger can do the power things.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> Reviewed-by: Li Jun <jun.li@nxp.com>
>> Tested-by: Li Jun <jun.li@nxp.com>
>
> Before anything, I must say that I really liked this patch. It's

Thanks.

> minimaly invasive to udc core and does all the necessary changes. If it
> wasn't for the extra charger class, this would've been perfect.
>
> Can't you just tie a charger to a UDC and avoid the charger class
> completely?

Yeah, I also hope so. But we really want something to manage the
charger devices, do you have any good suggestion to avoid the 'class'
but also can manage the charger devices?

>
>>  static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
>>  {
>> +     if (gadget->charger)
>
> I guess you could do this check inside
> usb_gadget_set_cur_limit_by_type() itself.

OK.

>
> --
> balbi



-- 
Baolin.wang
Best Regards
