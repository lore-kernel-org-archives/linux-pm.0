From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFT][PATCH v2 0/2] PM / QoS: Device resume latency framework fix
Date: Mon, 6 Nov 2017 14:46:48 +0100
Message-ID: <CAMuHMdU-BMmznrtR6S+uppWdsiXjWZKwQYemb+_q89r852KFjg@mail.gmail.com>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan> <2520927.XkLgALY3I0@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:57185 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753291AbdKFNqu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2017 08:46:50 -0500
In-Reply-To: <2520927.XkLgALY3I0@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tero Kristo <t-kristo@ti.com>, Reinette Chatre <reinette.chatre@intel.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>

Hi Rafael,

On Fri, Nov 3, 2017 at 12:42 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, November 2, 2017 12:00:27 AM CET Rafael J. Wysocki wrote:
>> This series is a replacement for commit 0cc2b4e5a020 (PM / QoS: Fix device
>> resume latency PM QoS) that had to be reverted due to problems introduced by it.
>>
>> This time the genpd PM QoS governor is first updated to be more consistent
>> and the PM QoS changes are made on top of that which simplifies the second
>> patch quite a bit.
>>
>> This is based on the linux-next branch from linux-pm.git as of now (should
>> also apply to the current mainline just fine).
>>
>> Please test if you can or let me know if you have any comments.
>
> The v2 removes a couple of redundant checks from the first patch (and add
> comments to explain why the checks are not needed) and fixes up the
> "no constraint" value collision with a valid constraint multiplied by
> NSEC_PER_USEC in the second patch.
>
> Please test if possible and let me know about any issues.

With this series, the 3 issues I reported before do not happen.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
