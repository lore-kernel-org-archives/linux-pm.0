From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] PM / core: Invent a WAKEUP_POWERED driver flag
Date: Thu, 9 Nov 2017 17:31:10 +0100
Message-ID: <CAJZ5v0i9Qa4K-=UfC_zuZgWrP3=1r3pfdQ1e-AqNttze8utKFw@mail.gmail.com>
References: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org>
 <CAMuHMdUu6=zuCRBaON4K9ivG8bdV1xBuf4dCvPUr2JCL-=xC=w@mail.gmail.com>
 <CAPDyKFqeEZT631g=x_LTU+Dba=WAhM9YOHYfdsSYo+kJz7HtkQ@mail.gmail.com>
 <CAMuHMdX-MX-H0LKR68KLf4Ypp0ZBvV4sBEf8mv8DSNbe0VuGTg@mail.gmail.com>
 <CAPDyKFpY24tn7zZK8A+XzSvTXLa7s_o93sO+yH5Rkae8KmvrXA@mail.gmail.com>
 <CAMuHMdWJ5XXzP7wZ8NJjTaxHMARfcvCkVWev5Z29s077BGbYRA@mail.gmail.com>
 <CAPDyKFp6FYX-dLZJV6oto8Uc8e8KzO18ScTO8SU+8=NGbs7cOg@mail.gmail.com> <CAMuHMdUTX+=SfzivXz5HkgmrxcKB0miYnisBuy3iMtZNABS5KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUTX+=SfzivXz5HkgmrxcKB0miYnisBuy3iMtZNABS5KA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 9, 2017 at 3:41 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Thu, Nov 9, 2017 at 3:28 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> [...]
>>
>>>>> The Ethernet driver can still call device_set_wakeup_enable(... , false)
>>>>> to control this.  If WoL is disabled by the user (or deemed not usable, see
>>>>> below), it already does so.
>>>>
>>>> I don't think that API is intended to be used like that and I wonder
>>>> if it even works as expected.
>>>>
>>>> Quoting the doc:
>>>> "If device wakeup mechanisms are enabled or disabled directly by
>>>> drivers, they also should use :c:func:`device_may_wakeup()` to decide what to do
>>>> during a system sleep transition.  Device drivers, however, are not expected to
>>>> call :c:func:`device_set_wakeup_enable()` directly in any case."
>>>>
>>>> Rafael, can you comment on this?
>>>
>>> There are ca. 100 callers in drivers.
>>
>> Yeah, but those doesn't normally use it to toggle the setting, but
>> instead only to set a default value during ->probe() or whatever
>> initialization code that runs.
>>
>> I think that makes a big difference, doesn't it?
>
> The few Ethernet drivers I looked at change the state in their
> ethtool_ops.set_wol() callback, not during probe.
> This is to be configured from userspace using ethtool.

Which is the case I was talking about.

Since changing the WoL setting via ethtool is expected to cause the
sysfs knob to reflect its status, using device_set_wakeup_enable() in
there is not actually confusing.

The same applies to setting the default from ->probe().

It will be confusing in all of the other cases, though.

Thanks,
Rafael
