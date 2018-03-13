From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] cpufreq: scpi: add thermal dependency
Date: Tue, 13 Mar 2018 14:06:41 +0000
Message-ID: <882eb475-4cb7-98dd-8c16-dbab8df04d24@arm.com>
References: <20180313114607.2061209-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313114607.2061209-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 13/03/18 11:45, Arnd Bergmann wrote:
> A built-in scpi cpufreq driver cannot link against a modular
> thermal framework:
> 
> drivers/cpufreq/scpi-cpufreq.o: In function `scpi_cpufreq_ready':
> scpi-cpufreq.c:(.text+0x4c): undefined reference to `of_cpufreq_cooling_register'
> drivers/cpufreq/scpi-cpufreq.o: In function `scpi_cpufreq_exit':
> scpi-cpufreq.c:(.text+0x9c): undefined reference to `cpufreq_cooling_unregister'
> 
> This adds a Kconfig dependency that makes sure this configuration
> is not possible, while allowing all configurations that can work.
> Note that disabling CPU_THERMAL means we don't care about the
> THERMAL dependency.
> 

Makes sense,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
