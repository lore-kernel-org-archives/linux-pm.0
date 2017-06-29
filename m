From: Mason <slash.tmp@free.fr>
Subject: cpufreq: frequency scaling spec in DT node
Date: Thu, 29 Jun 2017 11:48:15 +0200
Message-ID: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:60964 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751804AbdF2Jsd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Jun 2017 05:48:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>

Hello,

I have two similar, but slightly different SoCs.

Firmware/bootloader sets the "nominal" CPU frequency to
- 1215 MHz on SoC A
- 1206 MHz on SoC B

On both systems, software can reduce the CPU frequency by
writing an 8-bit integer divider to an MMIO register.

Originally, I wanted to define a small number of operating points,
defined only by the divider value, and compute the actual OPP freq
at init.

For example, use { 1, 2, 3, 5, 9 } for dividers =>
1215, 607.5, 405, 243, 135 on SoC A
1206, 603, 402, 241.2, 134 on Soc B

I'm using the generic cpufreq driver.

Binding for the generic cpufreq driver:
https://www.kernel.org/doc/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt

I don't think there's a way to do what I want with the
existing driver, right?

It's not a big deal, I can write the actual target frequencies
in the DT. (BTW, the OPPs are more SW than HW desc, right?)

But my problem is: what happens if firmware/bootloader is
changed without me knowing, and they change the nominal
frequency? Because of the rounding, if the nominal freq
is slightly increased, the SoC will start working at
*slower* speeds.

For example, if nominal is 1215, and I request 603, I will
actually get 405.

This effect can be seen if I define SoC B OPPs on SoC A:

$ cat scaling_available_frequencies
134000 241200 402000 603000 1206000 
/sys/devices/system/cpu/cpu0/cpufreq$ echo 603000 > scaling_max_freq
[   60.401883] set_target: index=3
[   60.405118] clk_divider_set_rate: rate=405000000 parent_rate=1215000000 div=3


What can I do against that?

Should I check the nominal frequency in my clk driver?
(I'm not sure reading properties of unrelated nodes is acceptable practice.)

Regards.
