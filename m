From: Rob Herring <robherring2@gmail.com>
Subject: spurious bL cpufreq driver messages
Date: Fri, 17 May 2013 14:36:28 -0500
Message-ID: <519686BC.3090101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:63001 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756063Ab3EQTgi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 May 2013 15:36:38 -0400
Received: by mail-ia0-f172.google.com with SMTP id y26so4537684iab.31
        for <linux-pm@vger.kernel.org>; Fri, 17 May 2013 12:36:38 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>

The bL cpufreq driver appears to collide with the cpufreq-cpu0 driver.
There doesn't appear to be a functional problem, but just spurious
prints which indicate it is trying to do something. I think it needs
better checking whether the chip is actually multi-cluster. This is what
I get when I hotplug cpus:

[  909.372319] CPU1: Booted secondary processor
[  909.372616] cpu cpu1: get_cluster_clk_and_freq_table: init_opp_table
failed, cpu: 1, err: -61
[  909.385411] cpu cpu1: get_cluster_clk_and_freq_table: Failed to get
data for cluster: 9
[  909.394161] CPU2: shutdown
[  909.400957] CPU2: Booted secondary processor
[  909.401253] cpu cpu2: get_cluster_clk_and_freq_table: init_opp_table
failed, cpu: 2, err: -61
[  909.414044] cpu cpu2: get_cluster_clk_and_freq_table: Failed to get
data for cluster: 9

Rob
