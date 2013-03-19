From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 2/2] cpuidle / calxeda: remove redundant Kconfig option
Date: Tue, 19 Mar 2013 10:13:51 -0500
Message-ID: <514880AF.7010404@gmail.com>
References: <1363080476-26555-1-git-send-email-daniel.lezcano@linaro.org> <1363080476-26555-2-git-send-email-daniel.lezcano@linaro.org> <51485876.307@gmail.com> <514877B5.6080200@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:42548 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608Ab3CSPN4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Mar 2013 11:13:56 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so539892obb.3
        for <linux-pm@vger.kernel.org>; Tue, 19 Mar 2013 08:13:54 -0700 (PDT)
In-Reply-To: <514877B5.6080200@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 03/19/2013 09:35 AM, Daniel Lezcano wrote:
> On 03/19/2013 01:22 PM, Rob Herring wrote:
>> On 03/12/2013 04:27 AM, Daniel Lezcano wrote:
>>> When the CPU_IDLE and the ARCH_HIGHBANK options are set it is
>>> pointless to define a new option CPU_IDLE_CALXEDA because it
>>> is redundant.
>>>
>>> The Makefile drivers directory contains a condition to compile
>>> the cpuidle drivers:
>>>
>>> obj-$(CONFIG_CPU_IDLE)          += cpuidle/
>>>
>>> Hence, if CPU_IDLE is not set we won't enter this directory.
>>>
>>> This patch removes the useless Kconfig option and replaces the
>>> condition in the Makefile by CONFIG_ARCH_HIGHBANK.
>>
>> If I have multiple platforms including highbank compiled in, but want to
>> disable cpuidle just for highbank, then you can't disable it at compile
>> time.
> 
> Could you elaborate a bit ? Is it today possible to have multiple
> platforms in a single kernel ?

You've heard of single zImage, right? Vexpress, mvebu, highbank, imx,
omap2+, socfpga, vt8500 off the top of my head as of 3.8.

Rob
