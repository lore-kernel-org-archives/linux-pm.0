From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v3 3/4] irq: Allow multiple clients to register for irq
 affinity notification
Date: Tue, 2 Sep 2014 12:43:05 -0600
Message-ID: <20140902184305.GB91995@ilina-mac.local>
References: <1409170479-29955-1-git-send-email-lina.iyer@linaro.org>
 <1409170479-29955-4-git-send-email-lina.iyer@linaro.org>
 <alpine.DEB.2.10.1408272239190.3323@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36666 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbaIBSnK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 14:43:10 -0400
Received: by mail-pd0-f170.google.com with SMTP id r10so9221592pdi.15
        for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2014 11:43:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1408272239190.3323@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: khilman@linaro.org, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, daniel.lezcano@linaro.org

On Wed, Aug 27 2014 at 14:56 -0600, Thomas Gleixner wrote:
>On Wed, 27 Aug 2014, Lina Iyer wrote:
>
>> PM QoS and other idle frameworks can do a better job of addressing power
>> and performance requirements for a cpu, knowing the IRQs that are
>> affine to that cpu. If a performance request is placed against serving
>> the IRQ faster and if the IRQ is affine to a set of cpus, then setting
>> the performance requirements only on those cpus help save power on the
>> rest of the cpus. PM QoS framework is one such framework interested in
>> knowing the smp_affinity of an IRQ and the change notificiation in this
>> regard. QoS requests for the CPU_DMA_LATENCY constraint currently apply
>> to all cpus, but when attached to an IRQ, can be applied only to the set
>> of cpus that IRQ's smp_affinity is set to. This allows other cpus to
>> enter deeper sleep states to save power. More than one framework/driver
>> can be interested in such information.
>
>All you are describing is the fact, that there is only a single
>notifier possible right now, but you completely miss to describe WHY
>you need multiple ones.
>
>The existing notifier was introduced to tell the driver that the irq
>affinity has changed, so it can move its buffers to the proper NUMA
>node. So if that driver gets this information then it can tell the PM
>QoS code that its affinity changed so that stuff can react
>accordingly, right?
>
With the new PM QoS changes, multiple drivers would now be interested in
knowing the smp_affinity changes of the same IRQ. PM QoS abstracts the
notifier in the framework, so individual drivers dont have to register
for notification themselves and handle affinity notifications. But PM
QoS needs to coexist with NUMA and other arch drivers that need to
modify based on their arch specific needs upon affinity change
notifications.
Modifying the IRQ notifications to list, benefits having a simpler
mechanism to notify all arch drivers and frameworks like PM QoS.


>This is going nowhere unless you provide a proper usecase and
>arguments why this is necessary. Handwaving and I want a pony
>arguments are not sufficient.
>
>Thanks,
>
>	tglx
