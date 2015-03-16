From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] cpuidle: 4.0-rc3 fixes
Date: Mon, 16 Mar 2015 10:24:27 +0100
Message-ID: <CAMuHMdWtu3f9S0aXGGdnoO4JSu+9FN1zvEO6goWGSo3wEbQXrQ@mail.gmail.com>
References: <55032186.3000306@linaro.org>
	<2429393.iDkfxR0R07@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2429393.iDkfxR0R07@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Sebastien Rannou <mxs@sbrk.org>, Gregory Clement <gregory.clement@free-electrons.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Fri, Mar 13, 2015 at 10:56 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, March 13, 2015 06:42:30 PM Daniel Lezcano wrote:
>> this pull request contains a couple of fixes:
>>
>>   - Fix the cpu_pm_enter/exit symmetry in the mvebu driver (Gregory Clement)
>>
>>   - Fix the mvebu drivers latency/residency values to reach an
>> acceptable tradeoff between perf / power (Sebastian Rannou)
>>
>> Thanks !
>
> Pulled, but this is a bit too late for 4.0-rc4, so I'll queue it up for -rc5.

Please note commit 43b68879de27b199 ("cpuidle: mvebu: Fix the CPU PM
notifier usage") has a "Cc: stable@vger.kernel.org" tag.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
