From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 20/20] cpufreq: scmi: add support for fast frequency switching
Date: Wed, 8 Nov 2017 12:05:48 +0100
Message-ID: <CAK8P3a03wGUQ+wMsRctuqhN20iBrgLTZOnFqN1k3gCXnwaBtDA@mail.gmail.com>
References: <1509720477-18936-1-git-send-email-sudeep.holla@arm.com>
 <1509720477-18936-21-git-send-email-sudeep.holla@arm.com> <4588325.776kYim3Ci@aspire.rjw.lan>
 <3f79f75f-1b6a-3f7b-b0c0-f970f0fb6c12@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43131 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdKHLFt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2017 06:05:49 -0500
In-Reply-To: <3f79f75f-1b6a-3f7b-b0c0-f970f0fb6c12@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ALKML <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Roy Franz <roy.franz@cavium.com>, Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>, Loc Ho <lho@apm.com>, Ryan Harkin <Ryan.Harkin@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

On Wed, Nov 8, 2017 at 11:42 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 08/11/17 00:24, Rafael J. Wysocki wrote:
>> On Friday, November 3, 2017 3:47:57 PM CET Sudeep Holla wrote:
>>> The cpufreq core provides option for drivers to implement fast_switch
>>> callback which is invoked for frequency switching from interrupt context.
>>>
>>> This patch adds support for fast_switch callback in SCMI cpufreq driver
>>> by making use of polling based SCMI transfer. It also sets the flag
>>> fast_switch_possible.
>>>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>>> Cc: linux-pm@vger.kernel.org
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>> I'm assuming that this material will go in along with the rest of the series
>> through a different tree.
>>
>
> Indeed, I will ask ARM-SoC guys to take it via their tree when ready. I
> assume you are fine with that, please provide ack if that's still the case.

Yes, that makes sense.

      Arnd
