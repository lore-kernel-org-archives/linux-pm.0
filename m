From: Rob Herring <robherring2@gmail.com>
Subject: Re: spurious bL cpufreq driver messages
Date: Sat, 18 May 2013 14:51:04 -0500
Message-ID: <CAL_JsqLEv38DwnL4=ToXtEKNrDbgYv_0qiOc+cXZSjnfKVbeNg@mail.gmail.com>
References: <519686BC.3090101@gmail.com>
	<CAKohpom0cGfWvsCf-jaMyu0cQJi2hVk9_0wskEDH2X7MaeHDLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:51060 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab3ERTvG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 May 2013 15:51:06 -0400
Received: by mail-qc0-f180.google.com with SMTP id a10so2309352qcx.11
        for <linux-pm@vger.kernel.org>; Sat, 18 May 2013 12:51:04 -0700 (PDT)
In-Reply-To: <CAKohpom0cGfWvsCf-jaMyu0cQJi2hVk9_0wskEDH2X7MaeHDLw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>

On Fri, May 17, 2013 at 9:03 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 18 May 2013 01:06, Rob Herring <robherring2@gmail.com> wrote:
>> The bL cpufreq driver appears to collide with the cpufreq-cpu0 driver.
>> There doesn't appear to be a functional problem, but just spurious
>> prints which indicate it is trying to do something. I think it needs
>> better checking whether the chip is actually multi-cluster. This is what
>> I get when I hotplug cpus:
>>
>> [  909.372319] CPU1: Booted secondary processor
>> [  909.372616] cpu cpu1: get_cluster_clk_and_freq_table: init_opp_table
>> failed, cpu: 1, err: -61
>> [  909.385411] cpu cpu1: get_cluster_clk_and_freq_table: Failed to get
>> data for cluster: 9
>> [  909.394161] CPU2: shutdown
>> [  909.400957] CPU2: Booted secondary processor
>> [  909.401253] cpu cpu2: get_cluster_clk_and_freq_table: init_opp_table
>> failed, cpu: 2, err: -61
>> [  909.414044] cpu cpu2: get_cluster_clk_and_freq_table: Failed to get
>> data for cluster: 9
>
> See if this fixes your issue.
>
> https://groups.google.com/forum/?fromgroups#!topic/linux.kernel/XJF-82rad4o
>
> Attached too.

No, it still registers the bL driver. The problem is not that DT data
is missing, but it is present on a single cluster system. This is what
my 1st cpu node looks like:

$ ls /proc/device-tree/cpus/cpu@900/
clock-latency  clocks      device_type  next-level-cache  reg
clock-names    compatible  name         operating-points  transition-latency

This is the boot log:

[    1.192186] cpu cpu0: get_cluster_clk_and_freq_table: Failed to get
clk for cpu: 0, cluster: 9
[    1.200804] cpu cpu0: get_cluster_clk_and_freq_table: Failed to get
data for cluster: 9
[    1.208815] cpu cpu1: get_cluster_clk_and_freq_table:
init_opp_table failed, cpu: 1, err: -61
[    1.217345] cpu cpu1: get_cluster_clk_and_freq_table: Failed to get
data for cluster: 9
[    1.225354] cpu cpu2: get_cluster_clk_and_freq_table:
init_opp_table failed, cpu: 2, err: -61
[    1.233879] cpu cpu2: get_cluster_clk_and_freq_table: Failed to get
data for cluster: 9
[    1.241880] cpu cpu3: get_cluster_clk_and_freq_table:
init_opp_table failed, cpu: 3, err: -61
[    1.250403] cpu cpu3: get_cluster_clk_and_freq_table: Failed to get
data for cluster: 9
[    1.258406] arm_big_little: bL_cpufreq_register: Registered
platform driver: dt-bl
[    1.266123] cpufreq_cpu0: failed to get cpu0 regulator: -19
[    1.271704] cpufreq_cpu0: failed register driver: -16
[    1.276764] cpufreq-cpu0: probe of cpufreq-cpu0.0 failed with error -16

Rob
