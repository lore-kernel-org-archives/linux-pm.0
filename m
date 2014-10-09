From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v8 4/7] qcom: pm: Add cpu low power mode functions
Date: Thu, 9 Oct 2014 12:00:57 -0700
Message-ID: <20141009190057.GA5493@codeaurora.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-5-git-send-email-lina.iyer@linaro.org>
 <5435E245.1090507@codeaurora.org>
 <20141009155643.GB1277@ilina-mac.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:37807 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaJITA7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 15:00:59 -0400
Content-Disposition: inline
In-Reply-To: <20141009155643.GB1277@ilina-mac.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 10/09, Lina Iyer wrote:
> On Wed, Oct 08 2014 at 19:17 -0600, Stephen Boyd wrote:
> 
> >>+static int __init qcom_pm_device_init(void)
> >>+{
> >>+	platform_device_register(&qcom_cpuidle_device);
> >>+
> >
> >This is wrong. We're going to register a platform device whenever
> >this file is included in a kernel. This is then going to try and
> >probe the qcom_cpuidle device which is going to fail and print an
> >error message if we're not running on a qcom device.
> Why would this file be compiled on a non-qcom target? The file has a
> dependency on ARCH_QCOM (as it should be) and would not be compiled on a
> non-qcom target.

We will compile this file on non-qcom devices in a multi-platform
kernel build. Actually that looks like it would be a problem
because cpuidle_register() will blow away any other registered
driver on non-qcom devices.

> 
> >This is one reason why I've been arguing to get rid of this file
> >and just put it inside the spm driver. That way we don't ever add
> >the cpuidle device and:
> That is a poor excuse for removing this file, which has a purpose.
> Putting all this SCM code inside SPM is not a good design. SPM is a
> driver, doesnt know about SCM et al. Why would you want to clobber that
> file with all these irrelevant code? 8660 does not have a secure mode,
> but still uses an SPM. So all this code is pretty useless there, not
> that we are supporting 8660 at this time, just as an example.

On 8660 we still have to tell the secure code where to jump to
when we come out of power collapse. The only difference is if
we execute or don't execute the wfi in the kernel.

The only thing that really matters to me is that we don't add
useless devices and do things unnecessarily on non-qcom devices
when this code is compiled in. The easiest way to do that is to
register a saw driver and then do stuff in probe when the saw
device appears. We can probably add individual cpuidle devices
when each CPU's saw probes and register a cpuidle driver once
based on some static variable after we register the first cpuidle
device.

> >
> >a) We know the SPM hardware is configured and ready to be used
> Its just one line check to see if the SPM hardware exists. There is no
> error otherwise.

I'm talking about a probe ordering dependency that would become
explicit if we had one file instead of two.

> >b) We don't get this annoying warning and have some weird device
> >in sysfs on non-qcom devices
> We wont compile this file on non-qcom device, so the point is moot.
> Well, we may see the error, if the cpuidle framework is not compiled in.
> But putthing this in SPM doesnt solve that problem either.

See above, this file will be compiled and included.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
