From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] PM / OPP: Move CONFIG_OF dependent code in a separate
 file
Date: Thu, 5 May 2016 15:00:11 +0100
Message-ID: <572B51EB.1080505@arm.com>
References: <1f90c873e5801967acbb2e38fe0b268189247049.1462445391.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50151 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754017AbcEEOAR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 May 2016 10:00:17 -0400
In-Reply-To: <1f90c873e5801967acbb2e38fe0b268189247049.1462445391.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, eric.engestrom@imgtec.com, rufus.hamade@imgtec.com, linux-kernel@vger.kernel.org



On 05/05/16 11:50, Viresh Kumar wrote:
> Recently few issues were noticed in the code where CONFIG_OF wasn't
> consistently used for many routines. The core file is big enough now and
> ifdef hackery makes it less readable.
>
> Move OF specific code to another file and compile that only if CONFIG_OF
> is enabled.
>
> Compile-tested:
> - For ARM (exynos) with CONFIG_OF enabled
> - For X86 with CONFIG_OF disabled (have to enable CONFIG_PM_OPP separately)
>

Just gave it a spin on ARM64 Juno on top of linux-pm/bleeding-edge so
you can have:

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
