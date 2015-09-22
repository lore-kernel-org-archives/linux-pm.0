From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 2/5] PM / OPP: Support adjusting OPP voltages at
 runtime
Date: Tue, 22 Sep 2015 10:46:43 -0700
Message-ID: <20150922174643.GJ23081@codeaurora.org>
References: <1442623929-4507-1-git-send-email-sboyd@codeaurora.org>
 <1442623929-4507-3-git-send-email-sboyd@codeaurora.org>
 <20150922165041.GG24314@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55414 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbbIVRqp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 13:46:45 -0400
Content-Disposition: inline
In-Reply-To: <20150922165041.GG24314@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>

On 09/22, Viresh Kumar wrote:
> On 18-09-15, 17:52, Stephen Boyd wrote:
> >  /**
> > + * dev_pm_opp_adjust_voltage() - helper to change the voltage of an OPP
> > + * @dev:		device for which we do this operation
> > + * @freq:		OPP frequency to adjust voltage of
> > + * @u_volt:		new OPP voltage
> > + *
> > + * Change the voltage of an OPP with an RCU operation.
> > + *
> > + * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> > + * copy operation, returns 0 if no modifcation was done OR modification was
> 
>                                       modification
> 
> > + * successful.
> 
> Otherwise,
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

This typo is all over the file! I'll send a patch for that too.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
