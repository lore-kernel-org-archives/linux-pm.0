From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v9 1/4] gadget: Introduce the usb charger framework
Date: Thu, 7 Apr 2016 14:11:19 +0800
Message-ID: <CAMz4ku+_H6HXdAv2gRFfNHz7qrmSwyfO6ir44rDt-tCsEyiVEA@mail.gmail.com>
References: <cover.1459494743.git.baolin.wang@linaro.org>
	<6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org>
	<20160406072513.GB21101@shlinux2.ap.freescale.net>
	<87vb3v2nm8.fsf@intel.com>
	<20160406074310.GC21101@shlinux2.ap.freescale.net>
	<87shyz2md5.fsf@intel.com>
	<20160406081006.GD21101@shlinux2.ap.freescale.net>
	<87k2kb2fwd.fsf@intel.com>
	<20160407023925.GA10672@shlinux2.ap.freescale.net>
	<87bn5m10fh.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36460 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbcDGGLU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 02:11:20 -0400
Received: by mail-yw0-f182.google.com with SMTP id g3so84806229ywa.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 23:11:20 -0700 (PDT)
In-Reply-To: <87bn5m10fh.fsf@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Peter Chen <hzpeterchen@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On 7 April 2016 at 12:56, Felipe Balbi <balbi@kernel.org> wrote:
>
> Hi,
>
> Peter Chen <hzpeterchen@gmail.com> writes:
>> On Wed, Apr 06, 2016 at 01:25:06PM +0300, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Peter Chen <hzpeterchen@gmail.com> writes:
>>> > On Wed, Apr 06, 2016 at 11:05:26AM +0300, Felipe Balbi wrote:
>>> >> Peter Chen <hzpeterchen@gmail.com> writes:
>>> >> > On Wed, Apr 06, 2016 at 10:38:23AM +0300, Felipe Balbi wrote:
>>> >> >> Peter Chen <hzpeterchen@gmail.com> writes:
>>> >> >> > On Fri, Apr 01, 2016 at 03:21:49PM +0800, Baolin Wang wrote:
>>> >> >> >  +
>>> >> >> >> +static struct attribute *usb_charger_attrs[] = {
>>> >> >> >> +   &dev_attr_sdp_current.attr,
>>> >> >> >> +   &dev_attr_dcp_current.attr,
>>> >> >> >> +   &dev_attr_cdp_current.attr,
>>> >> >> >> +   &dev_attr_aca_current.attr,
>>> >> >> >> +   &dev_attr_charger_type.attr,
>>> >> >> >> +   &dev_attr_charger_state.attr,
>>> >> >> >> +   NULL
>>> >> >> >> +};
>>> >> >> >
>>> >> >> > The user may only care about current limit, type and state, why they
>>> >> >> > need to care what type's current limit, it is the usb charger
>>> >> >> > framework handles, the framework judge the current according to
>>> >> >> > charger type and USB state (connect/configured/suspended).
>>> >> >>
>>> >> >> it might be useful if we want to know that $this charger doesn't really
>>> >> >> give us as much current as it advertises.
>>> >> >>
>>> >> >
>>> >> > As my understanding, the current limit is dynamic value, it should
>>> >> > report the value the charger supports now, eg, it connects SDP, but
>>> >> > the host is suspended now, then the value should be 2mA.
>>> >>
>>> >> yes, and that's the limit. Now consider we connect to DCP or CDP and
>>> >> limit is 2000mA but we're charging at 1000mA ;-)
>>> >>
>>> >
>>> > Does the user need to know the $this charger limit? Don't they only
>>> > care about the current charging value? I have a USB cable which can
>>>
>>> Why not ? UI might want to change the color of the battery charging icon
>>> if we're charging @ 2000mA or @ 1000mA to give some visual feedback as
>>> to "how fast" battery is supposed to be charged.
>>>
>>> > show charging current value, it changes from time to time, when it
>>> > connects to host pc, it shows 430mA; when it connects to dedicated
>>> > charger, it shows 1000mA.
>>>
>>> good for you, now what does that have to do with $subject ?
>>>
>>
>> +static struct attribute *usb_charger_attrs[] = {
>> +     &dev_attr_sdp_current.attr,
>> +     &dev_attr_dcp_current.attr,
>> +     &dev_attr_cdp_current.attr,
>> +     &dev_attr_aca_current.attr,
>> +     &dev_attr_charger_type.attr,
>> +     &dev_attr_charger_state.attr,
>> +     NULL
>> +};
>>
>> Ok, even the users are interesting in current limit, we still have no
>> necessary to know all kinds of chargers limit and current value, since
>> we already have charger type user interface, the framework can show
>> limit according to charger type.
>
> Oh, now I get your comment and I totally agree. We already *know* the
> detected charger type, there's no point in showing them all.
>
>> I think below user interfaces are enough, who do you think?
>>
>> +static struct attribute *usb_charger_attrs[] = {
>> +     &dev_attr_current.attr,
>> +     &dev_attr_current_limit.attr,
>> +     &dev_attr_charger_type.attr,
>> +     &dev_attr_charger_state.attr,
>> +     NULL
>> +};
>
> agreed, const though.

OK. Thanks for Felipe, Peter and Jun's suggestion. I'll modify it in
next version.

>
> --
> balbi



-- 
Baolin.wang
Best Regards
