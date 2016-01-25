From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v6, 5/5] cpufreq: powernv: Add sysfs attributes to show throttle stats
Date: Mon, 25 Jan 2016 16:43:31 +1100 (AEDT)
Message-ID: <20160125054332.0D7D6140326@ozlabs.org>
References: <1453447145-17722-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:35527 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbcAYFnd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Jan 2016 00:43:33 -0500
In-Reply-To: <1453447145-17722-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, pc@us.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, shreyas@linux.vnet.ibm.com, anton@samba.org

On Fri, 2016-22-01 at 07:19:05 UTC, Shilpasri G Bhat wrote:
> Create sysfs attributes to export throttle information in
> /sys/devices/system/cpu/cpufreq/chipN. The newly added sysfs files are as
> follows:
> 
> 1)/sys/devices/system/cpu/cpufreq/chip0/throttle_frequencies
..
> 2)/sys/devices/system/cpu/cpufreq/chip0/throttle_reasons
..
> 3)/sys/devices/system/cpu/cpufreq/chip0/throttle_stat
..

These should all be added to Documentation/ABI/testing/sysfs-devices-system-cpu.

cheers
