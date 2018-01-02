From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/3] phy: core: Move runtime PM reference counting to
 the parent device
Date: Tue, 2 Jan 2018 14:28:14 +0100
Message-ID: <CAPDyKFrrHkhNH6Qr4NJQjPSVh+Ok-wC5-vrY5bi85Jk63Ash0A@mail.gmail.com>
References: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0hmSaWiy9zQPP+0FySySW4yNCm92mTtJ7ebd+rBjjqJng@mail.gmail.com>
 <CAPDyKFpHNYbf3Wz+Hq94Rm_wQGWnQkc6B2cS_RTjkmcbeeZoyw@mail.gmail.com> <1828343.cNA3rGR90B@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:37308 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbeABN2P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 08:28:15 -0500
Received: by mail-io0-f178.google.com with SMTP id n14so25685735iob.4
        for <linux-pm@vger.kernel.org>; Tue, 02 Jan 2018 05:28:15 -0800 (PST)
In-Reply-To: <1828343.cNA3rGR90B@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 24 December 2017 at 13:00, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Saturday, December 23, 2017 4:09:33 PM CET Ulf Hansson wrote:
>> [...]
>>
>> >
>> > So IMO the changes you are proposing make sense regardless of the
>> > genpd issue, because they generally simplify the phy code, but the
>> > additional use_runtime_pm field in struct phy represents redundant
>> > information (manipulating reference counters shouldn't matter if
>> > runtime PM is disabled), so it doesn't appear to be necessary.
>> >
>>
>> Actually, the first version I posted treated the return codes from
>> pm_runtime_get_sync() according to your suggestion above.
>>
>> However, Kishon pointed out that it didn't work. That's because, there
>> are phy provider drivers that enables runtime PM *after* calling
>> phy_create(). And in those cases, that is because they want to treat
>> runtime PM themselves.
>>
>> I think that's probably something we should look into to change, but I
>> find it being a separate issue, that I didn't want to investigate as
>> part of this series.
>>
>> See more about the thread here:
>> https://www.spinics.net/lists/linux-renesas-soc/msg21711.html
>
> Even so, it shouldn't matter when the provider enables runtime PM.
>
> Calling pm_runtime_get_*()/pm_runtime_put_*() should always work as
> long as they are balanced properly regardless of whether or not
> runtime PM is enabled for the device or it is enabled in the meantime.
> Of course, the initial runtime PM status of the device must reflect
> the values of the usage counters, but that should not be too hard to
> ensure.

Yes, this is probably the main reason.

However, as stated, I think we should look into addressing this
problem more carefully, in a separate next step.

>
> The reason why it matters here is because the phy core tries to be smart
> about manipulating reference counters by itself and that's a mistake.
>
> So it looks to me like the whole thing needs to be reworked and yes,
> that should be done in the first place IMO, because it will make the
> issue with genpd go away automatically.

Sorry, but I am not fully understanding what you suggest here. Perhaps
you didn't check patch2?

>
> [Why is phy_pm_runtime_get() there at all, for instance?  It seems
> to have no users and I kind of don't see use cases for it.  Also
> phy_pm_runtime_get_sync() is only used by the phy core in three
> places - shouldn't be too hard to fix that.]

Removing these APIs and functions is done in patch2, so I guess I am
already doing what you suggests above? No?

[...]

Kind regards
Uffe
