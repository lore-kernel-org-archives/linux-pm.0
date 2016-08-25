From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [RFC/PATCH 1/2] cpuidle: Allow idle-states to be disabled at
 start
Date: Thu, 25 Aug 2016 23:46:34 +1000
Message-ID: <adaebfb8-239c-8a0b-21b4-47150e6f2035@gmail.com>
References: <cover.1471557381.git.ego@linux.vnet.ibm.com>
 <48afad7788300482c047fc35e70ca8e4bf31a5ac.1471557381.git.ego@linux.vnet.ibm.com>
 <57BDB2D8.4080507@linaro.org>
 <fe9a9667-cbbb-8fa2-5db0-2edd3220ca7b@gmail.com>
 <57BDB7F7.3090502@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35516 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934181AbcHYNqi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Aug 2016 09:46:38 -0400
In-Reply-To: <57BDB7F7.3090502@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling <michael.neuling@au1.ibm.com>, Paul Mackerras <paulus@samba.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>, linux-pm@vger.kernel.org



On 25/08/16 01:06, Daniel Lezcano wrote:
> On 08/24/2016 04:48 PM, Balbir Singh wrote:
>>
>>
>> On 25/08/16 00:44, Daniel Lezcano wrote:
>>> On 08/19/2016 12:26 AM, Gautham R. Shenoy wrote:
>>>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>>>>
>>>> Currently all the idle states registered by a cpu-idle driver are
>>>> enabled by default. This patch adds a mechanism which allows the
>>>> driver to hint if an idle-state should start in a disabled state. The
>>>> cpu-idle core will use this hint to appropriately initialize the
>>>> usage->disable knob of the CPU device idle state.
>>>
>>> Why do you need to do that ?
>>>
>>
>> I think patch 2/2 explains the reason as it uses this infrastructure
> 
> Ok, let me elaborate the question, I was not clear.
> 
> Why the userspace can't setup the system environment at boot time by
> disabling the state instead of adding extra code to disable it at boot
> time in the kernel and then re-enable it from userspace ?

Gautham's patches don't want to have those states enabled by default.
They are unlikely to be what production systems need, but likely
what a knowledgeable person can look into selectively enable for
experimentation.

@Gautham?


Balbir Singh.
