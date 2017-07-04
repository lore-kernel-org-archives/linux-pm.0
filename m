From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 2/8] PM / Domains: Handle safely genpd_syscore_switch()
 call on non-genpd device
Date: Tue, 4 Jul 2017 20:19:47 +0200
Message-ID: <CAMuHMdWOLPViLB5+y90HKChT0y7+zFtinp3R6as26ugo8N1bBQ@mail.gmail.com>
References: <20170628145623.20716-1-krzk@kernel.org> <20170628145623.20716-3-krzk@kernel.org>
 <CAMuHMdXNAT6dW6Q_=_ZTUwiRmF0CpWXGfK0wYDgETT0xbTdZTA@mail.gmail.com> <20170704181011.zcialijxnyucwzry@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170704181011.zcialijxnyucwzry@kozik-lap>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On Tue, Jul 4, 2017 at 8:10 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, Jul 04, 2017 at 03:01:15PM +0200, Geert Uytterhoeven wrote:
>> On Wed, Jun 28, 2017 at 4:56 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> > genpd_syscore_switch() had two problems:
>> > 1. It silently assumed that device, it is being called for, belongs to
>> >    generic power domain and used container_of() on its power domain
>> >    pointer.  Such assumption might not be true always.
>> >
>> > 2. It iterated over list of generic power domains without holding
>> >    gpd_list_lock mutex thus list could have been modified in the same
>> >    time.
>> >
>> > Usage of genpd_lookup_dev() solves both problems as it is safe a call
>> > for non-generic power domains and uses mutex when iterating.
>> >
>> > Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> This is commit 8b55e55ee44356d6 in pm/linux-next, also part of the pull
>> request "[GIT PULL] Power management updates for v4.13-rc1".
>>
>> > Not tested on real hardware.
>>
>> This causes the following BUG during s2ram on all my Renesas arm32 boards,
>> where the system timer is an IRQ safe device:
>>
>> PM: Syncing filesystems ... done.
>> PM: Preparing system for sleep (mem)
>> Freezing user space processes ... (elapsed 0.001 seconds) done.
>> OOM killer disabled.
>> Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>> PM: Suspending system (mem)
>> PM: suspend of devices complete after 122.841 msecs
>> PM: suspend devices took 0.130 seconds
>> PM: late suspend of devices complete after 2.682 msecs
>> PM: noirq suspend of devices complete after 29.951 msecs
>> Disabling non-boot CPUs ...
>> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:238
>
> Thanks for report!
>
> Damn it, although I couldn't find this in the code, but I was fearing
> that this ends up in atomic section. That would kind of explain why
> mutex was not there [1].
>
> Anyway, the buggy code was there already. Instead of "sleeping in atomic
> section" there was no locking at all... In this context this was
> probably safe because it was executed *after* disabling non-boot CPUs
> but then the function cannot be called in other contexts.
>
> I am not sure I will be capable of developing the proper fix as I do not
> have the hardware and I do not know all stuff happening in sh suspend.
> Probably reverting this and living with non-locked path would be the
> safest choice.
>
> [1] https://patchwork.kernel.org/patch/9778903/

AFAIU, all syscore stuff runs in atomic context.

Don't worry, you're not the only one.
This bug report was almost 100% the same as an earlier one for a patch
from Ulf ;-)
(cfr. "[RESEND PATCH 0/2] PM / Domains: Fix asynchronous execution of
*noirq() callbacks")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
