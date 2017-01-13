From: Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/4] selftest: cpufreq: Add support for cpufreq framework
Date: Fri, 13 Jan 2017 15:35:20 -0700
Message-ID: <bde954c8-d581-aa9d-a64d-2ca94e794f2f@kernel.org>
References: <cover.1484289212.git.viresh.kumar@linaro.org>
Reply-To: shuah@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1484289212.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 01/12/2017 11:36 PM, Viresh Kumar wrote:
> Hi,
> 
> This patchset adds support for cpufreq selftests to the kernel selftest
> framework. More details can be found on individual patches.
> 
> These are all tested after installation of selftests on ARM Dual A15
> core Exynos platform.
> 
> The content of the output file for the basic tests looks like this:
> http://pastebin.com/nBY9AfD5 .
> 
> --
> viresh

Hi Viresh,

Could you please add .gitignore for generated files. You can
send that as a separate patch and don't have to resend the
series.

thanks,
-- Shuah

> 
> Viresh Kumar (4):
>   selftest: cpufreq: Add support for cpufreq tests
>   selftest: cpufreq: Add suspend/resume/hibernate support
>   selftest: cpufreq: Add support to test cpufreq modules
>   selftest: cpufreq: Add special tests
> 
>  tools/testing/selftests/Makefile                 |   1 +
>  tools/testing/selftests/cpufreq/Makefile         |   8 +
>  tools/testing/selftests/cpufreq/cpu.sh           |  84 ++++++++
>  tools/testing/selftests/cpufreq/cpufreq.sh       | 241 ++++++++++++++++++++++
>  tools/testing/selftests/cpufreq/governor.sh      | 153 ++++++++++++++
>  tools/testing/selftests/cpufreq/main.sh          | 194 ++++++++++++++++++
>  tools/testing/selftests/cpufreq/module.sh        | 243 +++++++++++++++++++++++
>  tools/testing/selftests/cpufreq/special-tests.sh | 115 +++++++++++
>  8 files changed, 1039 insertions(+)
>  create mode 100644 tools/testing/selftests/cpufreq/Makefile
>  create mode 100755 tools/testing/selftests/cpufreq/cpu.sh
>  create mode 100755 tools/testing/selftests/cpufreq/cpufreq.sh
>  create mode 100755 tools/testing/selftests/cpufreq/governor.sh
>  create mode 100755 tools/testing/selftests/cpufreq/main.sh
>  create mode 100755 tools/testing/selftests/cpufreq/module.sh
>  create mode 100755 tools/testing/selftests/cpufreq/special-tests.sh
> 
