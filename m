From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Drivers taking different actions depending on sleep state
Date: Thu, 22 Jun 2017 18:09:52 +0200
Message-ID: <CAJZ5v0i0HBXG_Ocipf86PuKTdSM_g3aQoV7OZ-a977GVXJykFg@mail.gmail.com>
References: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr> <CAJZ5v0iL7voAz9T+36fXXncOj4UrFSAH8WzwEbec96GuFUteaQ@mail.gmail.com>
 <ccac39d6-4611-8b46-12f7-24227ef3b35e@gmail.com> <CAJZ5v0g_egRwxOLqft=JhvzAqBWuyvC8yiO7De5TYUZLUT2Fpw@mail.gmail.com>
 <7001768d-9134-4975-127e-e8444e00f677@gmail.com> <CAJZ5v0ihqn5Xcj1yoZcrb7caYiH+x8YivLJit6BqvDGradZJ=Q@mail.gmail.com>
 <b7a49925-d823-b03d-2990-2894ba2c2714@gmail.com> <CAJZ5v0hzkVwf1HkH4GLbAeK7iJ_7V1UXHErruuvMVEpb5MqZ3Q@mail.gmail.com>
 <6a4d18d9-2494-e35c-d209-a019292d6648@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36294 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbdFVQJx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jun 2017 12:09:53 -0400
Received: by mail-io0-f172.google.com with SMTP id e63so16947947iod.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Jun 2017 09:09:53 -0700 (PDT)
In-Reply-To: <6a4d18d9-2494-e35c-d209-a019292d6648@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mason <slash.tmp@free.fr>, Ulf Hansson <ulf.hansson@linaro.org>, JB <jb_lescher@sigmadesigns.com>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>

On Thu, Jun 22, 2017 at 5:18 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
> On 06/21/2017 05:03 PM, Rafael J. Wysocki wrote:
>> On Thu, Jun 22, 2017 at 1:55 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> On 06/21/2017 03:57 PM, Rafael J. Wysocki wrote:
>>>> On Thu, Jun 22, 2017 at 12:48 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>> On 06/21/2017 02:59 PM, Rafael J. Wysocki wrote:
>>>>>> On Wed, Jun 21, 2017 at 11:16 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>>>> On 06/09/2017 03:53 PM, Rafael J. Wysocki wrote:

[cut]

>
> For the reasons explained before, if the same set of drivers need to
> deal with one or more platform_suspend_ops driver, say a classic
> homegrown one, and one that is ACPI/ARM SCPI based for instance, we
> would have to sprinkle checks like these in the driver:
>
> static int drv_suspend(struct device *d)
> {
>         if (platform_suspend_get_state() == PM_SUSPEND_STANDBY ||
>             acpi_target_system_state() == XXXX |
>
>
> and so on and so forth, that does not seem to scale horizontally.
>
>>
>> ACPI has acpi_target_system_state() for this very purpose, for example.
>>
>>> If this seems acceptable to you along with proper documentation to
>>> illustrate the platform specific meaning of these states, I will got
>>> ahead and cook a patch.
>>
>> I wouldn't like platform-specific things to pretend that they are generic.
>
> Would a notifier model be more appropriate perhaps? The mechanism by
> which the notifications get registered to and signaled can be made
> generic, the exact information however would be inherently
> platform_suspend_ops specific, and only the relevant drivers that need
> to subscribe to that kind of information would do that.

Please see the message I've just sent in this thread. :-)

Thanks,
Rafael
