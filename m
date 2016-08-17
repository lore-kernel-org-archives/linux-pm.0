From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: how to enable suspend to ram for arm-64 bits
Date: Wed, 17 Aug 2016 18:49:47 +0100
Message-ID: <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54279 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbcHQRtv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Aug 2016 13:49:51 -0400
In-Reply-To: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: yoma sophian <sophian.yoma@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>

Hi Yoma,

On 17/08/16 18:26, yoma sophian wrote:
> hi all: After I finish porting aarch64 linux kernel on my platform
> and enable CONFIG_PM and CONFIG_SUSPEND,  I found there is no output
> when I cat /sys/power/state.
>
> After tracing kernel code, kernel/power/suspend.c, it seems we need
> to create global suspend method table with suspend_set_ops then we
> can get valid pm_states.

Correct. What's the cpu enable method on your platform ? Is it PSCI ?
If yes, does you PSCI implementation support SYSTEM_SUSPEND ? If yes,
it should work. Check your PSCI implementation otherwise.

> Is any dts or place like arm/match-xxx for registering global suspend
> method?
>

No, currently only PSCI is supported and the firmware is queried and the
suspend_ops is registered automatically.

-- 
Regards,
Sudeep

-- 
Regards,
Sudeep
