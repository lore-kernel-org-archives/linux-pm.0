From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: apm_32.c: undefined reference to `cpuidle_poll_state_init'
Date: Thu, 15 Feb 2018 17:08:20 +0100
Message-ID: <aa8d3514-a22c-703b-f59a-a05bad9cfdf6@intel.com>
References: <alpine.LRH.2.21.1802141954010.25362@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39255 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424477AbeBOQIX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Feb 2018 11:08:23 -0500
In-Reply-To: <alpine.LRH.2.21.1802141954010.25362@math.ut.ee>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, x86@kernel.org, Linux PM <linux-pm@vger.kernel.org>

On 2/14/2018 7:02 PM, Meelis Roos wrote:
> This is 4.16-rc1+git as of today, on a IBM PC 365 that uses APM instead
> of ACPI. APM linking fails:
>
>    MODPOST vmlinux.o
> arch/x86/kernel/apm_32.o: In function `apm_init':
> apm_32.c:(.init.text+0x597): undefined reference to `cpuidle_poll_state_init'

There is a fix for that already in the linux-pm tree: 
https://patchwork.kernel.org/patch/10212015/

Thanks,
Rafael
