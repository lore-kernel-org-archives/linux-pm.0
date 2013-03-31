From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/9] cpufreq: pxa3xx: move cpufreq driver to drivers/cpufreq
Date: Sun, 31 Mar 2013 09:22:34 +0530
Message-ID: <CAKohpokq+JJF2Ec3=_QF5dk_w9tMuKZ0trtcgXbC1if=HXEBRg@mail.gmail.com>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
	<2aa937c3d81776f01c2c1d6fcfcb08ba74163b53.1364205812.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2aa937c3d81776f01c2c1d6fcfcb08ba74163b53.1364205812.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org

Eric/Haojian,

On 25 March 2013 15:41, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This patch moves cpufreq driver of ARM based pxa3xx platform to drivers/cpufreq.
>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-pxa/Makefile                                           | 1 -
>  arch/arm/mach-pxa/include/mach/generic.h                             | 1 +
>  drivers/cpufreq/Makefile                                             | 1 +
>  .../mach-pxa/cpufreq-pxa3xx.c => drivers/cpufreq/pxa3xx-cpufreq.c    | 5 +----
>  4 files changed, 3 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/mach-pxa/include/mach/generic.h
>  rename arch/arm/mach-pxa/cpufreq-pxa3xx.c => drivers/cpufreq/pxa3xx-cpufreq.c (98%)

Can i have your Ack or views about 6/9 and 7/9 Patch?
