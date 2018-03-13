From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] cpufreq: scmi: add thermal dependency
Date: Tue, 13 Mar 2018 15:27:18 +0100
Message-ID: <CAK8P3a0jXmeNXwNkq+qOcaCvMSkzpVhOoq6QRs=3c2B1DqiaVA@mail.gmail.com>
References: <20180313114607.2061209-1-arnd@arndb.de> <20180313114607.2061209-2-arnd@arndb.de>
 <357f8fbd-d079-8b75-aec6-96e59f5a9556@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <357f8fbd-d079-8b75-aec6-96e59f5a9556@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 13, 2018 at 3:09 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 13/03/18 11:45, Arnd Bergmann wrote:
>> A built-in scmi cpufreq driver cannot link against a modular
>> thermal framework:
>>
>> drivers/cpufreq/scmi-cpufreq.o: In function `scmi_cpufreq_ready':
>> scmi-cpufreq.c:(.text+0x40): undefined reference to `of_cpufreq_cooling_register'
>> drivers/cpufreq/scmi-cpufreq.o: In function `scmi_cpufreq_exit':
>> scmi-cpufreq.c:(.text+0x88): undefined reference to `cpufreq_cooling_unregister'
>>
>> This adds a Kconfig dependency that makes sure this configuration
>> is not possible, while allowing all configurations that can work.
>> Note that disabling CPU_THERMAL means we don't care about the
>> THERMAL dependency.
>>
>
> This newly added entry is only in arm-soc linux-next. Let me know if you
> want pull request with other possible fixes or you want to merge
> directly as it might be need to suppress these errors in your build
> system. For now I assume you will merge this directly in your tree, so
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

I've applied it into my next/drivers branch now. Thanks for the Ack.
I assume the cpufreq maintainers will pick up the other one. I'm not
sure why I didn't run into that problem earlier, but today I saw both
for the first time.

      Arnd
