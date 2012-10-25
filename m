From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Fix sparse warnings by updating cputime64_t
 to u64
Date: Thu, 25 Oct 2012 09:00:22 +0530
Message-ID: <CAKohpo=Sw6eUP6Xk3=a=rk6WMJQta=T7ReBPM+7e9E5PsvMJgg@mail.gmail.com>
References: <93ed702aba4c33d9a477c7296c59cc2882e16f82.1351064553.git.viresh.kumar@linaro.org>
	<1829614.cr6YHfW4bW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1829614.cr6YHfW4bW@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, pdsw-power-team@arm.com, arvind.chauhan@arm.com, fengguang.wu@intel.com
List-Id: linux-pm@vger.kernel.org

On 25 October 2012 02:44, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday 24 of October 2012 13:15:58 Viresh Kumar wrote:
>> There were few sparse warnings due to mismatch of type on function arguments.
>> Two types were used u64 and cputime64_t. Both are actually u64, so use u64 only.
>>
>> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> This series appears to be based on your "cpufreq: governors: remove
> redundant code" patch that hasn't been applied yet.
>
> Please rebase it on top of linux-pm/linux-next or on top of v3.7-rc2,
> whichever is more convenient, and resend.

Please apply it after applying the latest cpufreq: governors patch i have sent.

--
viresh
