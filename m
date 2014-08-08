From: "edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3] Thermal: imx: add i.mx6sx thermal support
Date: Fri, 8 Aug 2014 08:15:54 -0400
Message-ID: <CAC-25o_C1ijr64NyA22JqfS9Z90-v9iseaYzcf1ojy_QNXzExA@mail.gmail.com>
References: <1407309129-5562-1-git-send-email-b20788@freescale.com>
	<20140807085024.GE27051@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140807085024.GE27051@dragon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Anson Huang <b20788-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Shawn,

On Thu, Aug 7, 2014 at 4:50 AM, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Aug 06, 2014 at 03:12:09PM +0800, Anson Huang wrote:
>> i.MX6SX has some new features of thermal interrupt function,
>> there are LOW, HIGH and PANIC irq for thermal sensor, so add
>> platform data to separate different thermal version;
>>
>> The reset value of LOW ALARM is 0 which means the highest
>> temp, so the LOW ALARM will be triggered once irq is enabled,
>> so we need to correct it before enabling thermal irq;
>>
>> Enable PANIC ALARM as critical trip point, it will trigger
>> system reset via SRC module once PANIC IRQ is triggered, it
>> is pure hardware function, so use it instead of software
>> reset by cooling device.
>>
>> Signed-off-by: Anson Huang <b20788-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>
> Tested-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Thanks!

Did you have the chance to test on both? i.MX6Q and i.MX6SX?

-- 
Eduardo Bezerra Valentin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
