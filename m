From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 2/2] PM / QoS: Fix device resume latency framework
Date: Fri, 10 Nov 2017 09:03:15 +0100
Message-ID: <CAMuHMdXZbXt2wP6=iZYL1ev_p8+H=3RDoTB9M4jkwp0muEXqgg@mail.gmail.com>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan> <2941273.uOhv3ydaDP@aspire.rjw.lan>
 <3598777.oHhnkmKSmP@aspire.rjw.lan> <5398562.D1bMImPBRK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:48032 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbdKJIDR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Nov 2017 03:03:17 -0500
In-Reply-To: <5398562.D1bMImPBRK@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tero Kristo <t-kristo@ti.com>, Reinette Chatre <reinette.chatre@intel.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>

Hi Rafael,

On Tue, Nov 7, 2017 at 11:33 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The special value of 0 for device resume latency PM QoS means
> "no restriction", but there are two problems with that.
>
> First, device resume latency PM QoS requests with 0 as the
> value are always put in front of requests with positive
> values in the priority lists used internally by the PM QoS
> framework, causing 0 to be chosen as an effective constraint
> value.  However, that 0 is then interpreted as "no restriction"
> effectively overriding the other requests with specific
> restrictions which is incorrect.
>
> Second, the users of device resume latency PM QoS have no
> way to specify that *any* resume latency at all should be
> avoided, which is an artificial limitation in general.
>
> To address these issues, modify device resume latency PM QoS to
> use S32_MAX as the "no constraint" value and 0 as the "no
> latency at all" one and rework its users (the cpuidle menu
> governor, the genpd QoS governor and the runtime PM framework)
> to follow these changes.
>
> Also add a special "n/a" value to the corresponding user space I/F
> to allow user space to indicate that it cannot accept any resume
> latencies at all for the given device.
>
> Fixes: 85dc0b8a4019 (PM / QoS: Make it possible to expose PM QoS latency constraints)
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=197323
> Reported-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
> As noticed by Ramesh, the v3 had issues with an overlooked value
> conversion and a stale comment, so here goes a v4.

JFTR, with v4, the WARN_ON() is no longer triggered when waking up
r8a7740/armadillo or sh73a0/kzm9g by tapping the touchscreen.

I hadn't reported that before, as I only noticed it with v2 after you had
already posted newer versions, so I wanted to try those first.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
