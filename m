From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Thu, 31 Mar 2016 16:03:45 +0800
Message-ID: <CAMz4kuJwfWPEndmVMoDBQQFZ2X8BAzDgej_9qMKQq0xU3tC=5w@mail.gmail.com>
References: <cover.1458128215.git.baolin.wang@linaro.org>
	<11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
	<87h9foqnur.fsf@intel.com>
	<CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
	<87poubgnbh.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36183 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbcCaIDr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 04:03:47 -0400
Received: by mail-yw0-f178.google.com with SMTP id g3so88557610ywa.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2016 01:03:46 -0700 (PDT)
In-Reply-To: <87poubgnbh.fsf@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On 31 March 2016 at 14:42, Felipe Balbi <balbi@kernel.org> wrote:
>>>> +#define DEFAULT_CUR_PROTECT  (50)
>>>
>>> Where is this coming from ? Also, () are not necessary.
>>
>> Just want to protect the default current limitation. If that does not
>> need, I'll remove it.
>
> It's your HW :-) You tell me if it's really necessary. But, hey, if you
> get enumerated @500mA, this is the host telling you it _CAN_ give you
> 500mA. In that case, why wouldn't you ?

Make sense. I'll remove the 'DEFAULT_CUR_PROTECT' macro.

>
>>>> +#define DEFAULT_SDP_CUR_LIMIT        (500 - DEFAULT_CUR_PROTECT)
>>>
>>> According to the spec we should always be talking about unit loads (1
>>> unit load is 100mA for HS/FS/LS and 150mA for SS). Also, this will not
>>> work for SS capable ports and SS gadgets (we have quite a few of them,
>>> actually). You're missing the opportunity of charging at 900mA.
>>
>> I follow the DCP/SDP/CDP/ACA type's default current limitation and
>> user can set them what they want.
>
> no, the user CANNOT set it to what they want. If you get enumerated
> @100mA and the user just decides to set it to 2000mA, s/he could even
> melt the USB connector. The kernel _must_ prevent such cases.
>
> In any case, DEFAULT_SDP_CUR_LIMIT shouldn't be a constant, it should be
> variable because if you enumerate in SS, you _can_ get up to 900mA.

Make sense. But these are just default values. They can be changed
safely by power driver with 'usb_charger_set_cur_limit_by_type()'
function to set 900mA.

>
>>>> +#define DEFAULT_DCP_CUR_LIMIT        (1500 - DEFAULT_CUR_PROTECT)
>>>> +#define DEFAULT_CDP_CUR_LIMIT        (1500 - DEFAULT_CUR_PROTECT)
>>>> +#define DEFAULT_ACA_CUR_LIMIT        (1500 - DEFAULT_CUR_PROTECT)
>>>> +#define UCHGER_STATE_LENGTH  (50)
>>>
>>> what is this UCHGER_STATE_LENGTH ? And also, why don't you spell it out?
>>> Is this weird name coming from a spec ? Which spec ?
>>
>> It is used to indicate the array size to save the charger state to
>> report to userspace. I should move it to where it is used.
>
> and ARRAY_SIZE(arr) is not enough ?

OK.

>
>>> sure this fits as a bus_type. There's no "usb charger" bus. There's USB
>>> bus and its VBUS/GND lines. Why are you using a bus_type here ?
>>
>> I want to use bus structure to manage the charger device. Maybe choose
>> class to manage them?
>
> I guess a class would fit better in this case.

OK.

>
>>>> +{
>>>> +     return container_of(udev, struct usb_charger, dev);
>>>> +}
>>>> +
>>>> +static ssize_t sdp_limit_show(struct device *dev,
>>>> +                           struct device_attribute *attr,
>>>> +                           char *buf)
>>>> +{
>>>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>>>> +
>>>> +     return sprintf(buf, "%d\n", uchger->cur_limit.sdp_cur_limit);
>>>> +}
>>>> +
>>>> +static ssize_t sdp_limit_store(struct device *dev,
>>>> +                            struct device_attribute *attr,
>>>> +                            const char *buf, size_t count)
>>>> +{
>>>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>>>> +     unsigned int sdp_limit;
>>>> +     int ret;
>>>> +
>>>> +     ret = kstrtouint(buf, 10, &sdp_limit);
>>>> +     if (ret < 0)
>>>> +             return ret;
>>>> +
>>>> +     ret = usb_charger_set_cur_limit_by_type(uchger, SDP_TYPE, sdp_limit);
>>>> +     if (ret < 0)
>>>> +             return ret;
>>>> +
>>>> +     return count;
>>>> +}
>>>> +static DEVICE_ATTR_RW(sdp_limit);
>>>
>>> why RW ? Who's going to use these ? Also, you're not documenting this
>>> new sysfs file.
>>
>> Cause we have show and store operation for SDP type. If users want to
>> know or set the SDP current, they can use the sysfs file.
>> I'll add the documentation for it.
>
> but why would the user change it ? Here's the thing: you have a few
> posibilities for this:
>
> a) you are connected to a dedicated charger
>
>         In this case, you can get up to 2000mA depending on the charger.
>
>         If $this charger can give you or not 2000mA is not detectable,
>         so what do charging ICs do ? They slowly increase the attached
>         load accross VBUS/GND and measure VBUS value. When IC notices
>         VBUS dropping bit, step back to previous load.
>
>         This means you will always charger with maximum rating of DCP.
>
>         Why would user change this ? More is unsafe, less is just
>         stupid.
>
> b) you are connected to a host charging port and get enumerated with
> your 500mA configuration.
>
>         you *know* 500mA is okay, but you _can_ get more (it is a
>         charging port after all). So charging IC will connect a 500mA
>         load and step upwards until VBUS drops a little, just like (a)
>         above.
>
>         This means you will always charger with maximum rating for this
>         host charging port.
>
>         Why would user change this ? More is unsafe, less is just
>         stupid.
>
> c) you are connected to a standard port and get enumerated with your
> 500mA configuration.
>
>         you *know* 500mA is okay. So you connect a 500mA load and get it
>         over with.
>
>         This means you will always charger with maximum rating for this
>         SDP.
>
>         Why would user change this ? More is unsafe, less is just
>         stupid.
>
> d) you are connected to a standard port and get enumerated with your
> 100mA configuration.
>
>         you *know* 100mA is okay. So you connect a 100mA load and get it
>         over with.
>
>         This means you will always charger with maximum rating for this
>         SDP.
>
>         Why would user change this ? More is unsafe, less is just
>         stupid.
>
> do you see what I mean ? It's pointless to let this
> be-writeable. Whatever value user writes will either be unsafe or
> sub-optimal.

That sounds reasonable. Mark what do you think? Thanks.

>
> Just trust the charging IC to do a good job.
>
>>>> +
>>>> +/* USB charger state */
>>>> +enum usb_charger_state {
>>>> +     USB_CHARGER_DEFAULT,
>>>> +     USB_CHARGER_PRESENT,
>>>> +     USB_CHARGER_REMOVE,
>>>> +};
>>>
>>> userland really doesn't need these two ?
>>
>> We've reported to userspace by kobject_uevent in
>> 'usb_charger_notify_others()' function.
>
> I mean as a type ;-) So userspace doesn't have to redefine these for
> their applications.

Make sense. I can introduce some sysfs files for userspace. Thanks for
your comments.

>
> --
> balbi



-- 
Baolin.wang
Best Regards
