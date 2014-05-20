From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V3 3/4] cpufreq: Tegra: drop wrapper around tegra_update_cpu_speed()
Date: Tue, 20 May 2014 09:48:26 -0700
Message-ID: <CAD=FV=UMKofTg5fUbzxJvPrYAcdeCJs8WgBjVEYLs2bcwcUxxg@mail.gmail.com>
References: <cover.1400302114.git.viresh.kumar@linaro.org>
	<898b7b84ba61d89bc2cebb63111a745ec633a02e.1400302114.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <898b7b84ba61d89bc2cebb63111a745ec633a02e.1400302114.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Russell King <linux@arm.linux.org.uk>, Thomas Abraham <thomas.abraham@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Viresh,

On Fri, May 16, 2014 at 9:51 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Tegra has implemented an unnecessary wrapper over tegra_update_cpu_speed(), i.e.
> tegra_target(), which wasn't doing anything apart of calling
> tegra_update_cpu_speed(). Get rid of that and use tegra_target() directly.
>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/tegra-cpufreq.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
