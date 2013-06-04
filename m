From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: bit.LITTLE needs cpufreq table
Date: Tue, 4 Jun 2013 10:12:32 +0530
Message-ID: <CAKohponKKMvHQQvr+K44YfpD0Ykxj_OKc5K+LhKShGXQV3aYgg@mail.gmail.com>
References: <3453738.rxYxRehmQz@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <3453738.rxYxRehmQz@wuerfel>
Sender: cpufreq-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 4 June 2013 03:11, Arnd Bergmann <arnd@arndb.de> wrote:
> Like a lot of the other cpufreq drivers, this one needs to
> select CONFIG_CPU_FREQ_TABLE to avoid a build error like
>
> built-in.o: In function `bL_cpufreq_set_target':
> cpufreq/arm_big_little.c:71: undefined reference to `cpufreq_frequency_table_target'
> built-in.o: In function `bL_cpufreq_verify_policy':
> cpufreq/arm_big_little.c:55: undefined reference to `cpufreq_frequency_table_verify'
> built-in.o: In function `bL_cpufreq_init':
> cpufreq/arm_big_little.c:170: undefined reference to `cpufreq_frequency_table_cpuinfo'
> cpufreq/arm_big_little.c:178: undefined reference to `cpufreq_frequency_table_get_attr'
> built-in.o:(.data+0x5a80c): undefined reference to `cpufreq_freq_attr_scaling_available_freqs'
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>

Applied.
