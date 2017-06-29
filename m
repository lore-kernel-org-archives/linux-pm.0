From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq: frequency scaling spec in DT node
Date: Thu, 29 Jun 2017 20:04:32 +0530
Message-ID: <20170629143432.GM29665@vireshk-i7>
References: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
 <20170629100459.GL29665@vireshk-i7>
 <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35016 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdF2Oeg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 10:34:36 -0400
Received: by mail-pf0-f182.google.com with SMTP id c73so51546386pfk.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2017 07:34:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>

On 29-06-17, 13:41, Mason wrote:
> I was trying to "emulate" the behavior of the ondemand governor.
> Based on your reaction, I got it wrong...
> Here is the actual issue:
> 
> I'm on SoC B, where nominal/max freq is expected to be 1206 MHz.
> So the OPPs in the DT are:
> operating-points = <1206000 0 603000 0 402000 0 241200 0 134000 0>;
> *But* FW changed the max freq behind my back, to 1215 MHz.
> 
> Here is what happens when I execute:
> echo ondemand >scaling_governor
> sleep 2
> cpuburn-a9 & cpuburn-a9 & cpuburn-a9 & cpuburn-a9
> ### cpuburn-a9 spins in a tight infinite loop,
> ### hitting all FUs to raise the CPU temperature
> 
> # cpufreq_test.sh
> [   69.933874] set_target: index=4
> [   69.944799] set_target: index=2
> [   69.947988] clk_divider_set_rate: rate=303750000 parent_rate=1215000000 div=4
> [   69.955542] set_target: index=4
> [   69.958801] clk_divider_set_rate: rate=607500000 parent_rate=1215000000 div=2
> [   69.984789] set_target: index=0
> [   69.987980] clk_divider_set_rate: rate=121500000 parent_rate=1215000000 div=10
> [   71.947597] set_target: index=4
> [   71.950996] clk_divider_set_rate: rate=607500000 parent_rate=1215000000 div=2
> 
> As you can see, the divider remains stuck at 2, so the SoC
> is actually running only at 607.5 MHz (instead of 1215 MHz).
> 
> If I fix the OPPs in DT to:
> operating-points = <1215000 0 607500 0 405000 0 243000 0 135000 0>;
> Then I get the expected behavior:
> 
> $ cpufreq_test.sh 
> [   32.717930] set_target: index=1
> [   32.721131] clk_divider_set_rate: rate=243000000 parent_rate=1215000000 div=5
> [   32.731326] set_target: index=4
> [   32.734521] clk_divider_set_rate: rate=1215000000 parent_rate=1215000000 div=1
> [   32.754556] set_target: index=0
> [   32.757738] clk_divider_set_rate: rate=135000000 parent_rate=1215000000 div=9
> [   32.765864] set_target: index=4
> [   32.769217] clk_divider_set_rate: rate=1215000000 parent_rate=1215000000 div=1
> [   33.438811] set_target: index=0
> [   33.442001] clk_divider_set_rate: rate=135000000 parent_rate=1215000000 div=9
> [   33.450249] set_target: index=4
> [   33.453470] clk_divider_set_rate: rate=1215000000 parent_rate=1215000000 div=1
> [   33.477888] set_target: index=0
> [   33.481067] clk_divider_set_rate: rate=135000000 parent_rate=1215000000 div=9
> [   34.714786] set_target: index=4
> [   34.718237] clk_divider_set_rate: rate=1215000000 parent_rate=1215000000 div=1
> 
> Divider settles at 1 (full speed) to provide maximum
> performance for the user-space processes.

I am not sure how such behavior will happen just because we changed
the max OPP (actually increased it). You need to dig in a bit to see
why this happens, as I can't agree to your numbers for now.

> My concern is that if I don't check somewhere that the
> nominal frequency is as expected in the DT, the CPU might
> run slower than expected (max freq cut in half).

Its for the bootloader to decide, not a kernel developer. So whatever
they choose is what we want to use. This can happen with everyone else
as well, we are all using DT.

But surely, increasing the max OPP value shouldn't have any bad
effects.

> In what driver should I call these... the clk driver?
> (drivers/clk/tegra/cvb.c seems to be doind that)
> 
> A problem might arise when I need to do voltage scaling,
> though, since I also need to specify voltages, right?

Your cpufreq driver, which uses cpufreq-dt.c.

> You're talking about this document, right?
> https://www.kernel.org/doc/Documentation/cpu-freq/user-guide.txt

Documentation/admin-guide/pm/cpufreq.rst in mainline kernel.

-- 
viresh
