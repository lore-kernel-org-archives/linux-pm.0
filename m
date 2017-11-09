From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] PM / core: Invent a WAKEUP_POWERED driver flag
Date: Thu, 9 Nov 2017 15:28:55 +0100
Message-ID: <CAPDyKFp6FYX-dLZJV6oto8Uc8e8KzO18ScTO8SU+8=NGbs7cOg@mail.gmail.com>
References: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org>
 <CAMuHMdUu6=zuCRBaON4K9ivG8bdV1xBuf4dCvPUr2JCL-=xC=w@mail.gmail.com>
 <CAPDyKFqeEZT631g=x_LTU+Dba=WAhM9YOHYfdsSYo+kJz7HtkQ@mail.gmail.com>
 <CAMuHMdX-MX-H0LKR68KLf4Ypp0ZBvV4sBEf8mv8DSNbe0VuGTg@mail.gmail.com>
 <CAPDyKFpY24tn7zZK8A+XzSvTXLa7s_o93sO+yH5Rkae8KmvrXA@mail.gmail.com> <CAMuHMdWJ5XXzP7wZ8NJjTaxHMARfcvCkVWev5Z29s077BGbYRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:52205 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754957AbdKIO25 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Nov 2017 09:28:57 -0500
Received: by mail-it0-f52.google.com with SMTP id o135so10950292itb.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Nov 2017 06:28:57 -0800 (PST)
In-Reply-To: <CAMuHMdWJ5XXzP7wZ8NJjTaxHMARfcvCkVWev5Z29s077BGbYRA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

[...]

>>> The Ethernet driver can still call device_set_wakeup_enable(... , false)
>>> to control this.  If WoL is disabled by the user (or deemed not usable, see
>>> below), it already does so.
>>
>> I don't think that API is intended to be used like that and I wonder
>> if it even works as expected.
>>
>> Quoting the doc:
>> "If device wakeup mechanisms are enabled or disabled directly by
>> drivers, they also should use :c:func:`device_may_wakeup()` to decide what to do
>> during a system sleep transition.  Device drivers, however, are not expected to
>> call :c:func:`device_set_wakeup_enable()` directly in any case."
>>
>> Rafael, can you comment on this?
>
> There are ca. 100 callers in drivers.

Yeah, but those doesn't normally use it to toggle the setting, but
instead only to set a default value during ->probe() or whatever
initialization code that runs.

I think that makes a big difference, doesn't it?

>
>>> In addition, keeping WoL enabled for cases 1 and 2 may be desirable
>>> (e.g allow wake-up if a cable is plugged in during system suspend and
>>>  a magic packet is received afterwards), depending on the hardware.
>>> But the driver can already control that through device_set_wakeup_enable().
>>
>> Ehh, that sounds weird. :-) If the Ethernet interface is down, how
>> would such packet be received?
>
> It depends on your meaning of "up".  My interpretation is that "up" means
> ready to handle packets between physical media and the Linux networking stack.
>
> So even when "down", the actual Ethernet controller may still be able to
> receive a magic packet if WoL is enabled.  The magic packet is really a
> magic packet not intended to be transmitted to the networking stack, but
> merely serves as a wakeup signal.

I see! So, in the end this seems like a combination of what the HW
supports and what the user policy is set to.

Out of curiosity, can you tell how those Renesas Ethernet devices
works in this regards?

Anyway, thanks for clarifying!

Kind regards
Uffe
