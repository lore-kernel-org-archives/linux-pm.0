From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / QoS: Fix default runtime_pm device resume latency
Date: Tue, 31 Oct 2017 14:09:20 +0100
Message-ID: <CAMuHMdVKh9n4aep+niyYYEA_4cNrB4+BfGWrJ3WLpej1me114w@mail.gmail.com>
References: <1509347446-26105-1-git-send-email-t-kristo@ti.com>
 <CAJZ5v0i8HMDfV907QDTD54YPaFpoBLVt+R4oeQ704+9_C8APoA@mail.gmail.com> <3227682.nATp9NGxKU@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:51867 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbdJaNJV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2017 09:09:21 -0400
In-Reply-To: <3227682.nATp9NGxKU@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tero Kristo <t-kristo@ti.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Rafael, Tero,

On Tue, Oct 31, 2017 at 12:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, October 30, 2017 11:19:08 AM CET Rafael J. Wysocki wrote:
>> On Mon, Oct 30, 2017 at 8:10 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> > The recent change to the PM QoS framework to introduce a proper
>> > no constraint value overlooked to handle the devices which don't
>> > implement PM QoS OPS. Runtime PM is one of the more severely
>> > impacted subsystems, failing every attempt to runtime suspend
>> > a device. This leads into some nasty second level issues like
>> > probe failures and increased power consumption among other things.
>>
>> Oh, that's bad.
>>
>> Sorry about breaking it and thanks for the fix!
>>
>> > Fix this by adding a proper return value for devices that don't
>> > implement PM QoS implicitly.
>> >
>> > Fixes: 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")
>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Applied.
>
> And pushed to Linus.

I'm afraid it is not sufficient.

Commit 0cc2b4e5a020fc7f ("PM / QoS: Fix device resume latency PM QoS")
introduced two issues on Renesas platforms:
 1. After boot up, many devices have changed their state from "suspended"
    to "active", according to /sys/kernel/debug/pm_genpd/pm_genpd_summary
    (comparing that file across boots is one of my standard tests).
    Interestingly, doing a system suspend/resume cycle restores their state
    to "suspended".

 2. During system suspend, the following warning is printed on
    r8a7791/koelsch:

        i2c-rcar e6530000.i2c: runtime PM trying to suspend device but
active child

Commit 2a9a86d5c81389cd ("PM / QoS: Fix default runtime_pm device resume
latency") fixes the second issue, but not the first.

Reverting commits 2a9a86d5c81389cd ("PM / QoS: Fix default runtime_pm
device resume latency") and 0cc2b4e5a020fc7f ("PM / QoS: Fix device resume
latency PM QoS") fixes both.

Do you have a clue?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
