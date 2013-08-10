From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 44/44] cpufreq: pass suitable index instead of freq to cpufreq_driver->target()
Date: Sat, 10 Aug 2013 13:15:54 +0530
Message-ID: <CAKohpokkcDcz0i3AjAVqLa7103TJoiF38g5gau-1szKVj2RcxA@mail.gmail.com>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
	<149222df041360bac7bb58a9f9baa5f5b8277445.1376116345.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <149222df041360bac7bb58a9f9baa5f5b8277445.1376116345.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 10 August 2013 12:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This tries to remove code redundancy from cpufreq driver by moving some common
> part of them to the core. Each driver calls cpufreq_frequency_table_target() to
> get a suitable index for a target frequency and then works on it. Its better to
> do this at core level before calling cpufreq driver and hence passing "index"
> instead of "target_freq and relation" to cpufreq_driver->target() routine.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

This one is sent by mistake.. It isn't ready yet and will be sent separately
later. :(
