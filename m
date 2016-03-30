From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 30 Mar 2016 16:40:31 +0800
Message-ID: <CAMz4kuJ2SprO0QE4sYg0ZgmO1KvfQjaJ_APusCSbK8DG4i5ueQ@mail.gmail.com>
References: <cover.1458822334.git.baolin.wang@linaro.org>
	<20160325070937.GA22398@peterchendt>
	<CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com>
	<20160328071351.GC3302@peterchendt>
	<20160329172314.GZ2350@sirena.org.uk>
	<20160330020501.GA2740@peterchendt>
	<CAMz4kuKkSt0xj_1jGC9d_yVpEX0krBB_M6x1C3ZR9bDGabQeLQ@mail.gmail.com>
	<20160330074229.GB2740@peterchendt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33378 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbcC3Ikc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 04:40:32 -0400
Received: by mail-yw0-f180.google.com with SMTP id h65so49759635ywe.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2016 01:40:31 -0700 (PDT)
In-Reply-To: <20160330074229.GB2740@peterchendt>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On 30 March 2016 at 15:42, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Wed, Mar 30, 2016 at 03:07:49PM +0800, Baolin Wang wrote:
>> On 30 March 2016 at 10:05, Peter Chen <hzpeterchen@gmail.com> wrote:
>> > On Tue, Mar 29, 2016 at 10:23:14AM -0700, Mark Brown wrote:
>> >> On Mon, Mar 28, 2016 at 03:13:51PM +0800, Peter Chen wrote:
>> >> > On Mon, Mar 28, 2016 at 02:51:40PM +0800, Baolin Wang wrote:
>> >>
>> >> > > > I am afraid I still not find the user (udc driver) for this framework, I would
>> >> > > > like to see how udc driver block the enumeration until the charger detection
>> >> > > > has finished, or am I missing something?
>> >>
>> >> > > It is not for udc driver but for power users who want to negotiate
>> >> > > with USB subsystem.
>> >>
>> >> > Then, where is the code the test user to decide what kinds of USB charger
>> >> > (SDP, CDP, DCP) is connecting now?
>> >>
>> >> Even without detection of CDP and DCP we have configurability within SDP
>> >> - there's the 2.5mA suspended limit, the 100mA default limit and the
>> >> higher 500mA limit which can be negotiated.
>> >
>> > Well, things may be a little complicated.
>>
>> I try to address your comments, maybe Mark need to do some complements. Thanks.
>>
>> >
>> > - First, how to design get_charger_type for each udc driver?
>> > Since the charger detection process affects dp/dm signal, it can't be done
>> > during the enumeration or after that. So, the detection process can be only
>> > done after vbus has detected and before udc pull up dp.
>> >
>> > Then, when the get_charger_type do real charger detection? My suggestion is,
>> > if the charger type is unknown, we do real one, else, we just return the
>> > stored type value.
>>
>> I think that is why we let udc driver to implement the
>> 'gadget->ops->get_charger_type()' callback, which can be controlled by
>> udc driver.
>>
>> >
>> > - Second, When to notify charger IC to charger:
>> > For SDP and CDP, it needs to notify charger IC after set configuration
>> > has finished.
>> > For DCP (and ACA, I am not sure), can notify charger IC after charger
>> > detection has finished or later.
>> >
>> > So, when we get charger is present, we need to notify charger IC at once
>> > for DCP (and ACA); But for SDP and CDP, we need to let the gadget
>> > composite core to notify charger IC after set configuration has finished,
>> > like the patch 2/4 does.
>>
>> But mostly charger IC is separate with gadget, so the charger IC
>> doesn't need to worry about the gadget status.
>>
>
> The reason why we need to combine charger IC with USB gadget (charger)
> driver is the charger IC should not charge as much as it wants, it
> needs to consider USB charger style and USB connection
> (un-configuration vs configuration) situation.

Yes, I agree with the charger IC should not charge as much as it
wants, but we don't want to combine two separated things. Like you
said, udc driver can implement 'get_charger_type()' callback to check
the charger type at the right time, then set the current after
checking the charger type (now the gadget has been set configuration).

>
>> >
>> > - Third, since composite driver covers 500mA (and more for CDP) after set
>> > configuration and 2mA after suspend, and vbus handler covers connect
>> > and disconnect. I can't see any reasons we need to notify gadget state
>> > for power driver, do we really need to have usb_charger_plug_by_gadget?
>>
>> In some solutions, gadget does not negotiate with the current. They
>> just send out one signal to power driver to set the current when the
>> gadget state is changed (plugin or not). So we need to check the
>> charger state by the gadget state to notify the charger IC to set
>> current.
>>
>
> Would you give some examples?

OK. I explain it in detail. Now charger detection can be from gadget
itself or PMIC, and we focus on gadget detection. Charger IC (charger
driver) is separate with gadget.
When the usb cable is plugin, we need to report the plugin event to
charger driver to set current after setting configuration for gadget.
The usb charger is responsible for reporting plugin event to charger
driver. But how usb charger get the plugin event? It can get the
plugin event from gadget state (if the gadget state is more than
'USB_STATE_ATTACHED', it means one cable plugin). So we need notify
gadget state to usb charger.

>
> --
> Best Regards,
> Peter Chen



-- 
Baolin.wang
Best Regards
