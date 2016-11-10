From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Thu, 10 Nov 2016 17:42:01 +0800
Message-ID: <CAMz4ku+qY4U7=v5nEBEdPTjwki8j10jYbQuokz785NEy5SzYmg@mail.gmail.com>
References: <cover.1476780088.git.baolin.wang@linaro.org> <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com>
 <87k2cttptn.fsf@notabene.neil.brown.name> <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com>
 <87a8dls7yn.fsf@notabene.neil.brown.name> <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com>
 <871sytqrqh.fsf@notabene.neil.brown.name> <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com>
 <87a8dbni27.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:32930 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754409AbcKJJmD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 04:42:03 -0500
Received: by mail-yw0-f171.google.com with SMTP id r204so233499468ywb.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2016 01:42:02 -0800 (PST)
In-Reply-To: <87a8dbni27.fsf@notabene.neil.brown.name>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>

Hi

On 8 November 2016 at 04:36, NeilBrown <neilb@suse.com> wrote:
> On Mon, Nov 07 2016, Baolin Wang wrote:
>
>> On 3 November 2016 at 09:25, NeilBrown <neilb@suse.com> wrote:
>>> On Tue, Nov 01 2016, Baolin Wang wrote:
>>
>> I agree with your most opinions, but these are optimization.
>
> I see them as bug fixes, not optimizations.
>
>>                                                              Firstly I
>> think we should upstream the USB charger driver.
>
> I think you missed the point.  The point is that we don't *need* your
> "USB charger driver" because all the infrastructure we need is *already*
> present in the kernel.  It is buggy and not used uniformly, and could
> usefully be polished and improved.  But the structure is already
> present.
>
> If everyone just added new infrastructure when they didn't like, or
> didn't understand, what was already present, the kernel would become
> like the Mad Hatter's tea party, full of dirty dishes.
>
>>                                                  What I want to ask is
>> how can we notify power driver if we don't set the
>> usb_register_notifier(), then I think you give the answer is: power
>> driver can register by 'struct usb_phy->notifier'. But why usb phy
>> should notify the power driver how much current should be drawn, and I
>> still think we should notify the current in usb charger driver which
>> is better, and do not need to notify current for power driver in usb
>> phy driver.
>
> I accept that it isn't clear that the phy *should* be involved in
> communicating the negotiated power availability, but nor is it clear
> that it shouldn't.  The power does travel through the physical
> interface, so physically it plays a role.
>
> But more importantly, it already *does* get told (in some cases).
> There is an interface "usb_phy_set_power()" which exists explicitly to
> tell the phy what power has been negotiated.  Given that infrastructure
> exists and works, it make sense to use it.
>
> If you think it is a broken design and should be removed, then fine:
> make a case for that.  Examine the history.  Make sure you know why it
> is there (or make sure that information cannot be found), and then
> present a case as to why it should be removed and replaced with
> something else.  But don't just leave it there and pretend it doesn't
> exist and create something similar-but-different and hope people will
> know why yours is better.  That way lies madness.

Like Peter said, it is not only PHY can detect the USB charger type,
which means there are other places can detect the charger type.
Second, some controller need to detect the charger type manually which
USB phy did not support. Third, it did not handle what current should
be drawn in USB phy. Fourth, we need integrate all charger plugin/out
event in one framework, not from extcon, maybe type-c in future. In a
word, we need one standard integration of this feature we need, though
like you said we should do some clean up or fix to make it better.

-- 
Baolin.wang
Best Regards
