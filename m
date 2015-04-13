From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] [RFC] PM / Domains: add multiple states
Date: Mon, 13 Apr 2015 15:25:29 +0200
Message-ID: <CAPDyKFrjzF0cmvCXo7PqJ6zhLJ+DPBimtekvANDzoZgLRbuS-Q@mail.gmail.com>
References: <1428507725-12205-1-git-send-email-ahaslam@baylibre.com>
	<1428507725-12205-2-git-send-email-ahaslam@baylibre.com>
	<CAPDyKFoSvY=G7PQ5EnacTDfmuxYw398A0h_TV--6E9exXJv-cg@mail.gmail.com>
	<552B9BAD.9050809@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36448 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbbDMNZa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2015 09:25:30 -0400
Received: by oift201 with SMTP id t201so3647860oif.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2015 06:25:29 -0700 (PDT)
In-Reply-To: <552B9BAD.9050809@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>

Hi Axel,

On 13 April 2015 at 12:34, Axel Haslam <ahaslam@baylibre.com> wrote:
> Hi Uffe,
>
>
> On 10/04/2015 12:24, Ulf Hansson wrote:
>>
>> On 8 April 2015 at 17:42,  <ahaslam@baylibre.com> wrote:
>>>
>>> From: Axel Haslam <ahaslam@baylibre.com>
>
>
>>>
>>>          .state_count = 3,
>>>          .dev_ops.start = dev_callback_start,
>>>          .dev_ops.stop = dev_callback_stop,
>>
>>
>> I would like to get the complete picture.
>>
>> Could you elaborate on what theese two callbacks will be doing in your
>> case?
>
>
> The idea is to add support to platforms where a power domain can be put into
> intermediate low power modes (retention), and not just on or off. context
> may be lost for only a subset of registers depending on how deep the
> retantion state is. Also the wakeup/sleep latency
> would differ. a  device constraint may not allow for a domain to go to off,
> but it may allow a Retention state.

These registers you are talking about, are those coupled with the PM
domain and/or the actual devices within the PM domain?

Normally, save/restore of device's registers are handled from
driver's/subsystem's (bus) runtime PM callbacks and not from the PM
domain. That's why I wonder about the details.

>
> I tested the patch using a dummy driver that would register several devices,
> and genpds, some of them would be subdomains, so that i could test if the
> most restrictive constraint on a genpd was respected.
> in my case these callbacks are not doing anything.
>
>
>>
>>>          .dev_ops.save_state = dev_callback_save,
>>>          .dev_ops.restore_state = dev_callback_restore,
>>
>>
>> ...and some more information about these as well, please.
>
>
> im not sure i understood these functions correctly.
>
> my thought is that the arch would implement these functions to
> save/restore the registers it needs for a given power domain.
> i added an extra argument to save and restore so the implementation
> would use this information to decide what is needed to save and restore.

As default genpd assigns these callbacks to
pm_genpd_default_save|restore_state().

This is a simplified description of what they do:

When all devices within a PM domain is "idle" (no runtime PM reference
count exists for any device within the PM domain),
pm_genpd_default_save() will be invoked to have it walk the hierarchy
of the runtime PM suspend callbacks. The one picked, will then have to
deal with saving register context and other necessary operations to
put the device into low power state.

Vice verse happens for pm_genpd_default_restore_state().

>
> again these were on my dummy driver, so they are not
> doing anything, in my case.
>

 [...]

>>> +static int pm_genpd_default_restore_state(struct device *dev, int state)
>>
>>
>> Why change this?
>
>
>
> so that the driver can save or not context depending on what state is beeing
> entered. also, there may be a subset of registers to save. but again, im not
> sure this was the intended purpose of these functions.
> i could not find examples of someone that uses them.

Then I first think you need to consider how to propagate this state to
the driver, because there are no way of doing that today.

[...]

Kind regards
Uffe
