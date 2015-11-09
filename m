From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v5 1/5] gadget: Introduce the notifier functions
Date: Mon, 9 Nov 2015 10:02:27 +0800
Message-ID: <CAMz4kuK1WwgY+KSgsoYx74LaUYCaez6vVO7zd3e-v3vLnU8UMg@mail.gmail.com>
References: <cover.1446807915.git.baolin.wang@linaro.org>
	<acd08255d6535082973a5e432c40433429544dbc.1446807915.git.baolin.wang@linaro.org>
	<20151106165644.GA23834@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151106165644.GA23834@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>, sre@kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Mark Brown <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sameo@linux.intel.com, Lee Jones <lee.jones@linaro.org>, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 7 November 2015 at 00:56, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Nov 06, 2015 at 07:35:10PM +0800, Baolin Wang wrote:

>>  #ifdef       CONFIG_HAS_DMA
>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> index c14a69b..755e8bc 100644
>> --- a/include/linux/usb/gadget.h
>> +++ b/include/linux/usb/gadget.h
>> @@ -609,6 +609,8 @@ struct usb_gadget {
>>       unsigned                        out_epnum;
>>       unsigned                        in_epnum;
>>       struct usb_otg_caps             *otg_caps;
>> +     struct raw_notifier_head        nh;
>> +     struct mutex                    lock;
>
> You have to document what this lock protects.

OK.

>
>
>>
>>       unsigned                        sg_supported:1;
>>       unsigned                        is_otg:1;
>> @@ -1183,6 +1185,22 @@ extern void usb_gadget_unmap_request(struct usb_gadget *gadget,
>>
>>  /*-------------------------------------------------------------------------*/
>>
>> +/**
>> + * Register a notifiee to get notified by any attach status changes from
>> + * the usb gadget
>> + */
>
> kerneldoc does not belong in a .h file.
>

I'll remove the comments.

> And the kbuild system found lots of problems with this series, please
> fix those at the very least :(

I'm sorry for that, I'll check the patches again. Thanks for your comments.

>
> thanks,
>
> greg k-h



-- 
Baolin.wang
Best Regards
