From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: unicore2: Staticize local symbol
Date: Fri, 9 Aug 2013 22:14:08 +0530
Message-ID: <CAOh2x=nOToVvWVm9=ZF9p4J_HOEJXJZWz--WdH+tKpk2voVsAA@mail.gmail.com>
References: <000701ce94d0$240949e0$6c1bdda0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <000701ce94d0$240949e0$6c1bdda0$@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 9, 2013 at 12:44 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> This local symbol is used only in this file.
> Fix the following sparse warnings:
>
> drivers/cpufreq/unicore2-cpufreq.c:27:5: warning: symbol 'ucv2_verify_speed' was not declared. Should it be static?
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/cpufreq/unicore2-cpufreq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
