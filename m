From: Mason <slash.tmp@free.fr>
Subject: Re: cpufreq: frequency scaling spec in DT node
Date: Tue, 11 Jul 2017 13:09:33 +0200
Message-ID: <c0838592-5613-660d-56fc-e7022a38a86d@free.fr>
References: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
 <20170629100459.GL29665@vireshk-i7>
 <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
 <20170629143432.GM29665@vireshk-i7>
 <405bfa30-b083-2690-5747-aa1cd423e576@free.fr>
 <20170711102514.GC17115@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:26545 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752645AbdGKLJq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jul 2017 07:09:46 -0400
In-Reply-To: <20170711102514.GC17115@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>

On 11/07/2017 12:25, Viresh Kumar wrote:
> On 11-07-17, 11:27, Mason wrote:
>> On 29/06/2017 16:34, Viresh Kumar wrote:
>>
>>> On 29-06-17, 13:41, Mason wrote:
>>>
>>>> I was trying to "emulate" the behavior of the ondemand governor.
>>>> Based on your reaction, I got it wrong...
>>>> Here is the actual issue:
>>>>
>>>> I'm on SoC B, where nominal/max freq is expected to be 1206 MHz.
>>>> So the OPPs in the DT are:
>>>> operating-points = <1206000 0 603000 0 402000 0 241200 0 134000 0>;
>>>> *But* FW changed the max freq behind my back, to 1215 MHz.
> 
> What does this line mean really? Where is this frequency changed ? In the OPP
> table in DT?

I apologize for being unclear.

What I meant is that the bootloader originally set the max frequency
to 1206 MHz. The OPP table in DTS was written based on that value.

Later, someone changed the bootloader code to set a slightly higher
max frequency. When I flashed the new bootloader on my board, the
OPP table no longer matches the actual frequency.

But I am not notified when bootloader authors change max frequencies,
which is why I wrote "changed the max freq behind my back".

Again, sorry for the confusing statements.

(The bootloader is not DT-aware, so it leaves the DT untouched.)

>>>> Here is what happens when I execute:
>>>> echo ondemand >scaling_governor
>>>> sleep 2
>>>> cpuburn-a9 & cpuburn-a9 & cpuburn-a9 & cpuburn-a9
>>>> ### cpuburn-a9 spins in a tight infinite loop,
>>>> ### hitting all FUs to raise the CPU temperature
>>>>
>>>> # cpufreq_test.sh
>>>> [   69.933874] set_target: index=4
>>>> [   69.944799] set_target: index=2
>>>> [   69.947988] clk_divider_set_rate: rate=303750000 parent_rate=1215000000 div=4
>>>> [   69.955542] set_target: index=4
>>>> [   69.958801] clk_divider_set_rate: rate=607500000 parent_rate=1215000000 div=2
>>>> [   69.984789] set_target: index=0
>>>> [   69.987980] clk_divider_set_rate: rate=121500000 parent_rate=1215000000 div=10
>>>> [   71.947597] set_target: index=4
>>>> [   71.950996] clk_divider_set_rate: rate=607500000 parent_rate=1215000000 div=2
>>>>
>>>> As you can see, the divider remains stuck at 2, so the SoC
>>>> is actually running only at 607.5 MHz (instead of 1215 MHz).
>>>>
>>>> If I fix the OPPs in DT to:
>>>> operating-points = <1215000 0 607500 0 405000 0 243000 0 135000 0>;
>>>> Then I get the expected behavior:
>>>>
>>>> $ cpufreq_test.sh 
>>>> [   32.717930] set_target: index=1
>>>> [   32.721131] clk_divider_set_rate: rate=243000000 parent_rate=1215000000 div=5
>>>> [   32.731326] set_target: index=4
>>>> [   32.734521] clk_divider_set_rate: rate=1215000000 parent_rate=1215000000 div=1
>>>> [   32.754556] set_target: index=0
>>>> [   32.757738] clk_divider_set_rate: rate=135000000 parent_rate=1215000000 div=9
>>>> [   32.765864] set_target: index=4
>>>> [   32.769217] clk_divider_set_rate: rate=1215000000 parent_rate=1215000000 div=1
>>>> [   33.438811] set_target: index=0
>>>> [   33.442001] clk_divider_set_rate: rate=135000000 parent_rate=1215000000 div=9
>>>> [   33.450249] set_target: index=4
>>>> [   33.453470] clk_divider_set_rate: rate=1215000000 parent_rate=1215000000 div=1
>>>> [   33.477888] set_target: index=0
>>>> [   33.481067] clk_divider_set_rate: rate=135000000 parent_rate=1215000000 div=9
>>>> [   34.714786] set_target: index=4
>>>> [   34.718237] clk_divider_set_rate: rate=1215000000 parent_rate=1215000000 div=1
>>>>
>>>> Divider settles at 1 (full speed) to provide maximum
>>>> performance for the user-space processes.
>>>
>>> I am not sure how such behavior will happen just because we changed
>>> the max OPP (actually increased it). You need to dig in a bit to see
>>> why this happens, as I can't agree to your numbers for now.
>>
>> I had a closer look.
>>
>> static int _div_round(...)
>> {
>> 	if (flags & CLK_DIVIDER_ROUND_CLOSEST)
>> 		return _div_round_closest(table, parent_rate, rate, flags);
>>
>> 	return _div_round_up(table, parent_rate, rate, flags);
>> }
>>
>> This flag was /not/ set for the CPU divider clock.
> 
> i.e. _div_round_up() was getting called ? And you failed to explain why do you
> think this results in that awkward behavior.

Yes _div_round_up() was being called

[   10.631624] _div_round_up: parent_rate=1215000000 rate=1206000000 div=2
[   10.648229] clk_divider_set_rate: rate=607500000 parent_rate=1215000000 div=2

	int div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);

Since the divider is rounded up, and parent_rate > rate,
we get a divider of 2, so 607.5 MHz

All dividers (d + epsilon) are rounded to d+1

>> But setting it breaks in dev_pm_opp_set_rate()
>>
>> [    9.201681] set_target: index=4
>> [    9.204870] dev_pm_opp_set_rate: target_freq=1206000000 freq=1215000000 old_freq=243000000
> 
> I have some assumptions on how you are printing this line and will present my
> analysis based on that.

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 6441dfda489f..53ec09eaa01c 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -603,6 +603,9 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
        old_freq = clk_get_rate(clk);
 
+       printk("%s: target_freq=%lu freq=%lu old_freq=%lu\n",
+                       __func__, target_freq, freq, old_freq);
+
        /* Return early if nothing to do */
        if (old_freq == freq) {
                dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",


> cpufreq core asked for a freq of 1206 (why?, DT should have had 1215 as max),

That's the source of the problem: DT has 1206 as max.
(Because max freq was changed in the bootloader, and the DT
was not updated.)

Maybe this is the real issue that needs to be addressed,
rather than the symptoms that turn up later because of
the root issue.

What's your take?

Regards.
