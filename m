From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V4 4/7] cpufreq: governor: Move common sysfs tunables to cpufreq_governor.c
Date: Wed, 10 Feb 2016 01:26:52 +0100
Message-ID: <CAJZ5v0jtUdjq362zeN1139m_2-Vb9yHjAB0ixMQTuCFv2C+dnA@mail.gmail.com>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
	<18cf5aab3f90b9d9db2d269057a309b624ea7924.1454988792.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34626 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbcBJA0y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 19:26:54 -0500
In-Reply-To: <18cf5aab3f90b9d9db2d269057a309b624ea7924.1454988792.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 9, 2016 at 4:46 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> We have got five common sysfs tunables between ondemand and conservative
> governors, move their callbacks to cpufreq_governor.c to get rid of
> redundant code.
>
> Because of minor differences in the implementation of the callbacks,
> some more per-governor callbacks are introduced in order to not
> introduce any more "governor == ONDEMAND/CONSERVATIVE" like checks.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Juri Lelli <juri.lelli@arm.com>
> Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

To me, the benefit from this patch is marginal and the cost is quite
substantial.

The code is really only duplicate if both governors are non-modular or
their modules are both loaded at the same time and it's not worth
adding the new governor callbacks IMO.

If the implementation of the given show/store pair is different enough
that you need an extra callback to move them to _governor.c, I won't
bother doing that.

Thanks,
Rafael
