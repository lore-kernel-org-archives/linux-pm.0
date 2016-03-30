From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 30 Mar 2016 15:07:49 +0800
Message-ID: <CAMz4kuKkSt0xj_1jGC9d_yVpEX0krBB_M6x1C3ZR9bDGabQeLQ@mail.gmail.com>
References: <cover.1458822334.git.baolin.wang@linaro.org>
	<20160325070937.GA22398@peterchendt>
	<CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com>
	<20160328071351.GC3302@peterchendt>
	<20160329172314.GZ2350@sirena.org.uk>
	<20160330020501.GA2740@peterchendt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160330020501.GA2740@peterchendt>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 30 March 2016 at 10:05, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Mar 29, 2016 at 10:23:14AM -0700, Mark Brown wrote:
>> On Mon, Mar 28, 2016 at 03:13:51PM +0800, Peter Chen wrote:
>> > On Mon, Mar 28, 2016 at 02:51:40PM +0800, Baolin Wang wrote:
>>
>> > > > I am afraid I still not find the user (udc driver) for this framework, I would
>> > > > like to see how udc driver block the enumeration until the charger detection
>> > > > has finished, or am I missing something?
>>
>> > > It is not for udc driver but for power users who want to negotiate
>> > > with USB subsystem.
>>
>> > Then, where is the code the test user to decide what kinds of USB charger
>> > (SDP, CDP, DCP) is connecting now?
>>
>> Even without detection of CDP and DCP we have configurability within SDP
>> - there's the 2.5mA suspended limit, the 100mA default limit and the
>> higher 500mA limit which can be negotiated.
>
> Well, things may be a little complicated.

I try to address your comments, maybe Mark need to do some complements. Thanks.

>
> - First, how to design get_charger_type for each udc driver?
> Since the charger detection process affects dp/dm signal, it can't be done
> during the enumeration or after that. So, the detection process can be only
> done after vbus has detected and before udc pull up dp.
>
> Then, when the get_charger_type do real charger detection? My suggestion is,
> if the charger type is unknown, we do real one, else, we just return the
> stored type value.

I think that is why we let udc driver to implement the
'gadget->ops->get_charger_type()' callback, which can be controlled by
udc driver.

>
> - Second, When to notify charger IC to charger:
> For SDP and CDP, it needs to notify charger IC after set configuration
> has finished.
> For DCP (and ACA, I am not sure), can notify charger IC after charger
> detection has finished or later.
>
> So, when we get charger is present, we need to notify charger IC at once
> for DCP (and ACA); But for SDP and CDP, we need to let the gadget
> composite core to notify charger IC after set configuration has finished,
> like the patch 2/4 does.

But mostly charger IC is separate with gadget, so the charger IC
doesn't need to worry about the gadget status.

>
> - Third, since composite driver covers 500mA (and more for CDP) after set
> configuration and 2mA after suspend, and vbus handler covers connect
> and disconnect. I can't see any reasons we need to notify gadget state
> for power driver, do we really need to have usb_charger_plug_by_gadget?

In some solutions, gadget does not negotiate with the current. They
just send out one signal to power driver to set the current when the
gadget state is changed (plugin or not). So we need to check the
charger state by the gadget state to notify the charger IC to set
current.

>
> --
> Best Regards,
> eter Chen



-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
