From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] cpufreq: dt: Support platforms with separate clock
 lines for each CPU
Date: Wed, 10 Sep 2014 08:29:37 +0200
Message-ID: <20140910082937.0780fd28@free-electrons.com>
References: <fcb88cd21f31a467d2d49911c2505082837f72ea.1410323179.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34665 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750766AbaIJG3y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 02:29:54 -0400
In-Reply-To: <fcb88cd21f31a467d2d49911c2505082837f72ea.1410323179.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, t.figa@samsung.com, santosh.shilimkar@ti.com, pramod.gurav@smartplayin.com, rob.herring@linaro.org, mike.turquette@linaro.org

Dear Viresh Kumar,

On Wed, 10 Sep 2014 09:59:07 +0530, Viresh Kumar wrote:

> Yesterday again I was pinged by Thomas about the status of this work and the
> thread isn't going anywhere. He is blocked with just this to get his platform
> running on mainline.
> 
> Will it be possible to get this through as a temporary solution?

A compile time conditional does not work, as it isn't compatible with
multiplatform: what if in the same kernel you want to support two
platforms that use cpufreq-dt, one having a single clock for all CPUs,
and one having one clock per CPU.

I'm still confused as to what is the problem with the DT binding
surrounding this driver. Isn't it simply a matter of adding a clocks =
<...> property to all CPUs, and that's it?

Viresh told me there was an issue related to comparing the clocks in
the driver to find out which CPUs share which clocks. But that is not a
DT binding issue, it's an implementation detail. Since the driver is
purely for DT platforms (as its name suggest), comparing phandles could
work as a temporary solution. And since it's just an implementation
detail that doesn't affect the DT binding, we could change the
implementation later to use a proper clock API like clk_is_same(clk1,
clk2) that would tell us if the clocks are the same.

But I have probably missed some of the complexity of this.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
