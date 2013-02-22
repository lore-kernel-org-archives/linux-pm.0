From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2][RFC] time : set broadcast irq affinity
Date: Fri, 22 Feb 2013 19:45:32 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302221945170.22263@ionos>
References: <5123C299.3080005@linaro.org> <1361484083-5906-1-git-send-email-daniel.lezcano@linaro.org> <1361484083-5906-2-git-send-email-daniel.lezcano@linaro.org> <20130222095530.377fd218@chromoly>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59632 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659Ab3BVSpf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Feb 2013 13:45:35 -0500
In-Reply-To: <20130222095530.377fd218@chromoly>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, linux-pm@vger.kernel.org, fweisbec@gmail.com, john.stultz@linaro.org, linaro-kernel@lists.linaro.org

On Fri, 22 Feb 2013, Jacob Pan wrote:
> On Thu, 21 Feb 2013 23:01:23 +0100
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> 
> > +/*
> > + * Set broadcast interrupt affinity
> > + */
> > +static void tick_broadcast_set_affinity(struct clock_event_device
> > *bc, int cpu) +{
> > +	struct cpumask cpumask;
> > +
> > +	if (!(bc->features & CLOCK_EVT_FEAT_DYNIRQ))
> > +		return;
> > +
> > +	cpumask_clear(&cpumask);
> > +	cpumask_set_cpu(cpu, &cpumask);
> > +	irq_set_affinity(bc->irq, &cpumask);
> would it be more efficient to keep track of the current bc->irq affinity
> via cpumask then set it only if it is different?

You beat me :)
