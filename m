From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/3] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Mon, 17 Aug 2015 19:51:00 +0800
Message-ID: <CAMz4ku+OiQDpvsFuSbJWp4jXm1OnAfSNrYkYeXY3ZwsCcGd_pA@mail.gmail.com>
References: <cover.1439519412.git.baolin.wang@linaro.org>
	<20150814085527.GA17920@shlinux2>
	<CAMz4kuK7f=rGOO-YdB0AB8PzpTbnWZtasuQK8gOXLuM9zyn3gw@mail.gmail.com>
	<20150817011541.GA7122@shlinux2>
	<CAMz4kuJGR1ZQPbBNpp7EABJn=Rag8jSrb-2ztcefUf4R7pk4AQ@mail.gmail.com>
	<20150817082023.GB7122@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150817082023.GB7122@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Li Jun <b47624-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, sojka-Knnw/vAvyUalVyrhU4qvOw@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 17 August 2015 at 16:20, Li Jun <b47624-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> On Mon, Aug 17, 2015 at 02:02:08PM +0800, Baolin Wang wrote:
>> On 17 August 2015 at 09:15, Li Jun <b47624-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
>> > On Fri, Aug 14, 2015 at 07:04:56PM +0800, Baolin Wang wrote:
>> >> On 14 August 2015 at 16:55, Li Jun <b47624-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
>> >> > Hi Baolin,
>> >> >
>> >> > On Fri, Aug 14, 2015 at 05:47:43PM +0800, Baolin Wang wrote:
>> >> >> Currently the Linux kernel does not provide any standard integration of this
>> >> >> feature that integrates the USB subsystem with the system power regulation
>> >> >> provided by PMICs meaning that either vendors must add this in their kernels
>> >> >> or USB gadget devices based on Linux (such as mobile phones) may not behave
>> >> >> as they should.
>> >> >>
>> >> >> Providing a standard framework for doing this in the kernel.
>> >> >>
>> >> >
>> >> > Why not add power supply class support into this?
>> >> >
>> >>
>> >> Hi Jun,
>> >>
>> >> We don't need the power supply class support into the usb charger,
>> > I suppose usb charger is also a power supply for the system, we can use power
>> > supply class framework for notify mechanism and get/set many attributes(maybe
>> > also the current limit), I see those usb charger drivers under ./driver/power/
>> > are designed with power supply supported.
>> >
>>
>> I don't think so. The usb charger is rely on the usb gadget, which is
>> not a complete power supply device and it combines the usb and the
>> power supply. Thus we make it into usb gadget system. Thanks.
>>
> Why it cannot be a complete power supply device? I was thinking this
> framework can cover it, I have no doubt on putting this framework
> into gadget system, but still can't understand why we don't need
> power supply class at all for a usb charger, or you think introduce
> power supply into usb gadget is not a right direction from code structure
> point view?
>

We just do not think the usb charger as a real device, which is only
used to set the current limitation when the usb charger state is
changed detecting by extcon device or usb gadget. So we just need one
message to notify the power user to set the current limitation when
uab charge is added or removed. I also agree with the power supply
framework can cover it, but we don't need to implement it to be
another power supply, cause there is a real device as the power supply
to deal with the power issue in the system. Thanks.

> Li Jun
>> > Li Jun
>> >> just introduce the notify mechanism for power to set the current limit
>> >> when notifying some events from usb charger. Maybe I misunderstand
>> >> your meanings, please describe it detailedly. Thanks for your
>> >> comments.
>> >>
>> >> > Li Jun
>> >> >
>> >>
>> >>
>> >>
>> >> --
>> >> Baolin.wang
>> >> Best Regards
>>
>>
>>
>> --
>> Baolin.wang
>> Best Regards



-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
