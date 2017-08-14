From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] cpufreq: rcar: Add support for R8A7795 SoC
Date: Mon, 14 Aug 2017 15:36:20 +0200
Message-ID: <CAMuHMdWVYFBOHyBxbOZ7FHu0DHW4vWR9WnxfvwP4yGQGcZf19g@mail.gmail.com>
References: <1501852680-21127-1-git-send-email-horms+renesas@verge.net.au> <20170807033705.GE28857@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170807033705.GE28857@vireshk-i7>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Magnus Damm <magnus.damm@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On Mon, Aug 7, 2017 at 5:37 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 04-08-17, 15:18, Simon Horman wrote:
>> From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
>>
>> After the commit "a399dc9fc50 cpufreq: shmobile: Use generic platdev
>> driver", will use cpufreq-dt-platdev driver to enable cpufreq-dt support.
>> Hence, follow the implementation to support new R8A7795 SoC.
>>
>> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
>>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> This is identical to a patch posted by Khiem last year.
>> At the time it was asked if using opp-v2 was the preferred approach.
>>
>> https://patchwork.kernel.org/patch/9054011/
>>
>> An inspection of the current upstream kernel code seems to indicate
>> that adding a binding as this patch does is compatibile with using opp-v2
>> and I plan to post DTS patches separately which make use of the opp-v2
>> bindings - they depend on this driver change to work.
>>
>> I have provided an integration patch with this patch, those DTS changes,
>> and Renesas clock updates also depended on by the DTS changes. The result
>> is working CPUFreq for the r8a7795 (R-Car H3) ES1.0.
>>
>> If this work is acceptable I plan to follow up with patches to
>> enable CPUFreq on the r8a7796 (R-Car M3-W).
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/r8a7795-cpufreq
>>
>> A description of steps taken to lightly exercise the above can be found here:
>>
>> http://elinux.org/Tests:R-CAR-GEN3-CPUFreq
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index 096aea7fcb67..13b72f3c420b 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -67,6 +67,7 @@ static const struct of_device_id machines[] __initconst = {
>>       { .compatible = "renesas,r8a7792", },
>>       { .compatible = "renesas,r8a7793", },
>>       { .compatible = "renesas,r8a7794", },
>> +     { .compatible = "renesas,r8a7795", },
>>       { .compatible = "renesas,sh73a0", },
>>
>>       { .compatible = "rockchip,rk2928", },
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I'm still a bit confused about your original comment when introducing this
file with the ever-growing table of SoCs:

    "And for new platforms we may do things differently as they are going
     to use opp-v2 bindings."

Hence I was under the impression the growing would be mitigated by new SoCs
using the opp-v2 bindings instead, and not needing an entry in the table.

Perhaps I have misunderstood that comment?

Thanks for the clarification!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
