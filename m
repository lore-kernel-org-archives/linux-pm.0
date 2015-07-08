From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [RFCv5 PATCH 03/46] arm: vexpress: Add CPU clock-frequencies to
 TC2 device-tree
Date: Wed, 08 Jul 2015 13:36:15 +0100
Message-ID: <1436358975.2844.30.camel@linaro.org>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
	 <1436293469-25707-4-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smarthost01d.mail.zen.net.uk ([212.23.1.7]:41041 "EHLO
	smarthost01d.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753768AbbGHMgf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 08:36:35 -0400
In-Reply-To: <1436293469-25707-4-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

On Tue, 2015-07-07 at 19:23 +0100, Morten Rasmussen wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> To enable the parsing of clock frequency and cpu efficiency values
> inside parse_dt_topology [arch/arm/kernel/topology.c] to scale the
> relative capacity of the cpus, this property has to be provided within
> the cpu nodes of the dts file.
> 
> The patch is a copy of commit 8f15973ef8c3 ("ARM: vexpress: Add CPU
> clock-frequencies to TC2 device-tree") taken from Linaro Stable Kernel
> (LSK) massaged into mainline.

Not sure you really need to mention commit hashes from outside of the
mainline Linux tree and the values I added to that commit were probably
copied from some patch originating from ARM or elsewhere anyway. So the
second paragraph is this commit message is probably superfluous. But
this is nitpicking I guess :-)

-- 
Tixy

