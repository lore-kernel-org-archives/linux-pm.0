From: Tim Walberg <twalberg@comcast.net>
Subject: Re: 4.8.1 regression with cpufreq governors
Date: Wed, 19 Oct 2016 15:06:10 -0500
Message-ID: <20161019200610.GB9047@comcast.net>
References: <20161018004606.GA5559@comcast.net>
 <2549240.nvakNXlyKF@vostro.rjw.lan>
Reply-To: Tim Walberg <twalberg@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2549240.nvakNXlyKF@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tim Walberg <twalberg@comcast.net>, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This indeed turned out to be the fix.

On 10/18/2016 23:10 +0200, Rafael J. Wysocki wrote:
>>	On Monday, October 17, 2016 07:46:06 PM Tim Walberg wrote:
>>	> May or may not be related to similar reports, but here's what I've just observed
>>	> on my system. Built a stock kernel from tags/v4.8.1, relevant cpufreq bits:
>>	> 
>>	> CONFIG_ACPI_CPU_FREQ_PSS=y
>>	> CONFIG_CPU_FREQ=y
>>	> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
>>	> CONFIG_CPU_FREQ_GOV_COMMON=y
>>	> CONFIG_CPU_FREQ_STAT=y
>>	> CONFIG_CPU_FREQ_STAT_DETAILS=y
>>	> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
>>	> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
>>	> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
>>	> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
>>	> CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
>>	> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
>>	> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
>>	> CONFIG_CPU_FREQ_GOV_POWERSAVE=m
>>	> CONFIG_CPU_FREQ_GOV_USERSPACE=m
>>	> CONFIG_CPU_FREQ_GOV_ONDEMAND=m
>>	> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>>	> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=m
>>	> # CONFIG_X86_PCC_CPUFREQ is not set
>>	> CONFIG_X86_ACPI_CPUFREQ=m
>>	> CONFIG_X86_ACPI_CPUFREQ_CPB=y
>>	> 
>>	> 
>>	> Conservative is set as default governer, yet when boot completes, all CPUs are
>>	> pegged at the highest frequency. Changing governor to powersave knocks them all
>>	> down to the lowest available frequency. Putting them back on conservative (or
>>	> ondemand) results in no change in frequency, despite generating load. Switching
>>	> to performance of course kicks them back up to high frequency. Basically, the
>>	> governors don't seem to be ... governing.
>>	
>>	The "convervative" governor issue seems to be the one fixed recently
>>	(http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=pm-cpufreq&id=abb6627910a1e783c8e034b35b7c80e5e7f98f41).
>>	
>>	I'm not sure why "ondemand" behaves incorrectly for you though.
>>	
>>	Thanks,
>>	Rafael
End of included message



-- 
twalberg@gmail.com, twalberg@comcast.net
