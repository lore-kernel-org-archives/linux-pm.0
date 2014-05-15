From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] cpufreq: Tegra: drop wrapper around tegra_update_cpu_speed()
Date: Thu, 15 May 2014 12:44:55 -0600
Message-ID: <53750B27.4020708@wwwdotorg.org>
References: <a38df05b91198f393b1c4b78f39110c6bece3627.1400133049.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a38df05b91198f393b1c4b78f39110c6bece3627.1400133049.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net, swarren@nvidia.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com
List-Id: linux-pm@vger.kernel.org

On 05/14/2014 11:51 PM, Viresh Kumar wrote:
> Tegra has implemented an unnecessary wrapper over tegra_update_cpu_speed(), i.e.
> tegra_target(), which wasn't doing anything apart of calling
> tegra_update_cpu_speed(). Get rid of that and use tegra_target() directly.

I think it used to do something until some refactoring happened? Anyway,

Acked-by: Stephen Warren <swarren@nvidia.com>
