From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH][V2] cpuidle: simplify multiple driver support
Date: Tue, 28 May 2013 23:28:09 +0200
Message-ID: <3656140.hejcxbMi3x@vostro.rjw.lan>
References: <1369227904-16234-1-git-send-email-daniel.lezcano@linaro.org> <51A51CBD.5060301@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:53585 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755235Ab3E1VTQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 May 2013 17:19:16 -0400
In-Reply-To: <51A51CBD.5060301@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Francesco Lavra <francescolavra.fl@gmail.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Len Brown <lenb@kernel.org>

On Tuesday, May 28, 2013 11:08:13 PM Daniel Lezcano wrote:
> On 05/22/2013 03:05 PM, Daniel Lezcano wrote:
> > Commit bf4d1b5ddb78f86078ac6ae0415802d5f0c68f92 brought the multiple driver
> > support. The code added a couple of new API to register the driver per cpu.
> > That led to some code complexity to handle the kernel config options when
> > the multiple driver support is enabled or not, which is not really necessary.
> > The code has to be compatible when the multiple driver support is not enabled,
> > and the multiple driver support has to be compatible with the old api.
> >
> > This patch removes this API, which is not yet used by any driver but needed
> > for the HMP cpuidle drivers which will come soon, and replaces its usage
> > by a cpumask pointer in the cpuidle driver structure telling what cpus are
> > handled by the driver. That let the API cpuidle_[un]register_driver to be used
> > for the multipled driver support and also the cpuidle_[un]register functions,
> > added recently in the cpuidle framework.
> >
> > The current code, a bit poor in comments, has been commented and simplified.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >
> > [V2]:
> >  - fixed bad refcount check
> >  - inverted clockevent notify off order at unregister time
> 
> Hi Rafael,
> 
> could you consider this patch for merging ? I took into account
> Francesco's comments.

I'm waiting for Len to have a look at it which may take a few days more.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
