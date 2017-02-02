From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Correct comment in irq_safe_dev_in_no_sleep_domain()
Date: Thu, 2 Feb 2017 10:55:51 +0100
Message-ID: <CAPDyKFoF4wCSyUMrL_by-p3Oqkx=D1ySOH5CSO321CVyTX-oNQ@mail.gmail.com>
References: <1485878463-1672-1-git-send-email-ulf.hansson@linaro.org>
 <CAMuHMdXRvOTKCdvwy5JZM6RhSifse_goHubZq4FaMcOFE7x99g@mail.gmail.com>
 <CAPDyKFrUqDdFrHCLnEEOq5N9QCnoG_9eP_BD4yb9ccweyBLMog@mail.gmail.com> <CAMuHMdVvqUzU37vpcy9W=CFgzkemyq4jTW8bAFhWzojkyDpcPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35623 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbdBBJzx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2017 04:55:53 -0500
Received: by mail-wm0-f50.google.com with SMTP id b65so82160340wmf.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2017 01:55:52 -0800 (PST)
In-Reply-To: <CAMuHMdVvqUzU37vpcy9W=CFgzkemyq4jTW8bAFhWzojkyDpcPg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>

On 31 January 2017 at 18:17, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Tue, Jan 31, 2017 at 5:41 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 31 January 2017 at 17:17, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> On Tue, Jan 31, 2017 at 5:01 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> The earlier comment stated that the dev_warn_once() was going to be printed
>>>> once per device. Let's fix that, as dev_warn_once() is printed only once,
>>>> no matter of the device.
>>>
>>> While I agree this makes the comment match the code, I think we would serve
>>> the users better by printing the warning once per PM domain.
>>> Currently the user cannot know if two or more PM domains cannot be powered
>>> off due to IRQ safe devices.
>>
>> Right.
>>
>>> Perhaps a flag can be added to generic_pm_domain.flags to remember
>>> that the warning has been printed before?
>>
>> That seems like a reasonable adjustment. Allow me to cook a patch on
>> top of this one.
>
> Thanks!
>
>> Moreover, I was thinking of considering to check for always on domains
>> and perhaps skip printing this message in such cases. Would that make
>> sense as well?
>
> That would make sense.
>
> But how would you check that?
> By comparing its governor with &pm_domain_always_on_gov?
> Note that that is not sufficient, as I think its power_off() callback will still
> be called. Only if it fails to power off and returns -EBUSY, it's a real
> always-on domain.

Hi Geert,

Correct! At this point, I am looking into how I in general can improve
the code in genpd dealing with always on PM domains.

It seems like the genpd client, shouldn't need to implement the
->power_off|on() callbacks at all, but instead just configure the
genpd at init time as an always on PM domain.

Then that information can be used in genpd at various places, to do
optimizations and likely to avoid printing non-needed errors/warnings.
I keep you posted.

Kind regards
Uffe
