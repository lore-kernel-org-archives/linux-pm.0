From: Mason <slash.tmp@free.fr>
Subject: Re: cpufreq: frequency scaling spec in DT node
Date: Thu, 29 Jun 2017 13:41:46 +0200
Message-ID: <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
References: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
 <20170629100459.GL29665@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:24902 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752454AbdF2LmA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Jun 2017 07:42:00 -0400
In-Reply-To: <20170629100459.GL29665@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>

On 29/06/2017 12:04, Viresh Kumar wrote:

> On 29-06-17, 11:48, Mason wrote:
>
>> I have two similar, but slightly different SoCs.
>>
>> Firmware/bootloader sets the "nominal" CPU frequency to
> 
> So nominal here is MAX cpu frequency.
> 
>> - 1215 MHz on SoC A
>> - 1206 MHz on SoC B
>>
>> On both systems, software can reduce the CPU frequency by
>> writing an 8-bit integer divider to an MMIO register.
>>
>> Originally, I wanted to define a small number of operating points,
>> defined only by the divider value, and compute the actual OPP freq
>> at init.
>>
>> For example, use { 1, 2, 3, 5, 9 } for dividers =>
>> 1215, 607.5, 405, 243, 135 on SoC A
>> 1206, 603, 402, 241.2, 134 on Soc B
>>
>> I'm using the generic cpufreq driver.
>>
>> Binding for the generic cpufreq driver:
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
>>
>> I don't think there's a way to do what I want with the
>> existing driver, right?
> 
> No, you should rather use actual target frequency values.
> 
>> It's not a big deal, I can write the actual target frequencies
>> in the DT.
> 
> Right.
> 
>> (BTW, the OPPs are more SW than HW desc, right?)
> 
> Hmm, I wouldn't say that exactly :)
> 
> What OPP contains is mostly defined by hardware, apart from the
> frequency values we are talking about. And those are decided by the
> boot loaders and they are like hardware to the kernel really. They
> define hardware capabilities IOW.
> 
> If you want, you can actually try implementing a ->target() type
> cpufreq driver instead of ->target_index() and you will be able to
> select any frequency you want. But with the above example, what you
> can select is Max divided by integer value and so you can have 9
> different OPPs and reuse cpufreq-dt.
> 
>> But my problem is: what happens if firmware/bootloader is
>> changed without me knowing, and they change the nominal
>> frequency?
> 
> The kernel doesn't have any authority over what frequencies we are
> allowed to use and we depend on the boot loader for that. If someone
> changes that, screw him :)
> 
>> Because of the rounding, if the nominal freq
>> is slightly increased, the SoC will start working at
> 
>               decreased ?
> 
>> *slower* speeds.
>>
>> For example, if nominal is 1215, and I request 603, I will
>> actually get 405.
> 
> No, you will normally get a frequency >= requested frequency with the
> cpufreq governors we have.
> 
>> This effect can be seen if I define SoC B OPPs on SoC A:
>>
>> $ cat scaling_available_frequencies
>> 134000 241200 402000 603000 1206000 
>> /sys/devices/system/cpu/cpu0/cpufreq$ echo 603000 > scaling_max_freq
> 
> Wow. This is not how you request a frequency. What you said here is
> that the MAX frequency allowed now is 603000 instead of 1206000. And
> because 603000 isn't a valid frequency, we go down to 405000.
> 
> So, you should try using the userspace governor and play with
> scaling_setspeed sysfs file.

I was trying to "emulate" the behavior of the ondemand governor.
Based on your reaction, I got it wrong...
Here is the actual issue:

I'm on SoC B, where nominal/max freq is expected to be 1206 MHz.
So the OPPs in the DT are:
operating-points = <1206000 0 603000 0 402000 0 241200 0 134000 0>;
*But* FW changed the max freq behind my back, to 1215 MHz.

Here is what happens when I execute:
echo ondemand >scaling_governor
sleep 2
cpuburn-a9 & cpuburn-a9 & cpuburn-a9 & cpuburn-a9
### cpuburn-a9 spins in a tight infinite loop,
### hitting all FUs to raise the CPU temperature

# cpufreq_test.sh
[   69.933874] set_target: index=4
[   69.944799] set_target: index=2
[   69.947988] clk_divider_set_rate: rate=303750000 parent_rate=1215000000 div=4
[   69.955542] set_target: index=4
[   69.958801] clk_divider_set_rate: rate=607500000 parent_rate=1215000000 div=2
[   69.984789] set_target: index=0
[   69.987980] clk_divider_set_rate: rate=121500000 parent_rate=1215000000 div=10
[   71.947597] set_target: index=4
[   71.950996] clk_divider_set_rate: rate=607500000 parent_rate=1215000000 div=2

As you can see, the divider remains stuck at 2, so the SoC
is actually running only at 607.5 MHz (instead of 1215 MHz).

If I fix the OPPs in DT to:
operating-points = <1215000 0 607500 0 405000 0 243000 0 135000 0>;
Then I get the expected behavior:

$ cpufreq_test.sh 
[   32.717930] set_target: index=1
[   32.721131] clk_divider_set_rate: rate=243000000 parent_rate=1215000000 div=5
[   32.731326] set_target: index=4
[   32.734521] clk_divider_set_rate: rate=1215000000 parent_rate=1215000000 div=1
[   32.754556] set_target: index=0
[   32.757738] clk_divider_set_rate: rate=135000000 parent_rate=1215000000 div=9
[   32.765864] set_target: index=4
[   32.769217] clk_divider_set_rate: rate=1215000000 parent_rate=1215000000 div=1
[   33.438811] set_target: index=0
[   33.442001] clk_divider_set_rate: rate=135000000 parent_rate=1215000000 div=9
[   33.450249] set_target: index=4
[   33.453470] clk_divider_set_rate: rate=1215000000 parent_rate=1215000000 div=1
[   33.477888] set_target: index=0
[   33.481067] clk_divider_set_rate: rate=135000000 parent_rate=1215000000 div=9
[   34.714786] set_target: index=4
[   34.718237] clk_divider_set_rate: rate=1215000000 parent_rate=1215000000 div=1

Divider settles at 1 (full speed) to provide maximum
performance for the user-space processes.

My concern is that if I don't check somewhere that the
nominal frequency is as expected in the DT, the CPU might
run slower than expected (max freq cut in half).

>> [   60.401883] set_target: index=3
>> [   60.405118] clk_divider_set_rate: rate=405000000 parent_rate=1215000000 div=3
>>
>>
>> What can I do against that?
>>
>> Should I check the nominal frequency in my clk driver?
>> (I'm not sure reading properties of unrelated nodes is acceptable practice.)
> 
> We rely on the boot loader to get these details.
> 
> There is one thing you can do to avoid adding OPP entries in the DT.
> You can rather add them dynamically with help of: dev_pm_opp_add() and
> cpufreq-dt will continue to work with that too.

In what driver should I call these... the clk driver?
(drivers/clk/tegra/cvb.c seems to be doind that)

A problem might arise when I need to do voltage scaling,
though, since I also need to specify voltages, right?

> But you should understand how to use the sysfs interface first and
> make sure you are doing the right thing.

You're talking about this document, right?
https://www.kernel.org/doc/Documentation/cpu-freq/user-guide.txt

Regards.
