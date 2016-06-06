From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 0/9] cpufreq: Sort policy->freq_table
Date: Mon, 6 Jun 2016 23:09:20 +0200
Message-ID: <CAJZ5v0i2x3CVoVmrU0i51UVkKHQGtdGp9Joufi2OeKNvd68YRA@mail.gmail.com>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464960877.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 3, 2016 at 3:35 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Rafael,
>
> So all my patches are contained in two series. The first one is:
>
> [PATCH V3 0/8] cpufreq: cleanups and reorganization
>
> which I have sent this morning. It does some cleanup and shall be
> applied regardless of this series.
>
> This series improves the performance of cpufreq_frequency_table_target()
> routine by storing the policy->freq_table sorted in ascending order. On
> one hand it shall improve the performance of current governors for
> drivers providing freq-table to cpufreq core and on another hand this
> API can be used directly from schedutil governor as well.
>
> As Steve has requested earlier, these APIs are moved to a .h file to
> avoid function calls.
>
> Steve's series can use this API now without any performance lag.
>
> The first 7 patches makes sure that current drivers wouldn't break because
> of reordering of policy->freq_table and the 8th patch updates cpufreq
> core to sort policy->freq_table and make
> cpufreq_frequency_table_target() much more efficient.

Is there any particular reason why patches [2-7/9] are separate?

They seem to be making analogous changes in several drivers (and even
the changelog seems to be the same), so why don't you make a single
patch out of them?
