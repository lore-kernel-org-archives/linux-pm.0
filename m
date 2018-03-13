From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: scmi: add thermal dependency
Date: Tue, 13 Mar 2018 14:09:34 +0000
Message-ID: <357f8fbd-d079-8b75-aec6-96e59f5a9556@arm.com>
References: <20180313114607.2061209-1-arnd@arndb.de>
 <20180313114607.2061209-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313114607.2061209-2-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 13/03/18 11:45, Arnd Bergmann wrote:
> A built-in scmi cpufreq driver cannot link against a modular
> thermal framework:
> 
> drivers/cpufreq/scmi-cpufreq.o: In function `scmi_cpufreq_ready':
> scmi-cpufreq.c:(.text+0x40): undefined reference to `of_cpufreq_cooling_register'
> drivers/cpufreq/scmi-cpufreq.o: In function `scmi_cpufreq_exit':
> scmi-cpufreq.c:(.text+0x88): undefined reference to `cpufreq_cooling_unregister'
> 
> This adds a Kconfig dependency that makes sure this configuration
> is not possible, while allowing all configurations that can work.
> Note that disabling CPU_THERMAL means we don't care about the
> THERMAL dependency.
> 

This newly added entry is only in arm-soc linux-next. Let me know if you
want pull request with other possible fixes or you want to merge
directly as it might be need to suppress these errors in your build
system. For now I assume you will merge this directly in your tree, so

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
