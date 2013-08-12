From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 35/35] cpufreq: tegra: use cpufreq_table_validate_and_show()
Date: Mon, 12 Aug 2013 22:31:20 +0530
Message-ID: <CAKohpom4WsD_BSSGEbtmGR3JRzPXx9j1exM7CagwOXZ=0GZnGw@mail.gmail.com>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
	<568f3dbd414b050bb2319d960fb5044a5aed8ee3.1375964117.git.viresh.kumar@linaro.org>
	<5203BCDD.40809@wwwdotorg.org>
	<CAKohpomr8kwDitAFD7FKvHo3zNWz8qT5bkd3yOVEnC_k16o=Dw@mail.gmail.com>
	<CAKohpo=Gy7D2LYmdFU1p+eL-nMoPE18YXWvE2M8t-fb-a5HBgg@mail.gmail.com>
	<5205167F.1070906@wwwdotorg.org>
	<CAKohponQDAqHiRD7Aw5Wk6fEE-d8H=Svg0oBRyb9SKGdqYxGhw@mail.gmail.com>
	<52056842.8060109@wwwdotorg.org>
	<CAKohpon=j=NANLQzYuBdoFVLxQzETy5JDu2vORaAgK3NuEpeAg@mail.gmail.com>
	<52090E67.1080703@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <52090E67.1080703@wwwdotorg.org>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linaro-kernel@lists.linaro.org, Stephen Warren <swarren@nvidia.com>, linux-pm@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, rjw@sisk.pl, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 12 August 2013 22:03, Stephen Warren <swarren@wwwdotorg.org> wrote:
> It's in defconfig OK; I think the driver simply isn't initializing since
> some of the clocks it requests don't exist. I'll have our clock driver
> author look into it. In the meantime, I assume that your change is
> likely fine.

I wasn't' talking about your driver but cpufreq_stats.. That is disabled
by default with your defconfig.
