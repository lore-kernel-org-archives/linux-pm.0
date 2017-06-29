From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Clocks used by another OS/CPU (was: Re: [RFC PATCH] clk: renesas:
 cpg-mssr: Add interface for critical core clocks)
Date: Thu, 29 Jun 2017 12:28:11 +0200
Message-ID: <b2328038-64ac-f7e0-d8a9-434f2f0b0300@de.bosch.com>
References: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@baylibre.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29.06.2017 11:27, Geert Uytterhoeven wrote:
> Hi Dirk,
> 
> CC clock, ARM, DT, PM people
> 
> TL;DR: Clocks may be in use by another CPU not running Linux, while Linux
> disables them as being unused.
> 
> On Mon, Jun 26, 2017 at 1:30 PM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>> With commit 72f5df2c2bbb6 ("clk: renesas: cpg-mssr: Migrate to
>> CLK_IS_CRITICAL") we are able to handle critical module clocks.
>> Introduce the same logic for critical core clocks.
>>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>> ---
>> Commit
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/clk/renesas?id=72f5df2c2bbb66d4a555cb51eb9f412abf1af77f
>>
>> is quite nice to avoid *module* clocks being disabled. Unfortunately,
>> there are *core* clocks, too. E.g. using an other OS on the Cortex R7
>> core of the r8a7795, the 'canfd' is a quite popular core clock which
>> shouldn't be disabled by Linux.
>>
>> Therefore, this patch is a proposal to use the same 'mark clocks as
>> critical' logic implemented for the module clocks for the core
>> clocks, too.
>>
>> Opinions?
> 
> On r8a7795, there are several Cortex A cores running Linux, and a Cortex R7
> core which may run another OS.
> This is an interesting issue, and relevant to other SoCs, too.
> 
> In this particular case, the "canfd" clock is a core clock used as an
> auxiliary clock for the CAN0, CAN1, and CANFD interfaces.  This can lead
> to three scenarios:
>    1. Linux controls all CAN interfaces
>       => no issue,
>    2. The OS on the RT CPU controls all CAN interfaces
>       => issue, Linux disables the clock
>    3. Mix of 1 and 2
>       => More issues.
> Of course this is not limited to clocks, but also to e.g. PM domains.
> 
> How can this be handled?
> I believe just marking the "canfd" clock critical is not the right solution,
> as about any clock could be used by the RT CPU.
> 
> Still, Linux needs to be made aware that devices (clocks and PM domains) are
> controlled by another CPU/OS.
> 
> Should this be described in DT? It feels like software policy to me.
> 
> Note that we (mainline) currently don't describe the Cortex R7 core in DT.
> Dirk: do you describe it?


No, we don't describe anything R7 related in DT, too.


> Summary:
>    1. Core/module clocks are described in the clock driver (not in DT),
>    2. Unused clocks are disabled by CCF,
>    3. Clocks may be in use by the Real-Time CPU core, running another OS,
>    4. How to communicate to Linux which clocks are under control of the RT CPU?
 >
> Thanks for your comments!


While I appreciated that the overall issue is discussed, I'm not sure if 
there is anything really special we don't support generally, yet.

We have an infrastructure to mark clocks enabled anywhere else to be not 
disabled by Linux kernel (CLK_IS_CRITICAL). From my point of view, for 
this infrastructure, it doesn't matter, where this 'anywhere else' is. 
To take some concrete Renesas RCar3 examples, from my point of view it 
doesn't matter if its a GIC-400 clock enabled in the boot loader 
(U-Boot) or a CAN clock enabled by the R7. In both cases marking them as 
critical on Linux side does the trick.

The issue I just want to address (discuss) with this RFC patch is that 
for Renesas RCar3 we have CLK_IS_CRITICAL support for module clocks, but 
not for core clocks. From my point of view, this is a completely Renesas 
implementation specific discussion.

So I would rephrase the initial sentence above

"Clocks may be in use by another CPU not running Linux, while Linux 
disables them as being unused."

to anything like

"Clocks may be enabled (used) by others (U-Boot/CPUs/Hypervisors), while 
Linux disables them as being unused"

And I think this is completely addressed by CLK_IS_CRITICAL, as far as I 
can see :)

Best regards

Dirk

