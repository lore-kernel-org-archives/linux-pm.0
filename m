From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] CPUFreq stats: Bug fixes
Date: Mon, 06 Jan 2014 22:02:35 +0100
Message-ID: <1555125.bAi9TgavWd@vostro.rjw.lan>
References: <cover.1380190886.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380190886.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, nicolas.pitre@linaro.org
List-Id: linux-pm@vger.kernel.org

On Thursday, September 26, 2013 03:59:50 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> I know you asked me not to send any more patches before the earlier ones get
> into kernel. I got to this as Nicolas Pitre required to send few CPUFreq patches
> for ARM's big LITTLE In-Kernel-Switcher. And within linaro we have hacked these
> bugs in a bad way..
> 
> Because of his dependency I am forced to send these.. These aren't introduced
> recently and so they can be included in 3.13.
> 
> There are several problems/bugs in cpufreq-stats specially with cpufreq drivers
> as modules and suspend/resume path. These are mentioned well in changelogs.
> 
> These are tested over my thinkpad (acpi-cpufreq) in following way:
> [1] offline+online all CPUs except boot cpu in a while loop
> [2] then do suspend resume
> [3] repeat [1] and [2] several times.
> 
> No issues found..
> 
> Also tested on my exynos board:
> - Added cpufreq_unregister/register while loop in exynos-cpufreq.c so that we
>   continuously register/unregister driver... Stats were working fine now..
> - Compile cpufreq-stats as module and insert/remove it several times after
>   removing above hack (as that doesn't let linux boot :) )..
> 
> @Srivatsa: You also have fairly good idea of cpufreq now, so please give some
> time to review this :)
> 
> @Nico: Can you remove the hacky code from IKS tree and test these instead to see
> if we still have any issues?

Can you please rebase this series on top of linux-pm.git/bleeding-edge and
resend it?  Chances are it might make it into 3.14.

Thanks,
Rafael

