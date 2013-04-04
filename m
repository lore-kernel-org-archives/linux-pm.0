From: Arnd Bergmann <arnd.bergmann@linaro.org>
Subject: Re: [PATCH 0/9] ARM: CPUFreq: Move drivers arch/arm/ -> drivers/cpufreq
Date: Thu, 4 Apr 2013 09:38:11 +0000
Message-ID: <201304040938.11760.arnd.bergmann@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linux@arm.linux.org.uk
List-Id: linux-pm@vger.kernel.org

On Monday 25 March 2013, Viresh Kumar wrote:
> 
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
> 
> These are applied here for people looking to test them:
> 
> http://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=shortlog;h=refs/heads/cpufreq-move-drivers

Whole series 

Acked-by: Arnd Bergmann <arnd@arndb.de>

but please post them another time with linux-arm-kernel on Cc.

	Arnd