>>   drivers/clk/renesas/clk-div6.c         | 17 +++++++++++++++--
>>   drivers/clk/renesas/clk-div6.h         |  4 +++-
>>   drivers/clk/renesas/r8a7795-cpg-mssr.c |  7 +++++++
>>   drivers/clk/renesas/renesas-cpg-mssr.c |  3 ++-
>>   drivers/clk/renesas/renesas-cpg-mssr.h |  8 ++++++++
>>   5 files changed, 35 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/renesas/clk-div6.c b/drivers/clk/renesas/clk-div6.c
>> index 0627860..5917e05 100644
>> --- a/drivers/clk/renesas/clk-div6.c
>> +++ b/drivers/clk/renesas/clk-div6.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/of_address.h>
>>   #include <linux/slab.h>
>>
>> +#include "renesas-cpg-mssr.h"
>>   #include "clk-div6.h"
>>
>>   #define CPG_DIV6_CKSTP         BIT(8)
>> @@ -184,7 +185,9 @@ static const struct clk_ops cpg_div6_clock_ops = {
>>   struct clk * __init cpg_div6_register(const char *name,
>>                                        unsigned int num_parents,
>>                                        const char **parent_names,
>> -                                     void __iomem *reg)
>> +                                     void __iomem *reg,
>> +                                     const struct cpg_mssr_info *info,
>> +                                     unsigned int id)
>>   {
>>          unsigned int valid_parents;
>>          struct clk_init_data init;
>> @@ -246,6 +249,15 @@ struct clk * __init cpg_div6_register(const char *name,
>>          init.name = name;
>>          init.ops = &cpg_div6_clock_ops;
>>          init.flags = CLK_IS_BASIC;
>> +       if (info) {
>> +               for (i = 0; i < info->num_crit_core_clks; i++)
>> +                       if (id == info->crit_core_clks[i]) {
>> +                               pr_devel("DIV6 %s setting CLK_IS_CRITICAL\n",
>> +                                        name);
>> +                               init.flags |= CLK_IS_CRITICAL;
>> +                               break;
>> +                       }
>> +       }
>>          init.parent_names = parent_names;
>>          init.num_parents = valid_parents;
>>
>> @@ -298,7 +310,8 @@ static void __init cpg_div6_clock_init(struct device_node *np)
>>          for (i = 0; i < num_parents; i++)
>>                  parent_names[i] = of_clk_get_parent_name(np, i);
>>
>> -       clk = cpg_div6_register(clk_name, num_parents, parent_names, reg);
>> +       clk = cpg_div6_register(clk_name, num_parents, parent_names, reg,
>> +                               NULL, 0);
>>          if (IS_ERR(clk)) {
>>                  pr_err("%s: failed to register %s DIV6 clock (%ld)\n",
>>                         __func__, np->name, PTR_ERR(clk));
>> diff --git a/drivers/clk/renesas/clk-div6.h b/drivers/clk/renesas/clk-div6.h
>> index 567b31d..b619d6b4 100644
>> --- a/drivers/clk/renesas/clk-div6.h
>> +++ b/drivers/clk/renesas/clk-div6.h
>> @@ -2,6 +2,8 @@
>>   #define __RENESAS_CLK_DIV6_H__
>>
>>   struct clk *cpg_div6_register(const char *name, unsigned int num_parents,
>> -                             const char **parent_names, void __iomem *reg);
>> +                             const char **parent_names, void __iomem *reg,
>> +                             const struct cpg_mssr_info *info,
>> +                             unsigned int id);
>>
>>   #endif
>> diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
>> index eaa98b4..a54fed6 100644
>> --- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
>> +++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
>> @@ -114,6 +114,9 @@ static struct cpg_core_clk r8a7795_core_clks[] __initdata = {
>>          DEF_BASE("r",           R8A7795_CLK_R,     CLK_TYPE_GEN3_R, CLK_RINT),
>>   };
>>
>> +static const unsigned int r8a7795_crit_core_clks[] __initconst = {
>> +};
>> +
>>   static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
>>          DEF_MOD("fdp1-2",                117,   R8A7795_CLK_S2D1), /* ES1.x */
>>          DEF_MOD("fdp1-1",                118,   R8A7795_CLK_S0D1),
>> @@ -441,6 +444,10 @@ const struct cpg_mssr_info r8a7795_cpg_mssr_info __initconst = {
>>          .last_dt_core_clk = LAST_DT_CORE_CLK,
>>          .num_total_core_clks = MOD_CLK_BASE,
>>
>> +       /* Critical Core Clocks */
>> +       .crit_core_clks = r8a7795_crit_core_clks,
>> +       .num_crit_core_clks = ARRAY_SIZE(r8a7795_crit_core_clks),
>> +
>>          /* Module Clocks */
>>          .mod_clks = r8a7795_mod_clks,
>>          .num_mod_clks = ARRAY_SIZE(r8a7795_mod_clks),
>> diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
>> index 99eeec6..80be019 100644
>> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
>> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
>> @@ -293,7 +293,8 @@ static void __init cpg_mssr_register_core_clk(const struct cpg_core_clk *core,
>>
>>                  if (core->type == CLK_TYPE_DIV6P1) {
>>                          clk = cpg_div6_register(core->name, 1, &parent_name,
>> -                                               priv->base + core->offset);
>> +                                               priv->base + core->offset, info,
>> +                                               core->id);
>>                  } else {
>>                          clk = clk_register_fixed_factor(NULL, core->name,
>>                                                          parent_name, 0,
>> diff --git a/drivers/clk/renesas/renesas-cpg-mssr.h b/drivers/clk/renesas/renesas-cpg-mssr.h
>> index 148f4f0a..a723fdd 100644
>> --- a/drivers/clk/renesas/renesas-cpg-mssr.h
>> +++ b/drivers/clk/renesas/renesas-cpg-mssr.h
>> @@ -86,6 +86,10 @@ struct device_node;
>>        * @last_dt_core_clk: ID of the last Core Clock exported to DT
>>        * @num_total_core_clks: Total number of Core Clocks (exported + internal)
>>        *
>> +     * @crit_core_clks: Array with Core Clock IDs of critical clocks that
>> +     *                  should not be disabled without a knowledgeable driver
>> +     * @num_core_mod_clks: Number of entries in crit_core_clks[]
>> +     *
>>        * @mod_clks: Array of Module Clock definitions
>>        * @num_mod_clks: Number of entries in mod_clks[]
>>        * @num_hw_mod_clks: Number of Module Clocks supported by the hardware
>> @@ -109,6 +113,10 @@ struct cpg_mssr_info {
>>          unsigned int last_dt_core_clk;
>>          unsigned int num_total_core_clks;
>>
>> +       /* Critical Core Clocks that should not be disabled */
>> +       const unsigned int *crit_core_clks;
>> +       unsigned int num_crit_core_clks;
>> +
>>          /* Module Clocks */
>>          const struct mssr_mod_clk *mod_clks;
>>          unsigned int num_mod_clks;
>> --
>> 2.8.0
