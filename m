From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Drivers taking different actions depending on sleep state
Date: Sat, 10 Jun 2017 00:53:54 +0200
Message-ID: <CAJZ5v0iL7voAz9T+36fXXncOj4UrFSAH8WzwEbec96GuFUteaQ@mail.gmail.com>
References: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35492 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdFIWxz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2017 18:53:55 -0400
Received: by mail-io0-f173.google.com with SMTP id k93so38862309ioi.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Jun 2017 15:53:55 -0700 (PDT)
In-Reply-To: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>

Hi,

On Fri, Jun 9, 2017 at 5:20 PM, Mason <slash.tmp@free.fr> wrote:
> Hello,
>
> I read the "Sleep States" documentation:
> https://www.kernel.org/doc/Documentation/power/states.txt
>
> It mentions /sys/power/mem_sleep but I don't have that in 4.9
> # ll /sys/power/
> -rw-r--r--    1 root     root          4096 Jan  1 00:31 pm_async
> -rw-r--r--    1 root     root          4096 Jan  1 00:31 pm_freeze_timeout
> -rw-r--r--    1 root     root          4096 Jan  1 00:31 state
> -rw-r--r--    1 root     root          4096 Jan  1 00:31 wakeup_count
>
> # cat /sys/power/state
> freeze mem
>
> Currently my platform's "mem" is a true suspend-to-RAM trigger,
> where drivers are supposed to save their state (register values
> will be lost), then Linux hands control over to firmware which
> enables RAM self-refresh and powers the chip down. When the system
> resumes, drivers restore their state from their copy in memory.
>
> One driver is responsible for loading/unloading microcode running
> on the DSPs. This operation is required only when powering down
> the chip, but it should be avoided for "low-latency" sleeps.
>
> The problem is that, if I understand correctly, drivers have no way
> of knowing which sleep state is being entered/exited?
>
> How can I have the microcode driver take different decisions
> based on the sleep state?

The cleanest way would be to run that code from one of the platform
suspend hooks that receive information on what sleep state is to be
entered.

Alternatively, those hooks can set/clear flags that can be accessed by
drivers, but that of course may your drivers depend on the platform
(still, in the microcode case the driver seems to be
platform-dependent anyway).

Thanks,
Rafael
