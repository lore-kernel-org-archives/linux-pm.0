From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
Date: Tue, 21 Feb 2017 17:23:48 +0100
Message-ID: <CAMuHMdUAcRVLzDZCZucAt0agGZynQtqhWeh7yPaBrogCYhRW4g@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be> <08c5dcf3-9d7c-33ff-f801-8f94f630f49b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <08c5dcf3-9d7c-33ff-f801-8f94f630f49b@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

On Tue, Feb 21, 2017 at 11:42 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 20/02/17 20:33, Geert Uytterhoeven wrote:
>> Enable support for "shallow" suspend mode, also known as "Standby" or
>> "Power-On Suspend".
>>
>> As secondary CPU cores are taken offline, "shallow" suspend mode saves
>> slightly more power than "s2idle", but less than "deep" suspend mode.
>> However, unlike "deep" suspend mode, "shallow" suspend mode can be used
>> regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
>> an optional API in PSCI v1.0.
>>
>> List the available system suspend modes:
>>
>>     $ cat /sys/power/mem_sleep
>>     s2idle shallow [deep]
>>
>> Suspend to "shallow" mode:
>>
>>     $ echo shallow > /sys/power/mem_sleep
>>     $ echo mem > /sys/power/state
>>
>
> I don't have the links to such previous attempts handy, but we have

Don't worry, I did read earlier discussions about implementing shallow mode.

> more elegant alternative options(suspend-to-idle) and any such attempts
> to hack around the PSCI will be NACKed.

"s2idle" does not power down secondary CPU cores, so this is an improvement.
"deep" may not support configured wake-up sources, which is a bug.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
