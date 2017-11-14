From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Tue, 14 Nov 2017 10:13:29 +0100
Message-ID: <CAPDyKFrzJuWVr9hmcU-S6LMMGTh2pyQcjMJc2+ky5AmctatOLQ@mail.gmail.com>
References: <1713438.irjm9MTSvo@aspire.rjw.lan> <CAPDyKFp9Cqh3NOCMoT1d2R__yYynDBQ48OvfOLAfRQ_-Z9QfeQ@mail.gmail.com>
 <7259587.Kcyqf0xrP6@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:55201 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbdKNJNa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 04:13:30 -0500
Received: by mail-it0-f45.google.com with SMTP id b5so6469865itc.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2017 01:13:29 -0800 (PST)
In-Reply-To: <7259587.Kcyqf0xrP6@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linus Walleij <linus.walleij@linaro.org>

On 13 November 2017 at 22:50, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, November 13, 2017 2:26:28 PM CET Ulf Hansson wrote:
>> On 12 November 2017 at 01:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > The check for "active" children in __pm_runtime_set_status(), when
>> > trying to set the parent device status to "suspended", doesn't
>> > really make sense, because in fact it is not invalid to set the
>> > status of a device with runtime PM disabled to "suspended" in any
>> > case.  It is invalid to enable runtime PM for a device with its
>> > status set to "suspended" while its child_count reference counter
>> > is nonzero, but the check in __pm_runtime_set_status() doesn't
>> > really cover that situation.
>>
>> The reason to why I changed this in commit a8636c89648a ("PM /
>> Runtime: Don't allow to suspend a device with an active child") was
>> because to get a consistent behavior.
>
> Well, it causes the function to return an error in a non-error situation,
> which IMnsHO is a bug.
>
>> Because, setting the device's status to active (RPM_ACTIVE) via
>> __pm_runtime_set_status(), requires its parent to also be active (in
>> case the parent has runtime PM enabled).
>
> No!!!
>
> The check is in there, because the parent's usage_count is affected by that
> code and incrementing it in case the parent has runtime PM enabled and is
> RPM_SUSPENDED leads to an inconsistent runtime PM state of the parent.  IOW,
> it would confuse the framework.

Right, I do understand the reasons *why* it is like this.

>
> There's no such issue if the runtime PM status of a child is set to RPM_SUSPENDED.
>
> It is all consistent without the check I'm removing and is made inconsistent
> by that very check.
>
>> I would prefer to try maintain this consistency, but I also I realize
>> that commit a8636c89648a, should also have been checking if the parent
>> has runtime PM enabled (again for consistency), which it doesn't.
>>
>> What about fixing that instead?
>
> Runtime PM is *disabled* for the parent at this point, guaranteed, so there's
> nothing to check, I'm afraid ...

Where and how is that guarantee made?

[...]

Kind regards
Uffe
