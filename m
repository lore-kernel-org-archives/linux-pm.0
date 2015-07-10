From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFCv5 PATCH 03/46] arm: vexpress: Add CPU clock-frequencies
 to TC2 device-tree
Date: Fri, 10 Jul 2015 14:35:33 +0100
Message-ID: <559FCA25.6040801@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>	 <1436293469-25707-4-git-send-email-morten.rasmussen@arm.com> <1436358975.2844.30.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:7940 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753836AbbGJNfh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jul 2015 09:35:37 -0400
In-Reply-To: <1436358975.2844.30.camel@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

Hi Tixy,

On 08/07/15 13:36, Jon Medhurst (Tixy) wrote:
> On Tue, 2015-07-07 at 19:23 +0100, Morten Rasmussen wrote:
>> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>
>> To enable the parsing of clock frequency and cpu efficiency values
>> inside parse_dt_topology [arch/arm/kernel/topology.c] to scale the
>> relative capacity of the cpus, this property has to be provided within
>> the cpu nodes of the dts file.
>>
>> The patch is a copy of commit 8f15973ef8c3 ("ARM: vexpress: Add CPU
>> clock-frequencies to TC2 device-tree") taken from Linaro Stable Kernel
>> (LSK) massaged into mainline.
> 
> Not sure you really need to mention commit hashes from outside of the
> mainline Linux tree and the values I added to that commit were probably
> copied from some patch originating from ARM or elsewhere anyway. So the
> second paragraph is this commit message is probably superfluous. But
> this is nitpicking I guess :-)

Agreed. In the meantime we agreed that we don't have to use the
clock-frequency property for eas. Instead, we can derive the cpu
capacity values directly from the energy model. This will free us from
the dependency towards this dtb property and the cpu_efficiency for the
arm arch.
This patch won't be part of the next posting any more.

-- Dietmar

> 

