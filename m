From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [PATCH] PM / suspend: Always use deepest C-state in the "freeze"
 sleep state
Date: Mon, 12 May 2014 22:19:08 +0800
Message-ID: <5370D85C.3090505@linux.intel.com>
References: <2548502.zJ1no3NhRc@vostro.rjw.lan> <5370D5E4.5040001@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62445 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756705AbaELOUY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 12 May 2014 10:20:24 -0400
In-Reply-To: <5370D5E4.5040001@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Aubrey Li <aubrey.li@intel.com>

On 2014/5/12 22:08, Daniel Lezcano wrote:
> On 05/05/2014 12:51 AM, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> If freeze_enter() is called, we want to bypass the current cpuidle
>> governor and always use the deepest available (that is, not disabled)
>> C-state, because we want to save as much energy as reasonably possible
>> then and runtime latency constraints don't matter at that point, since
>> the system is in a sleep state anyway.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> This is on top of https://patchwork.kernel.org/patch/4071541/ .
>>
> 
> Wouldn't make sense to revisit play_dead instead ?
> 
play_dead() is broken.

Even if it works, we still should rely on cpuidle driver to place the
CPUs into the deepest c-state, because there is no architectural way to
enter deepest c-state and what play_dead() does is a bad assumption.

Thanks,
-Aubrey

