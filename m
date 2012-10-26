From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: governors: remove redundant code
Date: Fri, 26 Oct 2012 08:58:47 +0530
Message-ID: <CAKohpon_GLyFOfBBtBmjxJpx1pUze4gKd4Xh7rT=gs25U_sLjw@mail.gmail.com>
References: <32e5bed743cc6cc4e614291a7080299f5f0d0933.1350677395.git.viresh.kumar@linaro.org>
	<3245066.cWfgP9Ikey@vostro.rjw.lan>
	<CAKohpo=Nv6DfXqyv=v-1Eo=pvx25qyrQ2qs+pGqJvbJu2bwWaw@mail.gmail.com>
	<1707056.POnhGSP0pg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1707056.POnhGSP0pg@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, pdsw-power-team@arm.com, arvind.chauhan@arm.com
List-Id: linux-pm@vger.kernel.org

On 26 October 2012 05:43, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> I have applied this patch only because of the fixes on top of it.  It broke
> kernel compliation due to some missing EXPORT_SYMBOL_GPLs in cpufreq_governor.c,
> so I woulnd't have applied it otherwise.

Hi Rafael,

So sorry for this. I am really feeling bad for that. I should have
tried compiling
them as modules too. I had that in mind while coding it, but forgot it later.

Thanks for making changes on my behalf.

--
viresh
