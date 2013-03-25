From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 0/9] ARM: CPUFreq: Move drivers arch/arm/ -> drivers/cpufreq
Date: Mon, 25 Mar 2013 10:49:45 -0600
Message-ID: <51508029.6050801@wwwdotorg.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, linux@arm.linux.org.uk
List-Id: linux-pm@vger.kernel.org

On 03/25/2013 04:11 AM, Viresh Kumar wrote:
> Hi,
> 
> This patchset tries to move all CPUFreq drivers for ARM platforms from arch/arm
> to drivers/cpufreq directory.
> 
> This series is dependent (rebased of) on following patches:
> 
> http://www.spinics.net/lists/arm-kernel/msg232540.html
> https://lkml.org/lkml/2013/3/24/151
> 
> I want this series to go through Rafael's tree due to dependencies and so want
> Ack's by respective maintainers.

Patches 1 and 2,

Acked-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>

On Tegra.
