From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/4][V2] ARM: nomadik: add dynamic irq flag to the
 timer
Date: Fri, 8 Mar 2013 17:03:49 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303081703160.22263@ionos>
References: <1362219013-18173-1-git-send-email-daniel.lezcano@linaro.org> <513A0109.9060801@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55175 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759692Ab3CHQD6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Mar 2013 11:03:58 -0500
In-Reply-To: <513A0109.9060801@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: john.stultz@linaro.org, linus.walleij@stericsson.com, viresh.kumar@linaro.org, jacob.jun.pan@linux.intel.com, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, rickard.andersson@stericsson.com, vincent.guittot@linaro.org

On Fri, 8 Mar 2013, Daniel Lezcano wrote:

> > Add the dynamic irq affinity feature to the timer clock device.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
> > ---
> 
> Hi Linus,
> 
> AFAIU, you are ok with this patch, Rickard acked it and Vincent reviewed it.
> 
> Thomas agreed to merge it into its tree as I requested because we will
> need to wait for your tree to gain visibility to this new flag before
> submitting this patch, which can take awhile.
> 
> Could you please ack it if it is ok for you ?

I can provide a for-arm tree to pull as well. Either way fine with me.

Thanks,

	tglx
