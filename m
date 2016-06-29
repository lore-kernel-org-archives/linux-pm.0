From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Wed, 29 Jun 2016 20:16:22 +0800
Message-ID: <CAMz4kuJ2duayzdBL07+pMh5YA6QRXozX+CNpc8M8VQi=KicFbA@mail.gmail.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org>
 <87bn2uomzd.fsf@linux.intel.com> <CAMz4kuJ990pfVxSz7sVEOOiL8gC+BAjJ=PLioez5_Y5c+OyxxQ@mail.gmail.com>
 <87eg7giexn.fsf@linux.intel.com> <CAMz4kuK30ZGdqgyHNj=xnVLSpceCFD4R8-LvqMS3EOUTUhcHtA@mail.gmail.com>
 <87bn2kieb6.fsf@linux.intel.com> <CAMz4kuL9pJzNsn7xXXCp4s9Rczm5vWhuWfF7VjkuxsMUzNZXZQ@mail.gmail.com>
 <87twgcgpwp.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87twgcgpwp.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Felipe,

On 29 June 2016 at 20:06, Felipe Balbi <balbi@kernel.org> wrote:
>
> Hi,
>
> Baolin Wang <baolin.wang@linaro.org> writes:
>>>>>>>> For supporting the usb charger, it adds the usb_charger_init() and
>>>>>>>> usb_charger_exit() functions for usb charger initialization and exit.
>>>>>>>>
>>>>>>>> It will report to the usb charger when the gadget state is changed,
>>>>>>>> then the usb charger can do the power things.
>>>>>>>>
>>>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>>>>>> Reviewed-by: Li Jun <jun.li@nxp.com>
>>>>>>>> Tested-by: Li Jun <jun.li@nxp.com>
>>>>>>>
>>>>>>> Before anything, I must say that I really liked this patch. It's
>>>>>>> minimaly invasive to udc core and does all the necessary changes. If it
>>>>>>> wasn't for the extra charger class, this would've been perfect.
>>>>>>>
>>>>>>> Can't you just tie a charger to a UDC and avoid the charger class
>>>>>>> completely?
>>>>>>>
>>>>>>>>  static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
>>>>>>>>  {
>>>>>>>> +     if (gadget->charger)
>>>>>>>
>>>>>>> I guess you could do this check inside
>>>>>>> usb_gadget_set_cur_limit_by_type() itself.
>>>>>>
>>>>>> We will access the 'gadget->charger->type' member when issuing
>>>>>> usb_gadget_set_cur_limit_by_type(), so I think I should leave the
>>>>>> check here in next new version.
>>>>>
>>>>> Here's what I mean:
>>>>>
>>>>> int usb_charger_set_cur_limit(struct usb_gadget *gadget, unsigned int mA)
>>>>> {
>>>>>         struct usb_charger *charger;
>>>>>         enum usb_charger_type type;
>>>>>
>>>>>         if (!gadget->charger)
>>>>>                 return 0;
>>>>>
>>>>>         charger = gadget->charger;
>>>>>         type = charger->type;
>>>>>
>>>>>         return __usb_charger_set_cur_limit(charger, type, mA);
>>>>> }
>>>>
>>>> But that means we need to export  both 'usb_charger_set_cur_limit()'
>>>> function and '__usb_charger_set_cur_limit()' function in charger.c
>>>> file. Cause some user may want to set the current limitation by one
>>>> charger type parameter (may be not from charger->type), like by
>>>> issuing '__usb_charger_set_cur_limit(charger, SDP_TYPE, mA)'. How do
>>>> you think about this situation? Thanks.
>>>
>>> if we have that requirement, that's totally fine. Just rename
>>> __usb_charger_set_cur_limit() back to
>>> _usb_charger_set_cur_limit_by_type() and expose both. But
>>> set_cur_limit_by_type can assume its arguments are valid at all times.
>>
>> Make sense. I'll fix this issue in v14 version. Thanks.
>
> there's one thing bothering me though:
>
> gadget->charger is supposed to be "current detected charger" right? If
> we have a single port tied to a single charger, in which case would we
> *ever* need to change current limit of any charger type other than
> "current charger" ?

What I mean is user can set the current limit by charger type as what
they want at initial stage. As we know the default current of SDP (not
super speed) is 500 mA, but user can set the current limit of SDP as
450 mA if there are some special on their own platform by issuing
'__usb_charger_set_cur_limit(charger, SDP_TYPE, 450)'.

>
> IOW, why do we need _set_cur_limit_by_type() exported at all?
>
> --
> balbi



-- 
Baolin.wang
Best Regards
