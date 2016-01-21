From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 17/17] cpufreq: dt: No need to allocate resources anymore
Date: Wed, 20 Jan 2016 18:45:41 -0800
Message-ID: <56A04655.40106@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <df2534b4ced57791ec3ee42eb34211e132aa423a.1450777582.git.viresh.kumar@linaro.org>
 <20160112022022.GV22188@codeaurora.org> <20160112073426.GP1084@ubuntu>
 <20160121011806.GE12841@codeaurora.org> <20160121023610.GC15981@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59263 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756461AbcAUCpn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 21:45:43 -0500
In-Reply-To: <20160121023610.GC15981@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 01/20/2016 06:36 PM, Viresh Kumar wrote:
> On 20-01-16, 17:18, Stephen Boyd wrote:
>> Yeah I don't understand why we at least can't populate the OPP
>> structures and get the clocks and regulators for all the CPU
>> devices before we register the dt_cpufreq_driver structure. The
>> CPU devices should exist at that point, and we can wait to do
>> CPUfreq transitions until the regulators/clocks for all the CPUs
>> are registered. Sure we'd need to find the OPPs that are being
>> shared in the cpufreq_init callback and populate the cpu
>> frequency tables, etc., but that's not a big deal.
> We can do this, yes. But ->init() was really the right place to fix
> that, we aren't able to do it properly because we lack a cpu processor
> driver for ARM.

Sorry I don't understand why ->init() is so important here. It seems
like ->init() is being used because we lack a proper processor driver on
ARM, but it isn't required and I don't see how it could be the right
place to handle any probe defer stuff because that's already been
rejected by Rafael and Greg.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

