From: Jim Quinlan <jim2101024@gmail.com>
Subject: [RFC] LCCF: The case for "software" clocks
Date: Wed, 28 May 2014 15:38:02 -0400
Message-ID: <CANCKTBvUaAeJv1vxyFmQZf9viL329Dfx-DJeJ3b8SA7kMaj1Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:56977 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaE1TiE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 May 2014 15:38:04 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so11276130obc.35
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2014 12:38:03 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: mturquette@linaro.org, f.fainelli@gmail.com

This is my second post on the idea of LCCF software clocks.  It has more
details, an example, and includes reasons why current Linux solutions
don't fit the bill.  I also attempt to answer questions raised by a personal
correspondence with Mike Turquette (thanks Mike!).

Some chips, such as OMAP543x, have hardware that is cleverly partitioned
into clock and power domains designed specifically for modular clock
gating.  I would imagine that such chips are targeted for mobile devices
where power savings is paramount.  Unfortunately, the SOCs I work on
(Broadcom Settop chips) are not destined for mobile devices and do not
have a modular PM architecture, as this would require an investment in
HW design that is not currently available.  What we are delivered today
from the HW folks is a rather large clock dependency tree.  Although
our chips are not for the mobile market, we would still like to
save some power through clock gating.

In most examples of .dtsi files I have perused, a device is associated with
typically one clock, maybe two.  In the SoC I'm working on, some devices
need to turn off multiple clocks for PM, as many as 15.   The driver gets
the clocks from the device tree, and when the driver wants to turn off
clocks to the device, it loops through all 15 clocks.

I'm wondering if is possible to abstract a group of many clocks into one
"software clock". Invoking clk_disable() on said software clock would
effect the iteration of clk_disable() on all 15 of the parent clocks
it governs.  Enabling would effect clk_enable() on all 15.  This would
make the driver writer's life a little simpler and the code much cleaner.

I've looked at the LCCF, and it doesn't really accommodate multiple
active parents as it's somewhat contrary to its design.  By "multiple
active parents", I mean that each of the parent clocks are at the same
time enabled -- this is not a MUX -- and the child software clock of
those parents controls whether they are all enabled in unison or
disabled in unison.

Now you may think that runtime PM could be the abstraction that I am looking
for.  It would certainly serve as an abstraction, but it would just
move the mess from the driver to the runtime PM functions.  I would
like to remove the mess itself.

Allow me to give more details.  I cannot post a pointer to a datasheet,
as that is currently quasi-confidential.  Some of the drivers for
these chips are upstream, but they currently don't yet employ clock
gating or do so in a minimal fashion which we are refactoring anyway.

For an example, in one of our SOCs, turning off the genet0 device
involves 23 clocks.  Actually, the driver need only worry about 15,
since 15 of the 23 are "bottom" clocks and the other eight are
parents which will be implicitly affected.  The 15 have names like this:

genet0_alwayson_ck
genet0_sys_fast_ck
genet0_sys_pm_ck
genet0_sys_slow_ck
genet_54_ck
genet_scb_ck
genet0_gisb_ck_genet0
genet0_gmii_ck_genet0
genet0_hfb_ck_genet0
genet0_l2intr_ck_genet0
genet0_scb_ck_genet0
genet0_umac_sys_rx_ck_genet0
genet0_umac_sys_tx_ck_genet0
genet1_ck_250_ck_genet1
net_pll_pst_div_hld_ch1

Each of the above is registered in the DT as a gated clock and of
course has a register and bit associated with its enabling.

So the genet driver has to allocate storage for these clocks, "get"
all of them, and {en,dis}able them during PM management.  Note that
the driver is not necessarily aware how many there will be and what
their names are.  So the probe code might look something like this:

        int count = of_property_count_strings(dn, "clock-names");
        struct clk **clks = = kzalloc(count*sizeof(struct clk*), GFP_KERNEL);

        for (i=0; i<count; i++) {
                struct clk *clk = of_clk_get(dn, i);
                if (!clk)
                        ...
                clks[i] = clk;
        }
        /* now attach clks to the priv/drvdata */

and enabling might look like this

        static void enable_clks(struct device *dev)
        {
                struct clk **p = dev->platform_data;
                struct device_node *dn = dev.of_node;
                int count = of_property_count_strings(dn, "clock-names");
                int i;
                for (i=0; i<count; i++) {
                    int ret = clk_enable(p->clocks[i]);
                    if (!ret)
                        ...
                }
        }


So the driver must iterate through all of these clocks when
{en,dis}bling for PM.  The case for genet is actually more
complicated: there are actually three sets of clocks; this one, one
for wake-on-lan, and one for something we call "eee".  Somehow, the
probe function will have to partition the clocks into three groups,
and iterate through the clocks with each group.  Messy.

So this seems to be cumbersome: having many drivers iterate though
their sets of clocks when all of the clocks they govern in their
respecitve sets are either being turned on or off in unison.  The idea
of an abstract software clock that "hides" this iteration would be
pretty helpful.  In the case of our 15 clocks, a DT entry for such a
clock would look like this:

        sw_genet0 : sw_genet0 {
                compatible = "brcm,brcmstb-sw-clk";
                #clock-cells = <0>;
                clocks = <&genet0_alwayson_ck>, <&genet0_sys_fast_ck>,
                  <&genet0_sys_pm_ck>, <&genet0_sys_slow_ck>,
                  <&genet_54_ck>, <&genet_scb_ck>,
                  <&genet0_gisb_ck_genet0>, <&genet0_gmii_ck_genet0>,
                  <&genet0_hfb_ck_genet0>, <&genet0_l2intr_ck_genet0>,
                  <&genet0_scb_ck_genet0>,
                  <&genet0_umac_sys_rx_ck_genet0>,
                  <&genet0_umac_sys_tx_ck_genet0>,
                  <&genet1_ck_250_ck_genet1>,
                  <&net_pll_pst_div_hld_ch1>;
        };

Note that this is a new clock type which has multiple parents and is
not a MUX.  Now the genet driver (or runtime PM function) only has
to interact with one clock:

        clk = of_get_clk_by_name(dn, "sw_genet0");
        if (IS_ERR(clk))
                goto err;
        clk_enable(clk);
        /* .... */

To accomplish this, the code in drivers/clk/clk.c is changed to operate on such
clocks.  Such a clock is indicated by having CLK_IS_SW in its flags.
An example modification would look something like this for
 __clk_enable():

static int __clk_enable(struct clk *clk)
{
        int i, j, ret = 0;

        if (!clk)
                return 0;

        if (WARN_ON(clk->prepare_count == 0))
                return -ESHUTDOWN;

+       /* __clk_parent_safe() just returns the indexed parent clock by
+        * using the cache or looking it up */

        if (clk->enable_count == 0) {
+               if (clk->flags & CLK_IS_SW)
+                       for (i = 0; i < clk->num_parents; i++) {
+                               ret = __clk_enable(
+                                       __clk_parent_safe(clk, i));
+                               if (ret) {
+                                       for (j = i-1; j >= 0; j--)
+                                               __clk_disable(
+
__clk_parent_safe(clk, j));
+                                       break;
+                               }
+               else
                        ret = __clk_enable(clk->parent);

                if (ret)
                        return ret;

                if (clk->ops->enable) {
                        ret = clk->ops->enable(clk->hw);
                        if (ret) {
                                __clk_disable(clk->parent);
                                return ret;
                        }
                }
        }
        clk->enable_count++;
        return 0;
}

I can certainly post a more complete clk.c patch, but I thought I would solicit
more feedback first before I do that.

Comments appreciated!
