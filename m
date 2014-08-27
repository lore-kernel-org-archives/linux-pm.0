From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 3/4] irq: Allow multiple clients to register for irq
 affinity notification
Date: Wed, 27 Aug 2014 22:56:41 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1408272239190.3323@nanos>
References: <1409170479-29955-1-git-send-email-lina.iyer@linaro.org> <1409170479-29955-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35965 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932159AbaH0U4o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Aug 2014 16:56:44 -0400
In-Reply-To: <1409170479-29955-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: khilman@linaro.org, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, daniel.lezcano@linaro.org

On Wed, 27 Aug 2014, Lina Iyer wrote:

> PM QoS and other idle frameworks can do a better job of addressing power
> and performance requirements for a cpu, knowing the IRQs that are
> affine to that cpu. If a performance request is placed against serving
> the IRQ faster and if the IRQ is affine to a set of cpus, then setting
> the performance requirements only on those cpus help save power on the
> rest of the cpus. PM QoS framework is one such framework interested in
> knowing the smp_affinity of an IRQ and the change notificiation in this
> regard. QoS requests for the CPU_DMA_LATENCY constraint currently apply
> to all cpus, but when attached to an IRQ, can be applied only to the set
> of cpus that IRQ's smp_affinity is set to. This allows other cpus to
> enter deeper sleep states to save power. More than one framework/driver
> can be interested in such information.

All you are describing is the fact, that there is only a single
notifier possible right now, but you completely miss to describe WHY
you need multiple ones.

The existing notifier was introduced to tell the driver that the irq
affinity has changed, so it can move its buffers to the proper NUMA
node. So if that driver gets this information then it can tell the PM
QoS code that its affinity changed so that stuff can react
accordingly, right?

This is going nowhere unless you provide a proper usecase and
arguments why this is necessary. Handwaving and I want a pony
arguments are not sufficient.

Thanks,

	tglx
