From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Subject: Re: [PATCH] cpuidle: Add "cpuidle.use_deepest" to bypass governor and
 allow HW to go deep
Date: Thu, 16 Nov 2017 17:11:28 +0100
Message-ID: <9371b55d-c4eb-c3e0-aadf-f624ec72a83f@tu-dresden.de>
References: <1d81edef71c936099f8bb9d16162f8e70fbe401c.1510212816.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout6.zih.tu-dresden.de ([141.30.67.75]:57400 "EHLO
        mailout6.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1760039AbdKPQLd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2017 11:11:33 -0500
In-Reply-To: <1d81edef71c936099f8bb9d16162f8e70fbe401c.1510212816.git.len.brown@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: dsmythies@telus.net, linux-pm@vger.kernel.org, jacob.jun.pan@linux.intel.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On 2017-11-09 08:38, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> While there are several mechanisms (cmdline, sysfs, PM_QOS) to limit
> cpuidle to shallow idle states, there is no simple mechanism
> to give the hardware permission to enter the deeptest state permitted by PM_QOS.
> 
> Here we create the "cpuidle.use_deepest" modparam to provide this capability.
> 
> "cpuidle.use_deepest=Y" can be set at boot-time, and
> /sys/module/cpuidle/use_deepest can be modified (with Y/N) at run-time.

This is a good option to have and can conveniently prevent idle power consumption
issues. But that wouldn't be a reasonable default, would it?
I still think there is an inherent need for a heuristic and a corresponding
mitigation to avoid staying in a sleep state too long.

Best,
Thomas
