From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 2/2] cpufreq: Change freq before suspending governors
Date: Fri, 22 Nov 2013 13:37:50 +0100
Message-ID: <2783049.JzUB2QcsZz@vostro.rjw.lan>
References: <cover.1385118255.git.viresh.kumar@linaro.org> <df162ba4cbdf1379ccfa5dd4ca34153626ae9c71.1385118256.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54764 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753064Ab3KVMZI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2013 07:25:08 -0500
In-Reply-To: <df162ba4cbdf1379ccfa5dd4ca34153626ae9c71.1385118256.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, tianyu.lan@intel.com, nm@ti.com, jinchoi@broadcom.com, sebastian.capella@linaro.org

On Friday, November 22, 2013 04:59:49 PM Viresh Kumar wrote:
> Some platforms might want to change frequency before suspending governors. Like:
> - Some platform which want to set freq to max to speed up suspend/hibernation
>   process.
> - Some platform (like: Tegra or exynos), set this to min or bootloader's
>   frequency.
> 
> This patch adds an option for those, so that they can specify this at call to
> ->init(), so that cpufreq core can take care of this before suspending system.
> 
> If this variable is not updated by ->init() then its value would be zero and so
> core wouldn't do anything.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I don't think this is generally necessary, because the suspend/resume routines
added by patch [1/2] will be executed very late during suspend or very early
during resume and it shouldn't really matter what performance levels the CPUs
are at then.

The only exception *may* be hibernation, because the amount of time needed to
create the image will depend on the current performance level of the boot CPU,
but that should be an explicitly special case in my opinion.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
