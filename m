From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq: frequency scaling spec in DT node
Date: Thu, 29 Jun 2017 15:34:59 +0530
Message-ID: <20170629100459.GL29665@vireshk-i7>
References: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34186 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdF2KFD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 06:05:03 -0400
Received: by mail-pg0-f50.google.com with SMTP id t186so45882539pgb.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2017 03:05:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>

On 29-06-17, 11:48, Mason wrote:
> Hello,
> 
> I have two similar, but slightly different SoCs.
> 
> Firmware/bootloader sets the "nominal" CPU frequency to

So nominal here is MAX cpu frequency.

> - 1215 MHz on SoC A
> - 1206 MHz on SoC B
> 
> On both systems, software can reduce the CPU frequency by
> writing an 8-bit integer divider to an MMIO register.
> 
> Originally, I wanted to define a small number of operating points,
> defined only by the divider value, and compute the actual OPP freq
> at init.
> 
> For example, use { 1, 2, 3, 5, 9 } for dividers =>
> 1215, 607.5, 405, 243, 135 on SoC A
> 1206, 603, 402, 241.2, 134 on Soc B
> 
> I'm using the generic cpufreq driver.
> 
> Binding for the generic cpufreq driver:
> https://www.kernel.org/doc/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
> 
> I don't think there's a way to do what I want with the
> existing driver, right?

No, you should rather use actual target frequency values.

> It's not a big deal, I can write the actual target frequencies
> in the DT.

Right.

> (BTW, the OPPs are more SW than HW desc, right?)

Hmm, I wouldn't say that exactly :)

What OPP contains is mostly defined by hardware, apart from the
frequency values we are talking about. And those are decided by the
boot loaders and they are like hardware to the kernel really. They
define hardware capabilities IOW.

If you want, you can actually try implementing a ->target() type
cpufreq driver instead of ->target_index() and you will be able to
select any frequency you want. But with the above example, what you
can select is Max divided by integer value and so you can have 9
different OPPs and reuse cpufreq-dt.

> But my problem is: what happens if firmware/bootloader is
> changed without me knowing, and they change the nominal
> frequency?

The kernel doesn't have any authority over what frequencies we are
allowed to use and we depend on the boot loader for that. If someone
changes that, screw him :)

> Because of the rounding, if the nominal freq
> is slightly increased, the SoC will start working at

              decreased ?

> *slower* speeds.
> 
> For example, if nominal is 1215, and I request 603, I will
> actually get 405.

No, you will normally get a frequency >= requested frequency with the
cpufreq governors we have.

> This effect can be seen if I define SoC B OPPs on SoC A:
> 
> $ cat scaling_available_frequencies
> 134000 241200 402000 603000 1206000 
> /sys/devices/system/cpu/cpu0/cpufreq$ echo 603000 > scaling_max_freq

Wow. This is not how you request a frequency. What you said here is
that the MAX frequency allowed now is 603000 instead of 1206000. And
because 603000 isn't a valid frequency, we go down to 405000.

So, you should try using the userspace governor and play with
scaling_setspeed sysfs file.

> [   60.401883] set_target: index=3
> [   60.405118] clk_divider_set_rate: rate=405000000 parent_rate=1215000000 div=3
> 
> 
> What can I do against that?
> 
> Should I check the nominal frequency in my clk driver?
> (I'm not sure reading properties of unrelated nodes is acceptable practice.)

We rely on the boot loader to get these details.

There is one thing you can do to avoid adding OPP entries in the DT.
You can rather add them dynamically with help of: dev_pm_opp_add() and
cpufreq-dt will continue to work with that too.

But you should understand how to use the sysfs interface first and
make sure you are doing the right thing.

-- 
viresh
