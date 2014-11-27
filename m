From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v10 07/10] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Thu, 27 Nov 2014 10:23:08 +0000
Message-ID: <20141127102308.GA6560@red-moon>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
 <1416593037-27527-8-git-send-email-lina.iyer@linaro.org>
 <5475A599.1010601@linaro.org>
 <7hegspeoje.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40396 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaK0KXS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 05:23:18 -0500
Content-Disposition: inline
In-Reply-To: <7hegspeoje.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Kevin,

On Wed, Nov 26, 2014 at 07:43:01PM +0000, Kevin Hilman wrote:
> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
> 
> > On 11/21/2014 07:03 PM, Lina Iyer wrote:
> >> Add cpuidle driver interface to allow cpus to go into C-States. Use the
> >> cpuidle DT interface, common across ARM architectures, to provide the
> >> idle state information to the cpuidle framework.
> >>
> >> Supported modes at this time are Standby and Standalone Power Collapse.
> >>
> >> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> >
> > One nit and one comment below. Other than that:
> >
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > [ ... ]
> >
> >> +static int qcom_cpu_stby(struct cpuidle_device *dev,
> >> +				struct cpuidle_driver *drv, int index)
> >> +{
> >> +	lpm_ops->standby(NULL);
> >
> > In my last comment I was referring about a check for entering
> > successfully the idle state:
> >
> > 	if (lpm_ops->standby(NULL))
> > 		return -1;
> >
> >> +	return index;
> >> +}
> >> +
> >> +static int qcom_cpu_spc(struct cpuidle_device *dev,
> >> +				struct cpuidle_driver *drv, int index)
> >> +{
> >> +	lpm_ops->spc(NULL);
> >> +
> >> +	return index;
>  
> Similar to Daniel's comment above.  if lpm_ops->spc() fails, do you want
> to fall back to standby.
> 
> Hmm, using the DT idle states, it doesn't look as straight forward as it
> used to be to fall back to a "safe state."

What do you mean by "safe state" ? As in coupled idle states ?

It is just for me to understand why DT makes things more complicated :)

If the idle state enter fails it might also be because there is an
aborted power down owing to eg pending IRQ, there would be no reason
why you would revert to standby instead of going back to the kernel, so
error code must be explicit at least in that respect.

Thanks,
Lorenzo
